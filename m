Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <401267F8.9080308@Fampeeters.com>
From: Francesco Peeters <Francesco@Fampeeters.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] hci_cmd_task: hci0 command tx timeout
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
Date: Sat, 24 Jan 2004 13:41:28 +0100

I am running Fedora Core 1 now, with all BlueZ RPMs installed.

My Sitecom BT (CN-500) dongle is recognized and my laptop and T|T3 are 
paired.
When I do a hcitool scan and hcitool info, I see the T|T3.

I have hci and sdpd running, and dund --listen --msdun --channel 1 
10.50.164.3:10.50.164.4

I have sucessfully created the connection setup and network setup on the 
T|T3, but whenever I press the connect button, the T|T3 times out and 
the linux machine gives an error:
hci_cmd_task: hci0 command tx timeout

Any idea what to look for, or is this old laptop just *too* slow?

TIA!

--FP
PalmOS user since Pilot1000
 Tungsten|T3 owner, still learning new DateBK5 tricks every day!
Linux user since RedHat 4.0
 Just started playing with Fedora Core 1




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
