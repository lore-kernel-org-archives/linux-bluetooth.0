Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556391;
	b=AQzYH32UTSPJTQK3vgvZlR/jgGXPW93TgX0Ph/EOiOPItAYWoeF6Qmc6n6qKB2qaL/pv
	 ACZ3GY7/FzemCW9HwB2qQ3BcXRjMrFSWSCG7sQL0TgGSKAUE3fihYHBxFlWWE9uxNlaFI
	 OV2oPKDBum3TSygwQMq+FwZeRVXVKnpCZzEw9Lku4oCttN6kXNv7C4YmsH/I/VqkJbxaN
	 vQt1pJOKdvt9YBpyvw4NObSvBk2wNG5TwkKN6pEEEjs0ppN08rR0L9/12ANbyVs7JAz8Y
	 f0+tD7DCyxywEl6HNxrAVeHEYtJmb6VtAW+I8/kIza/HI8Sfg8j3vTErqsNlhQ/BbhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rKcmQzY1fFIxxd0rv2/hcSDo+t2xkRoDyf5sL0oMV1k=;
	b=uxM0ROrj2QRk/DHgqGeILASHdsVewi7q5DQrUl5TtuSqLG9/Z10SiMiuLvn7ucxk2usH
	 Q/lKBzwxZOrVBs9y2ragl+526UR9QYw8oxGFboSKxiUB5XGAi1DsoGObmp+i71Do6iXqM
	 WjlECgIX6FcW1xf2h1vc+knAtOrGaxnMqPLyl6ruGHb3zp4CHCd1z8Yebv5Pj19+hacmM
	 s5vb0uNzAdXjWBiRNubOdUVVr1PUMvRN/gH66j1Qj2V39Ts2amLazf+ud7K0PsOAXqbH3
	 5DaaEIUK/P/Sf9JuVFxGMiOH/j4OmLevNq5ClUVkhIB+TZM2sr/iNVQUpYwL4gcnFYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbNIEeB9;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A8606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2A8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbNIEeB9
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so5670332c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556390; x=1796161190; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rKcmQzY1fFIxxd0rv2/hcSDo+t2xkRoDyf5sL0oMV1k=;
        b=hbNIEeB9/wCJR3mMpbnOp4e0RA3fSlbk878/z69fPVMysMSD2k773DJ9JpbouEPI+j
         S/Mg3DPKAqK+P2ft6O9Ylz9B7rTegeCZvnOsTpsr2TO0yEozpCdNBAv2rbEg3C6mUJ7C
         xzWNtGMVyypgbWtE9F1PJdV4NugH/VDusS1Tw9H0zCe40VlqNmdN/NOHu5r5/ERNk/p0
         NYQiUodDwrFZzbITEO6RgcZCMy6hTqE0Jp29COaLhORWIdns87MkXCwAeqQyGwlLwSHs
         4dV02kd8XI61kjJxMP+FCjgfmJACpx3MIs5owjUc7Sh232p3sipn2FVi0+UicsUydIyT
         gJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556390; x=1796161190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rKcmQzY1fFIxxd0rv2/hcSDo+t2xkRoDyf5sL0oMV1k=;
        b=AUIePYpvcCpLyYsynZSMp8pJi+n/1kSdx2dIs+sG8gPhJ5evrCKDt1bSdv0W7KpP9m
         pzI4ll3SLYBmAtUvFxofQ97n8bOwVKMPq7cFvVicEFzSTxs4w37n6whW7tIZoY9D3m9k
         6GziEgkbemdcy1kz+jqVNrA2WubLZnVVzbHVZmWfR3FdT1InRXM9cZnqjfB/diPt63il
         X2NBuzZ1QIYXCriJjbVVUboZkyi0Z7WmbejKsyR01wy0zF4YN0obKvwiCpAxn5pl7sBu
         Do8I3X7YBktXMesjuHxJbunYAGojMsgqKRSeldU2YZ+0K4uEoTFqRVumR1CO2lOdiY/K
         Brng==
X-Gm-Message-State: APuU4Z8EI9xztHBPaJkz4bLUYzBfJdehKyd1w93G8+boO6auOLtsZ8ne
	p9xh+WPrAl2DQd3ys0gZ5uvmo3BBMMBI9CVXXmoVguJKZxv+QXG4srPFd8k+KA==
X-Gm-Gg: AZFdTZdWXDfRr1plwhHN51mg52WeQN+dd8z4WPNCwmu5yjdMLsiExI5IPbkQGhQVaT6
	Q6ZU3qxPB5UVPHAycP59lnl+97sb9QZcj135g3+PALMsjpdiG51a7i7NtW/skOyo/KaOHtAT2AR
	n5hbv6tkjL6q437X6LlmpSrWrbP7+eLoFTKmAimEF00VHfTHyFYVNyg4Fz/2slm0znkH9F8LQTx
	u5UfpFvNesS03XM2I0EAQ2iJD+U8zuDExF1jyDCtcxww7UESwXw4RBxLvLY4Iy5D1nFTX15xIUB
	QY8QU0e3LvdG63zYwFFjvfrEovHADxcXkbjLkh3R7Hdco9z8JK6psC+N76HWT03I6QepY4g89ZQ
	TD+5LabyLz+Ysqwz9lcZomd4kIHJ6qI2zAwe39jF6JDLSAsuzhVhfKKDpzPWdnMmgYnE98RVhUu
	6qBsXxbLcHcdbaw0dtmTqLh2LqvSLR0pCf7rU/hzfcNuVRpfFPHSnl8Mi+P1M95eot8jwW7omKs
	D2lO0pYe0tYj3i+416smCmNP/48ug9dphoPDiu5NOUj8Be4H1Pwy2BKNK4Fiw==
X-Received: by 2002:a05:701a:ccdd:20b0:1b5:5699:6703 with SMTP id a92af1059eb24-1b5569968c8mr17463918c88.17.1795556390398;
        Tue, 24 Nov 2026 13:39:50 -0800 (PST)
Received: from [172.17.0.2] ([134.33.81.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm25905381c88.4.2026.11.24.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:39:49 -0800 (PST)
Message-ID: <6b060425.a99d0424.24609b.3a61@mx.google.com>
Date: Tue, 24 Nov 2026 13:39:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5024768010380568485=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add tests for security of deferred setup
In-Reply-To: <20261124205102.737384-2-luiz.dentz@gmail.com>
References: <20261124205102.737384-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5024768010380568485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221285/

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       PASS      1.12 seconds
BuildEll                      PASS      16.99 seconds
BluezMake                     PASS      231.88 seconds
CheckSmatch                   WARNING   236.64 seconds
bluezmakeextell               PASS      76.45 seconds
TestFunctional                PASS      1015.00 seconds
IncrementalBuild              PASS      268.99 seconds
ScanBuild                     PASS      845.44 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:713:28: warning: Variable length array is used.emulator/bthost.c:714:32: warning: Variable length array is used.emulator/bthost.c:967:28: warning: Variable length array is used.emulator/bthost.c:1001:28: warning: Variable length array is used.emulator/bthost.c:1002:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2913

---
Regards,
Linux Bluetooth


--===============5024768010380568485==--
