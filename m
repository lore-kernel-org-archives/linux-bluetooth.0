Return-Path: <cyrus@holtmann.org>
Message-ID: <4F7349EC.8080706@tu-ilmenau.de>
Date: Wed, 28 Mar 2012 19:27:08 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: problem with using BPA500
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

i have a problem with sniffing my 2 bluetooth devices. Google & forums 
didn't helped me.
I use the BPA500 for sniffing two BT3.0 devices; maybe someone of you 
also use this. This is my problem:
The frontline technical support told me, that i have to put my devices 
in discovery mode & at least one device in ssp debug mode. And it is 
important that the devices get paired AFTER i click on "Start Sniffing". 
I did so, but in my LMP there is some Opcode missing. There is only:
...
au_rand
sres
encrypt_mode_req

But there SHOULD be something like that:
...
comb_key
au_rand
sres
au_rand
sres
setup_complete
encrypt_mode_req

I think there is no problem with the BPA software, because when i sniff 
BT2.0 devices, everything works fine (because i don't have to use a ssp 
debug mode). And the BPA-support says, there are two possible misstakes: 
either the devices are paired before sniffing, or no device is in 
sspdebug mode. But i think i did this right.

Maybe you find out what i did wrong:

- two gentoo-PCs with two BT3.0 Dongles and i installed the latest bluez 
& the patch "Adding SSP debug mode configuration to hciconfig" on both PCs
PC2 # hciconfig hci0 piscan
PC1 # hciconfig hci0 piscan
PC1 # hciconfig hci0 sspdebug 1
(in a 2nd try also: PC2 # hciconfig hci0 sspdebug 1)
click on "start sniffing" at the software
PC2 # rfcomm listen 0 1
PC1 # rfcomm -r connect 0 <bluetooth-adress> 1

The connection worked (as seen on the two conncted PCs) but the sniffing 
software didn't really captured it. The Icon is blue indeed (so it's 
synchronized), but somehow there is missing something, because it 
doesn't sniff correctly.

Hope someone of you can help me.

Regards,
Steffen
