Return-Path: <cyrus@holtmann.org>
From: Ting Chou <Ting.Chou@iaSolution.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 3 Dec 2012 18:45:55 +0800
Subject: BLE: attribute-api and StartDiscovery
Message-ID: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65A630@Luna.iaSolution.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We are trying to enable notification from a LE a device, but found the API
listed in attribute-api.txt haven't been implemented yet:

  org.bluez.Characteristic.SetValue(),
  org.bluez.Characteristic.GetValue()

Also we found there's an item in TODO to expose client characteristic
configuration, but the priority is low.

May I understand your possible schedule of the feature, or any workaround you
suggest?

BTW, it'd be great if we can set the device type to discover (e.g., LE public)
for the API org.bluez.Adapter.StartDiscovery(). How do you think?

Thank you,
Ting
