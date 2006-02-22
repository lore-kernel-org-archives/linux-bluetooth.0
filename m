Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] /dev/rfcomm256 ...?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <DE083D10-98AA-41A8-8A08-DC4CEEC3B6BF@epfl.ch>
References: <DE083D10-98AA-41A8-8A08-DC4CEEC3B6BF@epfl.ch>
Content-Type: text/plain
Message-Id: <1140603337.4519.1.camel@localhost>
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
Date: Wed, 22 Feb 2006 11:15:37 +0100

Hi Thomas,

> rfcomm devices with a number > 255 (e.g. /dev/rfcomm256) in "/etc/ 
> bluetooth/rfcomm.conf" seem to be ignored by rfcommd. Is this a hard  
> limit, or does anyone know a simple way to increase this? We  
> currently have about 400 devices that should go into that file.

yes, that is a hard limit. We only have 256 minor device numbers
available and that is actually quite a lot. Describe your use case,
because creating more than 256 TTY seems not like one of the best ways
to go.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
