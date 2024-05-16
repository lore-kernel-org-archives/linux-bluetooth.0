Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F28156F4A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888336; cv=none; b=STrBPK8ErrwzYWLA1ZsD2zw68SMx2UkzfeH32FAgXcZuei6ywmH73rNLM9y5+vUQ/uOwxsSKxAFk5F3VSvNaxBQTWH3WJJBpqw/lpjloVzKxuTaInnV3BulmtC/Htes4f/5rFQSrpeiQtPmD0snFchhLAK2Oti7hHgsnvVW5Nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888336; c=relaxed/simple;
	bh=ZguKYdN/iMozp/GB5Cfsl1QrHZ1Hztu1zg1nE3FZ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwT/6ebhL5RpKVrvI4+j6ZNA+liycdT+E2I8QdnturretWXvl34H9pGNcnL1oBExn/FmqDp61EZwvdYv5WQsqkCv9fUWS3j0GA7xFW/3r1GqmW6Tr3ghPJa8MsuZWFQ1hlC6ElJ0doJjsiqI8SBFHc5Vjk5eCXjFt3cbzMgvZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=Mu9F9nO7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="Mu9F9nO7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b49162aeso344626366b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888333; x=1716493133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=Mu9F9nO72l7SFt/qLd31rE+q8Ct2h6hIqutVyxITfed/LvWNXzVU/iXOTbLgZ2Zbgm
         h+t3eUKC2altP2xQM8DfzxRYUozgYLBElkknhWJbJtHjlQwMML2/ovhR9kx2sjzyL9yB
         FpPhgttKiT8rSVwQ2BF+pH1ZvRIYfyxFux7qaonJaTTu0wSGCQ7d02J/5I2cjJH7Cx42
         03LOwPORtxnTZr5hduG+Jyyw/C/tf3OZM9jlgKtiA12uJ9+hTsVj24qFZP8K0fpftyTY
         XD36/7segZ8baREIRayhHfDgv4we8mbRinoLVlEFMlF7BKO2kYYmOPwAvKZ0HMkLhBU7
         F0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888333; x=1716493133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=wt3sIsS8Fq8lro4ftH3lWGhYHa1p4UntJof0uXyQjfcztlwhSMa2keBvN0C8JmC2wL
         SjRpFiu0rwZReDO9oAe4ZzNar/iP/GMHNO3mlgY3iWEW6xisv/wJqmrYX7W0XB4VGBfo
         1iWUan4J3tlZdmMToalb5KnTNHqGmYJgHJ3uCyBkF/3ZrHoMCtj3qRhIkr1JCEVPYcHq
         o6D2AzezaME11aayGcgu2khhbh9Tep93LtpIUXkA6oy9W0F7zin3UQ7l3H0ct5jXj3qo
         FaRe54S2dVDdSSFYeE0YIb9PkU1p4EAaxOLNIG4mEgOHZzizscwjNBaBeA4muGWOzhbq
         eAbg==
X-Gm-Message-State: AOJu0YyG9O9qUipvRzTwv9KF1u2xWgEho051XngMOVQfUlGA501EFhhF
	72PosGkge6duVXXmvEWB2KWxdct7djU8tX4IqYC7f06MKiRIkCSJwDdyiX7o0j/cx6Gz4e7rLTT
	8ppQ=
X-Google-Smtp-Source: AGHT+IGv00A6l1OMuMJBgf5gBcfYtDjOw0Nw4w5g1xxr7eOZG3AS8KUbDzDQu2M7RYplJhiQIoH9+Q==
X-Received: by 2002:a17:907:3f28:b0:a59:bd78:34ca with SMTP id a640c23a62f3a-a5a2d5c89f3mr1585431566b.36.1715888332914;
        Thu, 16 May 2024 12:38:52 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:52 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 5/5] gitignore: Add __pycache__
Date: Thu, 16 May 2024 15:38:36 -0400
Message-ID: <20240516193836.228281-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516193836.228281-1-arun@asymptotic.io>
References: <20240516193836.228281-1-arun@asymptotic.io>
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

