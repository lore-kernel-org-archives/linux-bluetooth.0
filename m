Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <453915B1.2010303@brainhub.org>
Date: Fri, 20 Oct 2006 11:30:09 -0700
From: Andrey Jivsov <bluetooth@brainhub.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45390A62.4050805@htt-consult.com>
In-Reply-To: <45390A62.4050805@htt-consult.com>
Subject: Re: [Bluez-users] Current information on bluetooth mouse support
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Robert Moskowitz wrote:
> I am trying to find information on bluetooth utilities.  Everything I 
> have found so far is either at least a year old, and does not map to 
> files on my system.
> 
> Anyway, I have an HP NC4010.
> 
> I am using a Cables Unlimited dongle:
> 
> /usr/sbin/hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0D:18:01:20:B9 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:491300 acl:31961 sco:0 events:5005 errors:0
>         TX bytes:5297 acl:136 sco:0 commands:205 errors:0
>         Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'nc4010.htt-consult.com-0'
>         Class: 0x120104
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver: 
> 0x512
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> So far I have been working with my IOgear mouse.
> 
> After much effort, I have gotten it connected and authenticated.  Now if 
> I turn it on and press its connect button I can then do a:
> 
> hidd --search
> Searching ...
>         Connecting to device 00:0A:94:C0:C3:19
> 
> and
> 
>  hcitool info 00:0A:94:C0:C3:19
> Requesting information ...
>         BD Address:  00:0A:94:C0:C3:19
>         Device Name: Bluetooth Mouse
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x356
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
> packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
> 
> But I loose connection with this mouse if it goes idle long enough, and 
> so far I have had to power it off and reconnect.
> 
> I have read messages like:
> 
> http://article.gmane.org/gmane.linux.bluez.user/6609/match=automatically+accepting+pairing+mouse
> 
> But I don't have a /etc/default/bluez-utils file to add:
> 
> 	HIDD_ENABLED=1
> 	HIDD_OPTIONS="--server"
> 
> Nor can I figure out what file this now goes into.
> 

Hello Robert. I successfully solved this problem. You don't even need to 
power-off or reset the mouse. Follow the directions in my earlier e-mail:

http://sourceforge.net/mailarchive/forum.php?thread_id=30640322&forum_id=1883
( or search for "Microsoft IntelliMouse with kernel 2.6.18 and 
patch-2.6.18-mh1 is broken (fix provided)" ).

> Also how do I get the Gnome bluetooth tools working on my Centos desktop?
> 
> I still have my headphone, stereo headset, and TREO 650 to connect....
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
