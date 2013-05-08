Return-Path: <cyrus@holtmann.org>
Message-ID: <5189C7C6.8090408@asianux.com>
Date: Wed, 08 May 2013 11:34:30 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jiri Kosina <jkosina@suse.cz>, andrei.emeltchenko@intel.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: hidp: using strlcpy instead of strncpy, also
 beautify code.
References: <518906A8.7060708@asianux.com> <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com> <5189A417.503@asianux.com>
In-Reply-To: <5189A417.503@asianux.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


For NUL terminated string, need always let it ended by zero.

Since have already called memcpy() to initialize 'ci', so need not
redundent initializations.

Better use ''if(session->hid) {} else if(session->input) {}'' instead
of ''if(session->hid) {}; if(session->input) {};''

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 net/bluetooth/hidp/core.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 940f5ac..f13a8da 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -76,25 +76,19 @@ static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo
 	ci->flags = session->flags;
 	ci->state = BT_CONNECTED;
 
-	ci->vendor  = 0x0000;
-	ci->product = 0x0000;
-	ci->version = 0x0000;
-
 	if (session->input) {
 		ci->vendor  = session->input->id.vendor;
 		ci->product = session->input->id.product;
 		ci->version = session->input->id.version;
 		if (session->input->name)
-			strncpy(ci->name, session->input->name, 128);
+			strlcpy(ci->name, session->input->name, 128);
 		else
-			strncpy(ci->name, "HID Boot Device", 128);
-	}
-
-	if (session->hid) {
+			strlcpy(ci->name, "HID Boot Device", 128);
+	} else if (session->hid) {
 		ci->vendor  = session->hid->vendor;
 		ci->product = session->hid->product;
 		ci->version = session->hid->version;
-		strncpy(ci->name, session->hid->name, 128);
+		strlcpy(ci->name, session->hid->name, 128);
 	}
 }
 
-- 
1.7.7.6
