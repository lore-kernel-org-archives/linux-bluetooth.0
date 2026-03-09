Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F11E9919
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773021493; cv=none; b=idqkTcfJEefbhaCg/0qgHmU9igWpxx6yUXR/65XnZqj6nPxNco80iTJVcBSblkGOr+8PHdhy1J80SjE9akY265rFI65IvmuO0iW6gycIeZbt/+82n90L4bLQoKzt3zYduxXLvys3CKLSDjpcr/gFReipv6QP46VfWPfwJSuLiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773021493; c=relaxed/simple;
	bh=yNFJVzRpwO6TQe5TXWb22UnwIdnz/zs2/kWMv4Qltck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLg0j+zXu/vFoJ88koP6kDy01Wbyirr8Ik4EfyK09CegvPYZokQMujKE4YLCdEm05AijYFh6NntDfAbrhnAlep2rKegpUoQmS1J3fRDXcnqbg8Ej9p19SLDmhX9jpHIK03GKtXsA2mrXZ3TjqWoZN3F7Ccd4NBxTgaav9Cq9jhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khNa6Ryj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khNa6Ryj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50919fc3a14so5601221cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773021491; x=1773626291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=khNa6RyjpmhzBVbeAjE3f3r9zqoOU5us3VlYGQistXkTvtaL+g+Xi3SJQWk8+WooUz
         04EKaBigKJJYxxRMAGTs2NpvnGJaI5TjPQmxd3EkscqnhzEO/tC6nu4Xkl6fQM/evuht
         KyLw5h7LWhrSBbNf+8MG2bLbyeQiwcz0uZLzTuAXq4YKWV7f+6371w9zQZgwTkCyHo9F
         /HiP9pYEZiamo2lpTK0MjpmItRMS3Jz9jy6yHGgaF6qILwE+AYqEL05K0oFNB5CuhcJf
         haqnvGxiEa/k3m6SGVpG0QHwvnYy7ls5u6ANnANiuLGwttNEAOv5iuTik6VsUMCxXdox
         6XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773021491; x=1773626291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=R5tdXbyZyrB9mP2SXd3DslWGnubpFgj6iSDlIV+Y11OdFTBsFbh6dxrNfZ5nv5m+HH
         yVEGbWghdmMakRCIrn2BDnXMMO9JZtVkUXQ7o6r76LZDuMv+h1yt/4YfNAPlmuzVKk+Y
         w03NtFhPpNCzfgwC2ZOyjvCrFoejy75WYgSR2pHhOo9oVDqA4UQQCnR77cnQ8BLJzaq+
         /Z2r2DxRNsgy4u/qTyIes4lNABvq9/ev9z85rZgGD0OKkX2K28Jqy0qXeyXCPaj9Eiq5
         faT9692i7gPtaFueny3qUwmixGz9+eXdsWTwequ+Mh0optKRKoHrqBeJpNNTBzC7Ut+Y
         KSWQ==
X-Gm-Message-State: AOJu0YxVKaVAA3NjfGPQSBusMCiaXlMe1SzwrSG8AZ4cBJZz7yVlx9o0
	iRQXPVoB31E3Cy1ozoRgRkU8pwdy6vd9ZdeIDf9433MHLbAzO1zaFxD0fM/pt+tniJU=
X-Gm-Gg: ATEYQzzVbyCGnjYLzdoJg0Aan4cujdDNvQc2hPPftmwSIgnAs3Z5lE8tY4tIHOr7MjI
	3ZPXoXTl9qQn40H9dyhjkIlAmhx0vZ5kVoJ6q//uUZ4y7gpQmToKJgxgQYQ4O7OvA5ihMLIXGYD
	nTS/v++MhMDtr/QbBEKx9k3v6nRKG5c3mfNcxJrpM/8KD9d+1ag/GLbSFeWZ0v4nwR0Hn/xS4u4
	aHPtDYpMVKkJvY4uw7+CSTLlLm9vnj5myb/Fke9iybgbsp4Tc54RHsB5c+9PbOPbTFky+jKVJqB
	xNK+T64sAN7Ax1HyUMFVvqZH+tMt/6s5eivarZ+CesPSSAMfqyoJvcPW+ab9wQRhgotajAIZDwN
	lPwwHRAnGxFwGRKtjHCA1MOd1+9x94ljEK9BXbvEijzhJgEjvekhrc0HQcVmIkYpNWBLCI7k0rt
	SmI2oOyF43Y4fmQY2FEJDCTBHERVwB7BMGhfi7
X-Received: by 2002:a05:622a:1446:b0:501:4f38:3d47 with SMTP id d75a77b69052e-508f498eca0mr128283291cf.53.1773021490695;
        Sun, 08 Mar 2026 18:58:10 -0700 (PDT)
Received: from gabes-pc ([184.145.175.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f6695738sm58616861cf.16.2026.03.08.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:58:10 -0700 (PDT)
From: Gabriel Woloz <wolozgabriel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Woloz <wolozgabriel@gmail.com>
Subject: [PATCH BlueZ 2/2] lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
Date: Sun,  8 Mar 2026 21:57:45 -0400
Message-ID: <20260309015745.1720-3-wolozgabriel@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260309015745.1720-1-wolozgabriel@gmail.com>
References: <20260309015745.1720-1-wolozgabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/bluetooth/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 1ad52529f..1c741ed55 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1199,6 +1199,7 @@ static const char *mgmt_op[] = {
 	"Read Mesh Features",
 	"Mesh Send",
 	"Mesh Send Cancel",
+	"HCI Cmd Sync",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.53.0.windows.1

