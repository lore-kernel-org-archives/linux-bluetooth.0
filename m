Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Wed, 21 Feb 2018 15:04:17 +0100
Message-ID: <CAOT_U5Y7+qMsUrmqTpJ1nP3py_jzZyfNtO2ySeVQRO3V0BsP5A@mail.gmail.com>
Subject: Setting a timeout for device_connect_le()
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
is it possible to set up a timeout for `device_connect_le()`?

Here is the output from the logs that explains it more clearly:

   ../bluez-5.46/src/device.c:att_disconnected_cb() Automatic
connection disabled
   ../bluez-5.46/attrib/gattrib.c:g_attrib_unref() 0xe04c8: g_attrib_unref=0
   ../bluez-5.46/src/device.c:device_connect_le() Connection attempt
to: F5:D4:41:9C:86:B0
   #### 40+ seconds of waiting
   #### can this be timed out after 10s?
   ../bluez-5.46/src/device.c:att_connect_cb() connect error:
Connection refused (111)

Is it possible to enforce a fixed timeout for this?

Be Well,
Alan
