Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v7 0/5] input: Connectability
Date: Tue, 16 Apr 2013 14:58:36 -0700
Message-Id: <1366149521-26908-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
It's me again. Let me insist with these input patches again for a good
reason. There is a qualification test (TP/HCE/BV-04-I [Host Initiated
Re-connection]) that requires a Bluetooth host to automatically
re-connect to a HID device when the device goes out of range (and comes
back in range, obviously). The HID 1.1 spec also states when a device
is supossed to accept re-connections from a host and now we export that
via the ReconnectMode property. I extended this patch with a retry timer
that attempts to reconnect to the HID device for a certain amount of
time.

This patch set includes: Patch 1 and 2 are the new ReconnectMode property
and its documentation. Patch 3 is just some details about bool and gboolean.
Bonus: patch 4 includes a memory leak fix; and patch 5 uses all this
thing to automatically reconnect to HID device when its ReconnectMode is
"host" or "any", as required by the test plan.

Coments are welcome, specially for the new patch 5.
Happy coding!
Alex.

Alex Deymo (5):
  input: Documentation for new Input1 interface
  input: Implement the new ReconnectMode Input1 property.
  input: Convert gboolean to bool
  input: Fix memory leak for hidp_connadd_req.
  input: Automatically attempt a reconnect when required.

 doc/input-api.txt       |  32 ++++++++++
 profiles/input/device.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 3 deletions(-)
 create mode 100644 doc/input-api.txt

-- 
1.8.1.3
