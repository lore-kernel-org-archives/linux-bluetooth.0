Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Chris Dawson" <chrisdawsonuk@lycos.co.uk>
To: <bluez-users@lists.sourceforge.net>
References: <1302.213.112.80.112.1097230559.squirrel@webmail.nada.kth.se> <1097234685.4407.3.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Message-Id: <20041008181039.B8513AB201@lmcodec02.st1.spray.net>
Subject: [Bluez-users] Hcitool rssi/tpl/lq
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
Date: Fri, 8 Oct 2004 19:10:39 +0100

Hi all,

I've got Bluez going now on newly installed Fedora Core 2 (thanks Jouni 
Lohikoski for the pointer).

I can scan for devices with 'hcitool scan' or inq, but I really want to play 
with the rssi and lq options... when I try them I get "Not connected".  When 
I try to connect ('hcitool cc 00:0a....) I get "Can't create connection. 
Operation not permitted". This is the same with two remote devices: one 
laptop, one T68i.

Can someone let me know how to get RSSI and LQ from a device? Do they need 
to be connected/paired? - ideally I'd like to be able to get both from 
unpaired & unconnected devices.

Thanks
Chris 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
