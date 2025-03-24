Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CB25F794
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824166; cv=none; b=A9pBYcEP2A7B5jqVApwlWdIA0w69ACYhmj0aWjwOQBPeDhAhZpPPkPwQCTNRwsZU/ibecI5jqhtAc/JG8rhXWdPn7vXR+MQ7DZGS/FXBm76CDzDY/hrDRzaWyCsUzwM4P1pjTwqrIPpLVpk1m/assOvIyjMDhRlNSozbGRDbUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824166; c=relaxed/simple;
	bh=USJvLpemHmBWdpM+Yu/IlUrbuNGcOT0su0cG3RU6qOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Eh2QmRPeuItkT8GbRQK0/EDNuLCG7vjuG3FVjtCxWS7HYzhNv7lTyJQY5WdKh6L5LnfX/igHNeuekGutZu1p6O850lTYrBou+/17PZhNVuqtAuAov1XQM4YsFf6iRG6qk5EniBytdz+EPYpz2+5gO7slOll0bXQKF+tuzDwIc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCXZXnUC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCXZXnUC"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5242f137a1eso1879389e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824163; x=1743428963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=GCXZXnUC/yAe7zVWK2t7V1FmRAzyLUXaM0ZFdUhXs+s6DZbolovN1b7IWBHJ5ENJgk
         n5nycWld/ogeb1a65W1EkZ0hT+F22afuxT7lQg70gE1nofva1+5rDGbuJfjkgGfS1O/9
         GrdlNIs7AZJ7a4LCTbvwRVnok5ubiZnjbs+qeVST6RU52TKY2x16DUViaeLllqEmjQA6
         LjCAJK50J7bWThpZKCgRZlHwfQq2EfIOiSeeI35hzpKAeIesIRl9UM1OWkNAFBcbzRsg
         Gjg/qpVo/T2l8Rrm1RY083+FtZxFcN+YaJ/nJkUqeeN1bYxHS8j58htlT2mZCg2mRXpV
         JF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824163; x=1743428963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=CznDVSlZAI0WsWJ6l/jKyyzddR5izzWVgMriX2uDVHKkBYSyUsddS43fIBK1baj978
         pM8256iXymEwrnT5md6Jo/UDbYWtl2AWStvSiC2mFvJw649O6kyLZxyD07wPvc193vcg
         wGr8NORhC5Qhqr8F9hh94sXtkTFG5IHPlC0VRp7zo6oKAIqrQO7TBWmjAdRzfYeOLpNs
         wH9q5SIgF1qvihb30Hj79w4o5UTyzVifpvrF/Cw31oIf18cEMp6xTjoigx+In1wQCq/d
         T+JZqqSDNm5qulwyTKGwY1sElS6lFILtWlhCY1pB5XA8YH9jbIxJvN4RhseId9aSr5uZ
         pBKQ==
X-Gm-Message-State: AOJu0Yyx3spAVxCfdrLoy7x5wPYJU4Me7S494lBwOU95ZR1EYKj9+cwv
	fNqfggeRFGdh2Q+olFFJhoTUx4NKQJ0glYmTXczX4nRxOiQbVt34bhkimGQk
X-Gm-Gg: ASbGnctDfVTyGrrP5IUvVuxEsY1zAm2Yeh4yrMruYgIKJXWlUzQK1rNbu4Mr9lSY+VK
	fYqBVOJNoLaqtqVVj6KdN2Hu16eW7Xx3s5SWqOjI97soQBeOQP5BbvTh2EXUWrvi+imC7/Zrkyi
	K+mGD94RUQeau4P1hwPOLVrZKl+KFf55FWoX9Ae4mZpVm7HmScwMh3ug0YMTAB40x0VKWtHzKYI
	K9D0Asqo1QN+i8343oh8MW+3cBryi/sC8zls8Y6I57mlvyLzAxXQB5bz/3Qq5G9raRUo7S/CdSx
	3mRkkvioE0BzTNcnqOKaz7VHNot6QdwIROcbjvyHwmaAyU12XCUBJIYIimeWIN5qWYIb2SmH394
	Gvzp0U/Hp7XtpPA==
X-Google-Smtp-Source: AGHT+IEWnQsZJ1ShKjKlV3dlVhDE5o5AJRMdL4ET6IoFoRtkSNLtqFYHHqps2a5X5JI5G95T6Jvk8w==
X-Received: by 2002:a05:6122:16a8:b0:520:5a87:6708 with SMTP id 71dfb90a1353d-525a80d076cmr6613175e0c.0.1742824162604;
        Mon, 24 Mar 2025 06:49:22 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73ed878sm1398381e0c.26.2025.03.24.06.49.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:49:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] mgmt-api: Add missing Device Flag
Date: Mon, 24 Mar 2025 09:49:16 -0400
Message-ID: <20250324134920.2111414-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing Device Flag - Address Resolution = bit(2)
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b4a5776574f7..3181607d94fa 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3429,6 +3429,7 @@ Get Device Flags Command
 
 		0	Remote Wakeup enabled
 		1	Device Privacy Mode enabled
+		2	Address Resolution enabled
 
 	This command generates a Command Complete event on success
 	or a Command Status event on failure.
-- 
2.48.1

