Return-Path: <cyrus@holtmann.org>
Subject: Re: Abt Kernel Patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6887eb5d0902242007v66d3b1ecjd21df305414e263d@mail.gmail.com>
References: <6887eb5d0902242007v66d3b1ecjd21df305414e263d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 10:53:27 +0100
Message-Id: <1235555607.24169.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

> I have downloaded patch-2.6.27-mh1.gz from www.bluez.org.
> At present I m working on Fedora 9 Kernel 2.6.25
> I want to apply this patch to my kernel. I don't fine any readme in
> this patch file...
> Pls guide me how to apply kernel patch file?

if you wanna apply a more recent patch against an old kernel, then you
have to backport all its changes (and maybe dependencies). This is not a
job the mailing list can really help you with.

Why not just installing Fedora 10 which already comes with a 2.6.27 by
default.

Regards

Marcel


