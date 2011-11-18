Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321643339.15441.622.camel@aeonflux>
References: <4EC6A13B.5030805@codeaurora.org>
	<1321643339.15441.622.camel@aeonflux>
Date: Fri, 18 Nov 2011 16:36:26 -0400
Message-ID: <CAJdJm_MHBsEER01OsgdhzYM8WyKuGfxHUZwDv-oYQjJtR9N_ww@mail.gmail.com>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Brian Gix <bgix@codeaurora.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 18, 2011 at 3:08 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> I think one of the most important questions that we have to ask
> ourselves at some point is if we wanna put ATT into the kernel.
>
> The potential candidate that forces us to think about this is HID over
> Low Energy. However I like to see numbers on how the context switches
> with keeping ATT in userspace will effect our latency.

I still fail to see how ATT handling in kernel would reduce context
switches. A GATT operation is composed of one or more (possibly many,
see e.g. discovery procedures) ATT PDUs.

Unless you are proposing GATT on kernel as well?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
