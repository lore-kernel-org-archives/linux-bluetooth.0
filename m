Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC] Cycling Speed and Cadence profile (CSCP) API
Date: Fri, 21 Sep 2012 11:09:20 +0200
Message-ID: <1348218561-24509-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's proposal for CSCP API. This is of course for Collector role.
Not sure if 'Cycling' prefix for interface names (and probably also for plugin
name) is good enough, but couldn't think of anything better.

Comments are welcome.


Andrzej Kaczmarek (1):
  Cycling Speed and Cadence profile (CSCP) API

 doc/cycling-api.txt | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 doc/cycling-api.txt

-- 
1.7.11.3

