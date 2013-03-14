Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	marcel@holtmann.org,
	deymo@chromium.org
Subject: [PATCH 0/6] bluetoothctl: agent's implementation
Date: Thu, 14 Mar 2013 11:22:00 -0700
Message-Id: <1363285326-20089-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The bluetoothctl client tool is able to register an org.bluez.Agent1 but the
current implementation is incomplete and has some trouble sharing the input
between the agent (for pincodes and passkeys) and the command.

This set of patches improves this bluetoothctl interface completing the agent
implementation with the missing DisplayPincode, DisplayPasskey and
RequestPasskey. It also lets the user chose the agent's capability argument
when registering it.

Alex Deymo (6):
  Add color modifiers to NEW, CHG and DEL events.
  Right prompt management on agent input
  "agent" command capability argument and autocompletion
  Agent's DisplayPincode implementation
  Agent's DisplayPasskey implementation
  Agent's RequestPasskey implementation

 client/agent.c   | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 client/display.h |   7 ++-
 client/main.c    | 115 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 237 insertions(+), 27 deletions(-)

-- 
1.8.1.3
