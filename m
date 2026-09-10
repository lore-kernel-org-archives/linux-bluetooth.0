Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E401545DAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061759; cv=none; b=I1DHsh2koFYn2quUhsZfGoZKPoRlni2g1dGmFpnkRWugCWOwOjiDbEm9QiaexAcLBayyKJlz/YUozvRBAe9vBAyyH+QQ8hKO8z8tnGET6cENXtJpuZr4gulzMf1Lrw2okArwx/eyrtEDESjJJ4JQu92X6NYUlhVia/q0qjZkBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061759; c=relaxed/simple;
	bh=ILxqly80nlk0D8ZXiHtP/t+6UPdaBW+9KBElpjn/VGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iFzCyBS9YJIgWEY+6jb3HqIb4m74dqZrxEGpkW1CgeUsbg1IwFvWNgZ/t4spZxNFpTFZEEUaomEciPAEZpwcl4CUXxTJVy/iZ0hIm0Ywk2Yw42UkxXQTVpf6bQM1W2vEIFkOKAOSXd6k0Rew3A7sEK288E54EmvJBUu8D1YHXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI8dyw9R; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI8dyw9R"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c664b8c3f3so109906e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789061752; x=1789666552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J4rxIGodVHu8HD1FOWvOlVm0DW2HaV5R1PN+9QIXDGI=;
        b=MI8dyw9RLzU75yVJvSeSBHpDGPlc9X0d4K3PKM7wsqpZsfJJ6jHkhzux3turYeI4Ej
         j9QVarDPXNYIVYSRXDEp+Qb9M5/l64nXg4QBOtEDox/zmxZL+n0HzmLWW+Z3zdfbZ+22
         shV2yoBltDRl02odE377o/bCTGG+s3vxFEt64mF3KWT3SxZqsR8sQMKSFKI+4pbrPoaB
         rHDBIfgK2bJB1DlrhS7lBS6oqzqFniKYwlqYH+cj26qyNU8DHl7Mk6PNjVvDkBNxuS6a
         J3cBfiipGJgB3VWrQ+2UwoGbGyEuiXqD3+Ji3/n9iSvnFYIIxJlvNxkpwm2TQHv6g4+O
         o1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061752; x=1789666552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J4rxIGodVHu8HD1FOWvOlVm0DW2HaV5R1PN+9QIXDGI=;
        b=iIzg2a1MjggJXijTNHIwGLU9dwjeUbuqdle3Ro1A0oxMwnFYV3r8qa4ClVedNc9huI
         6klMN+GveJWirDn7vViu33zI/Wh2m5ld7SFe6ujy6z8rec2oygxpiUmtljFj5o/RkgV5
         s1QTo/yL0KN1xZgXhLbyK63AXu6oVF2MynOu5cO5d2UeZUAu2MyAFTeMWJ/SD3n72Bdq
         O0wdxLXNiU64gYo3wVjnpfcHJhY1+sSAGVBee0M1h1UZW/YlshEsEBdZC1VI+PQnQF18
         mHlM1G603CRkGmyBIEOBNm/b0xrCAoF2bzZTrS42lQlxAQmAXFZrcUBjdUxCSCWklmsa
         y+mw==
X-Gm-Message-State: AFuF++mF4if6jamhj3LZcdNxmaM6ilF6g6Tq9TAW3uASLMivFQqEJnO+
	blYJeD4bjs5BAtkhj5a2PSYEuFdKyOnpZWj+fgdSsJGcQKM35T0R7D1B3GAV8UuB
X-Gm-Gg: AYBFou18QQGYXzd44TaGW7Tp83MCV8njhoyA5ioU4Utw0yqk5bXJJobabgTogcV35t8
	pL9yhlH4/Tp8wRcs4AGOFIgPFkFW7j1aJh5wyTRvo7WZ7qDTlSF1/J2m2BebKu+wiJ0B3aEvlEw
	AIfBblQEBgFhV9c48cWjbr14GqGx1kSn4xyCQRoEfbsCdDgAcEP+6pZ0TbIo5hxGBf7547ZYj2z
	pMnPQ9noz+woLMV5rCgEOw0lkreypRooJLwO2VRkstm04PtMl4+j3DeTfTNIPuRq5fCKiGCDUj0
	xDC9LkZXzC0GCnqg8IUvD18WuDAxe2Tm+ZiXHupi16V/KC4IMG5hmjEmUSvyuAExL1kWuaTZQip
	ua2VfkizqpvQahlS+5kspyXiFYXuuYSBpOsYB//c5Jg2AYrR3TMB6YY+eC3AXhlhOicGAcGom/x
	LdxD5h+RWrKDW+dgu8gdJIiw1AkCDS0zzQzhvYHiD489ei+YQr/Xw3adqlgXlu2zZzCCv+GrLZb
	GiG+Dij6YXJD4HbU8/ujpEg4Otn4xFnUH6SoRE6Ubfz/JQcGP/6jYarhhuZOBqHCA==
X-Received: by 2002:a05:6122:4f87:b0:5c8:2852:36cf with SMTP id 71dfb90a1353d-5c84628223cmr1120228e0c.4.1789061752026;
        Thu, 10 Sep 2026 10:35:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982ba16978bsm191562241.12.2026.09.10.10.35.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:35:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: pass the email token to the cleanup task
Date: Thu, 10 Sep 2026 13:35:42 -0400
Message-ID: <20260910173542.1508648-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The cleanup task notifies the mailing list when a pull request is closed
for being open for too long, but without the token it cannot send the
email and the pull requests are closed silently.
---
 .github/workflows/sync.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index c9e107ebc348..37179113da99 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -40,6 +40,7 @@ jobs:
       with:
         task: cleanup
         github_token: ${{ secrets.ACTION_TOKEN }}
+        email_token: ${{ secrets.EMAIL_TOKEN }}
 
     - name: Sync Patchwork
       uses: bluez/action-ci@main
-- 
2.55.0

