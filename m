Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43660FED.6040000@grimmer.com>
From: Lenz Grimmer <lenz@grimmer.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco module prevents ACPI S3
References: <200510301643.31873.rene.mayrhofer@gibraltar.at> <4365579A.4080709@xmission.com>
In-Reply-To: <4365579A.4080709@xmission.com>
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
Date: Mon, 31 Oct 2005 13:37:01 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

some input from me, as I noticed the same issues.

Brad Midgley wrote:

> > 1. It's name in the lsmod list is different from the module name, i.e. 
> > modprobe and rmmod must be used with different names.
> 
> Do you want to submit a patch (or at least tell us what the different
> names are?)

The module file is named "snd-bt-sco.ko", while "lsmod" displays it as
"snd_bt_sco". Not a biggie, but weird.

> > 2. It breaks ACPI S3 (suspend to RAM), making it pretty much unusable on 
> > laptops where S3 is used (like mine). Unloading snd-bt-sco does not work (I 
> > do that with a few other modules); as soon as it has been loaded once (even 
> > if it has not been used and/or has been unloaded), the kernel (2.6.14-rc5) is 
> > unable to enter ACPI S3. 
> 
> This may be the result of something we did but it's much more likely to
> be a change in the kernel.
> 
> What exactly happens when you try & fail to go to S3?

I can confirm this here (SUSE Linux 10.0, Kernel 2.6.13) - suspending
begins, but aborts at some point:

PM: Preparing system for suspend
Stopping tasks:
==================================================================================================================================
stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, snd-bt-scod not stopped
done

It has been reported as BUG#1218671 in the bug tracker on SourceForge
some time ago:
http://sourceforge.net/tracker/index.php?func=detail&aid=1218671&group_id=116589&atid=678258

This report even contains a patch, but it does not seem to match/apply
anymore.

There is a second bug report, even though the subject line is misleading:
http://sourceforge.net/tracker/index.php?func=detail&aid=1170421&group_id=116589&atid=678258

Does anybody actually check the bug reports that are filed at Bug
Tracking system at http://sourceforge.net/projects/bluetooth-alsa/ :
http://sourceforge.net/tracker/?atid=678258&group_id=116589&func=browse

There are about 27 open bugs.

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZg/rSVDhKrJykfIRAvzcAJ9YDcUCQtLlB1wDlikx1ZbK/6YOWgCfSnoc
xRVkKjjRUYuNpps/PaR4C/4=
=Ra14
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
