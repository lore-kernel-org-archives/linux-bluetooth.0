Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/7] Proximity Monitor optimizations and checks
Date: Wed,  3 Aug 2011 15:41:40 -0300
Message-Id: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: "[PATCH BlueZ 0/3] Add Proximity Monitor properties" needs
to be applied first.

The following patches contain optimizations and configuration checking
based on proximity config file values.

Bruna Moreira (1):
  Add enum for alert level values

Claudio Takahasi (6):
  Parse handles when probing on Proximity
  Request connection if Link or Path Loss is enabled
  Write Link Loss alert if the service is enabled
  Add utility function to convert alert levels
  Add function to check invalid alert level value
  Skip Link Loss handle discovery

 proximity/manager.c |   36 +++++++++-----
 proximity/monitor.c |  137 ++++++++++++++++++++++++++++++++++-----------------
 proximity/monitor.h |    3 +-
 3 files changed, 118 insertions(+), 58 deletions(-)

-- 
1.7.6

