Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363A130E4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968412; cv=none; b=YhE0FQT9TmZK8jMl8ncd+82TKIpdp27yaG6LHUqpxGSW6xKOsYAxVeMbt2/BFBGhvk4xjrGMHGl/GPui0DEc0VZEvRSbYLf7EW2yyi2uvtmoNxDVU8YLSXPd1Yla3PO6evVjLJ0C23yQuWZgMa9dwoDos290baIMSsw17gjTPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968412; c=relaxed/simple;
	bh=nMXhqh4HzokCG/i4LxOBg3hOYxhW1ngv6Tb8E8kN4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eed32JvDrjNoKOuteg0sVVisMSh02CcFrJH35EgxxfVftGmA+1L5RszbUkiu5egD409+Lovpm055bEmvY9Fa6AyVvj0amO+F7EQ03Y4cjowBbEk41XHzcchfz/MgfTw6LXaSYjGrAkRJ8sQDw5yBR+jN+C90jEMUgdvJtBrIZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=g2C4DFKy; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="g2C4DFKy"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so1686485b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728968410; x=1729573210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDE8ae4KGAACvTonZkpDinm//oEQtAd/MtLLCfcVh7M=;
        b=g2C4DFKyDe3l+Fzyu7zFErMJ3To8sKhu16V1BPylJQ7vw5WY4FNcCZQ2/YYYsZuCdo
         aY/6Sd04H4QxEYNKi2+PuZ4AmcHq9Y8Kd3HFnuWg+3OjeghaoOnFYOd9Q30Np7Jg54h4
         iTvf9otptP1Q+NOlBC5CgC9rE4vqh3BMAgDwqKSrWlsh6/Bk9xoBJZScKebIe8uzK17u
         pxobPNjJyvNXXU6k3/nB8/3Xx0otXeV/Ib7V3to3yOVVzMKTUe5KU0IqpBD7T/tkt15Q
         0xsUv5+WR7+nKpgr+Exv2UyS1QnYqr1ELsKLXtF6xecpWistpmXRnm7+U0wNPyUZ6BSY
         Tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728968410; x=1729573210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDE8ae4KGAACvTonZkpDinm//oEQtAd/MtLLCfcVh7M=;
        b=R2mHlnRaIqJtuzWIxUgCgwS6wankuJm3Et+ST+w3Ph/j5C4dErb+HFKe4/1TgNOrEO
         dXsTAwZECDs60qNTMeTKwkll5H1KNMw3SWqIKWxhT3kcIieTD+RgVGvzR0A5W5eiOgKu
         Ba6DL22Rmj7Ys+ytr7ocUJFW6hnrubmxWjD5FCdWay8RmZqbxLd/kYtB2L6AUrNwfqsJ
         s3NzQrYr2rFaxYVPbpb6lnmWg4/VMo1jrv6MuMnAl7Na/WYCSf/Uo/3A0e/EzHGSZewY
         Y/UucoUGpt13VxQqMIeJ1aoCoqiguQgc15I7kvieQe95Aaa3N9UBTBakYvxIexjw0JeY
         ewuA==
X-Forwarded-Encrypted: i=1; AJvYcCV43yP0GLBUKsOqAIDBSqhaP0Tj2CP31PQyq51jeGU6ntb9Ea9T8KnT3oj1tmPigRbPd0CSzzlI4d9ZkVoiH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1Qb0rq1hZJfzcIpd0SChiW1/Sj0c5yUt5Qg4Kc8pLm+lVcqw
	kt4bAEmORzuEEit+RUcnsE0mcfwjL9zVyE467kjAdQ3qD86JERqkRX70CkjUoko=
X-Google-Smtp-Source: AGHT+IGPdj8U1y9DYvRNnq4n+Baw1Zig5U/2Z3A5zNqzr6z2E57ek3/4AKtQDKOOKtFDMh3GKw4CrQ==
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr9511479b3a.0.1728968409796;
        Mon, 14 Oct 2024 22:00:09 -0700 (PDT)
Received: from localhost.localdomain ([138.199.9.153])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ea9c61c839sm439758a12.0.2024.10.14.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:00:09 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually deadcode
Date: Mon, 14 Oct 2024 22:58:41 -0600
Message-ID: <20241015045843.20134-1-everestkc@everestkc.com.np>
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
The intel bluetooth module was successfully built after the change
without any errors.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
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

