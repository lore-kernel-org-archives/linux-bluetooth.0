Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27740911F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219414; cv=none; b=p09ZcHtQADIvDJdOH4jvfGXErYarNLrzBLjaO5a6xeKfdC9qusqaa9ih+QIcYOGk2WF6K1Ac/3KVtAKsHdM16sI1H2Pk3iWE40QaSPlZxOaMbKIk5SrqE3zTD6vvr7qAyOu2Dn2Qu7NwFBbxIMMdN+/LHxkmj8UP1NdhKu9rZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219414; c=relaxed/simple;
	bh=p8nEhi1IZtqTa2fykU8x4aeb7Wc1ceZK1xYi1vQOBgU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MyJxVG9K3M7fhs6FumgsftN24Hb6U5kcjPS8XfNqJ0lBTUGMtStuuMOcE44UNiePXTVLpblViWVp7Gab5P66a6rediazl4Vv+H/bmhhPIJTi3Xe2OnJRzDDlns+JcSYO27aobqAZQ06U8sdpDJzLTQxc1BO75mJC7nD8/oyn8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEVeJVVM; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEVeJVVM"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-45ed55cbbaaso948966fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787219408; x=1787824208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zSywxAeOUNyPJqx9o8JIXuK2/uULgRUGJ9lqtWNytvc=;
        b=NEVeJVVMWniAvGGVal+80yR3HASYZllWddtAhbGBEfLK0Nz2Dcc4X0GlJ8bFz2uDaQ
         kE6pU24Q5FaG5Omy9rySgf+Svprh53ObCN4uxJ9M4ogipysNaytgHQiWzth/Zl2d7fbi
         zaessrp9BNnk9DX6B4xy7txXqi4dubdXaaYq6vsmXDRqXZCtUfBaMgE0Nf5JJ5sD2lGv
         gUuffZMJrhb8bs58Uodau3cqxsFoLXu6l3OLhHSOxW1fEjzvFbkqcms0Btni1Qd0VDGW
         ppDgDL3ynpgj6+fpFl83DrJOZ+sA/itWaMcrrQWMtZs3vH5SS0deld6iJj9w/5CvhcBy
         LCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219408; x=1787824208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zSywxAeOUNyPJqx9o8JIXuK2/uULgRUGJ9lqtWNytvc=;
        b=QBqiBKWWPQd2ugUwAWVT7VPuKw5muuOpC5icbcfSE9qoot4VTwn7eYNqJSU7WV9bCP
         /hfMReJRaS+ug/jeruKyeS04rBsaZj21KYOXiAR+ulFGwoSTs7thzrVJ3mZaOqP/IjMh
         Xt2GiezFzthve9WZzeSd3G5uOjBrYfxN9iL3sQmo+rzuvXXtmUtTYqYc6ePV1dsLh6MW
         JavvU79IaHyOnZv33Zgc97/wTH08fdSswtiPgeFECxwzoPEcQSIhC1ZXbxIlI9ZvYecO
         QxofHoC81Jo/9kV4WmD7xZzY47q8wLG7sINAPa3ZdkOTwu/7gNKVYW9xxzpi8gNNbrmt
         ibyg==
X-Gm-Message-State: AFuF++nYwLtLDGZiMKDX6jTpbzP4XMqLzwYwWWtxSBas8tvrwhgSe9K8
	a1ALrqXBHfaFxTDcq2A54NetkJ1eWZosaftFh/B/f8/Z8e3bGErS/5Aub08dnFmk
X-Gm-Gg: AR+sD10MOkNGIF7BrB1sCObjCCEJ59m1JpPv1gN6VMmdX7FwbSVE8b8UMVgDiRC0BdO
	CxNh+kIjB++8As/+1u7TvwarfGLk6/Dxt0N9w4T6eDHwkUoQnxEP9HsCz4L6PgHBHZgovc+Qa+v
	WtcNL3/LC1Vg2wyIfR61Y9BmpuRmTdc7oacD/4/8uWn3wE8GyOa/WbU8kWLCCd5DRF8+KeCBmSM
	DfP5n0duXFiSFSGTXxDKmEoFVokCKXWh8vkyMC4pFH3EhoS78NkRR/7ER+0KalS8GgZlnQjzeIT
	Tpz6C8qbjUAKeHiuYHkn/T8gvhyZG3mqYdXm/eCP77WFVF3ZFvbuOxPi2HXF0NfU4m9nyQrv+oF
	UB+FXgq5Xk/+sZVw72bzKuc0BytXA8jlP8dTbi6bgJ9Czp+IBR8ChynL/VvCXldOH/E56c/lKnv
	9bY9bpseIv76/YMZ7Vy7sbrWlwe+z0i4n9CQJFtTcaRCFBUnLH7V0khoTXSRXXk9cDzfc9Xg==
X-Received: by 2002:a05:6871:e485:b0:455:c1d1:9cc0 with SMTP id 586e51a60fabf-462f6c892c4mr13068898fac.19.1787219407936;
        Thu, 20 Aug 2026 02:50:07 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.224.117])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632aaea105sm1270851fac.18.2026.08.20.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:50:07 -0700 (PDT)
Message-ID: <6a86cdcf.abf573ab.5250.4f16@mx.google.com>
Date: Thu, 20 Aug 2026 02:50:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7801903013146698397=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: Bluetooth: btintel_pcie: Fix array bounds of device-controlled indices
In-Reply-To: <20260820-btintel_pcie_bounds_fixes-v1-1-c9dcd1ac8bf6@uniontech.com>
References: <20260820-btintel_pcie_bounds_fixes-v1-1-c9dcd1ac8bf6@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7801903013146698397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148965

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.91 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      27.65 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   PASS      29.33 seconds
BuildKernel32                 PASS      27.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.28 seconds
IncrementalBuild              PASS      29.95 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/623

---
Regards,
Linux Bluetooth


--===============7801903013146698397==--
