Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1100206677.4193d255a3140@support.tuxbox.dk>
From: Martin List-Petersen <martin@list-petersen.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Audio & Bluetooth
References: <418FC205.7070102@tootai.net> <1099943857.29330.27.camel@pegasus>
In-Reply-To: <1099943857.29330.27.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 11 Nov 2004 20:57:57 +0000

Citat Marcel Holtmann <marcel@holtmann.org>:

> actually this is not an easy to answer question. First thing is that you
> should get a Bluetooth device with a CSR chip and at least HCI 16.x
> firmware on it. The second is that it must route the SCO traffic through
> the HCI and via a PCM. Then it should be possible.

Getting back to this (and just to clarify this exactly).

on hciconfig hci0 revision: "SCO mapping:  PCM" is good ? And "SCO mapping: 
HCI" is bad ? 

Is there anyway that can be done to this in regards to audio ?

Kind regards,
Martin List-Petersen
-- 
Violence in reality is quite different from theory.
		-- Spock, "The Cloud Minders", stardate 5818.4



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
