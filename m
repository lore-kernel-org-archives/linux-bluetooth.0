Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hcitool rssi/tpl/lq
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris Dawson <chrisdawsonuk@lycos.co.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041008181039.B8513AB201@lmcodec02.st1.spray.net>
References: <1302.213.112.80.112.1097230559.squirrel@webmail.nada.kth.se>
	 <1097234685.4407.3.camel@pegasus>
	 <20041008181039.B8513AB201@lmcodec02.st1.spray.net>
Content-Type: text/plain
Message-Id: <1097262689.4848.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 08 Oct 2004 21:11:29 +0200

Hi Chris,

> I've got Bluez going now on newly installed Fedora Core 2 (thanks Jouni 
> Lohikoski for the pointer).
> 
> I can scan for devices with 'hcitool scan' or inq, but I really want to play 
> with the rssi and lq options... when I try them I get "Not connected".  When 
> I try to connect ('hcitool cc 00:0a....) I get "Can't create connection. 
> Operation not permitted". This is the same with two remote devices: one 
> laptop, one T68i.
> 
> Can someone let me know how to get RSSI and LQ from a device? Do they need 
> to be connected/paired? - ideally I'd like to be able to get both from 
> unpaired & unconnected devices.

they don't need to be paired, but they need to be connected. If you
wanna use "hcitool cc ..." then you must do this as root, but you can
also connect to a service via rfcomm etc. and then request RSSI or the
link quality.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
