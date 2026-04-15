Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B67346E43
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249842; cv=none; b=r9Tk7CGnW38qiTrTY7X9pZymHoGmbd9Qtk7HPfWjaCNOvcMUpMhY6AI2eXirdiWX0c2cVtk8tSUiQNc7sa1IC2ebYPD0LYGKEPxlqwTNZ8EvaNgNPj3s1bvS+JFMgOJeAvQDfySQi+33bdR+58qTQvDt10PRBIzZoIDGM+Dm1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249842; c=relaxed/simple;
	bh=QizZVTRUzTHfR1mYPypOJbSRLH3r6DbMJi50jsIVVkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PqCRTtk0FDAmSmJEH+Jhvu3wANPgXZOTZm3ZoTPR/UfI7pbi1Qok5ROSmNFaZ9e+tTyDFUb7Pqmn3hUZcZhMMYDrktX/F09TENYvZ/p3dIA0ZoeSQSiSN7WdANEGNQyIXMgoeJ76Lv/r1Y6KKA/4L5Znc29Bp67BNYLc2G7yV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpT7jK1o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpT7jK1o"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2ea1b3962so21454865ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249840; x=1776854640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0r3GGM+Ca8HIJae8nAZ92x/ik7k700SFym59YDDpY4=;
        b=CpT7jK1o4QhEeMS2T50r1peyu2ZVIYj1XF2Y4pb/YWLsBE4XA1wQScWPoXusUFJpTK
         9WRTY5HBAZio2X66kdjv6eJOZV+dlZhhLzzvTC81fzCJJrwNf9gv20T7X2mzOHXyJnMN
         6gFuKwcavcfBbqzZcIGObgGnVmcbEnrcEbgH4KcFrjCQIZSagCyuTJcy6rl0QbT8soNA
         YO5N1ho/Wx/xPMlL5G8bv5G6lu4dUNc31ng02y0pMerNTB38l1MGHkNUNDFJvhzhg4/G
         r8okVpVD5b5IQtGrn4Lof1hnkmVOu3RWwiyRx9vAHfkoEkwyL9vdzjpikBt7saSCn7V6
         ZdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249840; x=1776854640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0r3GGM+Ca8HIJae8nAZ92x/ik7k700SFym59YDDpY4=;
        b=lBqqy/K/iYxEkucJAYLS0H1o7djY2s489oQVjOuj+Jb8y5WqL8kLcXBsvXlPCabPCh
         3WNkVlVXI8GZVQfdnN7DOKls5M7C0CvI/8Q1uc06bDQu64VYQUBfNm1xNv5HG5rC0hpA
         cr5G4OOnCcGUjE6/iiG59zxVD529L2h8kt1iHWE6+gtUAFMw9LKjQcSESmnIidKvv+4H
         Q7RuqOyuBX7bSBo2OrkpUNjF45Z3juYQQ3wSVsp/TDmTBWWRlHhKeMnkaCctfjWIOVuh
         SBV0SFszxPOwlc+HyIFsFXXxImT923Zje5y8xQKmS5s0bqfPvDUhX2CL3BmIGLLLd9jN
         UyBQ==
X-Gm-Message-State: AOJu0YziwJtzXuZx49y/JjjINMUBw6XVSaTYv7D4zOARyI2HhhRMClAN
	KQjJ2K5sbCydSh/RTHaYjuj/50dHEIEh6kmdAXO5+oEI35NXC1LmezrQCFcW6g==
X-Gm-Gg: AeBDievOPiV08E5beb04rz5HhDrU6NP8iPOweF3Ug0rDB+BMoENjDxblz18xN3ffZTF
	uSoDrtjjSK3YHLHciszYwoLNbz00aaA5meHMFxmUDMSyrzDuv7MfahZOZjmc0S35LAOH1DpSQE1
	978W4gOJZZzixZLl5vlf4uvrfuBSezxQkT2CrbM7AIMNDQ8xI3MdCngXWJmQHdONeJMtKUCtO9L
	SEvfF1rR0CCCE/9Tkp/F60k+NPhxSfAQRW56H7g6t8obx5qTSvtMgmie6KU+CUIGgt/9yOKPD96
	0A/og7OT16E5rx+LPNE3ERsQqaSATWQbif64PnaFeJEaiNv06aXXaYKX+saCePUX1HLGQ790sqH
	A9YqPzaz76zigm0Y5wlnxvMNbUBx9IUMGqRBgBuYOosg9aVwHLR0/nknD2357AGVpyTwwAK604Q
	jsyZ22nyEmQTnUdLVqXM2eDLD1Ic50Y4+JpqpORJKyXQRqogFRLgNzZyEMMMQG
X-Received: by 2002:a17:902:b193:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2b2d5a5de38mr170364405ad.28.1776249840158;
        Wed, 15 Apr 2026 03:44:00 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e248sm17283225ad.47.2026.04.15.03.43.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 03:43:59 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req
Date: Wed, 15 Apr 2026 18:43:55 +0800
Message-Id: <20260415104355.76524-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The L2CAP specification states that if more than one channel is being
reconfigured, the MPS shall not be decreased. The current check has
two issues:

1) The comparison uses >= (greater-than-or-equal), which incorrectly
   rejects reconfiguration requests where the MPS stays the same.
   Since the spec says MPS "shall be greater than or equal to the
   current MPS", only a strict decrease (remote_mps > mps) should be
   rejected. Keeping the same MPS is valid.

2) The multi-channel guard uses `&& i` (loop index) to approximate
   "more than one channel", but this incorrectly allows MPS decrease
   for the first channel (i==0) even when multiple channels are being
   reconfigured. Replace with `&& num_scid > 1` which correctly
   checks whether the request covers more than one channel.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..29d793f3a2eb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5428,7 +5428,7 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 		 * configured, the MPS field may be less than the current MPS
 		 * of that channel.
 		 */
-		if (chan[i]->remote_mps >= mps && i) {
+		if (chan[i]->remote_mps > mps && num_scid > 1) {
 			BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
 			       chan[i]->remote_mps, mps);
 			result = L2CAP_RECONF_INVALID_MPS;
-- 
2.39.3 (Apple Git-145)

