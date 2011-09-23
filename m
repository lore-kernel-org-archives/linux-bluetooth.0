Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316765733.3433.0.camel@localhost>
References: <1316765733.3433.0.camel@localhost>
Date: Fri, 23 Sep 2011 12:55:35 +0300
Message-ID: <CABBYNZ+zqEarDZJYvNjuUmRxpAEDYOMH_4J=7XcZL4y2-nhazw@mail.gmail.com>
Subject: Re: bluetoothd segfault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Alberto_Jos=E9_Rodr=EDguez_Rodr=EDguez?=
	<ajrodriguez@blulabs.es>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ho

2011/9/23 Alberto José Rodríguez Rodríguez <ajrodriguez@blulabs.es>:
> Hello Bluetooth experts,
>
> I wrote a program that scan the air for obex capable devices, but I
> frequently get a segmentation fault from bluetoothd. The attached file
> contains the execution log of bluetoothd using valgrind. Any help will
> be appreciated.
>
> http://pastebin.com/9RLeMPPz

I found at least one possible cause of this, if you are connecting to
multiple devices simultaneously (have multiple ative sdp sessions)
src/glib-helper.c:find_by_bdaddr is broken because it will return 0
(found matching) for all sessions where the adapter matches which can
leads to remove the wrong context and cause a crash like you are
seeing.

In this case you the following patch should fix it:

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 22c14e7..0288c9c 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -333,9 +333,13 @@ int bt_search_service(const bdaddr_t *src, const
bdaddr_t *dst,
 static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 {
        const struct search_context *ctxt = data, *search = user_data;
+       int ret;

-       return (bacmp(&ctxt->dst, &search->dst) &&
-                                       bacmp(&ctxt->src, &search->src));
+       ret = bacmp(&ctxt->src, &search->src);
+       if (ret != 0)
+               return ret;
+
+       return bacmp(&ctxt->dst, &search->dst);
 }

-- 
Luiz Augusto von Dentz
