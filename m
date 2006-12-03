Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: eberhard.hackl@ise-hackl.at,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200612011603.03063.eberhard.hackl@ise-hackl.at>
References: <200612011603.03063.eberhard.hackl@ise-hackl.at>
Date: Sun, 03 Dec 2006 14:33:40 +0100
Message-Id: <1165152820.19590.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BT connection problem
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

Hi Eberhard,

> I am working with SuSE 10.1 and try to copy photos from my Kodak Easy Share  
> camera to the computer. The kbluetoothd is started and the usb bluetooth 
> stick was found. 
> On sending data the pairing works fine. But after commiting the pin the camera 
> tells me that there is a connection error. After this the kbluetoothd stays 
> connected with the camera. 
> I have no problems to copy data (with obex) from the computer to the camera, 
> and also the copy of data from the camera to other devices is no problem. So 
> that means, that there is something wrong on my linux system. 
> 
> Can anyone help me! I tried to find the problems with hcitool and hciconfig. 
> But there everything looks fine. Maybe I need a special service for the 
> camera...

maybe, but I am not an expert when it comes to the KDE support for
Bluetooth. However you can run "hcidump -X -V" as root and see what
happens there.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
