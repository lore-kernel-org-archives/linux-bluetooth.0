Return-Path: <cyrus@holtmann.org>
From: Murat Kilivan <Murat.Kilivan@csr.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: HoG: Support multi output report
Date: Wed, 30 Jul 2014 14:34:00 +0000
Message-ID: <45F17F5803927D43967AFEED068E781E0879D3C7@CAMEUREXM02.EUROPE.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a BLE HID device which has 2 output reports and it is discovered properly by BlueZ. However, when I try to send an output report it always calls the first registered report id's handle. It doesn't matter what the first byte is in the message.

How can I send to a different output report?

I can supply any log/debug output if it is needed.

Murat Kilivan


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
