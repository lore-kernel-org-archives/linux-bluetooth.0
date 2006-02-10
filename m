Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph =?iso-8859-1?q?B=E4chtle?= <christophbaechtle@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] modprobe snd_bt_sco fails with: FATAL: Error inserting snd_bt_sco
References: <200602100311.35870.christophbaechtle@web.de> <43ECCAC9.9050402@xmission.com>
In-Reply-To: <43ECCAC9.9050402@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602102017.41136.christophbaechtle@web.de>
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
Date: Fri, 10 Feb 2006 20:17:40 +0100

ah thanks. You know where I have to change it?

christoph

Am Freitag, 10. Februar 2006 18:18 schrieb Brad Midgley:
> Christoph
>
> > snd_bt_sco: Unknown symbol
> > there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
> >
> >
> > does anybody know how to solve this?
> > I am using suse 10.0 with kde3.5 and kernel 2.6.15-jad2
>
>  init_MUTEX_LOCKED(&bt_sco->thread_sem);
>
> needed to be changed to:
>
>  init_MUTEX(&bt_sco->thread_sem);
>  down(&bt_sco->thread_sem);
>
> This builds ok for me but my headset is having other problems. can you
> get it from cvs and check it out?
>
> Brad
>
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
