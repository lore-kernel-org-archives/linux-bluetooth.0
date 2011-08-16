Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Date: Tue, 16 Aug 2011 11:49:02 +0200
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 5/8] Added NULL check before dereferencing
Cc: "ovasik@redhat.com" <ovasik@redhat.com>
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0av70tbh52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
  plugins/hciops.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..e975eb5 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -593,7 +593,8 @@ static gboolean init_adapter(int index)
  	} else {
  		adapter = manager_find_adapter(&dev->bdaddr);
  		/* FIXME: manager_find_adapter should return a new ref */
-		btd_adapter_ref(adapter);
+		if (adapter)
+			btd_adapter_ref(adapter);
  	}

  	if (adapter == NULL)
-- 
1.7.4.4
