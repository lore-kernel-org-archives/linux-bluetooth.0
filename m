Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw3yNJpDbSywcHLZ9Y6CDY4SWx2FnvE-f0ZTbtj=4=cWQg@mail.gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
	<CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
	<CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
	<CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
	<CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
	<CA+i+Aw3yNJpDbSywcHLZ9Y6CDY4SWx2FnvE-f0ZTbtj=4=cWQg@mail.gmail.com>
Date: Wed, 5 Oct 2011 19:43:09 +0300
Message-ID: <CABBYNZ+=pruSoDhsbf=g+ZsbxTgWkoci1PXfiDyc83ikTKQ5eg@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 5, 2011 at 7:12 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> On Wed, Oct 5, 2011 at 5:38 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> I don't think this is true, if it was then why would we call
>> service->put on the end of stream and I also never see this happening
>> in practice e.g. calling ftp_put in the end of stream.
>
> Actually, if you will add DBG call to filesystem_write() you will
> clearly see, that ftp_put is called at the end of stream.

That is true only if the body is not bigger than the MTU, in other
words the body is not fragmented, otherwise it would be pointless to
check for name and folder only at the very end of the stream. I also
don't like the fact that OBEX_EV_REQ is generated in the end of the
first package, it is really confusing that a request event comes after
its data, but maybe there is a reason for that or the intention was
not that so we are not handling the event the way it was meant?

-- 
Luiz Augusto von Dentz
