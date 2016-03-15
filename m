Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 15 Mar 2016 19:49:00 -0300
From: rodrigoct@dcc.ufmg.br
To: linux-bluetooth@vger.kernel.org
Subject: Fwd: Advertising during connection in BLE 4.1
Message-ID: <5a29d52c4382a6edaab7cf55609fb30d@dcc.ufmg.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I try connect the BLE 4.1 LM910 
http://lm-technologies.com/product/bluetooth-usb-module-4-1-low-energy-class-1-lm910/ 
to more than one dongle. However, after of connect to one dongle, this 
device is not able of make advertiser. This function not work more, 
unless I disconnect the dongle.
I think this problem is in the stack of blueZ
