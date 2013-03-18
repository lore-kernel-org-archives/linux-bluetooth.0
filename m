Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 0/4] Basic mgmt API tests for discovery procedure
Date: Mon, 18 Mar 2013 16:53:02 -0400
Message-Id: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series implements initial basic tests for discovery procedure. The
following tests were added in mgmt-tester utility:
- Start Discovery: success testcase.
- Stop discovery: success, rejected and invalid parameters testcases.

More complex tests (including stop discovery at specific discovery stages) will
be sent in next weeks.

BR,
Bruna Moreira.

Bruna Moreira (4):
  tools: Add basic success test for start discovery
  tools: Add basic success test for stop discovery
  tools: Add basic rejected test for stop discovery
  tools: Add basic invalid parameters test for stop discovery

 tools/mgmt-tester.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

-- 
1.7.9.5

