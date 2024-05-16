Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A014D28A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871325; cv=none; b=rNJN5jONFAZjPgpimF6s3gAp1Gv1ur8mVn/HNwX0KRjIlpNT0DvnP6qi1uhtbLfvSdkUMWeao+nqHYQKKxlJU9Zug7hLBP+BGgBlgokzF9NIIRGtn4ufBIRpvuvBoXRaQ5Tcoj8UufpDimUqPUb+DTnyNj4hSY6+Plb2y9SAcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871325; c=relaxed/simple;
	bh=ZguKYdN/iMozp/GB5Cfsl1QrHZ1Hztu1zg1nE3FZ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGMXKZdSNWkUpYWbL57FgWmei3T0i5f8xCo7q6+BicsQNnn1sJuVRBSaNHVRmAQ+W/a5QfqmUJG2oCzPcECsfwZevu9EITETdS06Fwn+xBmy7UkhJJr67QzTetGvdCNKhW54Ky9AzJpya/kfSH466HnDbVZCczQ7rtBqGR81DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=KO2zr/EG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="KO2zr/EG"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so2862868a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871322; x=1716476122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=KO2zr/EGYfdMRTAuF/DBFtJQoW2JNok7lMAKwpBWKlppUNtcit3Z13Akd9A8PhWayN
         UXKf6pmpRcnuCNrKLqE4wA4H+DPePh7N0AjHrx7SGFSjXqmdp81x1som575ZZ/O10hWy
         tRztsXsA2zs5MiNnrByNdRyIzomikzY1PliQ0EnMqPOhsIJMbgF1AWKOWxSHVVxv+qB1
         FQQCNcawhsGxEMDqzq7GRJ0jknOGd/7sOlgmlSGhl76E8FoYtTVIbwAWsSk6YkglsVHY
         Q0sNKCO1d1s8DRGihIHj+eLnIULJPoJaJIFsjSGAmCxUHmFHAX778cMR2e9+yHSkBrNr
         Cm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871322; x=1716476122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjCipZTmzBvwWD52PMAXup3LXscw2Ozf5wMm+FDuE+g=;
        b=gYMlBhH0hD28oGLdYScj9Hk2i6MKpoJUnhQo+8V9nYqBj7EkJYMndsXgrQLEeWdv8x
         Cl0PFhM0lC7dtjuPrWnRFG+FDMujJY3Cn9n39NpuSGtvtrtN3C+MEULNQoHrtLX0DoIZ
         NJH7NVz1NwYJvU16HH6Coc0gblJnAQa9kO5JUrEjeYebuM65GrJGFVYZYql3rUf6M+Xx
         z+aQcZ7HyADLGdngmINmReMA6202Ai/JqLctojyKVzz4EjWqio1EsxTMnI585q4fn3dP
         woGEZG1iFkFmpTnJz6QLwgVPMAAy+8WD4uXcXK1mqVkKtFS4nwzz5LlavgXJoeJZ03GG
         vP2A==
X-Gm-Message-State: AOJu0Yy/R4d5gRKp7PrNMJZE9+2fqHWKosDMwzcQ6yS0lO0IzWxTpm3y
	/EDvhF5vFd0j/btfCoGdjPi678/DacBpNSMcDHFD4q/u9mk9VVKrF1XNikeUNRAIOBDTl92koMl
	qu90=
X-Google-Smtp-Source: AGHT+IHcVxZJSYl79VdGwIUzPRnQ7xnhUjK5oVFe6bXqHnZMB8RiaO/mWK3vCMMI2qfmibd3dMh5ug==
X-Received: by 2002:a50:a45b:0:b0:572:6dd5:67da with SMTP id 4fb4d7f45d1cf-5734d705b2dmr18323575a12.36.1715871322404;
        Thu, 16 May 2024 07:55:22 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:22 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 5/5] gitignore: Add __pycache__
Date: Thu, 16 May 2024 10:55:01 -0400
Message-ID: <20240516145501.134118-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145501.134118-1-arun@asymptotic.io>
References: <20240516145501.134118-1-arun@asymptotic.io>
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

