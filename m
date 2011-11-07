Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <henrik.possung@stericsson.com>, <ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] SAP: Support for ongoing call
Date: Mon, 7 Nov 2011 15:56:30 +0100
Message-ID: <1320677790-32185-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches adds support for handling 
ongoing call in sap-u8500.c backend and 
add couple fixes to SAP implementation related
to this topic.

Lukasz Rymanowski (4):
  SAP: Add support for handle ongoing call
  SAP: Fix for connect response
  SAP: Fix handling ongoing call
  SAP: Fix handling ongoing call in sap-dummy

 sap/sap-dummy.c |    4 +---
 sap/sap-u8500.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---------
 sap/server.c    |   41 +++++++++++++++++++++++++++++------------
 3 files changed, 74 insertions(+), 24 deletions(-)

-- 
on behalf of ST-Ericsson

