Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: BT_ADDR not updated
Date: Sat, 16 Feb 2013 09:51:39 -0500
Message-ID: <87bobkjoqs.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This question is regarding bluez 5.2:
 
i'm changing bt addr "on-the-fly" via a vendor-specific hcitool 
command but the bluetoothctl is not seeing the new address, even 
after a hciconfig hci0 reset

however i do see the new address via "hcitool dev", so it's 
getting changed in the device

is there some bug in bluez updating the device address on a reset?
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
