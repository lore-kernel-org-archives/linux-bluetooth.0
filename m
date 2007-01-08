Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Damien Bardon <damien@bardon-net.fr>
To: Bluez-users@lists.sourceforge.net
Date: Mon, 8 Jan 2007 19:35:15 +0100
MIME-Version: 1.0
Message-Id: <200701081935.15944.damien@bardon-net.fr>
Subject: [Bluez-users] My device can't be detected by another one
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


Hello,

I have the following problem, I don't really know where to find a solution, 
that is why I ask for your help. I have a Cambridge Silicon Radio, Ltd 
Bluetooth Dongle (Bus 001 Device 017: ID 0a12:0001), regarding the list 
here : http://www.wiili.org/index.php/Compatible_Bluetooth_Devices this 
device should work with linux. I have an OpenSuse 10.2, and the device is 
perfectly detected, and I can see other devices and connect to them. The 
problem is that other devices (I have tried with two different mobile phones, 
one nokia and one samsung) can't see my device. Which means that for example, 
I can send a file from my laptop to my phone, but can't send a file from my 
phone to my laptop. My linux seems to be configured to be able to be 
detected, but I have probably missed something and I hope you can tell me 
what.

Here is the content of /etc/bluetooth/hcid.conf

options {
        autoinit yes;
        security auto;

        pairing multi;

        passkey "0123";
}

device {
        name "damienlap";

        class 0x3e010c;

        iscan enable;
        pscan enable;

        lm accept;

        lp rswitch,hold,sniff,park;
}

Tell me if you need more details.

Thanks a lot,

Damien


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
