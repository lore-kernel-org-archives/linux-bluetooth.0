Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3313CF99
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221636; cv=none; b=mWc6LI28Q2f2U4eEw++F7z+js98jbY8B8eUuZ80uR1HzDHeXD9cBvBcqZmaYfyGQ0+Ljqfd4nWjkgINY/HSavj2YUEhgALe3aDiZPZDrE6KG2C5jbT8wPGe8hUvVhCeHgFpAXr+8vUCwkOmI6EDWKP4RZFeL7zoLnOba4KsZUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221636; c=relaxed/simple;
	bh=ZguKYdN/iMozp/GB5Cfsl1QrHZ1Hztu1zg1nE3FZ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo22lZPEHx1Id8/ANoJnOihFNrNK7o+If9o4XeS2GVWszlakE0IFCfOEn26AOfxRHn989xwcZ5hvblOpRYa78gvRd3v7vNhQ83nxX7k7jl0vCgFQQmP3oMyRcyZ7wWcafKXb8/W4JuOimsTu3AUQNJ6k/xdZ0RfPi/9ZawEFxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=Iaitx71f; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="Iaitx71f"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43d4c5f7b1bso2264761cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221633; x=1715826433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=Iaitx71fz0ccwXaq6cZ8fgBACAD4k4mzknv3l4Xp8jp6NeMNMKHNc1SlNUAt1Gx5QD
         myu/F7ptkxD7CqGLgdPKOPbPiBYdx3gbJlUQg7iOmfGha5kylcfhXWru1kNnAhVvhKWf
         pHJYUH2G/qw5U+wKhs1hORlOZwZrF6mUlK10sxHfJIiwJK/doboQUf60cfaNhEkeaS6r
         xflE4Jdxd7Dg3oqSNN6z4HqA0aarKL1npL8Tpt19gYC6GhVErL0SNp+bpYujyMHEi6RT
         ACxoQgRN90uDR6Gp69Nc4IFQrLBgU+TYkCpMvH6v/rejk5d1VSbzaeEhLt8JvoX5A7o+
         WNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221633; x=1715826433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=iJaRjY7ko7CGWxxN7j9dcWtl+Tdl5OVTaIOYzEcq/pcuDkgHwc9VqkJUn4ayAhEyKW
         e3jek2bTFEVqRb11OY4ICP8A8bpYeMr9z+dJGhNuNWg+TLW+g6H4LTUi7Qq9CDRbp+m2
         GIDDtL1V5RWo7POIRcPwMmFAEt+WEUIxsHYUYKHwbEXncuWhRCLfNEeB8kHarCuUhkp4
         HPLCBX13c7VhwZFmzZ884GQW7vBlTU0+2nGjkFa8FjrzjYFLvDTqNZUbTSM5msrPjdHL
         graNa5m/5dLfzoA2Min2lm3ejPMykT7w6q9rG3Fvyix9my/V9wQfkRAfcBsSpTXFPHIq
         Rhug==
X-Gm-Message-State: AOJu0Yzg/To4BKHNY76oeK2usOQulNSvlbrFZHWQpBDxaUjyaV7hLYtJ
	99o1xEV+LMPCfQoxZF3mFWd9u6rsJPqi5c/v4KdPD/BTe1yPZTTjQrr078N99l41X4Hu3pGGpxJ
	w
X-Google-Smtp-Source: AGHT+IHGsMRQdhhqWQ62xf2XasLACnrJLfRX59YEaq0C1/CBVTqBGLnuKWmKygqAen6GpP9j8DX4ZA==
X-Received: by 2002:a05:622a:248:b0:43a:c483:9fc3 with SMTP id d75a77b69052e-43dbf50f8c9mr41250901cf.26.1715221632806;
        Wed, 08 May 2024 19:27:12 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56e278csm2091761cf.93.2024.05.08.19.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:27:11 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v2 4/4] gitignore: Add __pycache__
Date: Wed,  8 May 2024 22:26:40 -0400
Message-ID: <20240509022640.451351-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509022640.451351-1-arun@asymptotic.io>
References: <20240509022640.451351-1-arun@asymptotic.io>
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

