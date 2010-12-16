Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Dec 2010 13:13:27 -0800
Message-ID: <AANLkTimkug4kjs8S1LDf7MVTeyc3v7_QUmu5MLmBhDpk@mail.gmail.com>
Subject: Hci layer not getting event header from BT firmware
From: ashwath narasimhan <ashwath.narasimhan@oneconvergence.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 I am facing an intermittent issue and would really appreciate if
someone could throw some light, or atleast point me in the right
direction.

Issue:  I reboot my hardware multiple (say 20) times and each time, I
perform hciattach ( eg: hciattach /dev/ttyHS2 any 921600) in linux
terminal prompt. There is this one or two times when hciconfig after
the hci attach shows the BD address as 00:00:00:00:00:00 and the
interface as DOWN and I have to restart the hardware to actually see
this go UP again.

Hardware used:  tegra Harmony platform from nvidia

BT chip used :  Bluecore 4 CSR

Software : ubuntu 9.10, 2.6.32.25 #1 SMP PREEMPT arm7l GNU/Linux

Architecture : ARM

Protocol: H4, communicates using UART.

Modules: BT driver and stack is built as part of kernel.


Detailed Description: Upon debugging further - I found that, as soon
as "hciattach" was issued,  the h4_recv() function in the Hci layer
seems to be getting a packet of type HCI_EVENT_PKT (0x04) in the good
case. This is the first packet that is received after the vendor
packet (0xff) and this happens before hci_request for opcodes like
0x1003, 0x1001, 0x1005, 0x1009, 0xc14, 0xc25, 0xc05, 0xc18, 0xc16 are
sent. In the failed case it neither receives the vendor packet (0xff),
nor the event packet (0x04). I dumped the received buffer's hex values
for the good and bad cases. In good case, the length was 35 bytes and
this includes the vendor packet header and the event packet header. In
the failed case, the length was 31 bytes and I didn't receive the
vendor or event packet headers. Another interesting observation is
that the content of the buffers matched in the good and failed cases
barring data from bytes 1st to 5th.
The hci_request eventually times out and hence the interface is never
up. Why is this happening, and why do I not receive the same values in
some cases? Am I looking in right path?

I am not subscribed to the list, so please "reply" to this email.
Appreciate your help and time.

Thanks,
Ashwath
