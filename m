Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] obexd: Fix memory leak in phonebook-dummy
Date: Thu, 06 Jul 2017 21:38:15 +0530
Message-id: <1499357295-22470-1-git-send-email-s.syam@samsung.com>
References: <CGME20170706160048epcas5p2e073fb00c373bc8b9fe0413505b5f65b@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_build_filename() returns a newly-allocated string
that must be freed with g_free().
---
 obexd/plugins/phonebook-dummy.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 29ae889..b9e3a0d 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -524,6 +524,9 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	filename = g_build_filename(root_folder, folder, id, NULL);
 
 	fd = open(filename, O_RDONLY);
+
+	g_free(filename);
+
 	if (fd < 0) {
 		DBG("open(): %s(%d)", strerror(errno), errno);
 		if (err)
-- 
1.7.9.5

