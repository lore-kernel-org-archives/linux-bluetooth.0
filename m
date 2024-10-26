Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E638DD3
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729946303; cv=none; b=FtmyH/2Lo+fMT5eHpHXHH0c8kyRrYqdGyUsRi3L5ONvs3Y/hQRBy64M4CQsGyJn4+gjbU+8b6+eRCNScd/+aOYAMTXuuAcj5xxSRBZf+rXPxKx4vJLi3Unvs8xfmz9xBDVBqRu5qLhD8NyghIP48OZqyEos+C4jHnPcRJcEjHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729946303; c=relaxed/simple;
	bh=eCAUc2VTXr7TvcI0RwRLuNOzmb2JulUB4LJPlGP4K7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H2uHRDzQprsasJLoeQniLHdj9O4Ra8zp1xMMWfiRElqrSsxmWW2ERJ4aybTfbDpteEJbOWV3LsM/gvgyUQFzy3AnTkHTaAQAgnFyfIUijvgIn7JmTbqP4nORO9rrrfsbBc0aeCVfTdbP+f0bjVxyqPG/IWpjJKfYWgxEfwWWhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtvVyNBs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtvVyNBs"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1488fde46so205397485a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729946300; x=1730551100; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+0KIkhUQUleoLSxy4a8Ug4Ha3HKipX4QJNapu+jBw4=;
        b=OtvVyNBsdmBSsJfV+jgqLonNs6UhpzzGgTFR9jyqA1267T8V275MoOiTAkCcbwpPXi
         5vNdfDhpAZTx2sDqHxSh6kU0uNX4V3YIRgGAf2mEGfkm4olPLyxoO4oo7iFTuRJKPt3x
         94LdQJ7E6ow4khwHXxa+6LRO1O7tmHC/wDT3TwrVreio7UQQ3HyTKX9QCeCzlTVuB1Yt
         mr4If+SwzqVzSvVgZh+bIuT+ebE4rkvZ/hbG4ru5DKVjevKeelogGVFRGg28m1pClAyV
         XRvz2731wWk1HCixDdaxZJAxZLZkNZgZ+StOLTjD2DKmdSRpD7ynQ4QNSwmvvjARoECH
         dx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729946300; x=1730551100;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+0KIkhUQUleoLSxy4a8Ug4Ha3HKipX4QJNapu+jBw4=;
        b=ue4UZXGgUOITdP+O34c0Q5txrE6FN18uWrWzYt/V0Xykh0njyjyMiia7wVJiCquTuq
         87nPrrVjNNlnHXlD1xTN13uM/U1sF4xmjpPci5hOKioCdDm5xVnWFbZvPHK3UIp1K6BL
         9PPKAghRlM9r3bQaYsvfWWpKatGgj+c3z6kj2iKAi5lowQdf+Lw/Rw19EpnOqg8CAd9u
         xlyaXyY9zxNL2k+KPnXmAe/cj208F5ROez5/5YAqs37vO/9EYk9Apgue5ae7VWv7OAfw
         cDllrGJfngO8BdK6naYJjWd+cES5VCgsNoZGB/hkMGQhjXdDFOPk2VdsQcliugAuQtQN
         S9rg==
X-Gm-Message-State: AOJu0YwB9iFRpVLPMCL/D/dR2Q1EyxDEUQYXslQsXAmibei3QEVIEhcA
	vcI0ZLKlRYI/ZBmR5Mi0XEv1b+A9R9z4V/j5n2JzcICe6H00k+E6WCbJaA==
X-Google-Smtp-Source: AGHT+IFKqzaH7cTTec7EPG8psqBk1qR0EhhYKrOgcPSulojcvbdvru9Xk1eRMoCWJTuzL3vmPIKB/w==
X-Received: by 2002:a05:620a:31a2:b0:7a9:c964:b358 with SMTP id af79cd13be357-7b193ee16fbmr316021585a.6.1729946300488;
        Sat, 26 Oct 2024 05:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d343cefsm147550185a.106.2024.10.26.05.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:38:20 -0700 (PDT)
Message-ID: <671ce2bc.050a0220.f1919.4e62@mx.google.com>
Date: Sat, 26 Oct 2024 05:38:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6410243922116055921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: don't disconnect A2DP if canceling Acquire() with Release()
In-Reply-To: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
References: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6410243922116055921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903413

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1617.77 seconds
MakeCheck                     PASS      13.75 seconds
MakeDistcheck                 PASS      179.49 seconds
CheckValgrind                 PASS      251.77 seconds
CheckSmatch                   PASS      354.37 seconds
bluezmakeextell               PASS      120.08 seconds
IncrementalBuild              PASS      1441.58 seconds
ScanBuild                     PASS      1020.25 seconds



---
Regards,
Linux Bluetooth


--===============6410243922116055921==--
