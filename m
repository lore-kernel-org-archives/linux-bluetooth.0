Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKMi572+BUbymbA=sX4s3NKSGcHsrGQWSptj5xVSTkMBw@mail.gmail.com>
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
	<1335342544-17320-2-git-send-email-manojkr.sharma@stericsson.com>
	<alpine.DEB.2.02.1204250827200.20357@mathewm-linux>
	<D43D72D2B7084BA8B750CE7FD0D1C287@sisodomain.com>
	<CABBYNZKMi572+BUbymbA=sX4s3NKSGcHsrGQWSptj5xVSTkMBw@mail.gmail.com>
Date: Mon, 14 Jan 2013 00:05:10 +0530
Message-ID: <CAFBvHifW55ADuDY+1WM+KUvhWwB7Sr3W0r8R9hALeLuHJTNULw@mail.gmail.com>
Subject: Re: Obexd OPP filesend fails with Windows7 stack
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Syam Sidhardhan <s.syam@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Jan 13, 2013 at 9:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Syam,
>
> On Fri, Jan 11, 2013 at 10:32 AM, Syam Sidhardhan <s.syam@samsung.com> wrote:
>> Hi,
>>
>> We are using the obexd 0.48 version and testing the obexd.
>> During testing OPP file send, we found one interoperability
>> issue with the Windows7 PC stack and some commercialized devices
>> available in the market.
>>
>> The issue is: OBEXD file transfer is getting failed
>> once after the complete file content got transfferd. This is
>> because of, we do a direct RFCOMM disconection rather than
>> doing a proper OBEX disconection before.
>>
>> Does someone can help me a with a fix for this?
>
> We probably need to send a disconnect command before disconnecting
> RFCOMM, iirc there was someone else looking into a similar problem
> with a Nokia phone, the strange part is that the remote stack has
> acknowledged the transfer complete and in theory we could go ahead and
> start another one using the same session.
>

Yes, you are correct. We need to send a OBEX disconnect command
before the RFCOMM disconnection. We have tried with the same and
its working fine.

Regards,
Syam
