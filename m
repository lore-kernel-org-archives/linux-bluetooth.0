Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v6 0/3] HID Connectability
Date: Fri, 12 Apr 2013 13:20:22 -0700
Message-Id: <1365798025-12798-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm sending this patch again with a fix in the documentation file and
other minor fix. Please consider this patch for inclusion in the tree.
Thanks,
Alex.

Alex Deymo (3):
  input: Documentation for new Input1 interface
  input: Implement the new ReconnectMode Input1 property.
  input: Convert gboolean to bool

 doc/input-api.txt       | 32 +++++++++++++++++
 profiles/input/device.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100644 doc/input-api.txt

-- 
1.8.1.3

