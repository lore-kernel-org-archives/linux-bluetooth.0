Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351384;
	b=w2TaNRoc6F5YSFqhD3o3HTZ6UzoSzC91l3Q22Z6s/ncLjNKno3WqTCbP1rkOEy7c2+rp
	 xg4BCLdkO1WDxMfzblM52lUyPm6ahkuGwkrGjeuRHhM3EIaqwst0icKbrxF1/V5T0ZUJT
	 /7QKN8klcHVEu075DvWx04NCQPQSv+v4w9cEx5CyCILvxP7NtYrjK37Lynsgz2OnhYY4M
	 x0L9Xjq0RiUXlg0zQCpt81eHqbZB3YPjEqZYRkBgtDFrUkdGlSIompVCqfXGHLrUsyKCt
	 QnTtktKbG+H8l1VZgvBkPoDzT9WJw3Bj1SnrUCbbv24L37zRGiOJw+A3HUif92C1kIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zKPdYKjpMf41eer90nOBtZmSRZYqh2124uKG9FtHyVY=;
	b=vLQrg6shKqFtZP2QAc66hv8GXcMgqgSsMazMIJuxid7NvXiEqUzdgYJyC3BglRekMpEK
	 /+pivgTSMD5WZj/AnzSl0/omq2+F86YPljRQO9ILFshP5qzG7rnx2RkAGjvIauIRoRE2y
	 y90QSwf0kaQ1W2Fer/KBjHSeMyGHSvqRsW9BTSD+EHX04vvxIj7Rr2xYpEuIqgzqTTCS8
	 3mZTVnQoLmcLFtK5Y3E71xwIBzuFbYOG24XjN1ldycpXBBypWGKbrzahaL5OnrTp9EDAt
	 vzuvor95LMvl4k+LnHI5caeBEP3Sf9QU/4sJtrjybItgMInQ8VZ+WS9upZImTD7mmoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=teenage.engineering;
	spf=pass smtp.mailfrom=teenage.engineering;
	dkim=pass header.d=teenage.engineering header.i=@teenage.engineering header.a=rsa-sha256 header.s=google header.b=L8iUS2f7;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7A606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA7A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=teenage.engineering
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teenage.engineering
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=teenage.engineering header.i=@teenage.engineering header.a=rsa-sha256 header.s=google header.b=L8iUS2f7
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c423b145922so51664466b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teenage.engineering; s=google; t=1793351382; x=1793956182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKPdYKjpMf41eer90nOBtZmSRZYqh2124uKG9FtHyVY=;
        b=L8iUS2f7Bz+EFHT8RXts6vCsDCwhdxxl83mTxrfsyxGGquYS97NMz+0iH8pn4tOLBI
         r6+DUf46ftKPkJhFDh8b2Otmwkf8vEYXOmlVfMNHk5fqDgmmSEYtS2Nlx9kJBWavRwv0
         H+rEjhkfxuNO1jHsJbqXd8ATfHQ8g8U/wt6gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351382; x=1793956182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKPdYKjpMf41eer90nOBtZmSRZYqh2124uKG9FtHyVY=;
        b=YrgAyVhhP532vTTBSYxfdTceGl6JRUXqFiAfYsx8AlHvOihsdh+3Qua8boryx4sgi3
         jhUkmSrv7sJZnKueoNMpchiibEzHNN2JeoVgRBud8WTo0itoR+WnDDnMW/6XyRhLzRgl
         jzZjMIMlw38IJuukQdmQeC0gOm/Fb4sTC3f+AUFXTx3xJBCVEYZsjUCOFiI86AzjNtf1
         2sIjk8ReG6jj4cSEDg2uRJV78qOkTQRgdrypMrGPLOB3wzT27cQvurcL6iKRYVJuYr4z
         w7BDkq9jMwxfoMb0p33NYh2IAdAKBgLOLiLAlX9uS+csgDVwcCmnjCxoNHkRYKCL3mV2
         yHiQ==
X-Gm-Message-State: AFq9FYK+kqyLFpmbXex1rjm1eH9u6P+C/iRCCO1TsVZaRHbcmh+MG6dn
	qdRgzYcNidfxaqP5ItVvHE7jQ7P66Tf7Wlzm5boWnwi4vXHjrmVzgnSKR8EEGCgHQDgeFGxqe7D
	sG9LT9Q==
X-Gm-Gg: AYBFou39kk1Vz9b5elt2Eu+EpT56Wi4es3/6f3dNMp4565lI7YVG3MxMHyjNc7GPlJ0
	RqTtMeqqGUGq80pHTbToohYEt7a1U1HQIBnNRovdns5HLOrPbCaKlANx+I5kaB2CcH8Zxn84PQm
	cyuPZA38MEoZIXLTtbNSOM+ovOTKioVezdq44lDn9cDjDkd7rXlpkva3A+u33OijZdcPmEdizsR
	hmBkgszOkCuAO0SH2wyqX3i2GnE5MgXfElr5jV2f+fT4CZ0O8GAkGSpftKIWZMPLp8u01MP19jt
	wcUaasfYUQDzojSQLXz36mOdNO2SoKygTIyg1EWVOiwgTqSEr8f2GlzC8N7C+nsD6T+araT7JeF
	LotzauDDq+olxQvVcvs9v0wEdeagU9gr7lLdUW2KueDc1Cplgwqa4OjwB5ibg27VvTqCkKx3L+O
	YkWhZkuK977K1jQhdUSKzYlU0J7YYoN2mEy/WL/PJ7SxV7Tv4fUF1VEcNHQlkf6Y4kgSDYq70NA
	zvMAxR1VEN+TzxnnByZ8+zcIYY9BWZiikHUS0kaIO/+B3fOcEKk2Fz2xbg6E6PKPX6VXEQa9UJs
	rhjdqusaKguWX5HPvlaW8IFL5Gi6k/9ispmQ0tRAbmlhlh+3sAekelZWxGVK4do7fvmmpF6H99k
	q2bVFXir6KkGD5z0XRBBd7owJ4Ff4emP/IfCWC6f/5KXBXMvw91jIfwoRiejM
X-Received: by 2002:a17:906:99ca:b0:c31:c767:adfb with SMTP id a640c23a62f3a-c4ca7432ef7mr144394866b.0.1793351382433;
        Fri, 30 Oct 2026 02:09:42 -0700 (PDT)
Received: from jacob.localdomain (c90-143-204-146.bredband.tele2.se. [90.143.204.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cab9dc577sm43480466b.0.2026.10.30.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:09:41 -0700 (PDT)
From: Jacob Siverskog <jacob@teenage.engineering>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH BlueZ] client/telephony: Fix missing string.h include
Date: Fri, 30 Oct 2026 10:09:34 +0100
Message-ID: <20261030090934.89910-1-jacob@teenage.engineering>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcmp() is used without including string.h, which only builds because
some glib versions pull it in indirectly. With older glib:

  client/telephony.c:641:2: warning: implicit declaration of function
  'strcmp' [-Wimplicit-function-declaration]

Assisted-by: Claude:claude-opus-5-5
---
 client/telephony.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/telephony.c b/client/telephony.c
index 858c02c0b..1d6885fa6 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -14,6 +14,7 @@
 
 #define _GNU_SOURCE
 #include <stdlib.h>
+#include <string.h>
 
 #include <glib.h>
 
-- 
2.53.0

