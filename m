Return-Path: <patilabh@msu.edu>
Message-ID: <406A3B62.40006@msu.edu>
Date: Tue, 30 Mar 2004 22:30:42 -0500
From: Abhishek Patil <patilabh@msu.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ with 2.6.4 kernel
References: <20040330201859.75357.qmail@web10911.mail.yahoo.com> <1080687412.2773.39.camel@pegasus>
In-Reply-To: <1080687412.2773.39.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Thanks a lot for your reply. The patch helped.. my BT systems is up and 
running... and with hotplug installed all I need to do is just start hcid.

Regards,
Abhishek

Marcel Holtmann wrote:
> Hi Abhishek,
> 
> 
>>I'm having trouble getting BlueZ to work with the new kernel (2.6.4). I am
>>using a 3COM Bluetooth USB device. 
>>
>>I checked Marcel's website and didnt find any patch for the 2.6.x kernel.
>>so, I assume that I dont need to patch the 2.6 kernel... please correct me
>>if I am wrong.
> 
> 
> 	http://www.bluez.org/patches.html
> 
> 
>>My kernel compilation went smoothly and after the first reboot, I installed
>>the latest bluez-libs and bluez-utils with no errors. After another reboot,
>>I tried starting bluez:
>>
>>[root@abhishek-pc BlueZ]# modprobe bluez
>>FATAL: Module bluez not found.
>>[root@abhishek-pc BlueZ]# modprobe hci_usb
>>[root@abhishek-pc BlueZ]# modprobe hci0 up
>>FATAL: Module hci0 not found.
> 
> 
> It is "modprobe bluetooth" in 2.6 and it is "hciconfig hci0 up". However
> nothing of that is needed if you have hotplug installed and hcid is
> running.
> 
> 
>>lsmod shows the following:
>>
>>[root@abhishek-pc BlueZ]# lsmod
>>Module                  Size  Used by
>>snd_seq_oss            32576  0
>>snd_seq_midi_event      6272  1 snd_seq_oss
>>snd_seq                52400  4 snd_seq_oss,snd_seq_midi_event
>>snd_pcm_oss            49220  1
>>snd_mixer_oss          17536  1 snd_pcm_oss
>>snd_via82xx            21792  1
>>snd_pcm                88128  2 snd_pcm_oss,snd_via82xx
>>snd_timer              22080  2 snd_seq,snd_pcm
>>snd_ac97_codec         60548  1 snd_via82xx
>>snd_page_alloc          9348  2 snd_via82xx,snd_pcm
>>snd_mpu401_uart         6208  1 snd_via82xx
>>snd_rawmidi            20800  1 snd_mpu401_uart
>>snd_seq_device          6468  3 snd_seq_oss,snd_seq,snd_rawmidi
>>hci_usb                12224  0
>>bluetooth              44452  1 hci_usb
>>usbcore                63904  1 hci_usb
>>autofs                 14464  0
> 
> 
> Actually I miss "uhci_hcd" or "ohci_hcd".
> 
> Regards
> 
> Marcel
> 
> 
> 
