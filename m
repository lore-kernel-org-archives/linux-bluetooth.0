Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hello
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41AB1804.8070807@Uni-Bielefeld.de>
References: <41AA81F0.8080005@bielefeld.ccc.de>
	 <1101694796.9527.13.camel@pegasus>  <41AB1804.8070807@Uni-Bielefeld.de>
Content-Type: text/plain
Message-Id: <1101732250.10115.3.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 29 Nov 2004 13:44:10 +0100

Hi Nick,

> | check with "hciconfig hci0 revision" (as root) for the setting of
> | the SCO routing. I think it is set to PCM.
> 
> you were right:
> 
> (0:1)root@Muramasa:~$ hciconfig hci0 revision
> hci0:   Type: USB
> ~        BD Address: 00:60:57:02:95:FE ACL MTU: 192:8  SCO MTU: 64:8
> ~        HCI 12.7
> ~        Chip version: BlueCore01b
> ~        SCO mapping:  PCM
> 
> so, is that the way it should be?

to use your dongle with a headset it must be set to HCI. This value is
stored in the PS keys and it is changeable, but there exists no free
tool for this job.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
