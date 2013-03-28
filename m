Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 12/16] sbc: Declare and implement sbc_init_msbc
Date: Thu, 28 Mar 2013 11:18:59 +0100
Message-Id: <1364465943-959-13-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc.c   |   31 +++++++++++++++++++++++++++++++
 sbc/sbc.h   |    1 +
 sbc/sbc.sym |    1 +
 3 files changed, 33 insertions(+)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 137757b..3c7f7b3 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
  *  Copyright (C) 2005-2008  Brad Midgley <bmidgley@xmission.com>
+ *  Copyright (C) 2012-2013  Intel Corporation
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -966,6 +967,36 @@ SBC_EXPORT int sbc_init(sbc_t *sbc, unsigned long flags)
 	return 0;
 }
 
+SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
+{
+	if (!sbc)
+		return -EIO;
+
+	memset(sbc, 0, sizeof(sbc_t));
+
+	sbc->priv_alloc_base = malloc(sizeof(struct sbc_priv) + SBC_ALIGN_MASK);
+	if (!sbc->priv_alloc_base)
+		return -ENOMEM;
+
+	sbc->priv = (void *) (((uintptr_t) sbc->priv_alloc_base +
+			SBC_ALIGN_MASK) & ~((uintptr_t) SBC_ALIGN_MASK));
+
+	memset(sbc->priv, 0, sizeof(struct sbc_priv));
+
+	((struct sbc_priv *)sbc->priv)->msbc = true;
+
+	sbc_set_defaults(sbc, flags);
+
+	sbc->frequency = SBC_FREQ_16000;
+	sbc->blocks = MSBC_BLOCKS;
+	sbc->subbands = SBC_SB_8;
+	sbc->mode = SBC_MODE_MONO;
+	sbc->allocation = SBC_AM_LOUDNESS;
+	sbc->bitpool = 26;
+
+	return 0;
+}
+
 SBC_EXPORT ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len)
 {
 	return sbc_decode(sbc, input, input_len, NULL, 0, NULL);
diff --git a/sbc/sbc.h b/sbc/sbc.h
index bbd45da..5f8a1fc 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -83,6 +83,7 @@ typedef struct sbc_struct sbc_t;
 
 int sbc_init(sbc_t *sbc, unsigned long flags);
 int sbc_reinit(sbc_t *sbc, unsigned long flags);
+int sbc_init_msbc(sbc_t *sbc, unsigned long flags);
 
 ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len);
 
diff --git a/sbc/sbc.sym b/sbc/sbc.sym
index 2cabcdd..3a47c12 100644
--- a/sbc/sbc.sym
+++ b/sbc/sbc.sym
@@ -1,6 +1,7 @@
 SBC_1.0 {
 global:
 	sbc_init;
+	sbc_init_msbc;
 	sbc_reinit;
 	sbc_finish;
 
-- 
1.7.9.5

