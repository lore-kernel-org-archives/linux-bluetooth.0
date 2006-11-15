Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <455B8696.2010405@xmission.com>
Date: Wed, 15 Nov 2006 14:28:54 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <455B6987.3070703@gmail.com>
In-Reply-To: <455B6987.3070703@gmail.com>
Subject: Re: [Bluez-users] Low quality audio on Bluetooth Headset
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

Manuel

> I have a pair of Hifi bluetooth hearphones, that AIRcable 
> (www.aircable.net) send to me. I use it under Windows and Linux, it 
> cames with a usb bt dongle, that is recognized as a usb-sound card which 
> works perfectly, the thing is that when I try to use the headset with a 
> generic Bluetooth Dongle (using a2dpd) I get very low quality audio. I 
> think the headphones work at 22kHz, and I don't get more than 11kHz when 
> I use a2dpd, is there anything that I can do to fix this (including 
> doing some code :D)

what kind of quality problem? Is it only the low sampling rate or is it
one of the other problems? (low volume... popping sounds... played too
fast or slow... static...)

a2dp headsets are required to support 44.1khz btw.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
