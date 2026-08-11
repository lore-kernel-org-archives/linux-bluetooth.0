Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2392931C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423534; cv=none; b=fQizubSZmA9/DMoQdtUKIy8epPGS+rXH/cF3xvIaxgATxSSdZgLQFLxQgxQt15blT8+fEXYXQYy00qBgkQxMlfCUOQd1JrPyd29TYKxREvHWW0kEDqBd+Q7iUChU1ey/4BDgLeGRdaBmq4+juKtJkLhU6WeDBHYo5pKikS+yzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423534; c=relaxed/simple;
	bh=OvYcNl4ZCjhebXchi84VZcyOd9rK3bIZSuu+MwUdFy8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ViBGhQPx3jIrHASiMJaothbtEJimziMdQ2PoXKMUAPn6+0jUDBk9joTfCvxZfoP7AJSKHg/PYw5c8w/Cms7zBb/88UfZAzC6yoR1O0sUQ9f6HPOzt1jytqPOSsfJHUeZU0uv/cpWcOXO2Avb7/rtje5yfyb4jhJMCDBphnt3Mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICTN57Xb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICTN57Xb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cca0c5799eso26050855ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786423532; x=1787028332; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=98Q1mvXIljuBaaskEqePySTwwp4P4cOm96Jmy6BnPAw=;
        b=ICTN57XbBaSgjyxF9gWMlk9casWDd2t1cJOSqwvz9x8nkpIyX3iVgzpnM36o8NYGNW
         SBeQRfso6ugxbbVWQEX9EHJnnln8M4342pACTJcvNx+ecs3o1CyPSYmHD1v2ZCGjcG+2
         6Rx0ghdwf8+dt5JYmOw6qANhUeKIhnP3KqQfeBMv+BJiRS6+PyLh2M0tnJ1COvjYNZtb
         6xGiKN9wSMRdXqSyxev3IvOxGZbH7HSXFqvrovjL5B0thtvtn8H3ppOgbRf8HVCJG2Gs
         nUF8PC0jSq+8B/9GgyoJmgpoHfOIrGFICjQDORxi0KbFdWlS9NvGv1VObx/1tp4wy5NW
         G8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786423532; x=1787028332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=98Q1mvXIljuBaaskEqePySTwwp4P4cOm96Jmy6BnPAw=;
        b=camgzprP6++CRAjY+v64P9br8FnI1/gnQGAmbex+S8bDSkWNsNYFBXAjEUn0goKnxm
         J8N5ND9r9iaJmVZo6qlNc4ZSqk1b0/VzmtOtDMZjLIdUBqSBiiv1H6tgRFu2J2qleebA
         gF95DaizQyVd0wSz3qBCNE4u2zn8JMR3G9rgYTI535j2GxfhlJuTssOSut1qBLXPwgJR
         TIO8/RSicw5+P5ECZwKmztnOIXPblLGbvewNYIm9qbu47s9y4D/jitg6/W8RKgjLeDUr
         OHjyEoj4H6dT1ZgSYqR/QdAaeLgk8gaX27zBtYWmXR+VA1f9d0UsoC9h/4n+QcnzDGI3
         HL0g==
X-Gm-Message-State: AOJu0YxxiNA8b38/Nsri9LEOVkLu+L2gosizngCCXGM6w08uxNukpFml
	VoXfcasFsgG+UZZjEWTNsom2LmT9yGpRIQ11kRQlNuzp6+eWK1G0dj44TaX1gu5U
X-Gm-Gg: AR+sD13NQWXHDW3dEBKwczKtod2Hy6ypAM/7jmTT22C1pSjHuCFvv3lW1vksu30ESPV
	LNaf7YWfMrcOXLm7KVBM3ckGTcmKyzFcTX//HHHVcQRGn+KfJqxxxADnKlj9FzDCQGkxDyrzNtU
	Y+J/y4zjKyPFzMjbseMNd1MfOpWJsZDUK1rI7JGsu9Esw+w65VcvAKhS+AX7n0XDw3nZ9rCFbmu
	wXKGm6kOPq/MQ6NZcvFbGoMtsk/RsuLX4ZZlmp1bT9utb17kUbIn2DcJ2f2sjRvswoqe3vyA9Lw
	AdHoyWHcFhSi0meXADz/IGKBlUaNKFPT0y8VFdpnu3xW/MLOEZcXGuqaQLuJLPGYdoMxnOO4Isk
	3OxkPLgreQxA+sNon+zy9XMg1Y5apw86Y6GRi0CuQDic/i46iwn8mTgUEfflFIG1BfdU5DtCBUn
	EATVD49winUUh+2PxBAecELIqNvaAgfyA9bzSLT7T4W03dxvdDgy0otX19dAi66UbhtXA=
X-Received: by 2002:a17:903:2405:b0:2c9:c991:6ed3 with SMTP id d9443c01a7336-2d3178c8ad7mr9553315ad.12.1786423532241;
        Mon, 10 Aug 2026 21:45:32 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0c7dsm1287875ad.4.2026.08.10.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:45:31 -0700 (PDT)
Message-ID: <6a7aa8eb.5da26cf0.2bf9d6.cd5a@mx.google.com>
Date: Mon, 10 Aug 2026 21:45:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6963914940954970425=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cong.yi@linux.dev
Subject: RE: Bluetooth: virtio_bt: harden probe error paths
In-Reply-To: <20260811032702.67908-2-cong.yi@linux.dev>
References: <20260811032702.67908-2-cong.yi@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6963914940954970425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143771

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.54 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   PASS      28.75 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.05 seconds
IncrementalBuild              PASS      27.24 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/568

---
Regards,
Linux Bluetooth


--===============6963914940954970425==--
