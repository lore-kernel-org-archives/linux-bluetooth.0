Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF3275864
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725512; cv=none; b=sA+72DZMJj3WKgPUb47rsn1kiYrxksqlXYZJGz/+va0UZqwld5VkdITVoYD9Qs28774T7k+Sr8AL37xO5lPhvnmBE7w13iv565DDld3RUPeKzGn4m09YzFsQXW9A2aPGC5uK4dH6LM1JiJVHYD+5aBjWvEkOhT6QVJVXisdP35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725512; c=relaxed/simple;
	bh=NEd2Tf7H49pgHdO7rdrsVzn2xK7WxrmVg/NGQzOuJu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5yC6+/XvVajCVgd64sqy07DsGdi8F2AYj1Pk0eVvh5UXHc2l22YDKVWv8MAinZePvRVB7Wkwem1QZ89Fg8DwWRaqTji5Q0M4/WCre0ARpfE5DZiudm5n5tWsd4BwGWDhgX+SX711wN2htx2gbz8XhPGI2SmguoW81IBemCo8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaCsPmdo; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaCsPmdo"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e7f38440fcso1344674137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753725509; x=1754330309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=JaCsPmdoEM8lW+gOwi1X98FX8i40hD1ioT1h24+HRu2sxBnTU9eUkoRCqyBHKQkFdH
         92SuRhAhohgqTcqzesRms9iTDqECqAalIb27z6efcqvexawkl4AEBdR21otdz25HVsDx
         cC2ZR0TGjt2un+K5otVmaegtKYiJFxJ4xRTxp+1y0ft3YJipN3GTaISpjOLtUh23DaYc
         pnvjrARZDr8IqigZ/e79rraHECc3qIctyzbHaXApsnRXNeF7eF/vsn2L3Z7BVYNahC9T
         DYcKpUtJMc3WQbsBKjZQEfyUwMEeM4ntQG2hfl0OGCQpMEVYpZx1LvFXCi6Y74ggxUJ8
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725509; x=1754330309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66s/I0IDDRgdBaXz+fBQqyoKsm1eef0GEc1hdRHWyzY=;
        b=lToajedvnkrwy6/XkXwtdW23S1Q2VcHNrj3hrmliRTRjaWCgHwqEmtyBQZ4qolNSwX
         jmcMboAGZnD6abRJNVJbyldsFs0qDl5TkovXwGWjBxRlC+FxXPphRwhCUTPz7HM5ZTPB
         z25y5Sjwgeq0dvkDYLVooMHAhNDh1fzaNbqz4rL+Sh6bP2FnALTXgIPtLPzJI20+ERxL
         d2nWtW4FTJ+XriIdIbSY+sZL9TisXMDQCyXSi7VjSTevdc0ckgEqX2DK5fP7i0jnxY+Q
         Q6jCRARIW9tPTetoTMnMWxV0IUX4y+fbbYjS1a4ryUfgAl1g+bwl03UA2XEmq1GUo8dz
         18EA==
X-Gm-Message-State: AOJu0YyAeEeLktQ7hoRoUquUH7KkhGmbMRFpak2Nnubi013Uo1tewN9z
	pa7+3AaqwLlUDwlm2B4jl0mdh6i4RKHmN3hrzZAB4YytmfOWrCN1+cqXerBslPbp
X-Gm-Gg: ASbGncsW/n3weSgZvcwfwgDTWxNKMZo4LbnyhloCNC/KIfyddA5kM/HTcGf2wi5Ptzw
	EGtwLAb6jtVGqOfR3O1S0iCpAkgGiRmDEiZV1xkZAq1yMyNWGTWAshOk8C83+52/55pRXxCAOk0
	vu84EZf+DoIG2s4DcCPLk1jPjJA4k+QgqjB3f8kZl+nHkTpyCnHjkZ7/g+DVjl2rp4LWYSAZCRG
	cU38vPkES4mOiVhHg7v9taXa9T0YscDDP+x9BC56jNOVRYE1hEiH9DnwDbgYE7hJeycA+9XB3Yu
	Q4arkPIN0eHsCzviC1K+mAIcOgIWHSyBP+fMV4E13NBmNwaB3CM+1X6c49QUyr4en51//H3MF1P
	Czwo8iBrcoGnlEcwmvnTkwRCPqFiVq0Jv4nxFnStwy3HeT9QHaaLC7y5lO/aLpg5TilXHiLFf5O
	E=
X-Google-Smtp-Source: AGHT+IHCLPE6vQUh1H15t7n+SsJNhNipJqclyDNwfZ9cQZFjI683AaTAXhlfb6oo9GjveT7Q0oL17A==
X-Received: by 2002:a05:6102:dcc:b0:4e2:a235:2483 with SMTP id ada2fe7eead31-4fa3ff38660mr4949860137.19.1753725508590;
        Mon, 28 Jul 2025 10:58:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8de03ac7sm1393940241.21.2025.07.28.10.58.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:58:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: ISO: Fix getname not returning broadcast fields
Date: Mon, 28 Jul 2025 13:58:15 -0400
Message-ID: <20250728175816.850399-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728175816.850399-1-luiz.dentz@gmail.com>
References: <20250728175816.850399-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getname shall return iso_bc fields for both BIS_LINK and PA_LINK since
the likes of bluetoothd do use the getpeername to retrieve the SID both
when enumerating the broadcasters and when synchronizing.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7bd3aa0a6db9..eaffd25570e3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1347,7 +1347,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
-		if (hcon && hcon->type == BIS_LINK) {
+		if (hcon && (hcon->type == BIS_LINK || hcon->type == PA_LINK)) {
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
-- 
2.50.1

