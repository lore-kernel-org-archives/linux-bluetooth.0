Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph =?iso-8859-1?q?B=E4chtle?= <christophbaechtle@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] modprobe snd_bt_sco fails with: FATAL: Error inserting snd_bt_sco
References: <200602100311.35870.christophbaechtle@web.de> <200602102017.41136.christophbaechtle@web.de> <43ECF652.4000902@xmission.com>
In-Reply-To: <43ECF652.4000902@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602112247.48075.christophbaechtle@web.de>
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
Date: Sat, 11 Feb 2006 22:47:47 +0100

ok, thanks, it worked

christoph

Am Freitag, 10. Februar 2006 21:23 schrieb Brad Midgley:
> Christoph
>
> if you are using cvs, you just need to update.
>
> if you used the 0.41 release, open btsco/kernel/btsco.c and change the
> only occurrence of init_MUTEX_LOCKED
>
> brad
>
> >> init_MUTEX_LOCKED(&bt_sco->thread_sem);
> >>
> >>needed to be changed to:
> >>
> >> init_MUTEX(&bt_sco->thread_sem);
> >> down(&bt_sco->thread_sem);
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
