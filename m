Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43ECF652.4000902@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] modprobe snd_bt_sco fails with: FATAL: Error inserting
 snd_bt_sco
References: <200602100311.35870.christophbaechtle@web.de> <43ECCAC9.9050402@xmission.com> <200602102017.41136.christophbaechtle@web.de>
In-Reply-To: <200602102017.41136.christophbaechtle@web.de>
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
Date: Fri, 10 Feb 2006 13:23:46 -0700

Christoph

if you are using cvs, you just need to update.

if you used the 0.41 release, open btsco/kernel/btsco.c and change the
only occurrence of init_MUTEX_LOCKED

brad

>> init_MUTEX_LOCKED(&bt_sco->thread_sem);
>>
>>needed to be changed to:
>>
>> init_MUTEX(&bt_sco->thread_sem);
>> down(&bt_sco->thread_sem);


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
