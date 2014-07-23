Return-Path: <cyrus@holtmann.org>
From: Dibyendu Roy <dibyendu.roy@samsung.com>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: Query regarding gatt server implementation on Tizen
Date: Wed, 23 Jul 2014 17:29:51 +0530
Message-id: <003401cfa66d$9ec5c140$dc5143c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

Greetings!!!  I'm trying  to test bluez-5.20  gatt-server on Tizen.

I have a query regarding gatt server implementation in bluez.

Please let me know how bluez will get the properties exported through
interfaces mentioned in the bluez doc/gatt-api.txt (org.bluez.GattService1
etc.).

And is it required to emit the InterfacesAdded/InterfacesRemoved signals
after exporting interfaces org.bluez.GattService1,
org.bluez.GattCharacteristic1? 

What does bluez do with those signals in case of gatt-server.

Thanks in advance.

BR-
Dibyendu Roy



