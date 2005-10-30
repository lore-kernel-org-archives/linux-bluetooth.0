Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4365579A.4080709@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, rene.mayrhofer@gibraltar.at
Subject: Re: [Bluez-devel] snd-bt-sco module prevents ACPI S3
References: <200510301643.31873.rene.mayrhofer@gibraltar.at>
In-Reply-To: <200510301643.31873.rene.mayrhofer@gibraltar.at>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 30 Oct 2005 16:30:34 -0700

Rene

> 1. It's name in the lsmod list is different from the module name, i.e. 
> modprobe and rmmod must be used with different names.

Do you want to submit a patch (or at least tell us what the different
names are?)

> 2. It breaks ACPI S3 (suspend to RAM), making it pretty much unusable on 
> laptops where S3 is used (like mine). Unloading snd-bt-sco does not work (I 
> do that with a few other modules); as soon as it has been loaded once (even 
> if it has not been used and/or has been unloaded), the kernel (2.6.14-rc5) is 
> unable to enter ACPI S3. 

This may be the result of something we did but it's much more likely to
be a change in the kernel.

What exactly happens when you try & fail to go to S3?

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
