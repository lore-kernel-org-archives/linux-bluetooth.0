Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 0/5] Rebond support
Date: Thu,  4 Aug 2016 15:28:34 +0200
Message-Id: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This serie adds support for asking agent for rebond consent. It makes
use of recently added 'Authentication Failed' error code on MGMT
device disconnected event.

If agent gives consent for rebond then device is unpaired and new
pairing is started without need for user to manually remove device
and discover it again.

I'm not fully happy with method name RebondConsent() so I'm open for
suggestions.

Comment are welcome.

Szymon Janc (5):
  lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE definition
  doc: Add RebondConsent method to agent API
  core/adapter: Add support for rebond consent
  plugins/policy: Disable policies on authentication failure
  client: Add support for RebondConsent request

 client/agent.c    |  22 ++++++++++
 doc/agent-api.txt |   8 ++++
 lib/mgmt.h        |   1 +
 plugins/policy.c  |  58 ++++++++++++++++++-------
 src/adapter.c     | 124 +++++++++++++++++++++++++++++++++++++++---------------
 src/agent.c       |  47 +++++++++++++++++++++
 src/agent.h       |   4 ++
 7 files changed, 215 insertions(+), 49 deletions(-)

-- 
2.7.4

On behalf of SCHILLER Medical SAS.
