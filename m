Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319192;
	b=WzFBcpoYtoeB/pHTXCl9pJVpBZh6XVci9aAWf4cyGZQ5urmh2KsbJOQAocHsP1swWl9F
	 qxzu3eSwC08O15Hf8yRjk18cw5ZHrfcd1yfUi+3lVhjqJEY94hr1zBauUlDb8p4o/O9lM
	 H7/AoRnBHIgIQ0cL3Djg+dcbTYGIwHxcjgcbtp5h9HAjMPaUN2X2UjWXNKm7lbllBt14P
	 E+SrmBi8g5Pxo8dtiBmqyECiZaiRbhMgBOtdN5bOil9vDKAmvjv/EJ2+2w35ecHO6ALg5
	 EUCWvWr506WBGoMJ5O3vCOR6QL2DheIj7d4n6a37plre4JUPhmHmbfOskz6sVp55yFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=C3cKsS3oON6v75/Ekv6voPdxg7Qs8tMvR45d4pE8VzY=;
	b=ggIyFeW6aHeBPTlonrnDULgtt+lM+FIIydXNUX+qAKvzgDrrnT0O8YwclREsNYrpxsW3
	 UwIH9NTN+vXNy8vREwQcazBP6CqK/lezWM3euJDfNMarnTTwnaMFcJDKdkvd/D6GmUfnb
	 nqidkGMhQRoIrOaUVb/fWyoTvTaKweFJ82ofpkmEd524CmOdQFDnt6UHNjN63iy1MucsZ
	 WLFhv7kXpq6QW3yd7613aQg96AyNPEYauG6qnye+3KpQkD4YhjXhCa7WS/MQ4uJX5p8Zw
	 z13tOKD1BqBF98dYHEzna7BDq2JN1q4fdjQhsxZzZHziku9oj9amtHduk+LyPkalEsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LK3U9DDe;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA054606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 00:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA054606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LK3U9DDe
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6df7f544919so87914eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 17:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793319191; x=1793923991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C3cKsS3oON6v75/Ekv6voPdxg7Qs8tMvR45d4pE8VzY=;
        b=LK3U9DDeAsY1hqWUymLPNHmNQdJF49S5YS2on5FhGzIbq19Rw0vrdVOPgyNSdD+uXV
         J9WO1Sh6Vmts6uWV4S35CjVm+EchhzHZ2wEo+gO1oOQHvAmJ8ABbytE7tvZgYYzTlOw+
         XqOcYmtn5VlroSJZ0Ho5vFbNQ/XCX+enpFfjbNsh9RwM1eJ1/nhZmubfwtO4hxc2Yocp
         aUCoFc1iC330033b+48+Ou8+Z/9cCG6dRvHNi6vhIbYP6TsGKjJ4tACqM2Xye0iy9DmH
         qaT3EYpGYNm3MyCtZF5apcVPuXLA4AzyR60ZFDRWwJOGKNRv/zeh19iB64Vgt4KtXpIl
         AHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319191; x=1793923991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C3cKsS3oON6v75/Ekv6voPdxg7Qs8tMvR45d4pE8VzY=;
        b=kc/8krseOws/4OLJBTTReBN+w6k9XjRUcFSM/6shZ+MNI66hov2VDMOxJj3XNNbqN3
         kcLUHUw5OhROPF7Yy0A4C3mQJrbOri16v0tZJstKE/kq6IqgmVOdlaLTUOiVparOX/za
         5ZHxBItrDVwmM39hWfdNuOGYF/PY3xofsqU5rKm4hUmmbElVbHo4bbJlyPaP5bJuN3FI
         M3Ua5Xm239o9ddHbpiYSplPmA+z1BbLMx0yq47HvItJ6aGClOAGSY2Z2Gl8jVngqxKRC
         aV0hRuGgOx1B6P8xDK2au3769/Hpqq3YpkZvh1IhoP/uoZeTWEAdhrQaC7WNwB1e8+9G
         P2+w==
X-Gm-Message-State: AFq9FYIqIK/kvSLecuXWuQX5mzuLKwQsZ9LTa58t2dxeHHSK/WTvwzvV
	XPSvzKA+5rv1am7G6gVXU+dI6SYr1zlJ5vWZN4C+SLGEe6gvygBRNrDCagrpVfLc
X-Gm-Gg: AYBFou0T2atXFC4EfsWfOx9W4WRu/2JR+7F7A7tXU3nAvqMziQcURh4/NKiMPolt9y0
	9ppgI8m+Ob7dbNx9qxGldkdWUdClYUuQLMaH+dOg22u1we7SFH9xls05waJm5txXl0RbRcfsKtR
	cnvOspy8oOmhYVh5e3pAIXEBOD+EbunY/8kjRty47NiyflzPAQY5YH8/Kiz2f8uD9oYkExo4lKC
	HPtzcwJCavs0Gzxbcx0D0Wyn6Y1OF5WS5ZbjVWc5wGS4PD/NUrp2CSm/zcdYJwwC279t1OIEDvY
	5sXkEO0pTs/Y43JTYbb9MuryW4YVMKT6BLFcjEdvioXBCUPNRW3nWwRdFBnU42STd81pZw5uC/1
	z7b/+MBZwlWAkcFiRVpCtahk9hmBbZ/kqMrpR+l0dc/WQPCosdTsoOnTvNxxW6NEP/fNE1Fi2ic
	at9arHkBPAx022mZncXEkVnGDd1mmdGHF5iIsVx50KfCxzGjAcjf0WRF1Eb9UfNHetgr4mThFhR
	KpSGi3UyswXN+kaskhT3f8R5viP4aE3w11zYCoYHNXhwdzpwNV/0qJwnMYA
X-Received: by 2002:a05:6820:81e:b0:70a:c89b:d141 with SMTP id 006d021491bc7-714f2421568mr674847eaf.7.1793319190637;
        Thu, 29 Oct 2026 17:13:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.38.56])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e3c910sm615069eaf.9.2026.10.29.17.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:13:10 -0700 (PDT)
Message-ID: <6ae3e116.b25cc878.8030c.8fcd@mx.google.com>
Date: Thu, 29 Oct 2026 17:13:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4608639070965085499=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bluetooth: MGMT: Clear disabled connection parameters when loading none
In-Reply-To: <20261029202832.35354-1-kevin@simpleble.org>
References: <20261029202832.35354-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4608639070965085499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196594/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.88 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      20.74 seconds
CheckAllWarning               PASS      22.82 seconds
CheckSparse                   PASS      25.29 seconds
BuildKernel32                 PASS      27.67 seconds
CheckKernelLLVM               PASS      21.46 seconds
TestRunnerSetup               PASS      466.36 seconds
TestRunner_mgmt-tester        PASS      82.60 seconds
TestRunner_mesh-tester        PASS      9.94 seconds
IncrementalBuild              PASS      22.36 seconds



https://github.com/bluez/bluetooth-next/pull/1025

---
Regards,
Linux Bluetooth


--===============4608639070965085499==--
