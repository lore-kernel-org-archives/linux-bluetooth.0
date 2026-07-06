Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A643DDB1A
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342672; cv=none; b=ch5yehD7I+ctt8PhzX+H2fxil+NOLwM7n0JCNtxL7Mtdmt/LuO968sbAIfXl6tWODC8q7HrQqRZTyG/sp8IuAL+l1YHluPvbiWE7VNKdWaMNBKP5N0sc4qIp8lwOxc1AxT1xRc81iHAjkIGuTaTBVFPTs6cI7Z6/0WosurhfhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342672; c=relaxed/simple;
	bh=HZByWvGN0TcpKTsZT+BO6TD3Gmnw1SVrTlg+cx3LSo4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eoszpJ+KZpqZq+y6NS+GnQXqOJ5UIGaRV7OqeaRR3VcpBEzqbElPCWfFvWcuYp8HwOgj65csMHrmRUNeArqT7OpnqAEWfj5yWmxWEehAN1SdCuG/fueH76nQ4B4oUperH9s9N1qcKLKK18ALUYPuOaeKAJl2bTflkfrlfCSOQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArVarvDc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArVarvDc"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso2097130a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783342670; x=1783947470; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WOd341Di07XazHdr7MhjgMrHL+z1+rY20ceWVD0wfGA=;
        b=ArVarvDcRaBCDFzEui5w7cRGBqwd3CKYZdCdezrbjQNLhLQN3nFOYpVSO1QWH5THk5
         2MAAESwmgC50sPn6HMyApb2bQVNK4wy8f1VQ9Cim49qKwbDVqV8vZWcb+zhhz+f+HfIi
         anPjJP6MqMWYUQycjRve5BeL2w1gJarXatOwdetyq0OObViX8Eza2lboCAmJj828J+ib
         Cche4fKiruntFXyhPvAkuXrj+EN+dvZRgKaPrwbMFZOaio6/B5xky8MjP+J5lKjiqxAd
         zP8ZaJunfUyHzvATh5oXYh+0gvkkyz9uR7WpMdYN+EcG5uurmRM60iRO416HSs14vguL
         +Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342670; x=1783947470;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOd341Di07XazHdr7MhjgMrHL+z1+rY20ceWVD0wfGA=;
        b=Q6SVUfkm9H3uLctzoB7Jd1myFIjWAe7Oy2zDuM2dSjI8pQz7sMXND2D+RIsnd9MbOS
         lBHT8hVKJ8Rcw4XXptUaZoEABmscTEHDNlpg00WJS9Jz2+TqPwO8BR4IUWdDMvBhD9GX
         9X3mKulqmtt738XL3JyHKb137tquvW2BSWNkHSqMwz7bkJsXlga4V+28tfTkNLNshE3L
         5GYe4W3XEwJKLCgO4v6L/PtTkKH7jV0UY9HuwOUea9dML0vxFjMPo2SfQg++eJmeBHBR
         rcf3AIYE4el7inskWkva6kWu3vMhXAtKGjf9SqcJXx8nyXA6UlNvgvCbi5EhrFk0mgsJ
         CWpw==
X-Gm-Message-State: AOJu0YyhhiUVGAfq9PE3e8NTqKChRkC4lb1NIbUsR7rbCcZeJxWpqzDg
	DT+NXTYeS6NEyGH25IwymB8pLIEB/6aWoM3Xxrzk7oRoY81R+2cdv+UZQ4dHNg==
X-Gm-Gg: AfdE7cmW8qbQ1o0PLVZ2I3dhNfqAT44jzhahznt0hD+V6jaNFX2xV3gfjnlB354ypKt
	xYr3XKxLIYIezX/EhPB10EhOSUxz2CYr67Cc1S5wmUJnKp+eXQC0wUE+R2B4BEJaNm/IsiSzn0Z
	RPQEfBRgVL01JwrCKv265L1le7yMk5JrhlLWjxzwFEfpdnKde6NB6A+x44BYJQESawPuSTSNQ31
	qe/XwL+Vr+xc3wcUokmVwRZ2uV/4sHDpt14MFfCILj2pfU9wodk3HRh0zi4QezPyeq1Cf0d4H2U
	c7Ro6c0opMcdcu3wI5GxaMsyGSEqLDg1N1l6jp+/coXeVI6XUyfR/QQGZhSjNh9ijkCchHX0Chc
	eOdJM5fu8QVLifkQMIxUYJecPLqekqAjs9GgtoN/lydLOc6W/0HXkWWRM5USGxD9fQIrm9YcVML
	QQHBks4Ap94RSQ1LU1Ue5mgwgDF0vjMJk=
X-Received: by 2002:a05:6a20:938a:b0:3bf:bdb9:f602 with SMTP id adf61e73a8af0-3c08edef6d2mr586394637.22.1783342670443;
        Mon, 06 Jul 2026 05:57:50 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.138.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm49420153eec.11.2026.07.06.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:57:50 -0700 (PDT)
Message-ID: <6a4ba64e.d1496011.3d49cb.2320@mx.google.com>
Date: Mon, 06 Jul 2026 05:57:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3686391345009315860=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btusb: validate Realtek vendor event length
In-Reply-To: <20260706091618.77442-1-pengpeng@iscas.ac.cn>
References: <20260706091618.77442-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3686391345009315860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122166

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      23.62 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   PASS      24.61 seconds
BuildKernel32                 PASS      22.92 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      423.74 seconds
IncrementalBuild              PASS      22.01 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/402

---
Regards,
Linux Bluetooth


--===============3686391345009315860==--
