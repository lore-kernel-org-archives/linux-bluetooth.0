Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Qingtao Cao <qingtao.cao.au@gmail.com>
Date: Fri, 10 Jun 2016 17:25:44 +1000
Message-ID: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
Subject: How to initialise bcm4354A2 with 3.10 kernel?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear community,

I am trying to use the brcm_patchram_plus program to initialise
broadcom bcm4354A2 on my target with 3.10 Linux kernel. Currently the
hci0 can be found UP, however, it doesn't seem to function properly.

For example, the scan command timed out:

/ # hcitool scan
Scanning ...
Inquiry failed: Connection timed out
/ #

The hcidump says that there was NO relevant HCI Event packet received
as its response:


< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0


Relevant syslog reads:

Apr  5 05:44:53 armv8-generic-okl4 kernel: [  588.521355] Bluetooth:
Frame Reassembly Failed: 84
Apr  5 05:44:57 armv8-generic-okl4 kernel: [  592.516397] Bluetooth:
hci0 command 0x0401 tx timeout

The "84" error code was printed by my changes in
hci_recv_stream_fragment(). hci_reassembly() thought the passed in
type parameter was invalid:

    if ((type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT) ||
        index >= NUM_REASSEMBLY)
        return -EILSEQ;

So, once adding more debug logs, I found when such situation happens,
the data received by low level tty driver contained an extra "0x00"
byte:

Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078113] Bluetooth:
skb is null, pkt_type from data[0]: 0
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078212] Bluetooth:
Illegal byte sequence - type: 0, index: 0
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078248] Bluetooth:
Frame Reassembly Failed: 84. Received 11 bytes of data:
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078280] Bluetooth: 00
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078302] Bluetooth: 04
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078306] Bluetooth: 0e
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078310] Bluetooth: 07
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078315] Bluetooth: 01
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078319] Bluetooth: 23
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078323] Bluetooth: 0c
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078337] Bluetooth: 00
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078341] Bluetooth: 00
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078345] Bluetooth: 01
Apr  5 08:21:10 armv8-generic-okl4 kernel: [  221.078349] Bluetooth: 40
Apr  5 08:21:12 armv8-generic-okl4 kernel: [  223.071566] Bluetooth:
hci0 command 0x0c23 tx timeout

The normal response to the 0x0c23 (Read class of device) command should be:
04 0e 07 01 23 0c 00 00 01 40, that is, class == 0x400100. However,
this extra, preceding 0x00 byte would make hci_reassembly() regard the
packet type illegal. I guess the packet was simply dropped and
therefore hcidump received no responses at all.

It's very strange. During the execution of brcm_patchram_plus program
the HCI commands sent by it won't trigger such situation at all. Once
hci0 was brought up, I would run into it quickly. Moreover, if I
skipped over data[0] when it was 0x00, the HCI Event packet in the
data buffer could be handled properly since the rest of content in the
data buffer are sane.

So any insight on the root cause of this phenomenon? and how I should
initialise the bcm4354A2 correctly? Currently I am using below
parameters:

./brcm_patchram_plus -d --patchram /system/etc/firmware/BCM43xx.hcd
--no2bytes --baudrate 4000000 --use_baudrate_for_download --enable_hci
--bd_addr 40:40:a7:a6:a5:c1 --tosleep=100 /dev/ttyHS0 &

Where the BCM43xx.hcd file is obtained by AOSP and the --tosleep delay
in ms was arranged between the launch ram command and the hci reset
command (as inspired by relevant code in broadcom's libbt
implementation for bluedroid)


Moreover, once I skipped over data[0] when it was 0x00, the Scan
operation still failed:

Apr  5 13:01:07 armv8-generic-okl4 bluetoothd[3863]: hci0: Start
Discovery (0x0023) failed: Not Supported (0x0c)

The bluetooth spec reads that 0x0c error code means "Command
Disallowed" - the hardware was in a state unable to execute the
command. Again, I doubt I have enabled the bcm4354A2 properly.

Many thanks for any comments!

Cheers,
Harry
