Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Mick Wever <hair@netbeans.org>
Message-ID: <pan.2004.03.29.08.17.54.697624@netbeans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] Bluetooth device missing after kernel recompile
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
Date: Mon, 29 Mar 2004 10:17:55 +0200

After recompiling my kernel (2.6) bluetooth has stopped working for me.
lsmod gives me the required modules.
When I type 'hcitool scan' I get:
"Device is not available.: Success".
And 'hcitool inq' gives me:
"Inquiring ...
Inquiry failed.: No such device".
'hcitool dev' does not output any devices.

What am I missing? What is the /dev device file that is used? How do I
create the local device again if that is what's needed?

Mick.

lsmod output:
Module                  Size  Used by 
hci_usb                11904  0
hci_vhci                5248  0
hci_uart               15056  0
bnep                   10880  0
rfcomm                 25624  0
l2cap                  20868  4 bnep,rfcomm 
sco                     11012 0
bluetooth              42852  7 hci_usb,hci_vhci,hci_uart,bnep,rfcomm,l2cap,sco 
sg                     28960  0
i830                   66860  2
ohci_hcd               14852  0
intel_agp              15516  1
agpgart                25384  3 intel_agp 
uhci_hcd               28304  0
i810_audio             27540  0
ac97_codec             16524  1 i810_audio 
snd_intel8x0           28584  0
snd_ac97_codec         57092  1 snd_intel8x0 
snd_pcm                 81928 1 snd_intel8x0 
snd_timer              21380  1 
snd_pcm gameport        3712  1 snd_intel8x0 
snd_page_alloc          9220  2 snd_intel8x0,snd_pcm 
snd_mpu401_uart         6144  1 snd_intel8x0
snd_rawmidi            20000  1 snd_mpu401_uart 
snd_seq_device          6536  1 snd_rawmidi 
snd                    44260  7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
sbp2                   20488  0
scsi_mod               64172  2 sg,sbp2 
eth1394                17416  0
ohci1394               30340  0
ieee1394               90680  3 sbp2,eth1394,ohci1394 
hid                    29760  0
ehci_hcd               22916  0
usbcore                87644  7 hci_usb,ohci_hcd,uhci_hcd,hid,ehci_hcd

Mick.

-- 
-- <BR/>
"This above all: to thine own self be true. It must follow that you cannot then be false to any man." Shakespeare
<BR/> --- <a href=http://www.harryspractice.com.au>Harry's Practice</a> --- 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
