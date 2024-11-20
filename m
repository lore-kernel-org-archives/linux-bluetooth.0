Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D685288B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107816; cv=none; b=hCXG09VzOiWSipkaNfKClLEXuFQ9Rl0uI3b14XWCl6QvzC/l5gVUHpHDrsfrLPyqyHLxOqqSAj1lgJex6Zj7UlBoIMYG69uG9a9i4GPYGr7W1jvSwgLc0QNSKoG9NxgBM7x2BULv5X8msvwKNRWQX9G2mdA2LxG9D8M0ODIZL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107816; c=relaxed/simple;
	bh=Nl7Uj77zSazbfBxfTeLtOPuIELKoGTxwd0eeBgvEVGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lcszVh5lskLi0HDi6e5W1x8ItSJ4toBglw+PuKqFkH0KGVN3bZNH2WoCUULajo81niSVdfIEfsGiXbJEMjAqBUDdy0HUeWc4/thwR2K7WU+G7mLcR8GhVQqn/HwvLckVvuq6QNuXJx/8JvD5XUpT6P1VsKpZjvw6U2VDaFQRk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=Zk6crl04; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="Zk6crl04"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21278f3d547so2421015ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 05:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732107813; x=1732712613; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/9EqiUUwupYdHmVhIr5usiRW+faP9ptimY7V0ByCqA=;
        b=Zk6crl04j+cgel7JrgBaSj2lKNk1LwpxfjNEWSIK9dwj3KQyA4LgjGPhVRg5SPc7xX
         0oW2PIeeiJrU1nc/Hmf6U+CZ1ivDhIUHBZg4NEivs5UuQAqXt3CojHB6uB+8+7jDJURc
         wFjsA4rJTXH8OBVG2TC9stUmtSfFLjlUH382o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107813; x=1732712613;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/9EqiUUwupYdHmVhIr5usiRW+faP9ptimY7V0ByCqA=;
        b=KdVW3KpEyNDfzO07EbqUbtmEumLVY44LmOlnx4TDcawHbpCPavmzNf3WIxLpALs7BD
         //ttOHm6R9GjbNVUfNrGR6oajjgeKnxRjO9Cj+4PJUQBVWgI9AfMzCtDjw2Qdarkb3er
         pJMl3pY53D4hcvLIZXJN7baFXdYH59CpuVdlBSYAKS9GqHHPT/G+7JXMvjvt/A3qZrHx
         yFNTCAxqFUYc7ZxdMpBi8DeBaQg5IQq0S0taobLjVI1D1jPHc2rUcg3FAY2t/ZBQlvUr
         +vibAVZ6um673SmRZdwLo0k6Q3t+Qc4R6pLK6es2qNZwNl6fV9liJDWrpGFCk/cGxUsV
         Dheg==
X-Gm-Message-State: AOJu0YzkUZKzhdBAH+Yq46qLEv9qWie+mtmoCB9gqF3uZxEKDJg8GVNR
	ZSA+N62BCEtw+JHxE+qkNErrsuBRS2Yi/8N0WdmWw0pv9RQx5JlL2DC02BeiTaHG6OatbE1DyJu
	K
X-Google-Smtp-Source: AGHT+IG1AkM7DJvK+kuxFB3v5bm57Z+91vRsVmWfdm7tLaH4k1qlTeOLgVIva7tSBgQgTTfDyCjUlg==
X-Received: by 2002:a17:903:2301:b0:212:4aec:f654 with SMTP id d9443c01a7336-2126a3c1403mr31762425ad.31.1732107813200;
        Wed, 20 Nov 2024 05:03:33 -0800 (PST)
Received: from c8d99ad60702 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9c2f343sm74921205ad.122.2024.11.20.05.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:03:32 -0800 (PST)
Date: Wed, 20 Nov 2024 13:03:29 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-bluetooth@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH 2/3] shared/shell: fix -std=c23 build failure
Message-ID: <Zz3eIRBHrG7DHWiO@c8d99ad60702>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/shell.c:365:24: error: incompatible types when returning type '_Bool' but 'struct input *' was expected
      365 |                 return false;
          |                        ^~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index a8fa87696..aa6c16c8c 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -362,7 +362,7 @@ static struct input *input_new(int fd)
 
 	io = io_new(fd);
 	if (!io)
-		return false;
+		return NULL;
 
 	input = new0(struct input, 1);
 	input->io = io;
-- 
2.43.0

