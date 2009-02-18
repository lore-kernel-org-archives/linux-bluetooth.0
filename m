Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Feb 2009 12:12:08 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Reply-To: netdesign_98@yahoo.com
Subject: Dynamicall control the maximum or default transmit power
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <22544.7073.qm@web52601.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I am looking at possibility of dynamically control the maximum or default transmit power.
   Basically I would like to change the transmit power level during inquiry. So I could kind of dynamically control the physical range of devices that I see. In CSR's Bluecore chip, I think there are pskey that stored the maximum and default transmit power. And there seem to be bccmd psget 0x0017 to get the value.
  Now my problem is I am using a class 1 dongle using Broadcom chipset. Is there a way to dynamically control the default or maximum transmit power e.g.
   hcitool cmd 0x.. 0x.. ..... ?

   During the inquiry paging, does anyone know if they use default or maximum transmit power?

Thanks,
Edwin


      
