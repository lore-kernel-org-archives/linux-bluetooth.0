Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 24 Aug 2011 11:18:47 +0800
Message-ID: <CAB0WyvkviAkCo7fak1osg5Kx8tuU-qD03eCkY4yezbtnV1oqYA@mail.gmail.com>
Subject: In BlueZ, how can I get the "access address" of the Link layer
 connection for BT-LE?
From: "Min Jun,Xi" <xi.minjun@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
I have one question about the "access address" of the link layer
connection for BT-LE.
In the volume 6 ("Low energy controller") of the current Bluetooth
Specification V4.0, it is said that "The Access Address is a property
of the physical channel. The Access Address is present at the start of
every transmitted packet.". Also, in the Link Layer data format,
there's one field to contain "Access Address". I know all of them are
in the controller, but can I get the access address in Linux kernel?
In the kernel's source code, I can only see the interface to operate
on HCI layer and the upper layers.

Can I use the HCI interface to get the "Access Address" property for
one established BT-LE connection? I don't know how to do that. Can you
help me? Thank you!

-- 
best regards,
Xi Minjun
