Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: tobi <tobi@biertrinken.rocks>
Subject: warmreset breaks communication with CSR8811
Message-ID: <c20e33c4-ff97-00de-9fb2-e70b0d3b983a@biertrinken.rocks>
Date: Tue, 22 May 2018 13:30:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

i have problem connecting bluez (currently im using 5.49 from 
debian:unstable and linux-4.14) to my CSR8811 (connected via 2 wire UART).
hciattach works and i can use some bccmd commands but when i do a 
warmreset (to activate my pskey changes) bluez seems unable to get a valid
reply from the chip :-(

here my commands:

root@BLOKS ~# hciattach -s 38400 /dev/ttyS1 bcsp 38400 noflow
Device setup complete
root@BLOKS ~# hciconfig
hci0:    Type: Primary  Bus: UART
     BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
     UP RUNNING
     RX bytes:1314 acl:0 sco:0 events:41 errors:0
     TX bytes:2583 acl:0 sco:0 commands:40 errors:0

root@BLOKS ~# bccmd -t HCI buildname
Build name: gem_5hci_rom_bt4.1_gemA12_1407301204_dspm_encr128 2014-07-30
root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
Loading PSKEY_BDADDR ... done
Loading PSKEY_ANA_FREQ ... done
root@BLOKS ~# bccmd -t HCI warmreset
root@BLOKS ~# hciconfig
hci0:    Type: Primary  Bus: UART
     BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
     UP RUNNING
     RX bytes:1639 acl:0 sco:0 events:47 errors:0
     TX bytes:3587 acl:0 sco:0 commands:76 errors:0

root@BLOKS ~# bccmd -t HCI buildname
Can't read version info for hci0: Connection timed out (110)
root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
Can't read version info for hci0: Connection timed out (110)
root@BLOKS ~#


while executing the commands above i get the following kernel messages:

[  308.225409] NET: Registered protocol family 31
[  308.229874] Bluetooth: HCI device and connection manager initialized
[  308.237778] Bluetooth: HCI socket layer initialized
[  308.242980] Bluetooth: L2CAP socket layer initialized
[  308.248113] Bluetooth: SCO socket layer initialized
[  308.256807] Bluetooth: HCI UART driver ver 2.3
[  308.261273] Bluetooth: HCI UART protocol BCSP registered
[  308.290364] Bluetooth: Out-of-order packet arrived, got 1 expected 0
[  409.275259] Bluetooth: hci0 command 0x1001 tx timeout
[  439.755276] Bluetooth: hci0 command 0x1001 tx timeout
[  533.420270] Bluetooth: Checksum failed: computed d032 received d000


any ideas?

Thanks,


Tobi

