Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] MAP client: Add missing parameters for GetMessageListing
Date: Tue, 15 Jan 2013 14:56:39 +0100
Message-Id: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patchset adds the missing parameters Text, AttachmentSize and Status
as well as the filter SubjectLength.

Christian Fetzer (5):
  obexd: Add parameter SubjectLength to map_list_messages
  obexd: Move parse_size function in map.c
  obexd: Add parameter Text to GetMessageListing response
  obexd: Add parameter AttachmentSize to GetMessageListing response
  obexd: Add parameter Status to GetMessageListing response

 doc/obex-api.txt   | 20 +++++++++++--
 obexd/client/map.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

-- 
1.8.1

