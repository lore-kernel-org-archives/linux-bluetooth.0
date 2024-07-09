Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1371EA74
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526158; cv=none; b=LK0q9lNzV48gpTVB7IcS/xOzyYsYJPJ0lW4SsT4NLFtLeANaQN9DqosngKvhU6YYa54OKA+/B3OU21I0WrOw9qzpPQMBS0dRjhCIZdH0LK8jXBqi3Twpl7+pDRWbx0YSVeTm2imOFp9JFcGhlt+bhc5KS0PwkB+XROnRLDMV0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526158; c=relaxed/simple;
	bh=2fjIYJh8srvhunf5GjNU3kGvPoIQ3tonHuYxpwHVR7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UW6XoizUUCIcZxQ4CDxEXZMcR6W4HP/Snv6NTjZ4LS03xoRF/5HCaW+1jRH6l9JkpuyRTzUg/qUnym8xKewlYPe4RSGFQrXXUMqKgi0MxBZrtQUZPgYfDEEf1T2tdu6JaPgLivTPdCFjUxhLbPVGYae0qDzj8TNLnv8rHQV6HbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf+qoXsl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+qoXsl"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58c07e8e9d4so611584a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720526155; x=1721130955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puPx9fqO1iPPaJ0zLIGCvHQTqB9sCozhdUKZqnjpQE8=;
        b=hf+qoXslWlyq5+bDZjnePCStcePAFWtsXl89pdfYAlqqvZFDpnhXqeDakq/zeYu81t
         nqRUKFsD1Rm8JViyy1cPaPQP0Xo8ryIwGBu1lLiRhdApitWkJn0NRkQKYlrxgdjLk6K/
         UnjOfjWQq/verJCho+9HwhOCKi4v/0n+3CQj3xA/W+/irBWpRX8JOX0y++RPiwoJBrR5
         e1oHczlY5bM2IHRZXYwwJFGWqxtWX/hejBDxx28Faryu1r3yrM++kfsBs7IYJn1URrle
         PwwwzZlb1LDHFqSJmY8z5F0XAuB36PCBwUgktpDLuoEANhN92T2QtxO4NN5HjRJeyyPh
         Eteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720526155; x=1721130955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puPx9fqO1iPPaJ0zLIGCvHQTqB9sCozhdUKZqnjpQE8=;
        b=eNn5fOo/SzytqfjQbo7Ks3u2a2kL5UMxeUE+YjVrWYZOZ2681YWFGBStT+c6qClgur
         7SytaBHuTEE2DxeuvH9s1dnVlv9rlI5uy5lIUFVvzw9i1MGZz0d0dTfJMLw/FmnT2J0N
         QcUotNFfQ7twQiQ7DcZh42dTBuTL0+zhs5VIuF7h1hEVZbp4zJ1f50UTwtJXgd22z1xq
         SIL0Npawtt9mXQ6nOWwfA3M6Iw91FmfFmpME1l+SceZz7dftCRUrImE9eJsvYXJ6z5fG
         84PMmEbhaub66zXg7F5fhoRSqghBa7qN+DxAKSSBLXc1+/ZgUfKYp6m4I3iFNLtC+lFt
         rumw==
X-Gm-Message-State: AOJu0YxEZ0NU5Rse823Q04RKa4wImLhaeevI764FnEap1XbfDIKLpMH0
	Kr7dutwPOc0Wi4c4u2GllsHq4W8Kgrg5hpAZ2LVbGvdW35rpCfgBAQnwYeOf
X-Google-Smtp-Source: AGHT+IE5x/dmwa6dI5353CHId1KgmYCOJbKOauO+MyAwCIKfVZJBbBn41CqSc2VM9Vr6R2C0/hSPsA==
X-Received: by 2002:a17:906:a2d7:b0:a77:c825:2d0f with SMTP id a640c23a62f3a-a780b8a402bmr135768466b.6.1720526154951;
        Tue, 09 Jul 2024 04:55:54 -0700 (PDT)
Received: from laptop.lan (2a02-a46d-501f-1-4864-a54c-8d9a-5694.fixed6.kpn.net. [2a02:a46d:501f:1:4864:a54c:8d9a:5694])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e176dsm71208566b.77.2024.07.09.04.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:55:54 -0700 (PDT)
From: Arjan Opmeer <arjan.opmeer@gmail.com>
X-Google-Original-From: Arjan Opmeer <arjan@opmeer.net>
To: linux-bluetooth@vger.kernel.org
Cc: Arjan Opmeer <arjan@opmeer.net>
Subject: [PATCH BlueZ] tools/btmgmt: Fix --index option for non-interactive mode
Date: Tue,  9 Jul 2024 13:55:41 +0200
Message-ID: <20240709115541.66118-1-arjan@opmeer.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In non-interactive mode the --index option does not work because the
call to mgmt_set_index() is made after bt_shell_attach().
See also https://github.com/bluez/bluez/issues/893

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9b7f851bd..436c2bb21 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -51,8 +51,8 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	bt_shell_attach(fileno(stdin));
 	mgmt_set_index(index_option);
+	bt_shell_attach(fileno(stdin));
 	status = bt_shell_run();
 
 	mgmt_remove_submenu();
-- 
2.45.2

