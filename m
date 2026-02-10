Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F73346A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757152; cv=none; b=j9C3DatTerVCZ9rYbZDsFAmZ+978mEVmt/BuEEaPM9VBFYhfPxIh24VVU+yEEC0/Y7xPtOuUAgn23QsaafZkR0ZACTbEo/PBldBQtSo5f3p22t6a3VqlEDopQcKfXj9I619zc2KeO8wganhFs/cE4L3XOsmW+oYoP8Z3x8yrdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757152; c=relaxed/simple;
	bh=REleuWolR1YB0AaaxP+XTc0jcWESgRxuPnIZeocP2rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFv/c/cnHodX+5U3LaPxFxY3GI8R/joXj7oerH8Dfd3U1RNiAcvQzqfvb/JEdqfHffq0DDel+VKf1FPXOw5KNp9qab/yoQfwhjVF0MdwRjcw5KwpTKq6IlytgVFN8f6oo4fNHmn8wi2YeoVP60Tx2DEp+Pm5XRW8QhZq1AFIk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW3zW1aw; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW3zW1aw"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-56711650601so3507398e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757150; x=1771361950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyTktLpC6z8k4sOihPg6Xlo/TX/bqyqQ9h7VfQyFnXo=;
        b=XW3zW1awmW9lUyU7Ovv5Wkc1zKPfgeuaJLJVDw6i7FGrPtakOL+ImgyFBEIcxYhCfH
         WUzW6W4wHMeTIOD/cv0nHmZB4e18o1qlCy+22L973nEK5MyLQ5py5vaaes8AjDzaaDas
         nedkviiHBIPyIb/JasDAGfu93BqqYWVwp4SKmTvuPrkaOcLGvYPCNCqwDzx3i050B9La
         +GXY5+9l2g29H52yRlCp59Dks0LERjGBu7f71mgtl7oMeT+2Px6zckKzpTu7vV5a4x1o
         TdOLtMhxESgWcSEC0jszN332VuvHV4+qpEO7lo8qG9X+pL7bP8JKrmxC7cIYg7LCaIvw
         tPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757150; x=1771361950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SyTktLpC6z8k4sOihPg6Xlo/TX/bqyqQ9h7VfQyFnXo=;
        b=JKw8OzjbdOTY7lv6rVoBzxKMRbeg8Yeng+DmfWOe9nLzZ6kGYDuZ/Pyo6SSq7GjVo4
         bRFavTthAVVoHOaJJLnuQqOZcK20Am0x167PncEFvEJkyznc4L2m3fbXlrV9OEn3MizF
         PeAHY7oBBhr1pU0FZuIsV8WFevgNdwqhfXuEY1i0lrWs3ZDcG2G+3rctgBGYJ+DwLWX6
         avXFsRGxpGimNkBepYsdjug1ekYZtb9IsVqNO/Cq2Yl7socpkeMUpAmdLl+XMBqksjlf
         17s01Ld88z8DQXtc7XvRkVmnluk0NeOcnytF9lyjFfl3YIRLXoPAE8ns4h//fx0pGr8m
         N2gA==
X-Gm-Message-State: AOJu0Yz0BzVkCCLaaPjP0StQxixb0X6tsKWBAFnVPwFw1HMfJPqQPR7w
	EqSptGBLkWfEivoBGk3FTzFSkpKUoQnuus4hbw3pjm3OlTqi3VZeg8e/NzxIVNvZ
X-Gm-Gg: AZuq6aLP5VC2w59SQJuKDtXDQ7QWYs4hmaVDksoLfC1NCN7lLhR0PzlsPPen01rOt1C
	bYqq97CCdWoBSBu0qdLEGv7v0SxPd2FPIySHhPovTtsalQzLjAVGUc1HYQZihDHnBEYycQJbM/U
	150ggrcclS1P+PxCGyf/9NpY7z06ifYKIxLSjLlEN8NJ41Ov9pZYYqCQ1PKvwPVVfuhjnwELxzP
	k6mP7rvYuzOUMXT82T7XMurTtufSgWLc09Y9Lq9Kb3HaNzm9KY8H0Mwz9i/iNP8SP4/5bwlWJwn
	kusIWUqbQjjsBgw4L7XDn0eINy3boQkQMT9ZXpCyyLRrCPWEprfXP11MOBePJednXS7/uSU0mgm
	a3V67TmLyS0O1F3Lv06mHkL//OlU6CnBpX+Gin0e1PafFTcgsCkmyXdBJZcfPyHakp0IhEvcIUZ
	Bqm7YhRXlVHEZIBUADTILoJcifigXKDoO5SlRkbCIA6xaU5O0x4HMG1bVsnsxoplvfBELM9AfXy
	XtQqyubI3N3yiQ+5g==
X-Received: by 2002:a05:6122:2a03:b0:566:226b:e30 with SMTP id 71dfb90a1353d-56749d7b0a0mr175985e0c.7.1770757150312;
        Tue, 10 Feb 2026 12:59:10 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-567072e9586sm5080768e0c.1.2026.02.10.12.59.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:59:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] bluetoothctl-mgmt: Add documentation to exp-iso command
Date: Tue, 10 Feb 2026 15:58:59 -0500
Message-ID: <20260210205859.1240075-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210205859.1240075-1-luiz.dentz@gmail.com>
References: <20260210205859.1240075-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/bluetoothctl-mgmt.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/bluetoothctl-mgmt.rst b/doc/bluetoothctl-mgmt.rst
index 0ff16e4d268e..646c2dcb4365 100644
--- a/doc/bluetoothctl-mgmt.rst
+++ b/doc/bluetoothctl-mgmt.rst
@@ -1189,6 +1189,18 @@ Toggle codec support
 :Example Disable experimental codec offload support:
 	| **> exp-offload off**
 
+exp-iso
+-------
+
+Toggle ISO Socket support
+
+:Usage: **> exp-iso <on/off>**
+:<on/off>: Experimental ISO Socket support - "on" to enable ISO Socket support, "off" to disable
+:Example Enable experimental ISO Socket support:
+	| **> exp-offload on**
+:Example Disable experimental ISO Socket support:
+	| **> exp-offload off**
+
 read-sysconfig
 --------------
 
-- 
2.52.0

