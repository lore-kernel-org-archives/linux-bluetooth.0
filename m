Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v2 0/2] Clean up in the minimum mtu check
Date: Thu, 17 Feb 2011 11:18:39 -0300
Message-Id: <1297952321-12523-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just a little clean up in the minimum mtu check

Sheldon Demario (2):
  Move do_connect() to a common file between interactive.c and
    gatttool.c
  Use PSM value to select LE or BR/EDR transport on gatttool

 Makefile.am          |    3 +-
 attrib/gatttool.c    |   83 ++++-----------------------------------
 attrib/gatttool.h    |    4 +-
 attrib/interactive.c |   25 ++++++++----
 attrib/utils.c       |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 85 deletions(-)
 create mode 100644 attrib/utils.c

