Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <302E52C4-FCAB-11D8-B286-000D93C1FAF6@hairstock.fi>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: bluez-users@lists.sourceforge.net
From: Tuomas Peronvuo <tuomas.peronvuo@hairstock.fi>
Subject: [Bluez-users] Apple Wireless Keyboard, MX900-Hub & Mouse with FC2
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
Date: Thu, 2 Sep 2004 09:41:58 +0300

Hi!

First of all, I apologize if this sounds  vague, but I'll give my best 
shot.

The problem:

Trying to get the apple wireless keyboard and mx900-bluetooth -mouse 
working
in fedora core 2 (kernel 2.6.8-1.521) via the usb mx900 bluetooth-hub.

Installed: Bluez libs & utils & devs.

I've read Marcel Holtmanns 
http://www.holtmann.org/linux/bluetooth/hid.html -"guide"
and modprobed that I certainly have the hidp-module, but I'm not sure 
if the selection
"CONFIG_BT_HIDP" is enabled/selected.

My first question is: how do I check if the HIDP is enabled? And if 
it's not, how do I enable it?

Secondly and oddly enough, the mx900-mouse does work perfectly okay in 
my current setup via
the mx900 usb-bluetooth-hub. But when I run hcitool and try to find any 
devices, i get squat.

And the same thing with runing hidd, it also finds nothing.  My best 
guess is, that they both can't find
nothing because the CONFIG_BT_HIDP is not enabled?

Any good guide (step by step)  or advices considering the 
apple/hidp/mx900-hub -issue would be greatly appreciated.

Thanks!












-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
