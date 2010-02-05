Return-Path: <cyrus@holtmann.org>
Subject: Re: Problem with 'inquiry_cache' in sysfs
From: Marcel Holtmann <marcel@holtmann.org>
To: Frank Maas <frank.maas@cheiron-it.nl>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100204220516.GC8556@xs4all.nl>
References: <20100204220516.GC8556@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Feb 2010 11:50:09 -0800
Message-ID: <1265399409.31341.241.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frank,

> I have just connected to your mailing list as this is your prefered way 
> of contact. So excuse me for barging in a bit... And excuse me if the 
> following is too much text...
> 
> I am currently developing a system that relies heavily on the Linux 
> bluetooth stack. That system uses the sysfs interface to the kernel 
> module and more specifically the entry 'inquiry_cache' of the device 
> "directory".

that file should have been moved to debugfs, but we haven't done that
yet. It really doesn't belong in sysfs at all. And should not be treated
as an API.

Regards

Marcel


