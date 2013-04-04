Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, keybuk@chromium.org,
	vinicius.gomes@openbossa.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v4 0/2] Input1 Connectability revisited
Date: Thu,  4 Apr 2013 14:31:51 -0700
Message-Id: <1365111113-13741-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New version of this patch using Vinicius idea of ReconnectMode, except that
instead of "passive" and "active" we use "Host" and "Device", since the
the passive/active is relative to what end are you talking about (host/device)
Names are free to change.

Also, this patch set removes the input config file introduced in a previous
version of this patch. This property is readonly after all, and is derived
from the SDP record passed to the Input plugin init (input_device_register).
This SDP record comes from the SDP cache and hid_device_probe ensures it is
not NULL.

Comments are welcomed!

Alex Deymo (2):
  input: Documentation for new Input1 interface
  input: Implement the new ReconnectMode Input1 property.

 doc/input-api.txt       | 32 ++++++++++++++++++
 profiles/input/device.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 doc/input-api.txt

-- 
1.8.1.3

