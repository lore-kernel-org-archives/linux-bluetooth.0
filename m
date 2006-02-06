Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43E6ABAE.9080101@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>	 <43A78D40.7070209@xmission.com>	 <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>	 <43A9B384.5040202@xmission.com>	 <5bab330d0602041925h53623f50h8560344f37a62d0d@mail.gmail.com>	 <43E5BAB2.5030800@xmission.com> <5bab330d0602050339w271e072btc06e632e5caff33c@mail.gmail.com>
In-Reply-To: <5bab330d0602050339w271e072btc06e632e5caff33c@mail.gmail.com>
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
Date: Sun, 05 Feb 2006 18:51:42 -0700

Nigel

> In regards to my new issue, it appears that the SEID is not released,
> and is reported as (InUse) in the hci dump (
> http://hpc-external.jcu.edu.au/~nigel/uploads/Main/inuseHCIDump.txt).
> Even though 'hcitool con' reports no connections. However, this problem
> goes away if I reenable the code block at around a2play.c:1081 which is
> commened to be disabled because of problems it causes for the iTech
> headsets.

good. I was planning to reenable that block. I believe it was locking up
the headset because of a race condition when using the pthreads timer.
I'll reenable and dig into it.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
