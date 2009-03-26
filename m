Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Mar 2009 22:28:24 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <895461867.5591238086704517.JavaMail.root@mbv7.indiatimes.com>
Subject: a2dp connection of HT820 vs. BT620s
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using android [bluez-3.36] and using a2dp over it. I observe that I get a lot of audio gaps, when I connect to headset "Jabra BT620s".

However when I connect to "Motorola HT820", everything seems fine, audio streaming is good.
I have the hcidump, when the Jabra was connected, and it kind of reads the same in terms of frequency, Stereo, block size as when connected to Motorola headset

What could be the problem ? Any inputs would help.

Thanks,
Pavan

< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0078 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 3
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz 
          JointStereo 
          16 Blocks
          8 Subbands
          Loudness 
          Bitpool Range 2-50




--
Exclusive spy camera shots of the Tata Nano only on ZigWheels.com 
http://www.zigwheels.com/tata-nano/
