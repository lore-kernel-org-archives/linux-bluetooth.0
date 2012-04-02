Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v3 BlueZ 0/2] Generic GATT client fixes
Date: Mon,  2 Apr 2012 09:56:34 -0400
Message-Id: <1333374996-3126-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These are the remaining patches, with fixes from Johan comments.

Claudio Takahasi (2):
  attrib: Fix missing Discovery reply when disconnected
  gattrib: Protect GAttrib when there is a pending write

 attrib/client.c  |   14 ++++++++++++++
 attrib/gattrib.c |   12 ++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.5.4

