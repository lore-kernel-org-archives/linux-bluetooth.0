Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43984EAC.7080805@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Voice Setting
References: <HCEOIFALKKLBLJPENPNOAEGLCAAA.khaled@ipbill.com>
In-Reply-To: <HCEOIFALKKLBLJPENPNOAEGLCAAA.khaled@ipbill.com>
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
Date: Thu, 08 Dec 2005 08:18:04 -0700

Khaled

What I'm saying is asterisk either connects to (eg) /dev/dsp1 or the
alsa device, invoking snd-bt-sco which sends/receives over bluetooth
sockets OR asterisk sends and receives over bluetooth sockets without
bothering with snd-bt-sco. Have a look at the code or ask the asterisk guy.

Brad

> If I am trying to use voip, then wouldn't the application (asterisk) require
> the snd_bt_sco module? Perhaps this is why I am not getting any sound (as
> shown in the hcidump output of my last message).
> Is this a sensible assumption because I am using a softphone that is
> connected to the machine configured as a handsfree headset via voip?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
