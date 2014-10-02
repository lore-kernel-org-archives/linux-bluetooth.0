Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/11] unit/test-hfp: Provide test_handler function via struct data
Date: Thu,  2 Oct 2014 21:29:55 +0200
Message-Id: <1412278199-5761-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412278199-5761-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows us to use user defined test handler depends on needs.
Will use it in following patches which implements tests for HFP HF.
---
 unit/test-hfp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index a8801b0..4b3473b 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -52,6 +52,7 @@ struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
 	hfp_result_func_t result_func;
+	GIOFunc test_handler;
 };
 
 #define data(args...) ((const unsigned char[]) { args })
@@ -95,6 +96,7 @@ struct test_data {
 		data.result_func = result_function;			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
+		data.test_handler = test_handler;			\
 	} while (0)
 
 static void context_quit(struct context *context)
@@ -158,6 +160,7 @@ static struct context *create_context(gconstpointer data)
 	struct context *context = g_new0(struct context, 1);
 	GIOChannel *channel;
 	int err, sv[2];
+	const struct test_data *d = data;
 
 	context->main_loop = g_main_loop_new(NULL, FALSE);
 	g_assert(context->main_loop);
@@ -173,7 +176,8 @@ static struct context *create_context(gconstpointer data)
 
 	context->watch_id = g_io_add_watch(channel,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				test_handler, context);
+				d->test_handler, context);
+
 	g_assert(context->watch_id > 0);
 
 	g_io_channel_unref(channel);
-- 
1.8.4

