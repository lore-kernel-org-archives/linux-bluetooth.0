Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAkBwT9CxMpEGdJ0wBhZZ8JcKAAAAQAAAA6dBpOZC2R0mjNYo5QIcv4QEAAAAA@acselection.co.uk>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAkBwT9CxMpEGdJ0wBhZZ8JcKAAAAQAAAA6dBpOZC2R0mjNYo5QIcv4QEAAAAA@acselection.co.uk>
Content-Type: text/plain
Message-Id: <1119442492.26772.162.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 22 Jun 2005 14:14:52 +0200

Hi Andy,
> 
> I am writing to enquire about an issue I'm having, it is as follows. I
> have a Sony Vaio Laptop (VGN-B1XP) with Ubuntu Linux installed
> (2.6.10-5-386) and a 3Com Bluetooth Card (3CRWB6096), I have installed
> all of the bluez utilities and unzipped the firmware file from 3Com
> (BT3CPCC.bin), when i insert the card i get the following error is
> dmesg: 
>  
> bt3c_open: Firmware request failed 
> bt3c_interrupt: Call if irq 3 for unknown device
>  
> And in syslog:
>  
> kernel: cs: pcmcia_socket: unable to supply power
> cardmgr[6912]: socket 0: 3Com Bluetooth PC Card
> cardmgr[6912]: executing: 'modprobe bt3c_cs'
> kernel: bt3c_open: Firmware request failed 
> kernel: bt3c_interrupt: Call if irq 3 for unknown device
> cardmgr[6912]: get dev info on socket 0 failed: Resource temporarily
> unavailable
>  
> It seems to me that the issue is that bt3c_cs cannot find the firmware
> file, although i have tried everywhere noted on the net. I have also
> tried changing the reference in bt3c_cs from BT3CPCC.bin
> to /T3CPCC.bin and dropping that file in the system root.
>  
> I think its looking (for the firmare) somewhere specific to Ubuntu but
> i can't find where.

check out http://www.bluez.org/drivers.html and make sure that you
installed the hotplug package and that firmware.agent is present.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
