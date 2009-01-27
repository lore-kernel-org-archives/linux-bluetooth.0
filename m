Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2009 15:34:43 +0100
Message-ID: <e6fea9c20901270634k13bd0a67m872cc24e1ea21e42@mail.gmail.com>
Subject: Obexd 0.8 : pull failure
From: Thierry Pierret <tpi@qspin.be>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Any attempt to pull a business card using the OBEX protocol failed
with the following message :

bluetoothd[1844]: adapter_get_device(00:0E:ED:01:DB:67)
gw_obex_xfer_read(): Not found

What does it mean ? What could be wrong ?

Tested with BlueZ 4.26.

Thanks for any help.
Regards.
