Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052161;
	b=5rQYHt7Af6nZiUeIFPBAtgbrt/nhtJ+LeB/0VN5w2JON9t4KiGhxmE7++GKcPWmCeEzn
	 biboG2NxUQ7g0nhNGFGUwRNdLssGgWFe6vaVWsja9zqGab60FvagVgmp4CbSW6PxPL8bk
	 TsYGtLiFBS8EPaZ+mTHXQBbGWOrLJA/uus27lGid9gMg85ro7L9d3XfSZJKx0MEQ2fVfo
	 FxpAqIVFWrJ41t3Z+KR5hC0gdExxSkGc+oD3UatgXmm45vLyNX2umcDrxawBIDDFX0VCQ
	 FyCJRMj0t0NpudrzS9GaEU7khrxftX3IAwJh2qg3YrUo1XR8NY39gm8VK6B65Wi2wQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=z2vNedhECMhDPXCCyYcXK89cSfBJcyq22qJ6oKAr2aY=;
	b=4YzF7vAWHWJvrx/n+AlL5yX6X0CxiTRhJXN+EysR56y53D9WrXmha8IPjDbYU2XLp6D5
	 +IvGL4d4AP/AXocJtOE4gmKcXwDMxbd0Xh+hJsFoPEa1nioyG6tMKnozGJscq/EICI0kp
	 XlsL80OrOVi/i8r89qSsrUoHCqfDzlEOeImag7fOWOohXLsLtqu410mDbWRAIPi+tI6Ds
	 eVRZPe3jd5VLNBy8dMmreNX+cWnkofVP23eDa2cvPuRilbokA3/zyrHC+0KxXMAx6Hs6b
	 ozWLxu9vVIJ/7ZRoVLipF2Mw7xJGgLufnCYpyeKDC7lARhEXqjsJrdAgjNoQh35s0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qxbrKJhN;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8C606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 22:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qxbrKJhN
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc758830601so2153258a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793052160; x=1793656960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z2vNedhECMhDPXCCyYcXK89cSfBJcyq22qJ6oKAr2aY=;
        b=qxbrKJhNIOZk5hlt3k1J1aKqOrtW5DEXiN6kUFzSwpjml9EGqCgyP12jPxh2QwaXLh
         u8wx9sGgrfzykAK5hcOUuLqcuXxhtamld2Tez5TT7ov9j1Iv8zu14ItQaa5D25wx2kbl
         o7zMOmbCOarrfU2Bt7TvpNtKZa9m+8W/Td2OAUZgVIgEPY8rFmXjq+NR2S7ItrTgHhAo
         ppWFr6p4vWx8cvG+J3+UcPVYAYB9yK8NIdXbpZ9Q47stkRbeZABeUj5d8IdI+6GriGsR
         qbCW/JTUxOfwQV25ztb9RHXuAIl3umCglZUjlT7q9P9MTPJsfU2bJUNbYsp71jRyPrNO
         Xo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052160; x=1793656960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z2vNedhECMhDPXCCyYcXK89cSfBJcyq22qJ6oKAr2aY=;
        b=gpw/TPdxa4tKKpEMvsa84rusmIgimtXThJrWyUPZgr3TbLdMe9a0tyGruDgKSgaIsF
         tva+i94+juTQmnn6kzski9AhzT1M0xI1L2f/wa3pKlu5gme1DeSLmbAUFUrGgmBndFxK
         Dwxio1sYc0WAIj3dZ1ev+qHF59lzGVhWogg8Tz9f+w37Wc2WVg8a5iQfC87OuuV9UaAO
         XqU5xSmc3KNry05rxOIkG0MFYSYNMbOy4ko9FmtYo5knUDGcsH9k50T1nmmt40QUOF6L
         VIiIBT6GskYSjnECSgurUSplLSYG/DqIBITyOtXmYphDIyBf5a6VKjvjCzX8TwoFLAXP
         JzPg==
X-Gm-Message-State: AFq9FYJy0eO2QU0jS4NQh5widxhoPVNWDlwTy3ExldNhDSSPr0JWrmSE
	GLDG716gho2DXL+mUGAjTcX2ygexOyyoje3Bd5zXkavkbvWIDrBbFv3XaZ2ofWmy
X-Gm-Gg: AYBFou3tyrvnoiriv6D4zq3HHsjdUMcVm45b26YRk70iXSv7K7n5ok57aSRPzvktvLx
	WXl6CIcQmENtN1ucY3l59M4xOVL0v1YWbKo47KvaLyylVCZ0FyY2XVN4mAWN0owtefoY+QPhoS5
	FPbag8IyjW+4uxEH3ngCEvrucsW/wpyHOkNcBaEx4BgBg0pG66OhLYiTUiKSgneQHjws/tW9X4H
	3b4qJ29oq89jqKjkiE91tRUN4AWp6gCcV8Q7dSwl1uPapZAJRx7+iJoSt8hbAtrTDb3I0/cai0V
	J1fx+7V4y/WhwbCwNmlle9Cgbgeb38yuDquiL9h71UdFWPZqtG/q7TmbLLzDP3+6dw1AW0nCgGC
	0pQ+1OHI5LcS4xQDA0sk9BiAkl4hEeLyS+k9OTY/j8kCcJc2I0MizZtvD9+3vi5VoUEH0N6ir1M
	Hx56OZldhZIv06fi1mrqIAI3KavK04X75EJf5Et4dFc9MQ9VG+YrWbF+Daz7oQqmmOyBDRl4whs
	gLImLaxBpC/I1m0+koNhdlOZnlulptDRDpZRE/d7oatzG3wSOGakQ/IyP2wi3s=
X-Received: by 2002:a17:90b:17c9:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3adeafc4fddmr7013191a91.57.1793052160219;
        Mon, 26 Oct 2026 15:02:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.64.173.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm921599a91.17.2026.10.26.15.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:02:39 -0700 (PDT)
Message-ID: <6adfcdff.b57f1aaa.203a10.740a@mx.google.com>
Date: Mon, 26 Oct 2026 15:02:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8414245094767949462=="
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
To: linux-bluetooth@vger.kernel.org, ryanbrue.dev@gmail.com
Subject: RE: Bluetooth: btmtksdio: fix MT7663 setup next to the Wi-Fi function
In-Reply-To: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-1-121792305f72@gmail.com>
References: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-1-121792305f72@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8414245094767949462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194005/

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.70 seconds
CheckAllWarning               PASS      32.82 seconds
CheckSparse                   PASS      35.66 seconds
BuildKernel32                 PASS      28.78 seconds
CheckKernelLLVM               PASS      34.29 seconds
TestRunnerSetup               PASS      684.87 seconds
IncrementalBuild              PASS      29.06 seconds



https://github.com/bluez/bluetooth-next/pull/1003

---
Regards,
Linux Bluetooth


--===============8414245094767949462==--
