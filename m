Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200512021834.19314.mgorbach@yahoo.com>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
Content-Type: text/plain
Message-Id: <1140642881.3319.10.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Bitstuffing in a Rfcomm connection?
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
Date: Wed, 22 Feb 2006 18:14:41 -0300

Hi everybody,

I'm writing an application that communicates using rfcomm connections.
This application communicates with mobile devices. In order to debug the
application I also wrote a mobile device emulator that runs in a
computer.

Here's the problem:
When the application connects to the mobile device everything works
fine. But when the application connects to the computer emulating a
device, I obtain, mingled with the data the following bytes:
"00 5E 40". Sometimes these bytes are together. Some other times these
bytes are spreaded among the real data bytes. These additional bytes
keeps the application from synchronizing with the emulated device.

My question is: when an rfcomm connection is stablished between two
computers, is there some bit/byte stuffing involved?

Thanks a lot!

Agustin Fusaro - Apexar Technologies



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
