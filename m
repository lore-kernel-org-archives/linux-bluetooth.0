Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
Date: Mon, 21 Jul 2014 16:40:33 -0700
Message-Id: <1405986034-29122-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v1: 
    - Added back the "Value" property. Changed its meaning so that the property
      represents the cached characteristic/descriptor value and there are no
      read/write request semantics tied to Get/Set. PropertiesChanged is sent on
      notifications/indications and after successful read requests. The property
      is now read-only and optional, i.e. it won't be present until a read
      request or a not/ind.

    - Replaced the "Authentication", "Authorization", and "Encryption" errors
      with a simpler "NotPaired" error, since there's not much the external
      application can do on these errors other than try to pair. bluetoothd will
      automatically attempt to raise the security level of the connection on
      these errors.

Arman Uguray (1):
  doc/gatt-api: New API properties and methods for the GATT D-Bus API.

 doc/gatt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 12 deletions(-)

-- 
2.0.0.526.g5318336

