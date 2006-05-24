Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44748EFD.2060000@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth-alsa: a2recv stuttering sound from WM5.0
 AKU2.0
References: <96B7A15232D6CF42836BFD428AD6B6034E4F41@deexmb01.de.icap.com>
In-Reply-To: <96B7A15232D6CF42836BFD428AD6B6034E4F41@deexmb01.de.icap.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 May 2006 09:51:09 -0700

Guido

> But the sound is stuttering like hell. It is played at half to quater of
> normal speed in very small sound blocks.
> 
> Can someone help me? Has somebody got this working on a WM 5.0 Device as
> a sender?

You will be the first. :)

Did you configure with --enable-fixed? Fixed point decoding is more
efficient but it may not behave as well for some codec settings.

Can you figure out what codec settings the wm5 device is using? Maybe
they are not getting set in our decoder properly.

Brad


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
