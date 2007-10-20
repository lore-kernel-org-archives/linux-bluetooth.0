Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4719FE5F.3030003@vsnl.com>
Date: Sat, 20 Oct 2007 18:40:55 +0530
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
From: Mohan Sundaram <mohan.tux@gmail.com>
Subject: [Bluez-users] Ubuntu 7.10 and Moto L6
Reply-To: smohan@vsnl.com, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I had a lot of trouble getting BlueZ pairing up in Feisty. Upgraded to 
Gutsy BlueZ 3.0. Headset paired out of the box. Having problems with 
Moto L6 pairing. I want to use the phone with kmobiletools.

Gutsy says bluez-pin is depracated. syslog shows /org/bluez/passkey as 
registered agent. However, when I try to pair, I'm not asked for the 
key. Gnome did not show the Moto L6 as bonded.

Things I've tried so far:
1. hcitool scan and inq return the bdaadr.
2. sdptool browse shows DUN on channel 1.
3. I've bound rfcomm0 to the bdaddr channel 1.
4. hcitool cc bdaddr does not return anything but prompt.
5. hcitool con shows no connections.
6. hcitool auth bdaddr says not connected.

root@smohan-laptop:/home/smohan# rfcomm
rfcomm0: 00:17:84:85:5C:1E channel 1 clean
root@smohan-laptop:/home/smohan# rfcomm connect rfcomm0 00:17:84:85:5C:1E
Can't connect RFCOMM socket: Permission denied
root@smohan-laptop:/home/smohan#

Newest kmobiletools 0.5 does a search thro' all rfcomms for a DUN
connection. My phone does pop up a screen that vanishes immediately.
The Moto phone brings up a screen asking conf for connect even though it
is set to auto connect. The screen pops up and goes away immediately
not allowing me to hit the confirm key.

I tried dbus-send as stated in the wiki.
root@smohan-laptop:/etc/default# dbus-send --system --type=method_call
--print-reply --dest=org.bluez /org/bluez/hci0 
org.bluez.Adapter.CreateBonding
string:00:17:84:85:5C:1E
method return sender=:1.281 -> dest=:1.288 reply_serial=2

A notification window popped up where I keyed in the passkey and the 
phone asked me for a passkey which I gave. They bonded. Got somewhere.

After this, still kmobiletools behaves like before. My hcid.conf does 
not have any pin helpers defined. Do I need to define dbus passkey agents?

Need help please.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
