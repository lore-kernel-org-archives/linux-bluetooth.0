Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 0/6] *** SUBJECT HERE ***
Date: Thu, 24 Feb 2011 17:38:24 -0300
Message-Id: <1298579910-15198-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please ignore my all not-applied previous patches. I am resending them
with a few corrections.

Bruna Moreira (2):
  Move attr_data_from_string() to utils.c
  Add Write Request in interactive gatttool

Sheldon Demario (4):
  Create a helper function to deal with handles on interactive gatttool
  Add Characteristics Descriptor Discovery option in interactive
    gatttool
  Add characteristics read options in interactive gatttool
  Add sec-level option to interactive gattool

 attrib/gatttool.c    |   23 +---
 attrib/gatttool.h    |    1 +
 attrib/interactive.c |  348 ++++++++++++++++++++++++++++++++++++++++++++++++--
 attrib/utils.c       |   19 +++
 4 files changed, 361 insertions(+), 30 deletions(-)

