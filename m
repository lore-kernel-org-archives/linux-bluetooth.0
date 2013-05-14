Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 0/2] Reauthentication support
Date: Tue, 14 May 2013 23:23:13 +0200
Message-Id: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches are initial proposal for introducting reauthentication
support for BlueZ. This allows to set system wide property to change default
action when remote is missing link key from 'disconnect' to 'user consent' or
'auto-reauthentication' (later is what e.g. Android does).

Since reauthencation is not something that happens all the time first draft
proposal is for single system wide policy.

It is also possible to prepare more fine grained API like per adapter or per
device property. Not sure if that would give some real benefit over system wide
property... I have some draft proposal for such API as well but wanted to get
feedback for simpler variant first.

Some open points include pairing failure after reauthentication or weaker key
being created... should old key be restored in such case? Or just handle those
as regular pairing failure/success (there was user consent after all) and don't
restore old linkkey?

Last but not least:) Is 'reauthentication' a good name? Other option would be
'repairing' but that might be confusing with fixing..


Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (2):
  doc: Add reauthentication commands and event to Management API
  doc: Add reauthentication support to Agent API

 doc/agent-api.txt |   43 +++++++++++++++++++++-
 doc/mgmt-api.txt  |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 1 deletion(-)

-- 
1.7.10.4

