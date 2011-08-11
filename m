Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 4/4] Adapt PBAP to changes in get_next_header behaviour
Date: Fri, 12 Aug 2011 01:43:08 +0200
Message-Id: <1313106188-30273-5-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
References: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This means setting the header number when all headers
have been sent to OBEX_HEADER_EMPTY.
---
 plugins/pbap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index e10fa8c..6f605d4 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -980,6 +980,7 @@ static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 		return array_read(obj->aparams, buf, mtu);
 	}
 
+	*hi = OBEX_HDR_EMPTY;
 	return 0;
 }
 
@@ -1029,6 +1030,7 @@ static ssize_t vobject_list_get_next_header(void *object, void *buf, size_t mtu,
 	if (pbap->params->maxlistcount == 0)
 		return array_read(obj->aparams, buf, mtu);
 
+	*hi = OBEX_HDR_EMPTY;
 	return 0;
 }
 
-- 
1.7.4.1

