Return-Path: <cyrus@holtmann.org>
From: Murat Kilivan <Murat.Kilivan@csr.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth Low Energy service crash report - when trying read a HID
 feature report
Date: Wed, 23 Jul 2014 13:17:14 +0000
Message-ID: <45F17F5803927D43967AFEED068E781E0879A30E@CAMEUREXM02.EUROPE.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have successfully connected to a BLE HID (peripheral) device and /dev/hidraw1 file is created. I am able to read raw data successfully from hidraw1. However, when I try to read a feature report from this device, the Bluetooth service crashes. The bluetooth service log and my source code are below.

Enviroments:
------------
Linux Mint-17 KDE
Kernel 3.13.0-24-generic
BlueZ 5.21

Output of Bluetooth service:
----------------------------
# bluetooth -d -n
...
...
bluetoothd[2610]: profiles/input/hog.c:forward_report() Sending report type 3 to device 0x000C handle 0x1C
(bluetoothd:2610): GLib-ERROR **: /build/buildd/glib2.0-2.40.0/./glib/gmem.c:103: failed to allocate 4294967295 bytes

Source code:
------------
void foo()
{
    uint8_t buf[3];
    memset(buf, 0x0, sizeof(buf));

    m_DevReadWriteHandle = open("/dev/hidraw1", O_RDWR);
...
    buf[0] = 0x04; // Feature Report ID
    ioctl(m_DevReadWriteHandle, HIDIOCGFEATURE(sizeof(buf)), buf);
}




Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
