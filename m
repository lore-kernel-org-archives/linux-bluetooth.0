Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: andreas knuth <andreas.knuth@daimlerchrysler.com>
Message-ID: <loom.20050628T180644-282@post.gmane.org>
References: <loom.20050624T164608-144@post.gmane.org> <20050627080102.85B8E1EA336@mrelay1.st2.lyceu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: BlueZ, Linux and Windows
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
Date: Tue, 28 Jun 2005 16:08:29 +0000 (UTC)


> 
> Hi Andreas
> 
> I have review all information in Bluez home page and the one provided by
> you. Most of it is outdated... I haven't managed to get it into work. I
> think I'm missing some basic step... Let me explain you what I have done...
> - Install Fedora 4 (gnome-bluetooth, gnome-bluetooth-libs, bluez-hcidump,
> bluez-pin, bluez-utils, bluez-libs included)
> - hciconfig hci0 up
> - hciconfig (shows the device up and running)
> - hitool scan
> - mknod /dev/rfcomm0 c 216 0
> - sdptool browse <addr>
> - modify /etc/Bluetooth/rfcomm.conf
> 	Rfcomm0 { 	bind yes;
> 			device <addr>;
> 			channel 1;
> 			comment "FC4-BT";
> 		  }
> - Create file: /etc/bluetooth/mypin;
> 	#!bin /bash
> 	echo "PIN:1111"
> - In /etc/Bluetooth/hcid.conf
> 	pin_helper /etc/Bluetooth/my-pin
> 
> - hcid -f /etc/Bluetooth/hcid.conf (to reload file)
> - rfcomm connect /dev/rfcomm0 <addr> 1

Hi Esther 

anyhow you should play a little bit with "hcidump -X" for for getting in touch 
with the bluetooth stack communication.

When you would like to connect to another device then you normally would like 
to use (connect to) a service (on that device). For reaching this try to read 
out the service database of the other device (e.g. sdptool search ...). with 
this information you could select the service you would like to connect (on the 
other device). <= e.g. take the corresponding channel on the other device and 
connect to them.

Which address did you used? What is behind the channel 1? Did you checked the 
sdp database on the other device??
Does your hcidump trace shows a successful PIN delivering to the BT-chip (on 
the linux pc)?


When you try to connect your phone (e.g. in the context of sending vcards)to a 
clean bluetooth linux-pc then this will fail beause of missing "active" sdp-
records (eg. OPUSH, HF) with the specific channel number Y, a listening rfcommX 
socket on channel Y and some kind of server functionality (which takes the 
vcard) which will be called from rfcommX.  


Regards Andreas






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
