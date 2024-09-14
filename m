Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738A1CEADC
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324141; cv=none; b=b9cRyijg/WiJ14driD1RnaehwUUiK3Z3awuWfu5u5kPoTGsBFrekxZ/HwTjcViqpORoRjazKmIjernF0Y9iY5EGg+pRytd/rnaTy7mZBOtQfKeJ9yXXQoEsstE6+VWA3zNKVl/MfLGPs8QQJlV5b+ZLNtQ4Q8JiopMnwO5jSR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324141; c=relaxed/simple;
	bh=DSav6/C2BZE11C9BbiDadzSxf83CO6BODz0pe2or16s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PLjirjslGhRgG45HONg5EMc98WTmwY1PbGS9HuqyIF977zz7Php3KiCsVlM5GmzJY0kNMOpivi63Bd89UkMqFhHtu42XkRDNA5reqxlv6NqyXSqrYEHilGjsjCbJCQ+ZtfdfQjDF3PrP4Y44HmpVHiNjLNDegg/qo6KrjEVwjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOyyYfjr; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOyyYfjr"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2154171b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726324139; x=1726928939; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss782w9+b1FT/whh+kZ5DKPpOSvXCocQoytZk8t8S80=;
        b=AOyyYfjrjgkqdPAbne98PAcIA1cvj3fIat61mjAqDtHBqS6g1coQH5ChaEncjkTocO
         taY1rFOos382EtnlO3XIPLwQffEyfuyNgjf1gyItaO5/wK96vCqsA41Xvi61Z+Delgh0
         mNZDvvfpLsCmdTJ84i50GRDJ++zKlfG9Vx//14q3DgwLK1DtN9hZFf3uOTq/j9VDIM9A
         9kbEnALu+rf4Yet5CV4OGXy4VSpEsZTW1+jaceHAMuahFr98n/Nd+1zE/4uPGC8/iqD0
         kSlgWzPcrqUVv3L8zga7MGZYsTX/aslmJWPj1sfQu7LEJNrwVUompBlI+k84/N6pgV3Y
         iLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726324139; x=1726928939;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss782w9+b1FT/whh+kZ5DKPpOSvXCocQoytZk8t8S80=;
        b=C303rF+OMiuaucCaKmXnD9LYlbM2x/3wA66VHiL4VikL5nPJzrFy3OqhZ8sg7fQn0O
         4whh0Dtj79WRn/Ukv7FuRhNmKmKIBMAEH1YWnOS/r0bEuRNJj8JoVt93UsVoZzABHRFc
         B7XubP2qUTXCAdNXMt5rQLLIw5Zm5bPNx3TV4k/mzpIlhixVki4Q6XYZZSHJD6J4bEz4
         HxKSv1K+TZTCckbd+Ocm3s7r/6OMshAmbSwVblkl0Fcc/Syzm28po5zCTM4ohlftPzUw
         Cscwbww8PKGp/huY+IcNnZm2/xgKV90ZGdRkyKt5H14FCnYyZVjxwimP2rB6DB7oMzKQ
         E7oA==
X-Gm-Message-State: AOJu0Yx3fl7Z/++Az9sy4Tq9x2PgJn4BeZQY9TL1Er1MsCuXdiqOWOXT
	pYoIptBCaoKtNw41SvNDIRjdZ+q/IK6uC6bXJcZwCn/YCseNhP8/L0pdu6ww12A=
X-Google-Smtp-Source: AGHT+IGTNB/d/0abJSyhZ3pVuMkXyuuo5QGEZifNielyYipYwd+OgbbMB2uE9cUq12wAkMlPoY2ijQ==
X-Received: by 2002:a05:6a00:3c93:b0:718:e062:bd7e with SMTP id d2e1a72fcca58-71926212547mr13690745b3a.24.1726324138643;
        Sat, 14 Sep 2024 07:28:58 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b21csm1043940b3a.123.2024.09.14.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 07:28:58 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date: Sat, 14 Sep 2024 22:28:53 +0800
Subject: [PATCH bluez] contribution: add b4 config
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-add-b4-config-v1-1-ed57b7ed6eae@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKSd5WYC/x3MQQqAIBBA0avErBsYS6S6SrSoHG0gLJQiiu6et
 HyL/x9IHIUTdMUDkU9JsoUMVRYwL2PwjGKzoaJKU6s0jtbipHHeghOPxtSOWkfcKILc7JGdXP+
 vh2k9+IbhfT/BL//eZgAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=DSav6/C2BZE11C9BbiDadzSxf83CO6BODz0pe2or16s=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaU/nLj++y+nkGYu93Ps1Oj9t/73+0aXeLRvbvLY+r
 d2z7Xz0o4PTO0pZGMS4GGTFFFnEdj59vaz00YdlvCYzYOawMoEMYeDiFICJdIsx/GI+ufnwhMM5
 V/9sLj80aYanT5jef11HHvZlz1laVfxDJT4yMpwUujxn39tpl5bt3ZS88OnllUc1XNuTW2ebT3k
 ZxTzNvpsJAIQEU9M=
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

Add b4[1] config so b4 user can contribute more smoothly, especially
send prefix.

[1]: https://github.com/mricon/b4

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 .b4-config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..18c37b33bd143deb26d5ef4d35a906dfcac2e463
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,6 @@
+[b4]
+  midmask = https://lore.kernel.org/%s
+  linkmask = https://patch.msgid.link/%s
+  send-series-to = Linux Bluetooth <linux-bluetooth@vger.kernel.org>
+  send-endpoint-web = https://lkml.kernel.org/_b4_submit
+  send-prefixes = bluez

---
base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
change-id: 20240914-add-b4-config-663f09f0e810

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>

