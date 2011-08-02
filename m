Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] add profile version to HandsfreeAgent
Date: Tue,  2 Aug 2011 12:25:30 +0200
Message-Id: <1312280732-5952-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
Samsung SGH-D600 returning 0x0101 as profile version) do not accept
an AT+BRSF with latest features.
The Handsfree agent should adapt its AT+BRSF command depending on the
remote version, so add version information as parameter of
NewConnection method.

Frédéric Danis (2):
  doc: add remote version to NewConnection method
  audio: add profile version to NewConnection method

 audio/gateway.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/hfp-api.txt |    2 +-
 2 files changed, 86 insertions(+), 2 deletions(-)

