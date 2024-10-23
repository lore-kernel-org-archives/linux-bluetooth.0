Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE315B0E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674440; cv=none; b=ka0UeiMUTSCUXzpf9EIby09fTbCh9BVjOFoBD5uMEUipdKiIInlhDIiFx4k4rRz6wj5hgK9G6w74bBzQY29yt7IIrKZAogqGWEpA02RvDidgE/1UQfz3NVgkmqCufoCJRMKnVdcRM2ISwPgZ4d7ZsPREy8JMoVzukNCfTP4mQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674440; c=relaxed/simple;
	bh=SmtsVCg9IjRDpZcZaRwUE/r6HQIMLIuL6C7WMggonYQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kj8OYfRN2ZwwyI22geGDEh6PRsDxkM5F5bM6Xe+gJ7WsO/tpAnizvbh7ERRuUuYMeI8aAzlNuUDhuL63/1RYI3ubvo1LNVCUECFFD6nMg8jP2UkmZ9Hxn/ydUSGBMlKFJtsjBwmmEriLaDVjvzJrlPQ9oIYMxJVQ8fnmkIPMWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOG7mtjW; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOG7mtjW"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50d487a93a5so1719634e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729674438; x=1730279238; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WcSm6QMmV3XU2K1Z7I1YE4Spkqen2C2ho7hPKs53YaY=;
        b=fOG7mtjWWIcm0DmC3DHYGEA7DEDo/WLGGnXjJ/Lvl0JatlY3hAoOgFJxb6iBjBX/pJ
         b0vnbRo3ooJnORL/yLwxwZcoidTkoBxiByynnND1ezTsRUxCHm+5O4W4oyji/D/j1lCi
         QZ8fFXyu0hKxEwjAX5aEDX4BxjKjrRUNnIrjYvW0OcwOhaCCPXEZj1OSd4cwynwrEAgL
         X1y6wgJadizNzvRKguLNtMixHhaeT/OnL+7fsuDyaHk+qAKEnJaTg92Rfcf85pII1OGx
         NkwdxMu0/wqr7KEnsn+qYA/WKr0h6Fm6pueuzjo7QbGvCksJpTUOEsteueoQuG0RN1ZN
         PwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674438; x=1730279238;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcSm6QMmV3XU2K1Z7I1YE4Spkqen2C2ho7hPKs53YaY=;
        b=D5QS2vgL4400ERmrSX8OApDsYm0Alj3Tt/2mJFeAt++EUu7qPb/+Q1lKitMGxyZ8CO
         yGjcKeuuFCF2vEttrTS+ZD5ZjuO3r8nEFZGVIO7YGbfRsggB6V8jAL4aaOC+QBr9RNLb
         X79J/3EOHXiw3tpFB5e8rPlh3WNMuk88YIfc2h1u+CLCmIHHpNUms7G4h8oyDye0T8OR
         PL53BQcPKnTR2waeJ/JWroToJRsmKp87iuK+j8Qz9ULTjuo+tUZmOrSHYGOdJ8Mn8cOv
         RjXqZA8VI+wFHNwUMZSgPNUE12dIdM/aWnc+jH0gDChdQmexvcj9FS5v7Tg8VOFne80V
         XULA==
X-Gm-Message-State: AOJu0YxVwbliZVB5zibEbDe/Y0cgl20M/s0s+GmoFfxE+BrtAv8qDuCW
	0tMWTT+gjRYu8BB4PATMX3KtTqdFlcVM0eKrKD5sAYOgjBCNGUYExp3qsA==
X-Google-Smtp-Source: AGHT+IHsctcf7IHUQlTguPHNKtZDspu3DHv83QmKt1zkx8sFMqR+F2gjzk8ZPtYVu9QbYVTlcTXRbw==
X-Received: by 2002:a05:6122:ca5:b0:50d:4b8d:6745 with SMTP id 71dfb90a1353d-50fcfc02587mr1867570e0c.0.1729674437973;
        Wed, 23 Oct 2024 02:07:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a89c96sm362917885a.131.2024.10.23.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:07:17 -0700 (PDT)
Message-ID: <6718bcc5.050a0220.11b088.b698@mx.google.com>
Date: Wed, 23 Oct 2024 02:07:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2877115578957117243=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v3] obex: Resolve SRM issue for PTS testcases
In-Reply-To: <20241023071448.1017724-1-quic_amisjain@quicinc.com>
References: <20241023071448.1017724-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2877115578957117243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=902082

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      25.08 seconds
BluezMake                     PASS      1744.67 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      184.33 seconds
CheckValgrind                 PASS      256.52 seconds
CheckSmatch                   PASS      359.90 seconds
bluezmakeextell               PASS      121.76 seconds
IncrementalBuild              PASS      1491.25 seconds
ScanBuild                     PASS      1054.75 seconds



---
Regards,
Linux Bluetooth


--===============2877115578957117243==--
