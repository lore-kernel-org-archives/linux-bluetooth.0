Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 00/22] Add AVDTP/A2DP decoding to btmon
Date: Sun, 22 Nov 2015 21:20:12 +0100
Message-Id: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's series of patches which adds decoding of AVDTP signalling channel
and A2DP codec capabilities information. Few things are missing:
- no fragmentation support
- some rarely used capabilities are not decoded
- ATRAC capabilities are not decoded

Other that above, pretty much everything should be decoded.

Changes in v2:
- fixed formatting according to comments
- updated commit messages to include decoded frames (except for few of
  them where I was not able trigger proper signalling)
- some minor issues fixed found during development

Changes in v3:
- fixed comments from Szymon (few more raised offline)
- more minor issues fixed


Andrzej Kaczmarek (22):
  monitor/l2cap: Add channel sequence number
  monitor/avdtp: Add basic decoding of AVDTP signalling
  monitor/avdtp: Decode AVDTP_DISCOVER
  monitor/avdtp: Decode AVDTP_GET_CAPABILITIES
  monitor/avdtp: Decode AVDTP_SET_CONFIGURATION
  monitor/avdtp: Decode AVDTP_GET_CONFIGURATION
  monitor/avdtp: Decode AVDTP_RECONFIGURE
  monitor/avdtp: Decode AVDTP_OPEN
  monitor/avdtp: Decode AVDTP_START
  monitor/avdtp: Decode AVDTP_CLOSE
  monitor/avdtp: Decode AVDTP_SUSPEND
  monitor/avdtp: Decode AVDTP_ABORT
  monitor/avdtp: Decode AVDTP_SECURITY_CONTROL
  monitor/avdtp: Decode AVDTP_GET_ALL_CAPABILITIES
  monitor/avdtp: Decode AVDTP_DELAYREPORT
  monitor/avdtp: Decode basic Media Codec capabilities
  monitor/avdtp: Decode basic Content Protection capabilities
  monitor/a2dp: Decode SBC capabilities
  monitor/a2dp: Decode MPEG-1,2 capabilities
  monitor/a2dp: Decode AAC capabilities
  monitor/a2dp: Decode aptX capabilities
  monitor/a2dp: Decode LDAC capabilities

 Makefile.tools     |   2 +
 android/Android.mk |   2 +
 monitor/a2dp.c     | 638 +++++++++++++++++++++++++++++++++++++++++++
 monitor/a2dp.h     |  26 ++
 monitor/avdtp.c    | 787 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/avdtp.h    |  24 ++
 monitor/l2cap.c    |  57 ++--
 monitor/l2cap.h    |   1 +
 8 files changed, 1520 insertions(+), 17 deletions(-)
 create mode 100644 monitor/a2dp.c
 create mode 100644 monitor/a2dp.h
 create mode 100644 monitor/avdtp.c
 create mode 100644 monitor/avdtp.h

-- 
2.6.2

