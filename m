Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v4 0/6] client: agent implementation on bluetoothctl
Date: Thu, 21 Mar 2013 15:04:50 -0700
Message-Id: <1363903497-4517-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed Vinicius comments for agent prompt. I kind of hate readline =)
Thanks for reporting.
I'll leave the agent disabled at startup since you can choose the
capability you want to support for your agent, and also you may want
to test your environment without an agent.

Alex Deymo (6):
  client: Add color modifiers to NEW, CHG and DEL events.
  client: Right prompt management on agent input
  client: "agent" command capability argument and autocompletion
  client: Agent's DisplayPincode implementation
  client: Agent's DisplayPasskey implementation
  client: Agent's RequestPasskey implementation

 client/agent.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 client/display.h |   7 ++-
 client/main.c    | 106 ++++++++++++++++++++++++++++++++++------
 3 files changed, 232 insertions(+), 27 deletions(-)

-- 
1.8.1.3

