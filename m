Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] gatttool: Remove extra reference to the connection IO Channel
Date: Thu, 24 Feb 2011 17:34:28 -0300
Message-Id: <1298579668-3143-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1298579668-3143-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we want the connection to be closed when the last GAttrib
reference is dropped, we don't need to keep this reference.
---
 attrib/gatttool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 7478043..547757d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -620,6 +620,7 @@ int main(int argc, char *argv[])
 	}
 
 	attrib = g_attrib_new(chan);
+	g_io_channel_unref(chan);
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
@@ -634,7 +635,6 @@ int main(int argc, char *argv[])
 
 	g_main_loop_unref(event_loop);
 
-	g_io_channel_unref(chan);
 	g_attrib_unref(attrib);
 
 done:
-- 
1.7.4.1

