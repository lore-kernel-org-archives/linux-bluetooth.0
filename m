Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+=pruSoDhsbf=g+ZsbxTgWkoci1PXfiDyc83ikTKQ5eg@mail.gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
	<CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
	<CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
	<CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
	<CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
	<CA+i+Aw3yNJpDbSywcHLZ9Y6CDY4SWx2FnvE-f0ZTbtj=4=cWQg@mail.gmail.com>
	<CABBYNZ+=pruSoDhsbf=g+ZsbxTgWkoci1PXfiDyc83ikTKQ5eg@mail.gmail.com>
Date: Wed, 5 Oct 2011 19:28:59 +0200
Message-ID: <CA+i+Aw0yVhxVt8-H5KD0_Y4fpRaY7+wUP8=pUqD8j66j+LntsA@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 5, 2011 at 6:43 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Oct 5, 2011 at 7:12 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> On Wed, Oct 5, 2011 at 5:38 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> I don't think this is true, if it was then why would we call
>>> service->put on the end of stream and I also never see this happening
>>> in practice e.g. calling ftp_put in the end of stream.
>>
>> Actually, if you will add DBG call to filesystem_write() you will
>> clearly see, that ftp_put is called at the end of stream.
>
> That is true only if the body is not bigger than the MTU, in other
> words the body is not fragmented, otherwise it would be pointless to
> check for name and folder only at the very end of the stream.

False. You check the name and folder after OBEX_EV_REQCHECK, which was
specificaly added to allow earlier checks.

> I also
> don't like the fact that OBEX_EV_REQ is generated in the end of the
> first package, it is really confusing that a request event comes after
> its data, but maybe there is a reason for that or the intention was
> not that so we are not handling the event the way it was meant?

OBEX_EV_REQ is delivered when the remote party finished sending
request, not after first OBEX packet. This is the way it is intented
in OpenOBEX.

Please do check it or consult OpenOBEX code/documentation.

If you still do not agree, please to present an actual case when this
won't work. Please do try first with a transfer larger than the MTU
before assuming anything (maximum MTU is 64K, send a larger file),

-- 
Slawomir Bochenski
