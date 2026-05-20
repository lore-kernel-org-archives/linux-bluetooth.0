Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DE372EDA
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257724; cv=none; b=KM9WVCTtcvX980QqJmteFCZtqrtIroHo37eRqzTG02lhyVaMFgT11pblahcHgee8YDGF70WWrQtxwnP3+guRrpLcujR+BWSSErcEAEPMMY48EdiIFD9UzSvi2OGgM6ZXu/yMs+APtydI5QUVzThMjPlwx8mgeX2dNfaD3Uacg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257724; c=relaxed/simple;
	bh=aSoOSKwXl1Nec4GUcYP9COTMX9MI8WCt3wYR0lk+JC4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mvMOkXr3stlDTmvIDkT70YgeyZlBxKZiZjtO6UMUvPGGouuMwgxmhv3YPJDrTuP2Njt9DieRwvvJa/iWIB+MZYvhD8Jpg+Y++fOnj9RRv/F6v7Dx/nKwfunjwyshrhFC8tnL48Hj/1tJmrMB7RZgaNqvBVCG9V6H5MEgays/uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAQZT3MX; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAQZT3MX"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-47c6f914617so2093018b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779257722; x=1779862522; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UvX2oZUdG464bkmy5Prp0ngQxAa5cairZPfVEFMlcw8=;
        b=BAQZT3MX1azH56/omFMZlMOznYkKDCVr66Jw6DeZQB9/74lR+LJwDTjwt+S2FcEKHO
         FsLlcRMFocQh7nfP4jmkVMjiMH69ZA+ukVSq50V+RibO93vlypgcnt0VF8nG77FkmGyC
         Ou2s7lwWqGXEV3VzO/Gsv9ceYyEDGOq/cQrhblxxy++t8UKc3HfHHJf1rOUoQ2LE+wAn
         3biChJzzk5rfy/amvr8ohjah8lqDejt8EoGvOkBQQ0SOF7i7fQrMgMJvKRNln9LUI28Q
         dtExV2HnXH1Fy2+5EF60liCUJtRwBFkxie3IyyibzfMOGcqqKXwMqyRLsAId4FC372zf
         Srog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779257722; x=1779862522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvX2oZUdG464bkmy5Prp0ngQxAa5cairZPfVEFMlcw8=;
        b=HXG4LpkCci/FQdnllqBFcRIiTdUt2NMPPdWleZGk6e1tRIhga/JdSRZiYxRKEI24wI
         IbZ9aVwBAc+ySXYG5IkXoy9n0trsyDraIM83aG0AahHva8wEBd+Uk5ZNxX5QMP1pKi06
         xNo8BxrqjQWfPgTYmyFsEMU6LQ1iJ3ImlKNjf7Btle9ni1Bkg9ePRHdE4Dyspezuyeo6
         F39Ua5/CD0GAnCo8f9VDBVQr/1HF5Z09hs14juEJrj5lhWnJM0yhx6QKGsOyOVep9dQo
         mMadedRg5+BmmheAXL6LMSgT3g3QWRjaYd/yQeM7VOHjAncHx8/EOg7D9WbrdW0cPesy
         JPpQ==
X-Gm-Message-State: AOJu0YzaIramY+FtgiI3CIFzZtr/+MIJJR+fzL+JVk5i2xskQgbNuuo2
	oCc3ZD4O8d3Vxe0P0fphWB63kQ3uXFJsI0PhhNRU638sfZ7mGFPH0Pj0B5uCPg==
X-Gm-Gg: Acq92OH+4QGIjjBP4iVRmIxosFb2czX0xLUBmxHdWGB0Ph6f7vJHkUZgGynd5fIpKwK
	GoIKl7/7S6PMAmmirK+a3CghNQziE6Wf0nLT+NbQWZhX2uJ19ctsjFlcN3ROGNbXTGhr17jBCCO
	6KqUJpPReAPKdYuvnwjsGvZQuA6zFYUxulxOr9w67I8WoxsjbPxK2qJXORf27H7ekHBTFUH/K+R
	UigItwQ7eptDNSm45xY+3M5BuWPO6itZ8DjJKjzZhh3D6+DErd7fN5JnsWASK7fKTiMpn2ugBKM
	hNHMSlrJgvbu1ml8L0tqiGmpIVW+pbwZNtI08MjEdk2LhnkMeGzb4X4hpgxJhy2dYiE/gSlTkQD
	ARe7EwZZsnira9xJJc9ISRKmiF6xrMTrjRayiBdniEvX/c3rtflQLeBXeGT6zeY2Oa/iNd9oI+D
	JxBFvT9YuG5weEMK3nFyovvRehJdSZ5vM=
X-Received: by 2002:a54:4e88:0:b0:46c:e542:cc3e with SMTP id 5614622812f47-482e55e65a9mr10669741b6e.6.1779257721565;
        Tue, 19 May 2026 23:15:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.100.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94f49da9sm9718919fac.3.2026.05.19.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:15:20 -0700 (PDT)
Message-ID: <6a0d5178.94e94805.3bcae1.ce12@mx.google.com>
Date: Tue, 19 May 2026 23:15:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4353747972655845720=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: Bluetooth: btmtk: remove extra copy in cmd array init
In-Reply-To: <20260520021500.13504-1-liujiajia@kylinos.cn>
References: <20260520021500.13504-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4353747972655845720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097683

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.08 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      26.71 seconds
TestRunnerSetup               PASS      534.54 seconds
IncrementalBuild              PASS      24.40 seconds



https://github.com/bluez/bluetooth-next/pull/219

---
Regards,
Linux Bluetooth


--===============4353747972655845720==--
