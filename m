Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FC1C6A8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350120; cv=none; b=a2repXyYtMf2wPbTcwshBwbGv7uy8JxsOLgNYhwJGPmoy5pM1gm+h7YkCQ23RBAftg3YZXqTtIKd0/6s7uw0++Hhqeo4dqV6xofiX0nY3UETkOTMF7BEBpz9SzdBStbWqyJjb9DpdUjBITOkmecGBXFyyFtsvViFewJNE/dElLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350120; c=relaxed/simple;
	bh=z8ZBwjeIXrRw07mNy+A8R9cQ54jR79d7glQoja4OIcE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB33zFnoLVd7617Cibw16NTFso5uCjz0Hc55iEAn4/40oyXv89VzeHWw8eQnqW0HK3SiFHTFR/IwD58M8cOiw/3XR5a3DporACzJ5Zj+UJmz3pr3qVKiuAyw4AxsBJ4qNE7ZkOXCgbZgu1B6EsXDfSYIg4yXfmycAtYy4/T4WbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdS740+0; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdS740+0"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4daa8466d6fso699567e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712350117; x=1712954917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEl/NKTGQ+goyt2u6Uu6Fkz+Gbi0fKWM7UDj1mD+wHk=;
        b=kdS740+0/v5AHP7Nvni3EZIzwNUY8y/OdP3Ebsy8d0/x+eakUZH/qT3YQkbQF3XS5f
         2rowAE1ZZPlq8VsemHlkWvtutQrdQ6arA3+IFJLHk0poz4BAQczvIuCie/lJ8fHA57il
         llh2bVu7x6ViWAh1AY4V1InEU0WhE/aO7YnPh94/oHAOVU7DTRGRv7VHclz3K/iPgl1M
         KZPWWzPEbT2FpeYIMhVo4TsGMIHgpeCRTbuijBNjhEK7t5OH8ygGUnnghgWlcXGNuj+a
         wugG5lFxSfzk+hrKv6l/04uTAyoGTJ4cX+aIEJNIrNa42rBRpMd48ahDMW26p3gipJcg
         FTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350117; x=1712954917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEl/NKTGQ+goyt2u6Uu6Fkz+Gbi0fKWM7UDj1mD+wHk=;
        b=vk3G7Itj1vPkoRBfhIFUbFC48jkt6e6npElTmwTVrCeuN4NeiOgAe9rhmtwkyC72F+
         /K9OktDzEjbUghg4CwwvIpK4wfQuXwlZ4R2qenM4uSW6Tf/pu8FQ9tNVM9Q3e/NEBQil
         l0CiZMRtPEv23SkNemsnji/34MrZSXBZ8kIbLpy9hiUB/tBAS5PUyDxJxPuKni8oZ3W6
         Jqw54PWsczNKATBA0E1PfgxJBHD+iX6ORyhTZ836p0BZQ7BrMKGsYcGy/LeB3g8lKfUF
         edk1J7WUSqL5PSLmWH2mUV8hwKGHFtsSasNsnzgTVJZsqpZ2N1rIbnI7WLzpMEMrAU3j
         lwXw==
X-Gm-Message-State: AOJu0YycczFkn1x6q0QtQNH9gcLwrHVda07jdaK9eH7wKfNQJo6VMGAi
	35vxBgtmf2MSSdIHT0EvaHdsuiXvk+w/od7wqykEGr/ytk0QahTtzv2cfzTM
X-Google-Smtp-Source: AGHT+IFOUfWG2m2MANXP38UkAhcyGhL6eOg801rhPngbdbE0eLqkkW44auMCZ4JnLrzC2JOozxNKRQ==
X-Received: by 2002:a05:6122:a0b:b0:4d3:36b9:2c26 with SMTP id 11-20020a0561220a0b00b004d336b92c26mr2936268vkn.14.1712350117304;
        Fri, 05 Apr 2024 13:48:37 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y72-20020a1f7d4b000000b004d8a496db23sm336004vkc.1.2024.04.05.13.48.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:48:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: hci_sock: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:48:27 -0400
Message-ID: <20240405204827.3458726-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204827.3458726-1-luiz.dentz@gmail.com>
References: <20240405204827.3458726-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check user input length before copying data.

Fixes: 09572fca7223 ("Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4ee1b976678b..703b84bd48d5 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1946,10 +1946,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			hci_pi(sk)->cmsg_mask |= HCI_CMSG_DIR;
@@ -1958,10 +1957,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 		break;
 
 	case HCI_TIME_STAMP:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			hci_pi(sk)->cmsg_mask |= HCI_CMSG_TSTAMP;
@@ -1979,11 +1977,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 			uf.event_mask[1] = *((u32 *) f->event_mask + 1);
 		}
 
-		len = min_t(unsigned int, len, sizeof(uf));
-		if (copy_from_sockptr(&uf, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&uf, sizeof(uf), optval, len);
+		if (err)
 			break;
-		}
 
 		if (!capable(CAP_NET_RAW)) {
 			uf.type_mask &= hci_sec_filter.type_mask;
@@ -2042,10 +2038,9 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			goto done;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		hci_pi(sk)->mtu = opt;
 		break;
-- 
2.44.0

