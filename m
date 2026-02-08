Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C461F0991
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770533537; cv=none; b=frFP1RyRY6RDoNqaFtB0+yrpl+oSHeH/VHKcgEnU001zMUkb6mGdCkf9HLUvCz2X+IvExiFMBrn4suC9jyEPQAum9SkjaP3q1PlEQPci/05haT6iIf3V/5LofDi8LQTo01EBV7FjUPlDsel95MaSIuuzOxVS4zGuwApdufy6m6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770533537; c=relaxed/simple;
	bh=F9bNjK+pzEpZsGayI6GYJIczHINzrgN7fQGyUMcEuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEX4kPJiHnCAvhQav5VStvoJyNdYy4VYaoSt/30MUYt6V/eqqpFmnnnALCp8I+NoE95o18LRYMgQbA50vO+/lwqig5Hy6BAEkvxxcrS0FfQxfXkCu1atHqeZDNz2s8IhKVfHmVOh1R9jAB/rH73a5EBxt5ogBshkTtQU5Ha3FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCA/B9In; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCA/B9In"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1248d27f2b9so3957397c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Feb 2026 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770533536; x=1771138336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=iCA/B9InMxfKdSbUllM0X6EXujqq3zmgzcOVdFQrsoORXDGKmW05xy+tGlXAR9ysqY
         vf9ql8vMNnp5dJP/tx8rQcmgwUqGiN6saNGHLfnavdr/uDtZR4i3P1rx68iDOk/viDGC
         b0nwIJ39nOyLHV4wYNyQG5F1QfULnxdA0wnJl/0CGZiux1aRL2VfR+OH4FjUcPNturhp
         8bX+nYIqPTOYBly9ZowxE2VbZBFgrsDg7XDNMtyIHy611FIoKiXRqt7kYvjklcBnuA7m
         umunMZlVGO+QTT+BuYcHfjtRMVRYmcyPFp5OeGOm65q/enfKoGwB99GwUt8oBUuMWpTv
         tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770533536; x=1771138336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=Qj9hiwYAAh2zwhmd3+/vcjWT8yg/k2iCQ847GxynoeODF1HVMmw9CPmu3uru6BakyR
         0W2JT+rd9hE+D22EYxhYsutnOGgHVVukJoiRBIVE5UpVxVHjUh3N9ZtwLa+GsyiA296z
         bru9w6eagoma6aUNYpynhwiwglm+b2oVwRG6geX5N41xozgQbLmVPaa3YEaQn9CBTsU4
         kTgVOpRwnjSi5x1SMa0dlwrLE36sCL8d+wfeSzP3/9HNMsz+Pc4jPRUr3kEPh9fXTbKA
         Mw4zy7IQxknpdxZ3RlDXj/vELP0juMs6ry0B8k0DtCQbrBIC9onS9pVKvSJv/786R/ue
         B8eg==
X-Gm-Message-State: AOJu0YyONjwtoOC7Fidd6aSxLBK3LrD/bRbywh6/wPo/cjVBaE1elqRl
	OoFR9f7NwpcPWBiDKuWFE8ix4C+Ln4ZrgsO8VBvTQ/jcuFI+Kan0YybGG99NbA==
X-Gm-Gg: AZuq6aKIKp58YiX33I+jR1eh85i+fWHjJYFTurWaonwGZhC3HDAVA7OVpg+Vo9rEjXh
	8ZD9SLdyRwn/6PdhjTUc2z6M2+SW48Vkdr+x6ib5vU6jrux8OApYtqolFO7n36/+QI/iF8TLeAB
	mk4YUR/ctcbgXKln3ckzmUyRfgbmUxTUPecBp2Hz33o3iPz0eaUXpi1xPwFiDY197SiAAVl16aI
	dZxluNgesjI3+B8VlCp7OBUvY8otvd0lr7ApDeLmlLPsBAkja30K+UUofX52f+9goziuSUBkRe6
	UZYgfiKGyKN+pE7NfV1ZRLR7MmJbqkP8xz6V9bIarudFJq48ruhayY9sF+1YkQ9xa7VybGE+FVl
	WfnYJNm0qviVRAkKSogr6Mf7iaFygPwIr3eGHUZELse1hNM7Viz4W3sCoU9bJq8gAN/lq0RmnyV
	9VgGHgOiSWvkyrbDLsvUHqWDxyU6jEd0/yO7mwYQmVnC8jEhwZSTr2qgfDre1PpRS05C/x
X-Received: by 2002:a05:7022:60a3:b0:11d:f464:38b3 with SMTP id a92af1059eb24-12703f72281mr3368964c88.2.1770533536260;
        Sat, 07 Feb 2026 22:52:16 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e5460sm5673025c88.6.2026.02.07.22.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:52:15 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Sun,  8 Feb 2026 06:49:49 +0000
Message-ID: <20260208064951.41392-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208064951.41392-1-maiquelpaiva@gmail.com>
References: <20260208064951.41392-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the user-provided length in mgmt_mesh_add() against
the size of the param buffer. This prevents a heap buffer overflow
if the user provides a length larger than the destination buffer.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..bdce52363332 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -413,6 +413,9 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+			return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
-- 
2.43.0

