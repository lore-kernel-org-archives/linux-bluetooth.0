Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC v2 0/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
Date: Mon, 11 Aug 2014 13:37:06 -0700
Message-Id: <1407789427-7118-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set addressed further feedback:

* v2:
    - Added a "NotAuthorized" error for the ReadValue/WriteValue methods. This
      is in addition to the "NotPaired" error.

    - Added a "InvalidValueLength" error to the WriteValue methods.

Arman Uguray (1):
  doc/gatt-api: New API properties and methods for the GATT D-Bus API.

 doc/gatt-api.txt | 122 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 110 insertions(+), 12 deletions(-)

-- 
2.0.0.526.g5318336

