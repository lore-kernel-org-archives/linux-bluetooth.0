Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Feb 2011 15:39:11 +0800
Message-ID: <AANLkTinC4JqX627rv7PUWrhOZwmerCEQJ_jeZ0w29LW9@mail.gmail.com>
Subject: How to config bluetooth headset ?
From: Bob Liu <lliubbo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, folks

Since  I can't open the wiki: http://wiki.bluez.org/wiki/HOWTO/AudioDevices.
Is there any guide how to config bluetooth headset ?

I used to use
root:/> hcid -n &

root:/> sdpd &

root:/> headsetd -n &
But it seems that things have changed a lot now, there is only bluetoothd ?

Cureently I can scan the device:
# hcitool scan
Scanning ...
        00:1A:45:4A:EA:39       Jabra BT125
#

How to make aplay can use that device?

Thanks a lot.

-- 
Regards,
--Bob
