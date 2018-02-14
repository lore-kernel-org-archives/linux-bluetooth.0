Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] obexd: Fix null response name
Message-ID: <6b59ff69-6805-597a-814e-8813c9922d03@jp.fujitsu.com>
Date: Wed, 14 Feb 2018 16:20:31 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prints out "<unknown>" string if there is no response name as below:

  obexd[8117]: obexd/src/obex.c:cmd_connect()
  obexd[8117]: CONNECT(0x0), (null)(0xffffffff)
---
 obexd/src/obex.c | 59 ++++----------------------------------------------------
 1 file changed, 4 insertions(+), 55 deletions(-)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index ed219d3e7..2850d3a37 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -82,58 +82,12 @@ static struct {
 	{ 0xFF,			NULL		},
 };
 
-/* Possible Response */
-static struct {
-	int rsp;
-	const char *name;
-} obex_response[] = {
-	{ G_OBEX_RSP_CONTINUE,			"CONTINUE"		},
-	{ G_OBEX_RSP_SUCCESS,			"SUCCESS"		},
-	{ G_OBEX_RSP_CREATED,			"CREATED"		},
-	{ G_OBEX_RSP_ACCEPTED,			"ACCEPTED"		},
-	{ G_OBEX_RSP_NON_AUTHORITATIVE,		"NON_AUTHORITATIVE"	},
-	{ G_OBEX_RSP_NO_CONTENT,		"NO_CONTENT"		},
-	{ G_OBEX_RSP_RESET_CONTENT,		"RESET_CONTENT"		},
-	{ G_OBEX_RSP_PARTIAL_CONTENT,		"PARTIAL_CONTENT"	},
-	{ G_OBEX_RSP_MULTIPLE_CHOICES,		"MULTIPLE_CHOICES"	},
-	{ G_OBEX_RSP_MOVED_PERMANENTLY,		"MOVED_PERMANENTLY"	},
-	{ G_OBEX_RSP_MOVED_TEMPORARILY,		"MOVED_TEMPORARILY"	},
-	{ G_OBEX_RSP_SEE_OTHER,			"SEE_OTHER"		},
-	{ G_OBEX_RSP_NOT_MODIFIED,		"NOT_MODIFIED"		},
-	{ G_OBEX_RSP_USE_PROXY,			"USE_PROXY"		},
-	{ G_OBEX_RSP_BAD_REQUEST,		"BAD_REQUEST"		},
-	{ G_OBEX_RSP_UNAUTHORIZED,		"UNAUTHORIZED"		},
-	{ G_OBEX_RSP_PAYMENT_REQUIRED,		"PAYMENT_REQUIRED"	},
-	{ G_OBEX_RSP_FORBIDDEN,			"FORBIDDEN"		},
-	{ G_OBEX_RSP_NOT_FOUND,			"NOT_FOUND"		},
-	{ G_OBEX_RSP_METHOD_NOT_ALLOWED,	"METHOD_NOT_ALLOWED"	},
-	{ G_OBEX_RSP_NOT_ACCEPTABLE,		"NOT_ACCEPTABLE"	},
-	{ G_OBEX_RSP_PROXY_AUTH_REQUIRED,	"PROXY_AUTH_REQUIRED"	},
-	{ G_OBEX_RSP_REQUEST_TIME_OUT,		"REQUEST_TIME_OUT"	},
-	{ G_OBEX_RSP_CONFLICT,			"CONFLICT"		},
-	{ G_OBEX_RSP_GONE,			"GONE"			},
-	{ G_OBEX_RSP_LENGTH_REQUIRED,		"LENGTH_REQUIRED"	},
-	{ G_OBEX_RSP_PRECONDITION_FAILED,	"PRECONDITION_FAILED"	},
-	{ G_OBEX_RSP_REQ_ENTITY_TOO_LARGE,	"REQ_ENTITY_TOO_LARGE"	},
-	{ G_OBEX_RSP_REQ_URL_TOO_LARGE,		"REQ_URL_TOO_LARGE"	},
-	{ G_OBEX_RSP_UNSUPPORTED_MEDIA_TYPE,	"UNSUPPORTED_MEDIA_TYPE"},
-	{ G_OBEX_RSP_INTERNAL_SERVER_ERROR,	"INTERNAL_SERVER_ERROR"	},
-	{ G_OBEX_RSP_NOT_IMPLEMENTED,		"NOT_IMPLEMENTED"	},
-	{ G_OBEX_RSP_BAD_GATEWAY,		"BAD_GATEWAY"		},
-	{ G_OBEX_RSP_SERVICE_UNAVAILABLE,	"SERVICE_UNAVAILABLE"	},
-	{ G_OBEX_RSP_GATEWAY_TIMEOUT,		"GATEWAY_TIMEOUT"	},
-	{ G_OBEX_RSP_VERSION_NOT_SUPPORTED,	"VERSION_NOT_SUPPORTED"	},
-	{ G_OBEX_RSP_DATABASE_FULL,		"DATABASE_FULL"		},
-	{ G_OBEX_RSP_DATABASE_LOCKED,		"DATABASE_LOCKED"	},
-	{ 0xFF,					NULL			},
-};
-
 static gboolean handle_async_io(void *object, int flags, int err,
 						void *user_data);
 
-static void print_event(int cmd, int rsp)
+static void print_event(int cmd, uint8_t rsp)
 {
-	const char *cmdstr = NULL, *rspstr = NULL;
+	const char *cmdstr = NULL;
 	int i;
 	static int lastcmd;
 
@@ -148,13 +102,8 @@ static void print_event(int cmd, int rsp)
 		cmdstr = obex_command[i].name;
 	}
 
-	for (i = 0; obex_response[i].rsp != 0xFF; i++) {
-		if (obex_response[i].rsp != rsp)
-			continue;
-		rspstr = obex_response[i].name;
-	}
-
-	obex_debug("%s(0x%x), %s(0x%x)", cmdstr, cmd, rspstr, rsp);
+	obex_debug("%s(0x%x), %s(0x%x)", cmdstr, cmd,
+						g_obex_strerror(rsp), rsp);
 }
 
 static void os_set_response(struct obex_session *os, int err)
-- 
2.14.1

