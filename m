Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C15B107
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804184; cv=none; b=PSodXUKPSTyhopbIefv9nInhw0gdv4N8ZD9az/QxfkDXajSgYkOgvPTt8nCv8lTGryDi5XbgS0B+mYefIG7hmeQA98UTaeA7J+thlP01cG2LotH0hCVn8teMSCWYe85sIfG1ILnwhreHZPPtXli4Ylq8ByFAhZ0rArQdeqHBVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804184; c=relaxed/simple;
	bh=ZguKYdN/iMozp/GB5Cfsl1QrHZ1Hztu1zg1nE3FZ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxwIA8+nd9H60JXr8xwP5rvST5rD6mvfOX0a4sLei5wpD6d8rjj7vMvG+UyoH88dOzdDmP4aLOTWWfOK2AtQ05rfAkHhhmrOzh6NCYWUPAfCtS9mf+bZ+tO9N/68qjUXy3yg1Uad8J5+tGxM0MYkl0hdBpKD9yLpTdmVRkQuiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=uc1kGYvy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="uc1kGYvy"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52389c1308dso2114570e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715804181; x=1716408981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=uc1kGYvyU5EuC1XWzUbSM6KMTAZ2p+IpqhMDBLgkjUT0/8dDb2UQt03tK3ybCqgEbM
         ZJMLgtk3A8n+1aqFvf6ik0x/HJqrVWKJTqH0ZxMkcgJYawJV7IDgTIFa75kahLvcaTF8
         121CpoNUbPkgbrOmRp/yJSHcBtYxbNhBrxVmO79mkWcqsHBg2U//h29D+suzFk0VoJRZ
         bRXHDpWgjKX312zVgBDckK7ctYcVp0Y5BiDWzvNXfbn1mojd3jHq8lt3MljR3BlrrJAF
         dU4CVSfUADX56v7Hlck8o7vtEISJhjw+P46FjuKWXLoliLrUfd5pS1A10y8wYUpelpMu
         W0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804181; x=1716408981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=suAJD6HUeQxs6doiqdhD4LPKUVm2oVebBXf0fNL9pYU8VCJqKtt0h7km7q/BaMYj+q
         yM11b0F3rXlpGPoazVohkBbPQwZxjG+ZkEhEgQsggcj7h5nMQrGZD6oSNFcJoZi3JtOr
         6+DRszl6GcQ4zf50NFmtkB5r2AiYp2E4+rsJd5EFyS8towGXjtmk2I5ss8RK34/0sYVa
         k4K8xqsq31Z8dc4f/vlkiuYeNXm7THG4tlz26PNfxj7wp5lVvpJveppyFRAeVGsx+JMg
         vkngc0pMEtWlioK7hi46+2pEtrhcG9HTAyaOP9nKWOSehzBFEKTPymutLgbmDY0Myv/j
         k7hA==
X-Gm-Message-State: AOJu0YzXuMjAVNvMkuz4Xk7pkxye/QLMTCGmTbQHP+4W2Gj8efMJGZKG
	HNcNYMOjjihz6Cbl1cP2byveCayYcMQRHnCjAjp9xpIMSYKV2XDpV66DQgAdxAdqW+NtBk5+z2z
	0
X-Google-Smtp-Source: AGHT+IG4JhY7IEwa7XDGE5Pa8vyxDy9RUcWxUFtp50QRGdaoUFUIlk/N+R7roqkvjmbFjB7TWZEeAA==
X-Received: by 2002:ac2:5598:0:b0:522:297f:cb06 with SMTP id 2adb3069b0e04-522298f0e12mr7853883e87.32.1715804181195;
        Wed, 15 May 2024 13:16:21 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5743065dd09sm7457142a12.64.2024.05.15.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:16:20 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v3 5/5] gitignore: Add __pycache__
Date: Wed, 15 May 2024 16:15:52 -0400
Message-ID: <20240515201552.1831618-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515201552.1831618-1-arun@asymptotic.io>
References: <20240515201552.1831618-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These directories are created when running scripts in test/ in-tree, and
can safely be ignored.
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6a6422379..041a707af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -187,3 +187,5 @@ compile_commands.json
 cscope.in.out
 cscope.out
 cscope.po.out
+
+**/__pycache__
-- 
2.45.0

