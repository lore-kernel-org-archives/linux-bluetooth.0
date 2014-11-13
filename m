Return-Path: <cyrus@holtmann.org>
From: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Message-ID: <5464A38E.20502@LilandIT.com>
Date: Thu, 13 Nov 2014 13:26:54 +0100
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: gatttool --listen not working?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I am trying to connect to a GATT service (running on an iPhone) and register a 
notification listener using gatttool. I can read the attribute value with 
gatttool and the --char-read argument just fine. When I add --listen, gatttool 
keeps running, but I never see any notifications. Debugging on the other end 
reveals that the iOS APIs didSubscribeToCharacteristic never gets called.

Any ideas why this is not working?

gatttool -i hci0 -t random --listen --char-read --handle 0x0034 -b 5C:A2:D5:C7:BF:14
Characteristic value/descriptor: 2d

.... and then. Nothing.

Kind regards,
  Edmund


