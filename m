Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4AEAB4F8.1070202@gmail.com>
References: <4AE971D9.2010409@gmail.com>
	 <6b53b1990910291006x5c9473eep26725b082334c953@mail.gmail.com>
	 <4AEAB4F8.1070202@gmail.com>
Date: Sat, 31 Oct 2009 17:54:16 -0200
Message-ID: <6b53b1990910311254t2b5d11c9w3cc886bfb016d04e@mail.gmail.com>
Subject: Re: ERMT and Streaming mode in L2CAP
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: sancane <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi sancane

On Fri, Oct 30, 2009 at 7:42 AM, sancane <sancane@gmail.com> wrote:
> Hi Gustavo
>> Hi sancane,
>>
>> On Thu, Oct 29, 2009 at 8:43 AM, sancane <sancane@gmail.com> wrote:
>>
>>> Hi,
>>> I'm programming a MCAP library for Bluez, (it is in beta state yet). I
>>> need add support for ERTM and Streaming mode to L2CAP sockets and i've
>>> seen some work included in l2cap kernel module by Gustavo F. Padovan. I
>>> have downloaded the kernel source from
>>> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
>>> <http://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git>
>>> and compiled it enabling ERTM module parameter to test my current
>>> implementation of MCAP profile.
>>> I would like to know which is the current state of ERTM and Streaming
>>> mode in l2cap and if you are planning to continue the development task
>>> in above mentioned retransmission modes.
>>> My tests using ERTM results in kernel oops messages when i try to
>>> send/receive a buffer data. I tested Streaming mode too but it does not
>>> do anything when data is sent over L2CAP sockets.
>>> ......
>>
>> It looks you are using a duplex channel. This code doesn't support
>> that. You need the patches I sent to mailing list on Oct 3.
>>
> Thanks for your reply.
> I'm finishing my MCAP implementation and i would like to test it against
> other implementations. I'll release my code when i think that it is in
> stable state although i can release it before if somebody is interested
> in it. It will be GPL and i'll announce here in the hope that it will be
> useful by other developer who want test it or used to implement other
> profiles like HDP.
> I saw that you have been working in ERTM and Streming mode since August,
> i suppose that you have a l2cap module implementation more advanced, i
> would like to know if you have a git repository to get it, or if you can
> give me a local copy to use it for my tests.


All my code except the patches of Oct 3 are on the bluetooth-testing.git tree.
You can get this tree and apply my patches.

>
> Best regards
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan
http://padovan.org
