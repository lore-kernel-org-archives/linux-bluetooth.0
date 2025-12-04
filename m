Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9415274B23
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764884337; cv=none; b=mEbIRemP31pOpJUb5hu7yA8yiVzMUZYE+soFZKN8+Bb7KwnU26u/9kIqRPs11CxKh9EDorIKjAeSKJhTns+VjnPB4I1GtPMDGpLeOQHUfWjuS/vKQQloLNgCL+IyFrDA0T62DJVBrxbXH92FeKP+fKtJuR9uZLprtXIviJdB0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764884337; c=relaxed/simple;
	bh=TSfNxN2ynguPKkGiDPQsLgDVRLmhnGFPlUXau/gF1kE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ImdM7C1niBR7Zkp0IlTh3kxJdyfYbwp9fKcKyqjxEOc+auGiO/j6J0KN8zlKz/5VvghlweHAKN1Uody1ZVGbe7ssvgNBw6eRC/hbiiAkrIUDj1Egt4FbcuN9gqXabm9l+DEJt2CueaVvoiLdGMH+RHuDiQLuurBw9chyVitzlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ4onmEU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ4onmEU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953ad5517dso14623265ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Dec 2025 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764884335; x=1765489135; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bcrAi7isIHltqWKjrma1KjncRDWoUm8C5ocvM+iZANE=;
        b=PJ4onmEUH4pPHxEWl+vo5oha9v92afX+rpge2mnnaOQT2AQF9mgsuFANcOumXfXyHO
         sU0rX2KUeJ7H1kdLVY6MlYG3gJlCpyMzv5CBWJdwT8o8pHMBmUX6erFsB/6vPUXIcoKc
         fuSWh8dqed4R5D5S8TXzQFudKmEul8/2Q5E4NXcSAdpQBkqvOhXA/PciADXNQrHYPyCd
         YyE9B0cfZ8zHEjT95QhvHsBW7ADVeVbiL5SEbFLO1JbmiFFrkvdqyV2VrGIWP9RmuOEY
         hdKkA2IGjTNYFbP29SEtKEV113YhDFLuKOO+u+h7gftt1zc+v/7IXjEyaz2tU+7jiSvq
         llPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764884335; x=1765489135;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcrAi7isIHltqWKjrma1KjncRDWoUm8C5ocvM+iZANE=;
        b=NDB6yDu/gaNQLVi8RUEcCwwfj4l0ekgLMoEDLdf+nSvT20+d5tjkKBF/nomQw22HUj
         vO9ZVGKFGLJYZk1byflRhOlAADLryy4z0r4Ar3e+gsXOMILWlgi4984LtAjqj3Yat+mU
         9pCPzPpY1cSphuQvSfMa/KgSJHPhyMDJY358QfoxT9sIs9U0nbS1v9PFYpCSWbmfpT39
         W9SPChT64BnyYFAFqqDVHdmetk1l3CEzWPuFFLMSmnca7wPzUTLaH5CXNVYUjEoVV7t0
         uCEBg+phyJxQqCAfkSA7UvDgG8VUECPBg/U1C0o26CfHRVRdDnyyQ7kpDvG2dqIV5G8J
         Ss2A==
X-Gm-Message-State: AOJu0YwZ3xbYFUTFe6UBllqMfGDwumlAjVeXkdlrM3tu8eIShuZV+IFC
	bL4kanM4tNL01vS9+GbyvMSUTd0HM/UPpjnLGRC71PYp031IF2vMqMHNhBDMFg==
X-Gm-Gg: ASbGncv7WinLjZpvOJdzUaCVWigg5PYVlECELChFuTp5zFCQQ3pUnLif4RfI+Af1wxw
	PiLvqgKPiWENX2wtZA8ITJh1JX/5Tzp7BO8jn2wO7nq0AWo1obT2G9OAlUWNIas5sWnMAnMDXsZ
	kMclWYS5JKQFapaoWpwi7CEnE+caNQZMEQXyvfPpmT4j4+mOJy8aopuYwxbA4MOEcnhgJFSxDF6
	JTgJCgckTKOHevQ/1QsnqlI7t897cFJgEFBH/6TjqbjAQKyk83if6VVVHaAzjkTaQLiEBjJGyOR
	6EWcpzgzPgv3Wgl6YzYL3LxP8cw/kUfCKmE9bufoCeViTgrRLIhgj4Fh9imHha8LCV+vk+YuAHB
	LnEnezijDipNRRItAcmyH0pdniZtVxVauIZY7j//UsNvF20TtUP8CfXRBd2MqhXUBT3drxjRjCA
	aW/0EJ7Nysqic/zinVKaU=
X-Google-Smtp-Source: AGHT+IEthbnL+j4QzUMR811U40QO79b/wwgRs5JyoSabtcsEoBdAXZWb5N/MhNyRPxGuC4adr3m/xw==
X-Received: by 2002:a05:7022:628f:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-11df643c6e0mr3461115c88.9.1764884334597;
        Thu, 04 Dec 2025 13:38:54 -0800 (PST)
Received: from [172.17.0.2] ([172.182.195.185])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm11297044c88.4.2025.12.04.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:38:54 -0800 (PST)
Message-ID: <6931ff6e.050a0220.338a8d.725f@mx.google.com>
Date: Thu, 04 Dec 2025 13:38:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5332286159036421931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] main: fix bool vs. gboolean type in g_option_context_parse()
In-Reply-To: <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
References: <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5332286159036421931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1030592

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      654.14 seconds
MakeCheck                     PASS      22.06 seconds
MakeDistcheck                 PASS      252.50 seconds
CheckValgrind                 PASS      314.28 seconds
CheckSmatch                   PASS      365.87 seconds
bluezmakeextell               PASS      191.98 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1083.67 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5332286159036421931==--
