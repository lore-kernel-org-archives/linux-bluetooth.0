Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 2/5] Send new missed calls count once
Date: Thu,  2 Jun 2011 15:23:20 +0200
Message-Id: <1307021003-15418-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change introduced by commit b0619290e4128bb583268bfbfbb66de9a30ecf7c
prevented calling count query multiple times when getting the phone book
in parts. However value of newmissedcalls was kept between calls to
phonebook_pull_read() resulting in adding application parameters header
multiple times.
---
 plugins/phonebook-tracker.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 1022d3a..37e6440 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1551,6 +1551,8 @@ int phonebook_pull_read(void *request)
 	if (!data)
 		return -ENOENT;
 
+	data->newmissedcalls = 0;
+
 	if (g_strcmp0(data->req_name,"/telecom/mch.vcf") == 0 &&
 						data->tracker_index == 0) {
 		/* new missed calls amount should be counted only once - it
-- 
1.7.4.1

