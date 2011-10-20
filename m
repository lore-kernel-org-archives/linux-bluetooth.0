Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 hcidump 3/4] get_uint64 helper
Date: Thu, 20 Oct 2011 11:30:13 +0300
Message-Id: <1319099414-27993-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/parser.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/parser/parser.h b/parser/parser.h
index e975808..25aee09 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -193,6 +193,11 @@ static inline uint64_t get_u64(struct frame *frm)
 	return u64;
 }
 
+static inline uint64_t get_uint64(void *ptr)
+{
+	return btohll(bt_get_unaligned((uint64_t *) ptr));
+}
+
 static inline void get_u128(struct frame *frm, uint64_t *l, uint64_t *h)
 {
 	*h = get_u64(frm);
-- 
1.7.4.1

