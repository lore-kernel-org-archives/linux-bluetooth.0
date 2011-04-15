Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 0/4] hcimgmt: command line tool for mgmt interface
Date: Fri, 15 Apr 2011 14:57:41 -0300
Message-Id: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When the mgmt interface was first proposed Johan sent a patch
that introduced this tool, I updated it for the current MGMT API
and added a couple new commands.


--
Cheers,


Johan Hedberg (1):
  Add hcimgmt command line test tool

Vinicius Costa Gomes (3):
  hcimgmt: Add command to set IO Capabilities
  Add command to clear the link key list via MGMT interface
  hcimgmt: add support for setting pairable mode

 Makefile.tools  |    5 +-
 tools/hcimgmt.c |  546 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 550 insertions(+), 1 deletions(-)
 create mode 100644 tools/hcimgmt.c

--
1.7.4.3

