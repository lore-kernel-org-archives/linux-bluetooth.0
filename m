Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/2] Add g_attrib_send_seq()
From: Brian Gix <bgix@codeaurora.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20101228214722.GA30135@piper.indt.org>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
	 <1292626132-30029-2-git-send-email-bgix@codeaurora.org>
	 <AANLkTinnsNX_9ENWvBcnN7j8_kmBhbSoL6cCWJ8-Lzgh@mail.gmail.com>
	 <1293059620.7281.43.camel@sealablnx02.qualcomm.com>
	 <20101228214722.GA30135@piper.indt.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Jan 2011 14:27:56 -0800
Message-ID: <1294266476.20505.192.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, 2010-12-28 at 18:48 -0300, Vinicius Costa Gomes wrote:
> Hi Brian,
> 
> First of all, sorry for the delay.
> 
[...]
> 
> And taking a closer look at the spec, it was clear to me that only a higher
> level profile (above GATT) is able to know that a characteristic needs to be
> read by using the "Read Long Characteristic Value" procedure -- which I think is
> what brought this discussion, right? or you already have another need for 
> these procedures? -- Which gives me the impression that this should
> be dealt by the profile implementation. Which gives us more time to think about
> how to implement this correctly ;-) in case the need arrise.

It is true that the "Read Long Characteristic Value" is defined as a
distinct GATT procedure from the "Read Characteristic Value" procedure
(section 4.8.3 of Vol 3, as opposed to section 4.3.1). However it was
purposefully designed such that the two procedures could be overloaded
onto a single API such as I have done with the patch(es). (See the Note
just above Figure 4.10)

I believe that overloading the "Read Characteristic Value" in this way
is a valuable extension for a couple of reasons. It simplifies the API
(including the DBus API) by not having two APIs that do essentially the
same thing. It simplifies the API by not requiring that a client know
information ahead of time, such as the length of strings, on a remote
server.

The fact that this GATT procedure is Optional rather than Mandatory is
more a function of common sense rather than a statement of whether it is
explicitly needed for a particular profile.  For instance a Client may
not have the ability to display strings, so there is no point from a
specification standpoint of forcing it to read data it is not useful to
it.  And if a Server with limited resources decides to limit
Characteristic Values to 22 octets or less, there is no point in
requiring it to respond successfully to a READ_BLOB request.

However, as BlueZ will be heavily used, particularly as an LE client, in
environments with significant resources (Tablets, Cellphones, Desktops),
I think it would be short sighted to require each profile and/or each
client app to handle Long and Short Characteristic Values differently,
unless there is a compelling technical reason.  I personally find the
compelling technical reason to be behind overloading the single, simple
API.

[...]
> 
> Cheers,
> --
> Vinicius

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

