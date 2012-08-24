Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/22] Bluetooth: Add phylink lookup helper function
Date: Fri, 24 Aug 2012 17:00:08 +0300
Message-Id: <1345816821-32331-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/pal.h |    1 +
 net/bluetooth/pal.c         |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 201c501..31216cf 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -35,6 +35,7 @@ struct phy_link {
 struct phy_link *phylink_add(struct amp_mgr *mgr, u8 local_id, u8 remote_id,
 			     u8 *rem_assoc, u16 assoc_size);
 struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id);
+struct phy_link *phylink_lookup_by_handle(u8 handle);
 int phylink_put(struct phy_link *plink);
 void phylink_get(struct phy_link *plink);
 void phylink_list_flush(struct amp_mgr *mgr);
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index 24fb3aa..e781a20 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -139,3 +139,31 @@ struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id)
 
 	return found;
 }
+
+/* Returns phy_link referenced if found */
+struct phy_link *phylink_lookup_by_handle(u8 handle)
+{
+	struct amp_mgr *mgr;
+	struct phy_link *found = NULL;
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		struct phy_link *plink;
+
+		mutex_lock(&mgr->phy_links_lock);
+		list_for_each_entry(plink, &mgr->phy_links, list) {
+			if (plink->handle == handle) {
+				phylink_get(plink);
+				found = plink;
+				break;
+			}
+		}
+		mutex_unlock(&mgr->phy_links_lock);
+
+		if (found)
+			break;
+	}
+	mutex_unlock(&amp_mgr_list_lock);
+
+	return found;
+}
-- 
1.7.9.5

