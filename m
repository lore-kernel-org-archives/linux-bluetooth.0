Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46DEE2D5.3080804@free.fr>
Date: Wed, 05 Sep 2007 19:09:41 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <f58d13790709050943x4d8a7491qfc5131b76934cce6@mail.gmail.com>
In-Reply-To: <f58d13790709050943x4d8a7491qfc5131b76934cce6@mail.gmail.com>
Subject: Re: [Bluez-devel] [bluetooth-alsa] SCO-FLOWCONTROL patch in the
 newest kernels
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Carlo,
> I all,
> I've applied the 
> http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff 
> <http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.2.diff> 
> patch on my 2.6.22 kernel to let the SCO protocol works with my 
> bluetooth headset and it works well.
> 
> Anyway I had some problem during the patching as the kernel wasn't the 
> correct one.
> 
Indeed they should be updated to apply cleanly on latest 2.6.22 kernel.
If you can provide an updated version of the patch i would happily push 
it in CVS.

Regards,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
