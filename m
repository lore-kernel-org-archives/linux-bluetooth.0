Return-Path: <cyrus@holtmann.org>
Message-Id: <201008121026.o7CAQ00K005274@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Thu, 12 Aug 2010 12:17:10 +0200
Subject: [PATCH] Cosmetic: fix comment typos/indents
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/pbap.c            |    2 +-
 plugins/phonebook-ebook.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index c008e95..948f9df 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -921,7 +921,7 @@ static int pbap_init(void)
 
 	err = obex_service_driver_register(&pbap);
 	if (err < 0)
-			goto fail_pbap_reg;
+		goto fail_pbap_reg;
 
 	return 0;
 
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 1598d5f..ad40be3 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -152,7 +152,7 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 	}
 
 	/*
-	 * When MaxListCount s zero, PCE wants to know the number of used
+	 * When MaxListCount is zero, PCE wants to know the number of used
 	 * indexes in the phonebook of interest. All other parameters that
 	 * may be present in the request shall be ignored.
 	 */
-- 
1.7.2

