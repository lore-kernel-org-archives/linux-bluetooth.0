Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C021D2B37
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114875; cv=none; b=Ccv2ZryQS4pH4ajv6Nvev40UZxVV99YBt1htexeIuQv/EfYUe51KUgBBWI6JbN8krQIjsjCmCZS8yddhIxNDCsq8VNwKuEjoWVXR+2QYVjYYLvOENl4xp386zC7AcvvFk5MWPt0mfjQJhzOpCtkNvqPxo9doqymNOwckfkjfmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114875; c=relaxed/simple;
	bh=1ODZFGWN7pG3n1mrOfsCXSzGx7bHoac/SNo+CnFKsyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4jrPZCL7zrnVrt5y6t/sgufJFyhQ6p3lhsvarvHRgWWOUJVEc5om6DiLjoYhFdPrdIHZhGrOWi1mVWvt9HGSVsHTnqve3wBnRnK10Uz8zPfVVnIxy2VcBqFQJpNf3NjTzn44o8nYZSq+8ZmIuRvq2veqBPCfnGM2vI/Jz3OFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=qByNn6x7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="qByNn6x7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb7139d9dso2497245ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729114873; x=1729719673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddbb9e6b0S7Fxkl43VzMGVnKoYlm5P/BdVV+4+ie3dI=;
        b=qByNn6x7+VE6G0xxJ6eWlk4mtx0amqo+Yho1ksm4+FGZi0jqre1Xa6D3kbqXQ26y4k
         sjk4tER+B04oFHKb9Q9+xl1cmsoJJl/8IYhPReLIQX/yrWUhUDYviaHVtlDQWzjzK//m
         UX04TknoLs487fl/sNjtCeRT2qfhR84kWgH4rGVLfY7tFn57XzYfT6ZIy8HynIF8shOa
         MukiOe9nrBoZNDiBwBjnjT+pbxet70wXiyMnY3OHiD5cXK9KAmA8mrA6Mz0tp0cLkkug
         FNNQo6A3R7yL8I+niZ6oqNKaq1ZUFRlk4W4k49G1v5asXxfCtB6pBsa3RTvRuPrVzn8r
         Yfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114873; x=1729719673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddbb9e6b0S7Fxkl43VzMGVnKoYlm5P/BdVV+4+ie3dI=;
        b=XuxTUKGAcQ89QPNUXBvfiuU3X1OmZ9Pj4HIXH4OXlO8bWenH8z6Zoa8jM2rgDmj4eR
         UFgEmzcYItklsKcxsbLZy9vgsfgHWl+WVxOGRV77cOTj48Mi7C8T1/HxlvLczbC817bM
         P3Rbu3xnmOfYzNxcJxLm60jtr5eL4xaTUvE3m6lm4PUnJTTrduJn4T4kpWqKFPdGnQWc
         +kLSfYFmTdTwvtxrpYpthCQ/9uq00wGVMzL33VM21PbR0hPuGMTzA2n5+vdY6wav9rWr
         43XfKtAVgTDX5q1zTIqcXWL+uLsgt8YsoV2G1LzmtGAePXHK/8fD8p9L9XwG27VryzHA
         L9rA==
X-Forwarded-Encrypted: i=1; AJvYcCXxKXKuCSWFXxgdw9Jq0tKoMX/VwF8P1G4IK6pAoLDaArbVZzRig7oXyK6HsU4LLYidsnAoC4Nar7YRjqtQhXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwitGIQafmUOICy+ifH72iTg+wmA6bt4dYeKh5HlhMpH1Z+0K
	sT83VdQKJwds3p9wjjcRd3sLzT8h2PpAut+nubog4W3cRV6KimqMZ4J5owLhy3c=
X-Google-Smtp-Source: AGHT+IFF5kLMoC48OD87DALfa7jzhyotOgHNJHe9KbQ38evTLDmZB7LvV5xXD/UpoPr9cQJIkq3/ww==
X-Received: by 2002:a17:903:2347:b0:20c:6bff:fca1 with SMTP id d9443c01a7336-20d27ead21emr78451595ad.23.1729114872979;
        Wed, 16 Oct 2024 14:41:12 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.236])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d17f844c7sm32999215ad.46.2024.10.16.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:41:12 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5][next] Bluetooth: btintel_pcie: Remove structurally deadcode
Date: Wed, 16 Oct 2024 15:39:55 -0600
Message-ID: <20241016213956.4508-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch case statement has a default branch. Thus, the return
statement at the end of the function can never be reached.
Fix it by removing the return statement at the end of the
function.

This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
V4 -> V5: - Fixed typo in the subject
	  - Removed Fixes tag as this is a code cleanup
V3 -> V4: - Fixed typo in the subject
V2 -> V3: - Removed that the change was successfully built
	  - Removed the link to Coverity Scan report
V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
          - Added that the change was successfully built
          - Added kernel-janitors mailing list to CC
 
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..660496e55276 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	default:
 		return "unknown";
 	}
-	return "null";
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0

