Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201001221317.11486.ml@vdm-design.de>
References: <201001221317.11486.ml@vdm-design.de>
Date: Fri, 22 Jan 2010 17:39:31 +0200
Message-ID: <2d5a2c101001220739m135c8eadn891c0ac2183b6433@mail.gmail.com>
Subject: Re: obexd: Question about PBAP support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Thomas Zimmermann <ml@vdm-design.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Fri, Jan 22, 2010 at 2:17 PM, Thomas Zimmermann <ml@vdm-design.de> wrote:
> Hi,
> i tried to write a plugin for obexd to support the phonebook of
> freesmartphone.org.
>
> Browsing the device with "sdptool browse" shows Phonebook Access on channel
> 15, so i thing obexd is running properly. But when connecting a real PBAP
> device (tried Parrot Minikit and a BMW car system) the methods in my plugin
> aren't called. (I added some debug output at the beginning of the functions
> and that's not shown.)

Before running obexd you need to make sure that your driver will be
linked as phonebook.c, you can select it by doing
--with-phonebook=<driver name>, this will be expanded to
phonebook-<driver name>.c where it should be implemented.

> So, did someone tried before to use PBAP with a real device?
> And how can i help to get this working?

I got it working with obex-client + pbap-client and obexd + ebook
driver, but pbap code is maybe not mature yet for real devices, the
driver support was just introduced few months ago and of course
patches are welcome.

Regards,


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
