Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hid2hci: No devices in HCI mode found
From: Marcel Holtmann <marcel@holtmann.org>
To: Alberto Garcia Hierro <tcpdevil@linuxlover.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200410081543.46448.tcpdevil@linuxlover.org>
References: <3eef79ed04100803094fd88c74@mail.gmail.com>
	 <1097234566.4407.1.camel@pegasus>
	 <200410081543.46448.tcpdevil@linuxlover.org>
Content-Type: text/plain
Message-Id: <1097246961.4407.18.camel@pegasus>
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
Date: Fri, 08 Oct 2004 16:49:22 +0200

Hi Alberto,

>  I think there isn't any problems in the Gentoo package. I'm pretty sure the 
> problem is a bad configuration. Change HID2DCI_ENABLE=true to 
> HID2DCI_ENABLE=false in /etc/conf.d/bluetooth and the message will 
> dissappear.

actually it is safe to run hid2hci every time at boot even if you don't
own a HID Proxy Bluetooth dongle, but in that case you shouldn't see any
error messages. So using the -q switch is better.

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
