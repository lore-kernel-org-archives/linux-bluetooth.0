Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4395BA8B.9090004@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-alsa Project :::: Not clear documentation
References: <20051206094558.26664.qmail@web36103.mail.mud.yahoo.com>
In-Reply-To: <20051206094558.26664.qmail@web36103.mail.mud.yahoo.com>
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
Date: Tue, 06 Dec 2005 09:21:31 -0700

Swathi

> Can i know where can i download the packages
> libbluetooth-dev, libasound2-dev ?

this depends on your distribution of linux. search the available
packages and ask your distro maker.

> 
> 2)Using SCO audio
> 
>    1. insert the module (or better, set up the alsa
> configuration to load it)
>    modprobe snd_bt_sco

cd to "kernel" and if the file isn't already there, run make and you'll
generate snd_bt_sco.ko

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
