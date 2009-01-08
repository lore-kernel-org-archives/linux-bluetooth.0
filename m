Return-Path: <cyrus@holtmann.org>
Message-ID: <b014639a0901081044w3a0d6b44gc065bb1289ade64c@mail.gmail.com>
Date: Thu, 8 Jan 2009 13:44:35 -0500
From: "Mike Lockwood" <lockwood@android.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix a bogus pointer crash that occurred when reconnecting A2DP.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

commit af5d46b22852f4ec1ca0d7c43c7a7e71292fe334
Author: Mike Lockwood <lockwood@android.com>
Date:   Thu Jan 8 13:34:06 2009 -0500

    Fix a bogus pointer crash that occurred when reconnecting A2DP.

    Signed-off-by: Mike Lockwood <lockwood@android.com>

diff --git a/audio/unix.c b/audio/unix.c
index 1e4dd2d..ad31181 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -919,6 +919,7 @@ static int handle_a2dp_transport(struct unix_client *client,
        if (client->caps) {
                g_slist_foreach(client->caps, (GFunc) g_free, NULL);
                g_slist_free(client->caps);
+               client->caps = NULL;
        }

        media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
