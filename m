Return-Path: <cyrus@holtmann.org>
Message-ID: <1338377701.1817.2.camel@aeonflux>
Subject: Re: [RFC] network: Reply to extensions at connection setup
From: Marcel Holtmann <marcel@holtmann.org>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Date: Wed, 30 May 2012 13:35:01 +0200
In-Reply-To: <CA+QXtDuBEP3sT9oNAwhDPOoD1RjEtLQw-8tFM-5rrMSjP15_6Q@mail.gmail.com>
References: <1338286766-5368-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1338286766-5368-2-git-send-email-frederic.dalleau@linux.intel.com>
	 <1338302161.15105.125.camel@aeonflux>
	 <CA+QXtDuBEP3sT9oNAwhDPOoD1RjEtLQw-8tFM-5rrMSjP15_6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

>         > TP/BNEP/CTRL/BV-19-C is about extension in the
>         BNEP_SETUP_CONN_REQ
>         > control message. BNEP_SETUP_CONN_REQ is handled by
>         bluetoothd before
>         > giving control to kernel.  Current bluez do not reply at all
>         if an
>         > extension is added to BNEP_SETUP_CONN_REQ. This patch fixes
>         it by
>         > sending COMMAND_NOT_UNDERSTOOD reply.
>         
>  
>         
>         is this really a good idea to just decline all extensions
>         here?
>         
>         What happens to the filter setup done via these commands.
>         Don't we need
>         to process them inside the kernel to actually setup the
>         filters.
>  
> I have chosen to decline the extension because they are marked as not
> supported in all qualification listings that I have seen.

may that is the reason for it. Nevertheless no reason for us not to
support it.

> Processing extensions in the kernel is of course better, but both
> kernel and 
> userspace needs changing, which is usually a much longer process. If
> preferred,
> I can do so.

I am fine with doing this as a first step. Since essentially if we run
on an older kernel, we need to do that anyway. We need to fallback
gracefully.

However I do like to see a plan for adding a new ioctl() to BNEP support
that allows us to include leftover unprocessed extensions.

Please consider Luiz comments since the patch is not really clean. We
need to make this more readable. Especially when it gets more complex
and becomes a fallback case.

Regards

Marcel


