Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3382499
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027191; cv=none; b=QdWhddX4WfkBBogUNgdGKpuI6tYVRx/liEHXK6/t3FDQIRC8YOracRW2DwdgaoowTVHAUa2PQzGpaRbntbv8MD23eQBNDs1zhmks5ov3a8iXUL73JqDnZfp/ShpeEKneQ6CeyRUjgCo2GJ03xAT4GV/Iok8y6uGciaVEt05Cx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027191; c=relaxed/simple;
	bh=uxyKbTUa8LuiMLbAMmNJmGp8CWOKN0z/pAqw34MmAAg=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=MbRzccHkrpDwEsw9R40LVsFGL3PqSDJQDvVm1Upn6BKMwwLkAvZxMSFWV5/RCqeiudfXEKNyKtRP9US2mOj7oqlX5uwNRtc8j7NEEUP7sPNIXZ+WpWas7bjWdA8yyrv0YEWX9wcKhdfIO72DaFD0tQW2c1CcWf5GSdEsWGN8YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sas7I8VY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sas7I8VY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb610be6aso20265195ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728027189; x=1728631989; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiTJzJuEFD5MF7MOoDd7YGhkbk5aCsMZaD6gSjj3nY0=;
        b=Sas7I8VYJOckOMji/XoCxgOu91lJEJhVBXasYrqLYDM7seyZNE+sfD+xLLm6MOyG/e
         maQfhlG2xd+cjIqufjZaonEoR1tzrSaEQ5hkfbrmDyMzloAuf3q/bK3YDdWHeJUmPhha
         GP0CCFb7HrrSpnaOWK/Z6iSlTIvfKoJTJEMWBEV/I+1YBef1sMqepUpSrkt7CTGhkvq7
         cbsMm9bOQ56Fd4rhgGhECGvrkhc5l79VptVxVKiNrZxFjf9hZoOhC1IqwK3U0ddch/MH
         9sFcUahX4ed576AaD7CWmZqGKq9lu5zug2moFtFM16oJ3LSJUPpMjVQVicGc6pyi7gcD
         fXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027189; x=1728631989;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiTJzJuEFD5MF7MOoDd7YGhkbk5aCsMZaD6gSjj3nY0=;
        b=h6PbScyJEySwxFNHp2EqAkKRoEV1Mt1Ir8WqLlu2JkMc8dlnEfQnTFRuGxO3BzDHrw
         0vHKdxIjG326srZzGJP5X5r8TRJrlfUzznsW6RVS/go5QltNVMRK9ZLVjVV3A3GVnEcG
         wLJNmKcbSdHNcQJxIyEVYOj0zY+bYnGbZ35hMD+pixe8ChYGXJBn5jrvWSj7/9VLqulY
         o8rOWxXsxiIN+rE8RtIwD4E4bq06CzqoZwId7hzlQrVcv2j3YfJlX+sFdft9bUzw8VBA
         cIictueaAOh5snhZWzqj49am9+GH5YGroDaERV2LcXbvhsSMdRQnABoaIBZHu9BHOHEd
         EcFQ==
X-Gm-Message-State: AOJu0Yxk6tx3/d4YtE+Fjpr7OPuMrDVduUoZG28XNcWFgj+yAH9B3e3E
	tLhb20qzT59nJptSprvGS/0nv7xEB5vJyDY99DL7PbWDzCV7L5HG5vQTAw==
X-Google-Smtp-Source: AGHT+IHtig7dJ+HZMqkzWkp7Ivq8GD2ti0fyPiU4ReqJaBfZYN6LdOjjUxLLJOElgojKhvCWO78R8A==
X-Received: by 2002:a17:903:2a85:b0:20b:5fb1:ea52 with SMTP id d9443c01a7336-20bfdfc203amr30160605ad.21.1728027188959;
        Fri, 04 Oct 2024 00:33:08 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef8017b8sm18875625ad.294.2024.10.04.00.33.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:33:08 -0700 (PDT)
Message-ID: <66ff9a34.170a0220.32b24b.8523@mx.google.com>
X-Google-Original-Message-ID: <Zv+aMgEypkFa3ELE@JUNHO-NEOSTACK.>
Date: Fri, 4 Oct 2024 16:33:06 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] mesh: Fix inserting NULL into bool type arguments
 to false
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Inserting NULL into a variable of type bool is undefined behavior and
inconsistent.
---
 mesh/net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 41e415b65..f185f0280 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2649,7 +2649,7 @@ static enum _relay_advice packet_received(void *user_data,
 						msg, app_msg_len);
 				}
 			} else {
-				seg_rxed(net, NULL, iv_index, net_ttl,
+				seg_rxed(net, false, iv_index, net_ttl,
 						net_seq, net_idx, net_src,
 						net_dst, key_aid, net_szmic,
 						net_seqZero, net_segO, net_segN,
@@ -2657,10 +2657,10 @@ static enum _relay_advice packet_received(void *user_data,
 			}
 
 		} else {
-			msg_rxed(net, NULL, iv_index, net_ttl, net_seq, net_idx,
-					net_src, net_dst, key_aid, false,
-					false, net_seq & SEQ_ZERO_MASK, msg,
-					app_msg_len);
+			msg_rxed(net, false, iv_index, net_ttl, net_seq,
+					net_idx, net_src, net_dst, key_aid,
+					false, false, net_seq & SEQ_ZERO_MASK,
+					msg, app_msg_len);
 		}
 
 		/* If this is one of our Unicast addresses, disallow relay */
-- 
2.34.1

