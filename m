Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Klaus <projectu@gmail.com>
Date: Sun, 29 Apr 2007 20:58:49 +0000 (UTC)
Message-ID: <loom.20070429T224443-848@post.gmane.org>
References: <20070415095728.GA6212@ifup.org>	<20070424184826.GD6853@torres.zugschlus.de>
	<loom.20070429T141323-596@post.gmane.org>
	<4634C553.6080400@xmission.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
	upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad Midgley <bmidgley <at> xmission.com> writes:
> 
> you're looking at the upatched sco.c or maybe one hunk failed.
> sco-flowcontrol-v4.2.diff has changes for setsockopt() around line 550.

hrmp, my fault! You are so right, and everything is working fine with the patch! 

Now I just have to figure out how to use the headset from Ekiga.
 
(If you are curious, then I had updated my Fedora kernel-2.6.spec file with the
patch - but forgot the %patchxxx to actually enable the patch).


Thanks, Klaus






-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
