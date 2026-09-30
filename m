Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F143750CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761403; cv=none; b=Nzn/iWEPPCLkSS2rNkQLswc7p8CfroSVRgllgh/cuZuXUkuapdwT6wkT4pcFRodjkDu+IUVVyfjzsljXUvfKWzyAPRDG6R/FaV6chSHHDYTXmjat0r3Shrez3l5TOkBneVmW/Tx1opRtzhAVyzaLCZgvDHk0TAacu6A7O0miQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761403; c=relaxed/simple;
	bh=3Hpdi2MItLSePWYqx1uvNAIPo4cBjCV+JKSfMr8Md6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPEOay7stavF/SHW+gIlB7Cm/jpkeICmqVrQL0D3hjkx0AHZonidiVUpETW4I1Au27FgEW56YTZ8W6yZi04lJwAvApnWlt/lCon4ygLQKKfmWvNda0DydOA1IFcJYeDL6U0wlj6QI9q6Gim7jruuSOIDATpM0U8I9JXlK37GN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6MxxJ1Q; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6MxxJ1Q"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0d9260baso5509393a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761400; x=1791366200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kizLLq1ZfA9rCD/HRWGigPR2UERyDH3KalyssBSoaD0=;
        b=L6MxxJ1QVvlt5WTHBO6eQIPtPVQXiTOGLXqxpF/6BzcwNTjmzxCmJbuIGqQTbrP0Ru
         VkktF+ltZZeaYXv6Ynp3iONtb4xI2LPLsX+IGhDJqSfG4YSSFPok6Mx4seMsNAaaV+CV
         3qpZx+/dxgQnWNYnfeD2j5DITv60k7ZBzDlAJpKMnTUiM2/ex2ssM34awLyeQ60nU16A
         f2i+E0YMu3WcJaenIN/Zlw8p9DpSMVL9e9Cot66FjDZz2Vge9g4Yxl80KzoPtLZLNIOG
         0GCsKCUGNC0bQDcn7yy+egmqptJI7fCCWvs6/VImDVfEXFQ2WsbW2V5X3+uDg4/MV38X
         bwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761400; x=1791366200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kizLLq1ZfA9rCD/HRWGigPR2UERyDH3KalyssBSoaD0=;
        b=FqOtNVE5TG9lhhk+AGVOlH+2BWArzMUuk8StbUSCR1Wko2iGV2vwhOyhB0+Eyr0rL9
         vwR75kzOY6lL4ykOdkt1BYZ5wd9E+0dVHJts5NDrWOGZdAKefMR50K4wTlWohbrH/kCi
         0vs86eKGb7UB6qajrWwQ17KerGO0lNeN55xGiu1OCN0Z/QsZoNuOO0s0zPoXU20LCeDA
         xLaxtlnSLoVw0NvL1R0vPSr8Dcwx4ihKb/a8+GYn5712Q84MJZ64czcSB5nxKj8kS1oY
         BvZMLHqJ5bz8krH14icJeZ5Gac/Lbu6tHWP9so1o856iPE9KvdsM/FmT7VUE3tlxgiak
         79fA==
X-Gm-Message-State: AFq9FYLlH5ZZzNg2efcGTmIrec+O3a7pRuKbT4MwHolk89YCxw1LXoKG
	IK/e3qnbRo2Mxl0HS4fEcSbAGSFGqMVwdjYuQDAtxgNmJ0fkpN6CwzKD8HJWvDGw
X-Gm-Gg: AYBFou2Tfmak1G/AwwdLDGjtJZeiVOzJaNja1LwiKkQoQA+AwauAXJInG736IrXTX9q
	gN4yG6S4PWKSJ3mZ54FiQawrZcHN1JnW93ww/qHwMVn4sT+fkKlFmBcDMM4qgjUm0uUOqNdaLDw
	LxRG9Ub3sFOg+ioKGDEOU8HpUlGnAtYHfKTTPd8qrfWHGsQGWtexFIkVisc+PpkX/ERPSLHr0uc
	pr8c55b0ronPZ5LxGt9y96PVNRUUqs9TEwJn0pAt1EYLW9YhXzRbkrnniJ8eAF3ZTeoahUf7jcB
	7NvoxsDglw3+Je44zS4qD0CSuSvKq0CRyQc++4k72t4a+7KXXOLynaSxObezIl3W1uTKYKgehg7
	7JLxQoON1Hso1kxHn5GrWGtDjZZi4t1FcfjfD8rzSplSByWyBx0Av7r3KIZiPpo3zB2xo9EuK+X
	JWEs4zKlsOmsmOYiPBbgCRUr6rzUsAhrIK9r5UglUN3f/BYu4fAmIocf/6lnX+ukfAexXkv85wE
	t7hXCpITLtoFY7JWb5kTGWq5gRBoBHrx1ihnTrCSlXgxAJWj6BdUsMzhWk8pRlTsgo6e4bMPKY1
	7QWTsn9niXkcrvikhqfyjtsmM4EWshdwGYXkUK1hcCc=
X-Received: by 2002:a05:6402:43c6:b0:6ac:7868:b681 with SMTP id 4fb4d7f45d1cf-6ae197f6107mr650736a12.0.1790761399678;
        Wed, 30 Sep 2026 02:43:19 -0700 (PDT)
Received: from home-fedora.hippo-beardie.ts.net (146-241-156-87.dyn.eolo.it. [146.241.156.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1539561esm521126a12.13.2026.09.30.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:43:19 -0700 (PDT)
From: Gianluca Altomani <altomanigianluca@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gianluca Altomani <altomanigianluca@gmail.com>
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Fix double-queued service
Date: Wed, 30 Sep 2026 11:39:28 +0200
Message-ID: <20260930093928.360745-3-altomanigianluca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930093928.360745-1-altomanigianluca@gmail.com>
References: <20260930093928.360745-1-altomanigianluca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

discovery_op_create() loads every service already in the client
database into pending_svcs, active or not, and discovery_found_service()
then queues an inactive service again when it finds it. A service left
inactive by an earlier discovery that was cut short therefore ends up
in the queue twice.

If that discovery fails too, discovery_op_complete() walks pending_svcs
with its removal callback already unregistered: the first entry removes
and frees the service, and the second one dereferences it:

  gatt_db_service_get_active (src/shared/gatt-db.c)
  discovery_op_complete (src/shared/gatt-client.c)

Only queue an inactive service if it is not pending already.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/gatt-client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 95f83fa3e..3520b5cad 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1170,10 +1170,16 @@ static void discovery_found_service(struct discovery_op *op,
 {
 	/* Skip if service already active */
 	if (!gatt_db_service_get_active(attr)) {
-		/* Skip if there are no attributes */
+		/*
+		 * Skip if there are no attributes. An inactive service left by
+		 * an interrupted discovery is already pending from
+		 * discovery_op_create(); queueing it twice makes
+		 * discovery_op_complete() free it and then dereference the
+		 * second entry.
+		 */
 		if (end == start)
 			gatt_db_service_set_active(attr, true);
-		else
+		else if (!queue_find(op->pending_svcs, NULL, attr))
 			queue_push_tail(op->pending_svcs, attr);
 
 		if (start < op->svc_first)
-- 
2.55.0

