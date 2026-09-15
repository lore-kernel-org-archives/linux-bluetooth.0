Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FA3CC303
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457458; cv=none; b=HlJQ2bOuEuEAMd6GqqYShkvttq9M6YYOkTfXdZIBkFtQ/snatVnrvgxQpHJh7CDi/dxhrauSwen3nxqnmhA2i2GqlvtyvjxcOQ1pvThDuyUNyWn66HwU+UqpheydvKArOa8JxHflfgGMmNLyOv8ZLo2L5Ty6SxgPhnBZJaCE3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457458; c=relaxed/simple;
	bh=nzBAfO6JFyObPsszgH6rfnB0TQVQcSEDPL1Xs6Mtl8w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e8OEK/Suyi5kipEbQNly99cqNyrdAZ2nxP9GrZLb3aRpUx1zUwE43rsLy+305hUGFG2n+6uwCyS4XzBBF5waPS1jwyBQQ7R63dX59Gq1/qMWntdPldBBjFhfgJ4DyKN6mhPrQl1/d/Zq5XI88A7Z/7WGWkpGBSZz6goT1SIkFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWwcljkv; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWwcljkv"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso2800806a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789457454; x=1790062254; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=++GHyRLfKSItPk7INInMN239F4G4rEg1fmQvsC2RK3Q=;
        b=UWwcljkvHT/SlzXe40XF5dKUhwSjY0pGAnq7aWRSDo/5WHOGgHNFjWCzJPHDv0GJU6
         bR1h5/KTo0EZgfrMhvLrK9ZSzdHdJbOHlLsa/8jV55/qUgiDtKqK9K20KxaZ1g5KhFHR
         zeVQG9IN0efQSLFVGMJIrTg+EYAd9vxx3jAC6XP5KBnp3cyZ+aaEzSZq/kBAI5mL/90L
         dj4mgGMrt1e/nac8sKQ6xfXdD5SMrZetF5uadcHvpP8oHUBvCUpbjvs9U/nGflE+OeTb
         B6v6hLWryiraZcVdOpzESJdkoTRROzab38hUhLQaxN0d+W4IeGr+Ax1/UYTc7wBO9Mmi
         GZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789457454; x=1790062254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=++GHyRLfKSItPk7INInMN239F4G4rEg1fmQvsC2RK3Q=;
        b=tr4vkqJOoOqooy8rZMMYHJaxY8RMXNLhZZfbsg+VV52N/fIBpeEL5+NnjhPsS8721W
         D/gWyms5vRgiSgCnx9oF839GhceVxWCJdpXlMMQLogaVcgFDLSZ9evZKYLnJyQKnfaCv
         yJwdhc1ugfTC5M3oTkZh6IqreyKZoO3EhBJnDLN7yRPJmMxIYavKe4lsgCSn/clXzHu/
         Stqov2pNqCHWK3/1LNeQjAGb2b2zYZEzK5AM0k0QgI30W+9pVvyL+JilIOxoSLrWGzWv
         /RCtOq7HEU38f11++R6KidHHauwGIUoFOsoymJs44PhUTfsvYlQF9SxUv+ST8F/2Clbf
         le8w==
X-Gm-Message-State: AFuF++kWxyoIatMeVh67Kb9PsvM0JtqlIetlMcD3lo2qNPkMWYGc0KI/
	pQdqQfYnnloFm02Q63mpVxUdE3qKR/NDHqzuH+aPjJSPxKGq98h9mAYn7H1HbQ==
X-Gm-Gg: AYBFou2vGoLC3wl4j8/QOtinGU1mG1N8jPAu4Bo3fD/42NFkJugI4sLFHancCxrZOUh
	8Jfx9lkHE4aL0PTadiVsloKrQDY1a8Gl8A9aVwHOY72FAny1uYyuRJORa12iS4r41QOrDguwYQQ
	gvQwjSLKIaGnrUZxwhOrj0XqLdFoHTtbJghW5o71Ou87wCYe1S+4y7mYizl3NMCPNozxcp5FrMk
	DJFrKDBvgiIGX5hSHev3GvHDg7rDNih/2brDgLXB5xMQ3hD4+nwB4z/KfbfLcarCX81Yy+w7ArB
	Cz90FjBqdsVWqa8jJ77BbtwHhVAy8fvXH9FdB0xLOwmswoUK1HMHJR92J5WxerEp8amSGTkPwF5
	mljm72tFg00BLL8fuNX8gLUIkaWSnjuJRfOTXFjEbOGoQO5baqkGcAFQ5gJoR/O6yA7f13NWikc
	eFoJnsyxEKc8/ezinxPOrkm1D6F56OwMCl5AAOMygOwv4RB51IGzJNfuCxlw66XeIHkDCFqAabS
	yLZXQ==
X-Received: by 2002:a17:90a:d610:b0:39d:f06f:79be with SMTP id 98e67ed59e1d1-39df06f80c8mr12621488a91.15.1789457453682;
        Tue, 15 Sep 2026 00:30:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.150])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm28473942c88.8.2026.09.15.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:30:53 -0700 (PDT)
Message-ID: <6aa8f42d.7c5c4032.147fe4.8fce@mx.google.com>
Date: Tue, 15 Sep 2026 00:30:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4639994111022194240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: validate device-supplied DMA indices
In-Reply-To: <20260915051215.2691851-1-ravindra@intel.com>
References: <20260915051215.2691851-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4639994111022194240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165082/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.40 seconds
CheckAllWarning               PASS      33.55 seconds
CheckSparse                   PASS      35.80 seconds
BuildKernel32                 PASS      29.12 seconds
CheckKernelLLVM               PASS      34.83 seconds
TestRunnerSetup               PASS      768.66 seconds
IncrementalBuild              PASS      26.84 seconds



https://github.com/bluez/bluetooth-next/pull/769

---
Regards,
Linux Bluetooth


--===============4639994111022194240==--
