Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDD548573
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922123; cv=none; b=SS3TSsurpqpNUzWVamVOZt4jey+28hjEWccHidjBS4to38sA5riiwa308eV2xova9DfcO7Kg4c8iYfxXxm/KQE+rrtcQtMKEGpjlGuwiPOr3Y1YU9d9yl7z4tkXbfQw6N3d3FAogj3WtsNmMzvItD9gV4Acewy6T6XxI2f1QC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922123; c=relaxed/simple;
	bh=YvPMPpl2U5VQDxbTHHBChWX8+O0wMP1gjDrcOBGVkCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KvMOfjel1zt/vX6O19+Vo8glxEFCgTQgskiKFNSPvSm+GgqGDB0Dmtvg0U8jnLVLX5nO9+kWrTJ7M5n/EUiTkrspevYyvY0sAi09eHzuFWc24AK5iAsTu0jeJt7rpeB10CHH1YyGAFo7ARlA2n3o6ooP5wN8Zwf7jSRd4NalDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNr7tedE; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNr7tedE"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so3175506eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922121; x=1792526921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5FI6KKAozAEX1VmjkZEuieZ0yJ5snDD3Rm2IX9K2/Bg=;
        b=HNr7tedEouTAVWC2g+FyzvZI1wIrgDheqgg+ZNIzmAtAEWpn8ohAxU7Nl8Erh+ohM4
         F/S8AUzrsCAG2/4jSd4PH3HECSQPX7uqRlXezkmoQ3ZDRXYiuUcIO1Is/xhacXMtbNOI
         jdxQGnY9268HmDbsqqfU9MzNLzI9egBWsty9f0hIRpvkt7/HPdTCQpn2toHEF7fRdoyK
         rM6ucYhKuju+Byk7Ss2MqgsrvVlTnUZvsoTpQhyu5fihOI7w1jqU3mBkrRe82pHJYXOi
         KWbGQnLaxUloyelKqQDKzDOT62YZi7RcLK8MDiZZnegsw4X3tDmgodvTcw2RMUUVTJWQ
         S7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922121; x=1792526921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5FI6KKAozAEX1VmjkZEuieZ0yJ5snDD3Rm2IX9K2/Bg=;
        b=COsCLtsD/WE3Z8bgnEb+8d75gUr7zxFdlX5TWBIDnOuS1RhA9QHc/L4WJcLnX2M8Q/
         VogfZUaf1QtgPzdh/j/NWZlWKeRUXrJrTdQpgbnPHpJpcbpD8eLJ3e1c4CBfJFFC7m7Q
         NqtZSW06jx/9blJBDplBoXbHSZLwd7FbSbsfxo5JYsEpVmCs0wlOadxICTwrKoDwexQq
         CD/ECamjuEXOhFEfp+qYgimKcD4HLM6FcXIXlBKke9uwEsVf3don2W6+vpBaMSPlyjGh
         Shaj++x/azimpF/yt0Esc6Nj06mAIsSIcdmyRAwkwquDYtWkrW+c4SYJ073h3nfckc7a
         h5lg==
X-Gm-Message-State: AFq9FYKOrjIUJZtDYZ7WeNsG1RH49uqkJ/J1Gmiywt6v2RcnsQ6tP3JB
	H7KTggX2Nhl6WGuxf6fOGe7IR8Bh/rbRFukMWyVIWjapKQUIdGTBqT4WRZYoBg==
X-Gm-Gg: AYBFou2gnTeM2VZ04rFox+TKZqIXtKC3L7EMUWtWUuC1H1SBFNkvlSgb5dC+KjKerJk
	ktvJIkphfydoeyrNCsXN89CiJBu5MFlxKE/VFLsCO/bEe6P+lQdJBa/ICUXx+YRmcmbKp0P4+q/
	1mHJB52m9hqj17oZ28cyRih3ez3S1E9bcY5WwtaduiWeTgD6ObZe7gAcTWRKnIICnw2tj39oy4P
	HI05wiR7MJKevh3S13tugAxjEOmzkdopyLKfleJJdR5GNxO4glaRpXIsokd1qaS9so/KsNpqc3T
	zQrK5EUxukSyGGenZR5huDHZRU3E/UhiGWr/wBE0uOvG8Pk5oMHdQaQvMMrEEk8m/xuRWVaF3Jx
	Xln/GeigOsrv+pSJK5GabZuWxZNSXUN7F02H5DJlm9sjrH57wCDL1EOZD1yGB8vkpDNgTe9hGMo
	fMzb4lDHMy1/YAo9LqjBGErNNa7PGNKdQn2zU5OyulRqnaRAcf9fIcjPhnfwPFmgzl7aB5blXMm
	g==
X-Received: by 2002:a05:7301:6191:20b0:35c:2190:edf9 with SMTP id 5a478bee46e88-35c2190f38amr4836676eec.13.1791922120482;
        Tue, 13 Oct 2026 13:08:40 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.89.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35c89429484sm8466849eec.23.2026.10.13.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:08:40 -0700 (PDT)
Message-ID: <6ace8fc8.67914289.a890f.2095@mx.google.com>
Date: Tue, 13 Oct 2026 13:08:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2249132985915668612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Reject LTK loads while connections exist
In-Reply-To: <pm-bluetooth-objects-candidate-0136-v7-7f507d267b3bec2ac955@gmail.com>
References: <pm-bluetooth-objects-candidate-0136-v7-7f507d267b3bec2ac955@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2249132985915668612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184929/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
VerifyFixes                   PASS      0.45 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.43 seconds
BuildKernel                   PASS      18.09 seconds
CheckAllWarning               PASS      21.23 seconds
CheckSparse                   PASS      22.86 seconds
BuildKernel32                 PASS      18.59 seconds
CheckKernelLLVM               PASS      19.78 seconds
TestRunnerSetup               PASS      414.80 seconds
TestRunner_mgmt-tester        PASS      80.06 seconds
TestRunner_mesh-tester        PASS      4.96 seconds
IncrementalBuild              PASS      18.03 seconds



https://github.com/bluez/bluetooth-next/pull/920

---
Regards,
Linux Bluetooth


--===============2249132985915668612==--
