Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d961002111320n3e5626d6oca767c7facccc356@mail.gmail.com>
References: <9c9ad6a31002111256v1c3394d1rade3c3640ee7efb5@mail.gmail.com>
	 <35c90d961002111320n3e5626d6oca767c7facccc356@mail.gmail.com>
Date: Fri, 12 Feb 2010 11:06:07 -0500
Message-ID: <9c9ad6a31002120806m381e6548xacf28c5ba9b079de@mail.gmail.com>
Subject: Re: [PATCH] eSCO fallback to SCO on Error: Connection Failed to
	Complete
From: smcoe1 <smcoe1@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Nick,

Thanks, I guess I wasn't really paying attention, it was a late nite.

Signed-off-by: Stephen Coe <smcoe1@gmail.com>
---
  net/bluetooth/hci_event.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 592da5c..6c57fc7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1698,6 +1698,7 @@ static inline void
hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
 		hci_conn_add_sysfs(conn);
 		break;

+	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
