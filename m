Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE013AAF50
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233074; cv=none; b=lndSGSoY5MK9KVkBHj0yxuhGv6ldB37SzII+GVWL7ZjAVJ6dkbGSL37hVIa/uvO4w0dDX9VKPUoneFpDj1ng9UF33jVXdRGEdKGqgST88rlzpcZ1EJWN5vftERWo5pu0cI8UMbecF7WWVhSMrD4mt5+56BRSeNUe/DbmlNLHS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233074; c=relaxed/simple;
	bh=VZ9AhH8GNxPD3BtJGBAYbVUfZQKYdMQ1AmQEDJqmp/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnc6VZGl4nhkkaKKR+2Mle6HS/rVRKkGYPstavf43sYpygWJXolOQwerBMWbtjiBguoMi0rgpwAmZ21m0pujEfjYapgfjAmllmFSpaBbklIOFDd+qrFyTD8++XsE30wly9fmmFfm193xkdQem3JTHYLk5r2c3EBPbxp0D6jMUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTYM4ngB; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTYM4ngB"
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5e1acb86c7bso525644e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791233071; x=1791837871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=HTYM4ngBGa2aVZEo/GvHJytMA84VXxWCpTvVgKaiQR1REoe/GqjPZEScAjQrmNuAms
         MzjB4g5tuYbVQ/hV3T4eDy/3wUa18bZloTo5iyPXW+oAsLYN0DW/J0EGg1dnPS6ICdn6
         mU4itWVKVWYhhOUVavw3B8q31yH8GCWz2RSy/i520ZWSk6TtAGhuEpm1pjH5grPE+qo8
         nKORU42fsGAlELYVI61VtRTind2GK9IaIpGby3Lu0ry0ZZMD/69JwsK9tVzxpibI3CkA
         DoqGkbzPmeichcSBIAWuYTtRwYUvpzdN6HyBK1GvAHVnKB0iYHELGyRMIAM9FiC7cCRc
         iJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233071; x=1791837871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=AyQUhxExub378UBn2Glu1wq6SuUYilz15PY98TGjt3SccQ/6oWmWX+UIJarJsd1fu9
         2v7/NNCW6Mc9fH5wSwcda2m45JuhbWpBeYkKSohKZGsny2iSZxKbuL3Jll87bJwexlbK
         a915IPjsu0UIj0OAqv0QzQ/RH2xKIKD0MnDncBZUI4cqmjai2IAJlhviPJUgspm1DtNU
         /epGcZ5oriEdt67H0U55JBXIo2NaFOLcI8Csn9mNVugC8FHdtltG1T3TCFY3R4tg5p/5
         //on6TQjdXy5VVrMmpHgbdXh3UW21uVE6TcUCrR+g+4Sa9IKFAP6lvnGEt9L97N+rZAG
         zAcA==
X-Gm-Message-State: AFq9FYL8wVRaTeKUJBv+betqTapSifw/7d6YqsXruhjFM+3wL9lz3Nek
	n7U0c9UW+ZmueihivbITTdKvKSI9hupL4Cf8ahjYWeUugg2orybASyyTIte993zC
X-Gm-Gg: AYBFou0wA4dsLZgJ238BWK7wPR66omg1qsMAdGN6tJ8VBmPvVxDw+l8+8ViGqGn4y6d
	LQs8c/C3aodkRy9bNcU6+EWo9Qn5mrpj2WQGEqXSr1HMbksLETkkEvn386rdcQcISsLyXSZ7NPL
	7btNuVS/fXuyfyymXtzsaos9W7H09kicNkZ5Z/vby3tQgC+pcBxJ03kDNJ0AvKeDFs0uKbWiK+H
	lcrjQMr7+bYkVU/5B/1Dv4yDwjBjQx/rbjV9/IOXZ0QAb1suGC5CA5FBb+pOLbcu3BcioHxebp4
	T9P1FcbefO0mi9jAcYKy7mMhomC/pJzmJdpDzVYvBOx57/K6JWfPhVaFdIucnZbdImBEh1pY2D+
	rAYnmO+3YZxLRf6Cnu+CuoIDPuIags3nP3oDA8FznVBb6C7S+Wa0pJCXs+sTfCvtVYMxah94vso
	RQcFrwcYs3Qt+xXenEMeBCcVsKNKXNqz7sbc4unz45iZHvBx9kwZbC0TPDq4iCEP9iNe3XxKMAF
	ywPb0PEbKLJKd6O8cJ2NJNTyz+wq+QVpeIdKTIwUrAAY2vCstZ6qmW+L9qqeqOkP5Yb//scZOg=
X-Received: by 2002:a05:6122:2402:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5daaf77e705mr2968550e0c.4.1791233071059;
        Mon, 05 Oct 2026 13:44:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54ffb92a5sm531789e0c.18.2026.10.05.13.44.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:44:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
Date: Mon,  5 Oct 2026 16:44:19 -0400
Message-ID: <20261005204420.3684587-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005204420.3684587-1-luiz.dentz@gmail.com>
References: <20261005204420.3684587-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When Add Advertising completes without HCI communication, e.g. when the
device is not powered or the instance is overridden by Global
Advertising, the instance is left marked as pending, so a subsequent
failure in add_adv_complete would remove it despite it having been
successfully added.

Fix this by clearing the pending state before completing the command.

Fixes: fffd38bca51c ("Bluetooth: mgmt/hci_core: multi-adv for add_advertising*()")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 106b35c88c98..93872a5fc39c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9173,6 +9173,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (!hdev_is_powered(hdev) ||
 	    adv_overridden_by_global(hdev, adv) ||
 	    !schedule_instance) {
+		/* Instance has been accepted so it shall no longer be
+		 * considered pending, otherwise a later failure in
+		 * add_adv_complete would remove it.
+		 */
+		adv->pending = false;
+
 		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
2.55.0

