Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+RmdxgAbDSyjHeQj3nYmAMBPCt6jZxNrpbR2o6GOUi4A@mail.gmail.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	<1307554688-21555-1-git-send-email-hadess@hadess.net>
	<20110614080730.GC28890@dell.ger.corp.intel.com>
	<1308043116.26522.1.camel@air.hadess.net>
	<20110614094338.GA18317@dell.ger.corp.intel.com>
	<1308133135.9190.11.camel@air.hadess.net>
	<20110615210400.GA8352@dell.ger.corp.intel.com>
	<CABBYNZ+RmdxgAbDSyjHeQj3nYmAMBPCt6jZxNrpbR2o6GOUi4A@mail.gmail.com>
Date: Tue, 19 Jul 2011 14:35:16 +0300
Message-ID: <CABBYNZKCm0F=xLm0QqthhcOjK7e1DgweX2cXLzV6FeMijy2UCw@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Jul 19, 2011 at 2:26 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bastien,
>
> Apparently there is something wrong when removing last adapter
> bluetoothd start burning cpu, disabling adaptername fix the problem so
> there might be something wrong in adapter remove callback, can you
> take a look? Btw, Im using rawhide so I suppose adaptername should
> work, right?


It seems .remove is closing and removing the watch for every adapter
but the watch is initialized in the plugin init so it is not really
per-adapter, so I moved to .exit:

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2a54cc0..9e99e6a 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -262,10 +262,6 @@ static gboolean handle_inotify_cb(GIOChannel
*channel, GIOCondition cond,

 static void adaptername_remove(struct btd_adapter *adapter)
 {
-       if (watch_fd >= 0)
-               close(watch_fd);
-       if (inotify != NULL)
-               g_io_channel_shutdown(inotify, FALSE, NULL);
 }

 static struct btd_adapter_driver adaptername_driver = {
@@ -314,6 +310,13 @@ static int adaptername_init(void)

 static void adaptername_exit(void)
 {
+       if (watch_fd >= 0)
+               close(watch_fd);
+       if (inotify != NULL) {
+               g_io_channel_shutdown(inotify, FALSE, NULL);
+               g_io_channel_unref(inotify);
+       }
+
        btd_unregister_adapter_driver(&adaptername_driver);
 }


It seems to work fine.

-- 
Luiz Augusto von Dentz
