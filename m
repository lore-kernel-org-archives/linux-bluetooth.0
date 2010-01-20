Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5749B9.2080108@zydacron.com>
Date: Wed, 20 Jan 2010 19:21:45 +0100
From: Philip Oberstaller <p.oberstaller@zydacron.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Scan of already paired devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I would like to know if it's possible to see already paired devices in 
the scan results?

My scenario is the following:
First I create a connection from my host to a device and pair the device 
and the host. Then I disconnect the connection by simply switching off 
the device. I remove the pairing at the host but obviously cannot remove 
the pairing from the device because there is no connection anymore. If I 
then switch on the device again I am not able to find it in the scanning 
results because the device has stored the "old" pairing and thus seems 
to be invisible.

The device reappears in the scanning results only when I remove the 
pairing at the device itself.

Thus anybody know what I could do from the host side to be able to make 
the device "visible" again.

I am forced to use a quiet old bluez version 3.33. Maybe this behavior 
has changed in the meantime?

I am grateful for any hints.

Philip Oberstaller


