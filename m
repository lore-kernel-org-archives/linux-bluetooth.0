Return-Path: <cyrus@holtmann.org>
Subject: Re: rfkill read / write access needs to be enabled for normal users
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrea Veri <andrea.veri89@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20091024171318.345c2bbf@bluepaper>
References: <20091024171318.345c2bbf@bluepaper>
Content-Type: text/plain
Date: Sun, 25 Oct 2009 01:24:27 +0900
Message-Id: <1256401467.7812.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

> while working on gnome-bluetooth for Debian, I noticed that rfkill's
> read / write access needs to be enabled for normal users.
> 
> There is a patch for this already:
> 
> KERNEL=="rfkill", ENV{ACL_MANAGE}="1"
> 
> This is done through an udev rule, but I don't think this is the best
> way to have it fixed.
> 
> I guess that having a fix included into bluez itself would make the
> trick IMHO.
> 
> Is there someone working on this already? if not, someone can suggest
> me another way to have this fixed without having to use an udev rule?

I have said this before and let me repeat it again, gnome-bluetooth
should not mess directly with the RFKILL subsystem. It is the wrong
approach and that is the reason why normal users don't have uncontrolled
access to /dev/rfkill.

Regards

Marcel


