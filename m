Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9F340DA3
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666808; cv=none; b=Rx1l6qFA7T4X0jZbSh5QLtBVfLWXMaf4MZLGwl72bNLWqV9K/QpZt9SH+GIB9R1foEibCtLn+nR294z/q/yLKJVPbtOj/1MDRgtoUo1XsKEZZIKpRIiwA84hAkwTLSPkbimF2lxiArMrUDEtWuS5TWaYwLaomT9r57ZWOe0rE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666808; c=relaxed/simple;
	bh=AobRNxgST8zQe+P/0s/nrftHbBH4Gr6BiCzGVmdCIbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duBJk299niLfzjXhUYFTSKhN/ChYwPk0AKwuBZ3uy8ZoTp0EdLn2QHgaoyYUMcaJXGiW9RJ1FBmsaOaDv9YYpEqUTbDXrSWOm2cU9I8McGR8/D2xxglrmgZEngIKhl5QUhxwVmtxzbtz1Z0MkrcTRQMI88wjfLE38dHHOtj/Ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UxxlHrae; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxxlHrae"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42708097bbdso468936f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761666804; x=1762271604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXDC7M6kaxSAFbWMJYcixkWhlLJArFQmLx6hgFHXx14=;
        b=UxxlHraeHchuNuVy083vve6bfyMYIr9qwmjxJTL+3hspt7P4GdTajQSJ/JgMFT+ZrC
         uTCp3oabe9prNEurPYfixSOYHIMZQDXJpeCvGkxYBmBaGBtKRwl7uTgCAAniMX3XL5bP
         Lus/FdaAND+k71d/g61nMZWIVPkfRo5/+Vb18EeYe+80npNQ0S85E+MC0wFRHEz3BD8r
         t03oQZ2g6taYX/upmiSJtlYqRU0u0Oy+/BegpXFJl6MjNVQLoWJk2MHUjk/AMaSYm2fW
         w+hnMlNOukQy6vni9H5uy1tsC8RMcN15pOZ2Fhe2gRBkqMnIvzBqKvVxQOqsLA5gjWIJ
         yPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666804; x=1762271604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXDC7M6kaxSAFbWMJYcixkWhlLJArFQmLx6hgFHXx14=;
        b=Wo/zLG3UcmILG6Ws9bFRPhC6/87OmX6zGKeVQ63RXsKdQetS/chboh8Ox8u75v1/FR
         zrl1GbCCYnBW5/S1rKvAxIDm+4ULWRoUcgIH/NFaCgUTceaLSlHQw5s5RUfkHNuqygXq
         H1tFOYb7sGmbLnsLQUierKDxsvzbtkF9xlEs7BZuLyxNK1iRXbNvwv8EKlAxvsP278T8
         /mkpMmjfnvTb8GA4ANKj2R/JgP1cdC/JeaMGSiZ3uvZx1uHmvXOi1LMtOdIgMSo393kN
         uUZzYQLpvtZZ/MYOk1sPPCDKZroOYOcO/ROV4csrZdqfsacXvrbYO8UVupz9jvVKJ3dG
         HIDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqKV1pBUG8gE9Ynx3FyzTqM16s4X/eNI543j67as//VH1ZAfkanRd1FJeAAwTZHZvd3p4PNzFigSNc04XN94E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1eZTspM2s/hWrf7z1MrAtrdQwuIRBeqIrbdpOeOeWEvJ9sbnx
	MUsxxKHWxj9j0nmT1aeybJusq4UKb+xacIT6WNwL8ZR5b9uqXvFc6j77Z3F4titnP3k=
X-Gm-Gg: ASbGncumIeYwh7wJ4dWrczMDEsjLKejddO4oEMUXThzkj5ablGTdwigSnOrXeAbkHap
	d5pT2DHSDS0/kYjdBoRT6bgNLJfH+DrQh34hYuWYhT4sRCCsC3K+EiFDXvrOSH7mbU6DyqdSfk9
	5XfXausG1gNGO/ODHvDQrBVAYfB0eLk2JJiEaP/xjk2f1soaeGfJsl/zU3GNtaP/2lnd+MNVYCE
	cXNhRICgQqi7O8ooO7GC76URcFerhwqLsuJKP0UuUu1CB5u129dMGpmcxUk5Ezi/ZZjG+RdcY3v
	AgYHkP1HzNJZz+dES535rzZVp+AuVkVhNrRiq7VDxVKR6xQT94CXvJpfsXSlakc5Ip1ihnLQYYp
	bDnnRBaG2sJx7I9GEs294pcBNn+LXFsUbnXqTm+big1o9HzCCHbiwr65TxjCyHGNogG2J96qsae
	jh0iYorBaMLww=
X-Google-Smtp-Source: AGHT+IH41j4JtLznpnUlgn2fs08an0M9cSbhtKiZFIJBMeH8gjS49gF30paXeW6FuOaAsnvR2KptlQ==
X-Received: by 2002:a05:6000:4287:b0:3ea:4a1d:b542 with SMTP id ffacd0b85a97d-429a7e79ec0mr1797115f8f.3.1761666804285;
        Tue, 28 Oct 2025 08:53:24 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm20717047f8f.4.2025.10.28.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:53:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as Qualcomm hci_qca maintainer
Date: Tue, 28 Oct 2025 16:53:21 +0100
Message-ID: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no dedicated maintainers of Qualcomm hci_qca Bluetooth
drivers, but there should be, because these are actively used on many
old and new platforms.  Bartosz Golaszewski agreed to take care of this
code.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
Don't orphan, add Bartosz.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8abdc0e50699..8a2c5fb0ba55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21145,6 +21145,7 @@ F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
 QUALCOMM BLUETOOTH DRIVER
+M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/bluetooth/btqca.[ch]
-- 
2.48.1

