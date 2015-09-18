Return-Path: <cyrus@holtmann.org>
From: Stefan Schmidt <stefan@osg.samsung.com>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
	jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org,
	Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 0/4] GHC compression detection
Date: Fri, 18 Sep 2015 13:52:44 +0200
Message-Id: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

This is a first stab at RFC7400. So far we only hook into the NHC framework to
detect the three registered GHC types (extension header, UDP and ICMPv6).
This is aligned with how we detect the NHC frames.

Changes since RFC:
	o prefixed new files with nhc_ to stay in line with other nhc modules
	o added linux-bluetooth to CC

Stefan Schmidt (4):
  6lowpan: clarify Kconfig entries for upcoming GHC support
  6lowpan: add nhc module for GHC extension header detection
  6lowpan: add nhc module for GHC UDP detection
  6lowpan: add nhc module for GHC ICMPv6 detection

 net/6lowpan/Kconfig                    | 20 ++++++++++++++++++--
 net/6lowpan/Makefile                   |  5 +++++
 net/6lowpan/nhc_ghc_extension_header.c | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_icmpv6.c           | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_udp.c              | 27 +++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 net/6lowpan/nhc_ghc_extension_header.c
 create mode 100644 net/6lowpan/nhc_ghc_icmpv6.c
 create mode 100644 net/6lowpan/nhc_ghc_udp.c

regards
Stefan Schmidt

-- 
2.4.3
