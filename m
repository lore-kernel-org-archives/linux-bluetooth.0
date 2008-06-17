Return-Path: <cyrus@holtmann.org>
Message-ID: <07dc01c8d052$bb617080$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc><499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si><060701c8cf51$f8730fd0$0132a8c0@Raymondpc><499929A843E2C541A8AD31A881A2B6A2019C136C@hsl-lj-mail.hermes.si>
	<078501c8d02f$587b1200$0132a8c0@Raymondpc>
Date: Tue, 17 Jun 2008 16:18:18 +0800
MIME-Version: 1.0
Subject: [Bluez-devel] What't the difference between HIDD / HID2HCI /
	Bluetoothd-service-input ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi

    I want to run up an hid daemon to connect hid device.

    I notice that there are several bin as :

    hidd
    hid2hci
    bluetoothd-service-input

    I try to figure out what is their difference by man, however , the man 
has only very short description. And also , I did not find many documents on 
how to write the related config files for each bluez daemons.

    So
    1. Is there any good documents on describe the setting of different 
bluez daemons ? Or is there any good sample on setting up the daemons from 
scratch on embedded board ?
    2. I can see on pc and on some system, it run bluetoothd-service-input 
but no hidd found. Is that hidd is out of date and replaced ?
    3. Is the same situation with bluetoothd-service-audio and etc ?
    4. Is that possible to use bluez to simulate a hid device ? say 
providing mouse function instead of acting as a server to use bt mouse ?

Thanks.

Raymond 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
