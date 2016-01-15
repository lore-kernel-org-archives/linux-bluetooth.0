Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Adam Moore <adam.moore@savantsystems.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE Reverse Service Discovery
Date: Fri, 15 Jan 2016 01:41:10 +0000
Message-ID: <D2BD8E35.1AB78%adam.moore@savant.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I¹ve noticed that since around BlueZ 5.27, GATT client functionality is
enabled for all devices.

>From a LE Peripheral's perspective, this results in unconditional reverse
service discovery of a Central's GATT services.

It seems like this will not always be necessary depending on the use case,
and disabling GATT client functionality should save energy and time.  My
iPhone, for example, has about 8 services that my Peripheral doesn¹t care
about.

I¹m considering making an attempt to disable this, as the BT spec says
GATT clients are optional for LE peripherals. (BT 4.2, Vol 3, Part C,
Table 15.1), but I first would like to ask if anyone has any insight on
why it may be desirable to keep the client functionality enabled.

Thanks!
Adam



Statement of Confidentiality

The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.

