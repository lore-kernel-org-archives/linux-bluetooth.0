Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 0/2] HID Connetabillity
Date: Mon,  1 Apr 2013 17:40:24 -0700
Message-Id: <1364863226-10566-1-git-send-email-deymo@chromium.org>
In-Reply-To: <1363655144-9705-1-git-send-email-deymo@chromium.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Addressed Marcel comments on PATCH v2.
* The two properties are always exposed.
* Persistence file is <adapter>/<device>/input. No global helper is used.
* Doc in a separate commit.
* Logs updated.

Alex Deymo (2):
  input: Documentation for new Input1 interface
  core: Expose HIDNormallyConnectable and HIDReconnectInitiate
    properties

 doc/input-api.txt       |  21 ++++++
 profiles/input/device.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 doc/input-api.txt

-- 
1.8.1.3

