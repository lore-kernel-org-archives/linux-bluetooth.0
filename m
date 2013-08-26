Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] *** Make sdp independent from adapter ***
Date: Mon, 26 Aug 2013 15:07:17 +0200
Message-Id: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Solutions to consider:
- Access db has been expanded via sdp_get_access_list
- sdp_access_t moved to sdpd.h

Grzegorz Kolodziejczyk (4):
  sdp: Move sdp server init to adapter
  sdp: Move spd_init_services_list to adapter
  sdp: Make sdp_record_add to be handled by adapter
  sdp: Make sdp_record_remove to be handled by adapter

 profiles/audio/a2dp.c      |   10 ++--
 profiles/audio/avrcp.c     |    8 ++--
 profiles/health/hdp.c      |    2 +-
 profiles/health/hdp_util.c |    4 +-
 profiles/network/server.c  |    6 +--
 profiles/sap/server.c      |    4 +-
 src/adapter.c              |  109 +++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h              |    6 +++
 src/attrib-server.c        |    8 ++--
 src/main.c                 |    2 +-
 src/profile.c              |    4 +-
 src/sdpd-database.c        |   52 ++++-----------------
 src/sdpd.h                 |    8 +++-
 13 files changed, 152 insertions(+), 71 deletions(-)

-- 
1.7.9.5

