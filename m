Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26C12838B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183179; cv=none; b=YqfSrUYjkCklKC70JXtBNTPxCSffuOnehWfFrbyMZELZYH1UptPniUF9n6qmQcZuu7JCHDywG1Z97jmXIgeiD9j4sLPKY8jsaUfN8hXqP0Y7pf9Y7KyQK6pO3p0uurU3JP8mp6n7e2KO9FvunvNRMna8Wz/5yJQFPE7s/+70a6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183179; c=relaxed/simple;
	bh=ZguKYdN/iMozp/GB5Cfsl1QrHZ1Hztu1zg1nE3FZ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bumo5UgSyFJmRLf2OI4dEpVFHlsd8DmccX17Bkd6l/bvgboku5WZj3O5fg3lTsl2k8xtY27YRr6JTQXWLQJPjZHyIxqLdEDJ1uoDf9U6eySkY2Du7NGv7wi4oHbZllPBLjM6Q60ojdA0GKD64OupH2OvGW/k4HiVJ0JPy9FrpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=VSdpBIv6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="VSdpBIv6"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c7bd2586eso19163835ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715183176; x=1715787976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=VSdpBIv6niiPl2YZUxBlrEBybeEBLWIwmDvK1VaOvVSsJGmjee083SPTXpoxqBIBPT
         Xn7OLsNoQOUFvMZWlgZhQ6KaahV7l4hbjfPZgdegJj4PdpuZPt3l49lqzviaa7vJYnyo
         zD0AeR5mGr6ToZKjvJO33kdVMP95u7+Vn6g/G6sILA/aGcTNdT9lwzqwg407lmb2XJmf
         0E960XPrNvOSJOtPZPgNUGTWdq2HWbdOoVtzswFVLW8n0tDmZ7j3yEQmv7KqSJYXtuOC
         SmLJ3UF4AMNgazDUxiXSSs5NUhNcnaMNilM0P2CNR8nwWdVCV+UBNrndGTJ8fnLKVa04
         oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183176; x=1715787976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=V0dZwWBFYaoihgoLXYQMBkx+gEZ4H8S3ZHZUAHNbThNCBnn2ElwmnlONefzbI53Iwg
         zxkLfiIh4wlbjZjH+0R5cUTCP51U1FJnyw8VxC6Cbq/l8SOXIOi1asy6qc8uVWvITXhi
         A2Ko1t+WielDAkSdIRf+FUHEkfSw72RUdgVW64xGCVgDzsoZJF4tHhAzi7GvaP0nqqGz
         cUEvuBkBEBFwnRqdisG5NjnuCFvbIKcfKNmW+e6yZMwIRp7BK+9iQZlXMKlXkxO29m1j
         OGfDabhFRDLjjvZLpD8o18YoEWq3YhxPWn0jHBQo5m/h4zsm8Cu+BVQ0RKFNQ5qeXoZW
         fKRw==
X-Gm-Message-State: AOJu0YzJ+v5Scho17f6N5tW4uYQzoNMNip2l+WbHstEbYlSYOaoGT5M6
	xqijaOFWtj2k+5odpYWEvL+46J3+voMr3HtLSiIcackEvdnKvj2g9qmRIPXgUSXRWjnGDMKBUvK
	V
X-Google-Smtp-Source: AGHT+IEgXHEFzVnpf8/05Hb4bJELvoVpZoC3AIXarppT8ErTevuZr8N6bvswdFx/fZMNWnjhyJAakw==
X-Received: by 2002:a05:6e02:1521:b0:36c:85c:9800 with SMTP id e9e14a558f8ab-36caed56926mr32262565ab.29.1715183176544;
        Wed, 08 May 2024 08:46:16 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm7756513qtb.63.2024.05.08.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:46:16 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 5/5] gitignore: Add __pycache__
Date: Wed,  8 May 2024 11:46:04 -0400
Message-ID: <20240508154604.276763-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508154604.276763-1-arun@asymptotic.io>
References: <20240508154604.276763-1-arun@asymptotic.io>
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

