Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2014 15:25:35 +0800
Message-ID: <CAB0Wyv=3HBi6wnStgjGFwg7HUODoYj3mZBVTnZnC+tb+Mipyxw@mail.gmail.com>
Subject: BT-4.1 features (e.g. concurrent GAP operations) support
From: "Min Jun,Xi" <xi.minjun@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Where can I find the latest BT-4.1 features support for
Bluetooth-subsystem and BlueZ?

In the 4.1 features, I know connection-oriented channels has been supported;

I have one question about this new feature (Bluetooth Specification
Version 4.1[Vol 3] page 293 of 668, ): "2.2.2.5 Concurrent Operation
in Multiple GAP Roles"; this feature is very useful to support
mesh-like topology,

>From the description in chapter 2.2.2.5, the controller should support
operations in multiple GAP roles concurrently, and the host should
read the supported Link Layer States and State combinations from the
Controller before any procedures or modes are used.

Can anyone tell me if the bluetooth subsystem has supported the Link
Layer states and the States combinations? I am also looking for the
Controller support operations in multiple GAP roles concurrently, can
anyone know if CSR/Nordic/Broadcom has got the USB dongles which
supports concurrent operation and can used under Linux?

Thank you!

-- 
Best regards,
Xi Minjun
