Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Correction
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200511301046.25700.mgorbach@yahoo.com>
References: <200511301046.25700.mgorbach@yahoo.com>
Content-Type: text/plain
Message-Id: <1133371601.18079.39.camel@blade>
Mime-Version: 1.0
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
Date: Wed, 30 Nov 2005 18:26:41 +0100

Hi Michael,

> Sorry about a typo ... When i wrote "mouse" i meant keyboard. My dinovo 
> keybord is stuck in f-lock mode after I run hid2hci. Actually ... the f-keys 
> seem to be working in console mode (outside of x). Inside x, it xev shows a 
> kepress of the event "f12" but nothing seems to happen. Weird isnt it?
> Is it a problem with x keybindings? Also ... is there no way to put the device 
> out of hci mode when the system shuts off so that I can have access to GRUB 
> and my BIOS? The windows drivers seem to be OK doing this ...

are you using the -mh patch?

Try to sniff the sequence of setting the device back into HID mode and
then we can add it to hid2hci.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
