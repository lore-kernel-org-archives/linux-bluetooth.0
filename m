Received: from mail-vs2-f24.google.com (mail-vs2-f24.google.com [74.125.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FA37B01F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488015; cv=none; b=YyKZjI6+2cMLwvjWj9f/Zb+env9SAd3AwOT9XmFOL+7fHnnimTZCotonwVGalFA++Pis2LyhyQo35ZLrXvTKscRbtXgWbEsDQELVkHO7QCjRPUo1KRqHF5SOqaTyZV9CRBOLqSJqClQoVVEbFh+vacektq4jX0RBJitJAAOllTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488015; c=relaxed/simple;
	bh=c5rcdDdlE0FtYLAQf6VE6WbsbI2ilBQWR013Nj2HKGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhROajDKe372tVf/UNFjysqAW8PAgQVrNls8ubkhbF1zdjCZNbu1cWLdU1bWPZwRuP+CkQTuAkYpr0IO1xdvTeNrfLnnHIvfz/zAzcA3+wR+8bb7HFAMM2NXcxsOTjwDofspW3R1Lq96DzGcA68O42kAUXHSHv5qPsO6to/Rh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBeaedNa; arc=none smtp.client-ip=74.125.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBeaedNa"
Received: by mail-vs2-f24.google.com with SMTP id 71dfb90a1353d-5c97b28165bso415104e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488009; x=1790092809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jBwXWyCEkSTnm4vqQrbw6NCM+Mqq0U3bxGvHWqgfP9c=;
        b=BBeaedNaTksirHZrxy24M/hSXLmU9eCYHTAGP7qx6jeZMdbGHh9LTP4HCCMGbdlb0R
         AnGuJChstU+nUoHxNaLlg4y32rDHGMquRNT4hqb+wIUDDXvpO24UQwQjTY+jknIj90G8
         HPD+MkG2aoO0ukvV+GiCz71MukfDhxzINdXtZXkvwSDOBL4OrRu4eijvZtOZcoILMblM
         RzYo51DOSZLiIdtSkipIO+/Hu9YzLtwBVT1MUikgKUFMY8A53dFDzBcuajPK6w2/ufk6
         nEeLP9+Fdpm9EFC5H+2+SiwJBVHOUgRrs+s3NKmHKtrU0xttCy41zTNWaqvm3mYRt4nF
         Bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488009; x=1790092809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jBwXWyCEkSTnm4vqQrbw6NCM+Mqq0U3bxGvHWqgfP9c=;
        b=gK/DBgwVUANr4w5nffvOsAK9f2v0IrfeE6k0l3j0Pie1W+IABvn+XXCUZ52GNtLblb
         6eetaeJYNSdYnF5g+fCdfxykXNMDqGq98Jqefosl4DN8hiCojbzUeKhULvkXryW3XNdy
         e4iBttlGGbF7HH+MZiE0ljLD/FwbgzNBwfpxCRFmcFHYgFeLTWiQy6jUgBdNcjpQ0aIl
         80e4ouZboa/txQqN7wMcQI9ci226uVgIlr4Vco9aS4iDrw7YZ7AwpF+/n5q2DzVwM4hV
         3+VHlGhytykf2MT+KFz83jG7OhU4TvgwYgwo806TLp27g74pbT22/7saG6R+T6eXJ1cH
         NyOg==
X-Gm-Message-State: AFuF++mEYXi+CClH8OGTpsYHR9/ppQc3eUCS3ThPiLF/MKpZdSThxTNc
	cO2jbTQEZDTynomUttyIfLSk0WmIWxvqy+vfFa8JWQpkEWvo29U8/2DU
X-Gm-Gg: AYBFou3GTbqd+BOOP4xxEAdacvgw6G/EQ9FcGLk3o+sTzvFlRpoMPAwpKmUmH1AMRhX
	VS3V66CCj56f8cn8JVoN5aClSsCyNFPQPvOuXQMH7nontO2Kkeg76mGJE0v6kFdekZC5dGlM47T
	4c4NqjGV8I4V1UrcL8i3c5SJwSnAdCwokPkn0etc001KCpUcV7PlS3Mg8vFWdpjjUDFVgMtB0Kq
	5pSnrH98F6DVozGj/3WQPZnW/W7fZJtaOoSnERzQQsmtDS7SrLoIU5p7OR3Z7+9efY13wnvpVyE
	xvd/6GDYr3aEwtG5Hc5kCYOka0EnxliD5zUwZS+HxSzkCJ6+dGwsgIBNfzIBFq5i5QpU6RvDxHv
	btuUK/fggrv2xkLkScyavaGntPAfHIYvvjHjo1ihSQghdMgKOZEKPXYbjmXs7lqiMaK3SUvBJ7/
	6zQVjEfINKFZUxt3WlcbSybx5dYw2A5/mssh3/lK0UvEIeSg/smhGLsh43hcwj1KEdhg==
X-Received: by 2002:a05:6122:f8b:b0:5c8:2852:36cc with SMTP id 71dfb90a1353d-5c993c0c8c3mr3364356e0c.4.1789488009295;
        Tue, 15 Sep 2026 09:00:09 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c99149d764sm1485543e0c.3.2026.09.15.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:00:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] Bluetooth: mgmt: fix race in read_unconf_index_list()
Date: Tue, 15 Sep 2026 12:59:52 -0300
Message-ID: <20260915155952.3104711-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_unconf_index_list() counts unconfigured controllers before allocating
its response, then checks the device flags again while filling it.

hci_dev_list_lock stabilizes list membership, but it does not serialize the
per-device flags. During asynchronous controller setup, the worker can set
HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
omitted from the allocation count can then become eligible for the fill
pass, causing an out-of-bounds write to rp->index[].

Allocate space for every device on hci_dev_list. Since list membership
cannot change while hci_dev_list_lock is held, the response remains large
enough regardless of flag transitions. The reported count and response
length still include only eligible unconfigured controllers.

Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/mgmt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e34..1f6691278 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -496,13 +496,9 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	read_lock(&hci_dev_list_lock);
 
-	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	count = list_count_nodes(&hci_dev_list);
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
-- 
2.43.0

