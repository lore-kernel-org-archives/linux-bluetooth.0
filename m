Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <30ed240e0704020327v6003dd05v22c659c4e8103e87@mail.gmail.com>
Date: Mon, 2 Apr 2007 20:27:11 +1000
From: "Brett Owen Rees VK2TMG " <breree@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] problems with getting Plantronics M1000 to pair on
	Ubuntu system
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello all,

I am new to this list and to Bluetooth. I have a Plantronics M1000
headset and a Belkin USB dongle. The headset works ok with my Nokia
phone, and it worked _once_ with my Ubuntu 6.06 system but now refuses
to work. When it worked I could use aplay and arec to play and record
from the device and all seemed good. However, if I run hcitool scan
now I can see that the pairing mode at the headset eventually times
out. I tried deleting the files in /var/lib/bluetooth/_mac_address_
and restarting the daemons but still no go.

What I am trying to achieve is to build a wireless vox headset to my
HF ham radio - with the linux box performing compression and vox, as
well as DSP processing of the receive audio - however, I am finding it
hard just getting started.  Any help is greatly appreciated.

Thanks,
Brett

-- 
===============
Brett Rees VK2TMG

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
