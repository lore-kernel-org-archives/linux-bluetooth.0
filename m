Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/15] android/tester: Make local variable static
Date: Wed, 24 Sep 2014 13:37:48 +0200
Message-Id: <1411558680-26856-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This variable should be defined as static.
---
 android/tester-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 7997d8a..7a2f4c8 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -219,7 +219,7 @@ static struct get_desc_data get_desc_data_2 = {
 	.desc = &desc_1,
 };
 
-struct get_incl_data get_incl_data_1 = {
+static struct get_incl_data get_incl_data_1 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1
 };
-- 
1.9.3

