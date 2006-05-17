Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446B1E35.4080009@trn.iki.fi>
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVu?= <tronic+bdtmwkm6@trn.iki.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] rfcomm disconnects + hcid dying
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 May 2006 15:59:33 +0300

PROBLEM 1:

Whenever /dev/rfcomm0 (or rfcomm1) is closed, the corresponding Bluetooth 
device gets disconnected and I have to run hcitool cc xx:xx:xx:xx:xx:xx to 
get it working again. How can I have the devices automatically connected 
at all times whenever they are within reach and the USB BT dongle is 
plugged in?

My current workaround is an endless while loop that runs hcitool cc all 
the time, but this is obviously quite ugly. It works, but I'd really want 
to have something more elegant.


PROBLEM 2:

My hcid keeps dying occassionally. I don't know why, but it just does 
that. My current workaround is to have the init system restart it whenever 
it dies, but this, too, is somewhat ugly. Haven't found any messages about 
that in the logs yet, but that is partly because my log was flooded with 
other stuff.


- Tronic -



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
