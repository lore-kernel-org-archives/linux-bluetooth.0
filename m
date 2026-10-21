Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617744;
	b=N7J2flTmfprcUn856/bf/E7XMM6XXxdmXUTUW8cjPaDCTJHD4GnQwAfKb55yO+8e24OQ
	 KGWQ9L3UIJgI0UlMolsbo5KNlAR8tlixX4XVgPdXd1acxgZYKfxz9yMsy4m783K3rfTnY
	 Y6BmYKG+aiIrnj1n7YiGL6SgLj3Odlk+J0i+x8ch2877SxqWZw42oCeG70u012QkZeqF6
	 mRt2c+n0kKNdVbRjyg6zWrtWh2el8/vZ52OirkMZFJHrl7X+zrIakIDJuFaXDmPEpjhON
	 fq/3csOpL12K5+rhR1onaALYTmypZJlySQkfnGWwzFRyQ4KHCeCQnfsm0ygB7dhWCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Q6t3/ycfI+xBRkgB6ADMCXDXBoZ9byfEXw6mF48QB3k=;
	b=i/a26Fpt+v/aI4A2Z5lgek12lHzaoL4bk8nXEDjmYoiRCyDWya8vBIXl5yhuy5utKIfU
	 aZQ8dCoNQvl12u4JbofbanjP+TNYzT1rBKzPjfThR+JjpIKKb5RiAixrXTWIoaTaEszbL
	 FVTj1LM4oBNzovXnOrChYaCdgUBCfebBn9p1MIEXglPRhcN3r4sO6ZeNaSuRrFiII4vjs
	 Xu5MiUBGmVIdeZ6yMwFHOcgh+H/ClIJuxv4fbdshWf4V8MRloR8OsKsWfIvVjwDmbcLpQ
	 saA5s7tGMy2XTMHZ16ZKH+Jjto2YBfeJ09k56zCA/enFB3zHk5Y63OFztfW0FDT+O5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lypUEYAL;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BA606A319
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 21:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489BA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lypUEYAL
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2067664eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617743; x=1793222543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q6t3/ycfI+xBRkgB6ADMCXDXBoZ9byfEXw6mF48QB3k=;
        b=lypUEYALNf4MQGdO8ZmhS1m2dBs6KPnGsMRHXbNB47cyftwzhMSVrClS8hmdK9c63y
         bG1KnOplHtlrC5Z510prAn5ctpY4QO3yM0Lvwx/WptYv75U7noLLKBQ7N58WJNd445PI
         jeSxkPLYlZaJBizuNjF5fMzjgt1wR773pZ9B63XqbY0tI55LpoJauw5x2RgCCctyRwp8
         cxK35urNY6REKVfl0qeM8WeLMeG3Me1lkTxlzxMg1ZY2OBzdgaMn2HoV5I6FMXVkkI28
         u931nsDqKc+lTsXxMVuVCbOM9lUHGg6nsI830X8An/Z9x+hp/kKroxHcKVGuowbM2O+i
         IJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617743; x=1793222543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q6t3/ycfI+xBRkgB6ADMCXDXBoZ9byfEXw6mF48QB3k=;
        b=Hod0DM23VEjLWwjVKjIz26mUTAFPKEWof+5w1sbFWJwBp/vmG2/wJ8dfbJriW9KKWG
         tnP4VvLshUJCZDVhenzXgus8++M1A6eo22PHQVB7jrEPYEwKDybwHUWQXQNDt/BlT401
         OvlQoRgH0mOmg/UE1vT8jn6avjNe0n9jWBUDVYYOXUyX5Bn+X7klr28WfO3iBKzK4qrL
         BPXLfMReenkkdQjpvwIgibbXtR1HiRdDH5byWUTXZyK8fbzNubI6rZiAYKwoeHBpePzu
         xQBHkh3VZZzz52Sq/SAMFqMeHF2qgwxFU9ibOIng+HrSTBjqbZ8kjYKuyIUooQUdx7zF
         HJzA==
X-Gm-Message-State: AFq9FYIKcsh9YS5H+ihleJwpMMO6/rXIKWpuyA9eo2Bk8HNpY98aS3hr
	T+PZ6d0ShTfKPHdS1pRIwydK1JkEK+W25eVW6a+nE3x5aallpaRUVjMg/6LGo5rS
X-Gm-Gg: AYBFou1ct7VrGm5hwGN5hJZLtxscRs+90F5v69TXvigFUrCrTb2eZ389QLmjLQGzk2S
	X4dPd72weh5IlTP16tyVfH/8zjqZasRcK+XpKi2ZF/yalAh+NRxfqtoA42eE3dz9dAsmSH3zTpd
	if13OCwa03h+Kldfwaf+P6LpFI1OnTyt7yIVheAcnlZPpYTZTVg1LF6S62oMb3pZW2VKbFI0NTI
	dM12ToLcgeVSJQqO3mN4OWKHa5oIJL0q3zTyCy/mDqVCVFLwZDOMblD2IedjPUVoU+37I6F5Iim
	76uACAGEUw5DfunbEuboXoFYocOs/xwm5AmLoTxll225ETs1qcKPSLEMq5gzJ46k2B3uQdWROmP
	bVL3AVhESmqTEs4VcJovNnSNfDkispAZ8NhAL1HflbD3WHJ8hsl+heEEo0aX1YmbcpAzE4PYo8k
	uGhl+ho0Q06c8WNYC5QWqRTKcnGj37e+ilCh6296ghkYQFzAQxHcajkH89fmKgoTprbedCT12zU
	eh5gt4xNmkOkCglLg1I82gY5MkjZjWQTgFftra+7z5aPBf/kFWtc6lKJwtsrA==
X-Received: by 2002:a05:7301:4549:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-3674e163199mr4067338eec.28.1792617743349;
        Wed, 21 Oct 2026 14:22:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.21.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368b4b8e9c6sm1547941eec.1.2026.10.21.14.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:22:22 -0700 (PDT)
Message-ID: <6ad92d0e.a8e1b8b4.1f803b.6f9d@mx.google.com>
Date: Wed, 21 Oct 2026 14:22:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1455236622908359359=="
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
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: Bluetooth: qca: Fix the WCN3950 NVM baud rate offset
In-Reply-To: <20261021195112.41138-1-me@michaelmcallister.org>
References: <20261021195112.41138-1-me@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1455236622908359359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190806/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.29 seconds
CheckAllWarning               PASS      23.92 seconds
CheckSparse                   PASS      26.61 seconds
BuildKernel32                 PASS      22.23 seconds
CheckKernelLLVM               PASS      23.01 seconds
TestRunnerSetup               PASS      464.33 seconds
IncrementalBuild              PASS      20.55 seconds



https://github.com/bluez/bluetooth-next/pull/975

---
Regards,
Linux Bluetooth


--===============1455236622908359359==--
