Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Laszlo Sogor" <shogy@shogy.ohsh.u-szeged.hu>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1AaCHm-0004YL-00@shogy.ohsh.u-szeged.hu>
Subject: [Bluez-users] Linux + Bluez problem
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
Date: Sat, 27 Dec 2003 12:07:10 +0100

Hi all,

I have a problem with the Bluetooth connection between my computer and
my phone. Sometimes it drops the Bluetooth connection, I could reproduce
it in two different ways:

case #1
I use GPRS with my phone, the phone is connected to my computer using
Bluetooth. When I try to retrieve a page with images, the Bluetooth
connection fails with high probability (90 %).

I use /dev/rfcomm2 to access DUN (channel 1) service of my phone.
I monitored the Bluetooth connection with l2ping:

# l2ping 00:60:57:2F:11:8C
...
0 bytes from 00:60:57:2F:11:8C id 215 time 94.99ms
0 bytes from 00:60:57:2F:11:8C id 216 time 121.83ms
0 bytes from 00:60:57:2F:11:8C id 217 time 26.51ms
no response from 00:60:57:2F:11:8C: id 218
no response from 00:60:57:2F:11:8C: id 219
no response from 00:60:57:2F:11:8C: id 220
no response from 00:60:57:2F:11:8C: id 221
Recv failed: Software caused connection abort
#

At this point, the pppd drops the connection and the Bluetooth subsystem
will be unusable until I remove and re-insert the USB dongle (for the sw 
and
hw specification, see the end of the mail).

Unfortunately I have only one Buetooth device, so I could not determine 
whether the error is in the device, the driver or anything else.


case #2
I use p3nfs package (5.12) to mount my phone (Symbian Series 60). I 
mounted the phone and did some tests:
- in a loop
 - copy a large (3MB) file to the phone
 - wait 20 seconds
 - delete the file
- monitor the Bluetooth connection

I found that the Bluetooth connection failed just like when I used GPRS.

Used SW:
- Linux kernels 2.4.22 and 2.4.23 (with and without -mh1 patch for both)
- Debian Woody and Sarge
- bluez-libs-2.4 with bluez-utils-2.3
- bluez-libs-2.5 with bluez-utils-2.4

Used HW:
- Nokia 3650 (sw ver 3.16)
- Epox BT-DG03 USB dongle

I checked IRDA, it works perfectly.

I did not find anything that can help in the system logs.

Has anyone meet with this problem yet? Any tips?

Thanks,

shogy



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
