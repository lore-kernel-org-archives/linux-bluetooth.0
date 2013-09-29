Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
CC: "Hedberg, Johan" <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: FW: [PATCH 1/2] obexd:Add Operation property to transfer properties
Date: Sun, 29 Sep 2013 03:03:48 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E1179670E@SHSMSX104.ccr.corp.intel.com>
References: <1380008221-30501-1-git-send-email-wu.zheng@intel.com>
In-Reply-To: <1380008221-30501-1-git-send-email-wu.zheng@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Can you help review the patches? Thanks

Best Regards
Zheng Wu

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Wu Zheng
>Sent: Tuesday, September 24, 2013 3:37 PM
>To: linux-bluetooth@vger.kernel.org
>Cc: Zheng, Wu
>Subject: [PATCH 1/2] obexd:Add Operation property to transfer properties
>
>Sometime, operation property is needed by the Bluetooth APP.
>Therefore, add the property to transfer properties
>---
> obexd/src/manager.c |   38
>++++++++++++++++++++++++++++++++++++++
> 1 files changed, 38 insertions(+), 0 deletions(-)
>
>diff --git a/obexd/src/manager.c b/obexd/src/manager.c index
>f64b7b9..96976ec 100644
>--- a/obexd/src/manager.c
>+++ b/obexd/src/manager.c
>@@ -35,6 +35,7 @@
>
> #include <btio/btio.h>
> #include <gobex/gobex.h>
>+#include <gobex/gobex-packet.h>
>
> #include "obexd.h"
> #include "obex.h"
>@@ -515,6 +516,41 @@ static gboolean transfer_get_filename(const
>GDBusPropertyTable *property,
> 	return TRUE;
> }
>
>+static gboolean transfer_operation_exists(const GDBusPropertyTable
>*property,
>+								void *data)
>+{
>+	struct obex_transfer *transfer = data;
>+	struct obex_session *session = transfer->session;
>+
>+	if (session->cmd == G_OBEX_OP_PUT &&
>+				session->size != OBJECT_SIZE_DELETE)
>+		return TRUE;
>+	else if (session->cmd == G_OBEX_OP_GET)
>+		return TRUE;
>+	else
>+		return FALSE;
>+}
>+
>+static gboolean transfer_get_operation(const GDBusPropertyTable
>*property,
>+					DBusMessageIter *iter, void *data) {
>+	struct obex_transfer *transfer = data;
>+	struct obex_session *session = transfer->session;
>+	const char *operation;
>+
>+	if (session->cmd == G_OBEX_OP_PUT &&
>+				session->size != OBJECT_SIZE_DELETE)
>+		operation = "PUT";
>+	else if (session->cmd == G_OBEX_OP_GET)
>+		operation = "GET";
>+	else
>+		return FALSE;
>+
>+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
>&operation);
>+
>+	return TRUE;
>+}
>+
> static gboolean transfer_get_transferred(const GDBusPropertyTable
>*property,
> 					DBusMessageIter *iter, void *data)  { @@ -549,6
>+585,8 @@ static const GDBusPropertyTable transfer_properties[] = {
> 	{ "Time", "t", transfer_get_time, NULL, transfer_time_exists },
> 	{ "Filename", "s", transfer_get_filename, NULL,
> 						transfer_filename_exists },
>+	{ "Operation", "s", transfer_get_operation, NULL,
>+						transfer_operation_exists },
> 	{ "Transferred", "t", transfer_get_transferred },
> 	{ }
> };
>--
>1.7.7
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>the body of a message to majordomo@vger.kernel.org More majordomo
>info at  http://vger.kernel.org/majordomo-info.html
