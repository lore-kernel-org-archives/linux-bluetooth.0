Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ v1] Introduce GattProfile1 D-Bus API
Date: Tue, 27 Jan 2015 15:08:52 -0800
Message-Id: <1422400133-2222-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: After some IRC discussions, I got rid of the GattProfile1 API. This patch
set currently focuses on server-role updates and we'll come up with a slightly
different approach for the client-role.

Arman Uguray (1):
  doc/gatt-api.txt: Updates to GattManager1

 doc/gatt-api.txt | 86 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 26 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

