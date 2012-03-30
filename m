Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <lukasz.rymanowski@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCHv2 hcidump 0/3] SAP PDU parsing
Date: Fri, 30 Mar 2012 14:24:35 +0200
Message-ID: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This one is identical to v1 except for corrected copyright information
in parser/sap.c


Andrzej Kaczmarek (3):
  Add basic SAP parsing
  Add parameters parsing support for SAP PDU
  core: Add support for passing RFCOMM channel for SAP

 Makefile.am     |    1 +
 parser/parser.h |    2 +
 parser/rfcomm.c |    7 ++
 parser/sap.c    |  335 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcidump.c   |   11 +-
 5 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 parser/sap.c

-- 
1.7.9.4

