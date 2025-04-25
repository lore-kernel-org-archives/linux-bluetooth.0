Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D31A5BAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599484; cv=none; b=smPfyYS1yJC96fSkYNMj/4ptoJWZ8skCMhLXUE0k6efr02hkJgj9aq3TMOgzz/ABzFw76+L3Dvn+Wy0BbmLE5svLdK5dLfmVNcOdGoVpiUXtnwGxJpVlH5GxlHSZAIs/LhPSvaDidGRLODydakz+juteo0rM52O0vcgA99eqRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599484; c=relaxed/simple;
	bh=puF6EW9W/dqrcsWuEgUXwdy0EwewLuPvftgXt3eaQyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Vw/c5At2tu7Hh5uTSut+jMVcLqbc8UPwDP4QfH9gFZOROa6riYgcBHEAsytKIN+HGCgXpt4dxfyPX18mE9j3QcBMbtyXw3aFLnYVyCUugoyBy/j+deS0f0Z9CKXkPuhXZmmC3MN0mdbplS1uQ24kGmSbjSPNPVEOPaMpr6uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdFZFwb4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdFZFwb4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5242f137a1eso943918e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745599480; x=1746204280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qH+8fgPv4UjOrLwHCxH1vZIgpbcddM9DrVn+7OBsQMk=;
        b=NdFZFwb4gBWLhT184xf+AMqinl94VTD2Y+7DakJyw13qq71o5GFt7OTkwTMl8YIQeR
         w7Hh6g96SrneYU1i0o/38wiGAF7PKXsQoT9GFAfPIagatSpUAAat4n91FotAkyjZozza
         IyCk1n6Bl9tp0uD6jMUwl6LSm+/4KMtNnUC3v7tqx46JPYv5jH/07WAWJ8ERaBaz4aMI
         oVB0xadkOPRDZYKipFEl/gj/xEOuIImeSLjEJgU6SJcPSZqhXW9U6ySsaUM1+FuJ2S5C
         Lo9gPiWBYEo5TdftAUxTmGfBJIy4sNHtSLPiEgauerFHgW4SM6/TfUQ42CkMckjdljP7
         7Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599480; x=1746204280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH+8fgPv4UjOrLwHCxH1vZIgpbcddM9DrVn+7OBsQMk=;
        b=DJ8eXIvAMpV4YS6dul8BCYisClM1LaINuVITmiNYyWiPRZ91pNgSbmtx/C63IvtciD
         p++8toV+LrV2Ox3IcPh3GnBmiN9m25bfLapL2k75HwFtwmVpqKWrhIRe1LDm8LIZT1nR
         6FR1RKBWmbXMP7nmN9VMhamtCc11D3juu45EMn+E20StxlcCcG1CL9WAKTCbdJrSdqWV
         WHJYxdOe69Adx/BBopv+Q5R6cOjwDh0SbjDNtXSw7lwh+4fA7BrPTULPgfDB/hW6Z6tO
         EKNlXmUoMdc3NtMOmiAvbYstE80brB5bwQC/w3GiMr5BCpTOS2LNdyKpnCwuLA6RNGi/
         NVBQ==
X-Gm-Message-State: AOJu0YzWWZ0n3CzkIRCCaTroJOvLioHCtKqo+OROddMA3N6q0b8XLc/3
	Tm+rGuitOIXgvnjbgm1OHACkq6scWlsvr6wofymUvXp3teL1OcqLjQIz/jXYqTY=
X-Gm-Gg: ASbGncvjt0fQ3ZF9egoVGCUpOtKPhgZynzfeypmQOcnwEqCwCRa2UBIjO/ePsQPfIpx
	FMvyRnm14xOx1clJwB9uUQH1CsAXHOaIbEY1YlBgXHnHXeZnWYF7QlsrRBuUv+5utfSCVWB2hTQ
	lS9nsku3v0AAa2FsHh415i8EcGM8DZWW3FuqpQ1D5e8GWKtDc38xqXeP347B/C+69XdMHuRtHw4
	CyayZwkYNzN4Dme8INNpyZWB5njnaTKyqSe47bDM0I4xP5jZ2v34Dk6Bs055OaapV3W55OwY1ti
	OAptne++RLVRN5MoDhJMJHOOPxXmdNE/rCsvdmdZpEtoRIDpFMyKNGghxZuJWIPmpCfEtPTuPbF
	TZ8rVhKg7rQ==
X-Google-Smtp-Source: AGHT+IHJnqmqJtPEKItiL0pJFO0wojaQnU8/pljN3Rt/ubu8X93ORBDz6rq3xz9eMSDHcrQ60u41LQ==
X-Received: by 2002:a05:6122:d9b:b0:528:bd71:8a8e with SMTP id 71dfb90a1353d-52a89d8b45emr2181490e0c.5.1745599480203;
        Fri, 25 Apr 2025 09:44:40 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a7a12bd62sm719879e0c.43.2025.04.25.09.44.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:44:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] Add .editorconfig file for basic formatting
Date: Fri, 25 Apr 2025 12:44:35 -0400
Message-ID: <20250425164435.1482617-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425164435.1482617-1-luiz.dentz@gmail.com>
References: <20250425164435.1482617-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

See https://editorconfig.org
---
 .editorconfig | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..29a30ccfc07b
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+root = true
+
+[{*.{awk,c,dts,dtsi,dtso,h,mk,s,S},Kconfig,Makefile,Makefile.*}]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = tab
+indent_size = 8
+
+[*.{json,py,rs}]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = space
+indent_size = 4
+
+# this must be below the general *.py to overwrite it
+[tools/{perf,power,rcu,testing/kunit}/**.py,]
+indent_style = tab
+indent_size = 8
+
+[*.yaml]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = space
+indent_size = 2
-- 
2.49.0

