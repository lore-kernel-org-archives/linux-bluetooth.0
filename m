Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ with 2.6.4 kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: patilabh@cse.msu.edu
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040330201859.75357.qmail@web10911.mail.yahoo.com>
References: <20040330201859.75357.qmail@web10911.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1080687412.2773.39.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 31 Mar 2004 00:56:52 +0200

Hi Abhishek,

> I'm having trouble getting BlueZ to work with the new kernel (2.6.4). I am
> using a 3COM Bluetooth USB device. 
> 
> I checked Marcel's website and didnt find any patch for the 2.6.x kernel.
> so, I assume that I dont need to patch the 2.6 kernel... please correct me
> if I am wrong.

	http://www.bluez.org/patches.html

> My kernel compilation went smoothly and after the first reboot, I installed
> the latest bluez-libs and bluez-utils with no errors. After another reboot,
> I tried starting bluez:
> 
> [root@abhishek-pc BlueZ]# modprobe bluez
> FATAL: Module bluez not found.
> [root@abhishek-pc BlueZ]# modprobe hci_usb
> [root@abhishek-pc BlueZ]# modprobe hci0 up
> FATAL: Module hci0 not found.

It is "modprobe bluetooth" in 2.6 and it is "hciconfig hci0 up". However
nothing of that is needed if you have hotplug installed and hcid is
running.

> lsmod shows the following:
> 
> [root@abhishek-pc BlueZ]# lsmod
> Module                  Size  Used by
> snd_seq_oss            32576  0
> snd_seq_midi_event      6272  1 snd_seq_oss
> snd_seq                52400  4 snd_seq_oss,snd_seq_midi_event
> snd_pcm_oss            49220  1
> snd_mixer_oss          17536  1 snd_pcm_oss
> snd_via82xx            21792  1
> snd_pcm                88128  2 snd_pcm_oss,snd_via82xx
> snd_timer              22080  2 snd_seq,snd_pcm
> snd_ac97_codec         60548  1 snd_via82xx
> snd_page_alloc          9348  2 snd_via82xx,snd_pcm
> snd_mpu401_uart         6208  1 snd_via82xx
> snd_rawmidi            20800  1 snd_mpu401_uart
> snd_seq_device          6468  3 snd_seq_oss,snd_seq,snd_rawmidi
> hci_usb                12224  0
> bluetooth              44452  1 hci_usb
> usbcore                63904  1 hci_usb
> autofs                 14464  0

Actually I miss "uhci_hcd" or "ohci_hcd".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
