Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: travis.reitter@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 0/5] add bt command line tool
Date: Wed,  3 Oct 2012 14:34:24 -0300
Message-Id: <1349285669-20464-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The following patches add a new tool to handle BlueZ from the comand line.
Today the only code we have for this is the new python scripts. A proper tool
written in C was missing.

This work has two purposes provide a nice tool to use BlueZ and provide a
very nice sample on how to write code that uses the BlueZ's API. You will find
a well documented code in the commits here.

More work is planned on that, I already started some code to handle adapter
and device API's but it is still a work in progress. Should hit them mailing
list any time soon.

After applying this we should consider remove the test/agent.c code since this
one is a much better piece of code.

Thanks to everyone tat helped on this, about a year ago Bruno Dilly and me
started the very first bits of this. And to Travis Reitter that helped a lot
to make this possible.

Gustavo Padovan (2):
  bt tool: initial tool handling
  bt tool: add cmd 'agent'

Travis Reitter (3):
  bt tool: add cmd 'discover'
  bt tool: add cmd 'pair'
  bt tool: add cmd 'remove'

 Makefile.tools  |    7 +-
 tools/bt-tool.c | 1232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1238 insertions(+), 1 deletion(-)
 create mode 100644 tools/bt-tool.c

-- 
1.7.11.4

