Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674302;
	b=lv6z/87NNPL5/FWtg6HsG5nh9ZU4smZ37GQuI6frCgzXfy5BXwF418sSBjolwKVI4fbg
	 vyXl38ReKxuM+LB2GZ+KE/uMAklS+ijC/Ptd8pmYZ2vkYksCcfukcpUlyInzY9U4D3Zvm
	 EQ2gyrM/ZJUUFwXv7e816OeSMwJlgkud42+6A7EzptDQAWeYkoQ5MedOAN4uI7lppQ6vm
	 gYTukQFO6+zyT06rTduLal8lTFFCAsVXd7N/WuddOEXCoOOFF8vNid+h8wcbapZTgxCPW
	 mMYk2mDK7/bAW1JUALKvz4jubN+Ini1FPFboH82wTW4Id+faTr0Zj9fmdTS1qXFCrMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=U43q/SyCWxgVkbsWI+sjZlDnIAsHMaphvh0fsl+4dqk=;
	b=fFUS16iZqTOXRY/rir61CPRxMUI5InpENqkgcTa/a3eHu8GAqBnGthkpTjfJYjHGnLjw
	 i8+MLbXvKqO4DmphcgKBkZ+BHHh10dohyaRgE5GV5aCDsR2EDODiX+8OY352B70abX/HT
	 gb2QJ7CiqHhZkGQr37vN2YodnmAegVEIw1bmL+S6BaVIx7aaiui2Uo2QbG4/+bQ5cY9oX
	 T/Q+5LnlRyWdjxuG1M4EGzWIN3SWolwpak89ua6BbN7XyqPPfo1wyWQk76MsI6vZb/KsR
	 PgTrFug9Yg5S1PpRwFYdBpow3c0+NKZJGzQoex9aucSdc0Boz17Tk6n+XEGGu2gIloQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nKYmHgad;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25C606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D25C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nKYmHgad
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48e9476e26aso747852fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674301; x=1793279101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U43q/SyCWxgVkbsWI+sjZlDnIAsHMaphvh0fsl+4dqk=;
        b=nKYmHgadVjBj7/kttbrV5u2SFBhdAJn+5Fy3KjN+WOjAej5+ND9BaZDUZL9mzOQosS
         2EiUN+9Q19pXT/S+M41Uzg6uMi7v+RG5KdPRldHE23MWRZFct/ft49hqsBkf+ZKL3isF
         X3Dpl9HbMk84gRNOplVBnVBt+B9ejNFhJpUvz3IFe9ru0OXDUEZKCRGdT4a/ADrnuF5S
         8maYg1ctGBZLDsGNtSK+FtrDwv4IEvyYESUfKeIem+StQhPYNWsdJt7odaY6gVc4S9aK
         h3AmTeGwylvn/ofxiUZ0T/s9b5RN75NLlpvA/8P4kWA1KQWCo/wNG3UrUWxfCRlkvVac
         l1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674301; x=1793279101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U43q/SyCWxgVkbsWI+sjZlDnIAsHMaphvh0fsl+4dqk=;
        b=qPfUUS9S5VoEHL9NZPXTn4+k8T1Bf6xqztlSCtDqIj0Uo3n2bnPWk4QNZreQOvsYYW
         DG4pcMMYfDJ1e1gSiEoKmoNC+jPCWci62512mXBHgnpCaS8ujtqEdlAubybtlsfZkIz6
         4Kij+AY3J8QXwXmbUF7mUzTSkgk0pUSSAaJy9NkfU8xh+xkzU7vN4hBfVn8yxu92kK2+
         APj6CDgdK3YvlcgN0WN7mmYY7P+4SQ/Q7Zg0+zZLCnmVY8Tk60NqZqd/eL7oo5scPHj1
         zBeabzx+832iCo97ySbKB1dqvj6RotF4WTJ2EKckDvUybaSCZ+fnJ8jUCodQSnRtYTjJ
         zCyw==
X-Gm-Message-State: AFq9FYI8USFcoAScF1LV9ofbws7HwPFvOEGCboajGRZqzWQERzKzapTb
	BMtEwJ66zPAVM3IqPgzwwViFIS7I2EBZdALwGCCyDAYj0ikyXIkmL3o7bhxzXrvK
X-Gm-Gg: AYBFou08m4PQy49AacJg0Y+ux/7v43TgX3qWZD5myFdo9C5DnmK0ltXc2Ya6PieZ6pW
	b9dYvPMWq1Juulxi4wDeAQyRC8DS0KbXzdWFLcTxFsWP5LLiv9louuzKgZeml7ldutUEnSWTr4B
	/eNjigQWly4WhsvjW47loFuRCKJdeDZK3xcMe+PMkIRpSv/ePjwvpsvWpXtlaXPQvh2xdzXrXYn
	868qy+DQVXzxhIMG+xskGN5H9sRLiEwYDTF0n10ZhgLP0I5aZqNV3c3AW+w11A7S9bJ+hYYBTGS
	q6FC6xUhulDZd58udsFNaCVZLcVfWKuWBY/CJuhDKpwWddXb/Ofjtb07Hs5AjX1V+TlkXJRek2o
	12zvUYMd77vitXKXgU9cgjFCgwPFtpXkiEXKWlcWn2IOHdvDs90jotT9a60QeYtoCZPL7VSnCel
	4Ml9+qPtzLHrC+kZLt06IpO7jRGYVVg7uO+Yoo23POvEz2xv07MiBy1tGCcKsYODhWW8oE4NXP1
	ajaXWO85XiDdfQKIopRZAJcNLFSHkYAo3Zh30bqzmAnaf+tM6Z+CkTIWj34HjpKGw==
X-Received: by 2002:a05:6870:15c4:b0:475:a112:1276 with SMTP id 586e51a60fabf-4a7dc2c9858mr3570716fac.35.1792674301313;
        Thu, 22 Oct 2026 06:05:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.151.226])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d616e848sm4511921fac.7.2026.10.22.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:05:00 -0700 (PDT)
Message-ID: <6ada09fc.f81d2e1b.2d0ac.93a7@mx.google.com>
Date: Thu, 22 Oct 2026 06:05:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9079818087714352522=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: Create debugfs directory before running selftests
In-Reply-To: <pm-bluetooth-objects-candidate-0188-v10-ad807db51e45722aae62@gmail.com>
References: <pm-bluetooth-objects-candidate-0188-v10-ad807db51e45722aae62@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9079818087714352522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191265/

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.88 seconds
CheckAllWarning               PASS      23.04 seconds
CheckSparse                   PASS      24.74 seconds
BuildKernel32                 PASS      20.17 seconds
CheckKernelLLVM               PASS      21.13 seconds
TestRunnerSetup               PASS      453.34 seconds
TestRunner_l2cap-tester       PASS      13.23 seconds
TestRunner_iso-tester         PASS      13.13 seconds
TestRunner_bnep-tester        PASS      2.82 seconds
TestRunner_mgmt-tester        PASS      82.51 seconds
TestRunner_rfcomm-tester      PASS      4.02 seconds
TestRunner_sco-tester         PASS      4.99 seconds
TestRunner_ioctl-tester       PASS      4.10 seconds
TestRunner_mesh-tester        PASS      5.08 seconds
TestRunner_smp-tester         PASS      4.05 seconds
TestRunner_userchan-tester    PASS      2.90 seconds
TestRunner_6lowpan-tester     PASS      4.03 seconds
IncrementalBuild              PASS      20.88 seconds



https://github.com/bluez/bluetooth-next/pull/977

---
Regards,
Linux Bluetooth


--===============9079818087714352522==--
