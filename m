Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ironyman13@gmail.com
From: changyu li <ironyman13@gmail.com>
Date: Sun, 24 Dec 2017 01:42:26 -0500
Message-ID: <CALEhDxQULJEJJO+gFvy6jK-sfKHcxa0gOJqn_r5AOZHr_O2pJA@mail.gmail.com>
Subject: Question about HOG input devices
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I would like to be able to configure my Bluetooth HOG mouse but its
GATT characteristic used for configuration has no DBus interface
associated with it.

HOG services are not "external" and are marked as claimed in
add_gatt_service. This prevents the characteristic from being
exported.

  if (!profile->external) {
    /* Mark the service as claimed by the existing profile. */
    gatt_db_service_set_claimed(attr, true);
  }

So I have a few questions,

1. What does external mean?
2. Is there another way to access the characteristic and configure the device?
3. If not, can we make the input-hog profile external?

Thank you
