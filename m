Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 0/6] client: agent implementation on bluetoothctl
Date: Tue, 19 Mar 2013 13:54:59 -0700
Message-Id: <1363726505-15171-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
This is the same patch set I sent last week, but with the changes based on the
comments you made here. I think I addressed them all. Let me know if you have
other comments.
Thanks!

Alex Deymo (6):
  client: Add color modifiers to NEW, CHG and DEL events.
  client: Right prompt management on agent input
  client: "agent" command capability argument and autocompletion
  client: Agent's DisplayPincode implementation
  client: Agent's DisplayPasskey implementation
  client: Agent's RequestPasskey implementation

 client/agent.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 client/display.h |   7 ++-
 client/main.c    | 106 +++++++++++++++++++++++++++++++++++------
 3 files changed, 229 insertions(+), 27 deletions(-)

-- 
1.8.1.3

