Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 0/6] Add support for MAP MASInstance feature
Date: Tue, 07 Oct 2014 09:36:50 +0530
Message-id: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch-set implements MAP 1.2 MAS Instance feature.

The patch 1,2,3 will handle the Client part(MCE). It passes
the PTS 5.3 test case:TC_MCE_MMI_BV_01_I.

The patch 4,5,6 will handle the Server part(MSE). It passes
the PTS 5.3 test case:TC_MSE_MMI_BV_02_I.

Gowtham Anandha Babu (6):
  doc/obex-api: Add description about MASInstance request
  test/map-client: Add D-Bus API support to make MASInstance request
  obexd/client/map: Add API Calls for request and handlers for response
  obexd/mas: Add support for providing MASInstance Info as response
  obexd/messages: Add prototypes for MASInstance response
  obexd/message-dummy: Add MAS Instance description to response

 doc/obex-api.txt               |  6 +++
 obexd/client/map.c             | 88 ++++++++++++++++++++++++++++++++++++++++++
 obexd/plugins/mas.c            | 62 +++++++++++++++++++++++++++++
 obexd/plugins/messages-dummy.c | 18 +++++++++
 obexd/plugins/messages.h       | 16 ++++++++
 test/map-client                |  9 +++++
 6 files changed, 199 insertions(+)

-- 
1.9.1

