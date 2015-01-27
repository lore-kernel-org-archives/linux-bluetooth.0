Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ] Introduce GattProfile1 D-Bus API
Date: Tue, 27 Jan 2015 12:26:19 -0800
Message-Id: <1422390380-26000-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an RFC patch that introduces the GattProfile1 & GattProfileManager1 APIs
that we discussed earlier on the mailing list. This is by no means the final
form of the intended API, so I just went with the main features that I had in
mind to initiate the discussion.

Thanks!
Arman

Arman Uguray (1):
  doc/gatt-api.txt: Add GattProfile1 API

 doc/gatt-api.txt | 158 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 132 insertions(+), 26 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

