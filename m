Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCF37A487
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674537; cv=none; b=BkqGCSpnLc3c9+pvd/LvNymWYDOgHJJKH/H2m7E6ocY86NipPPX5fhkBJdSyviJ49+ZUewCmj1Mv1pdUpIVoGzdF60orA3gl3u6isgP4pwC3poK5PllL2WW/q1vQo8ObZ7EGA4C76ICUzqf4EQtDhzxEMOCXI41b5/+wt9cqVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674537; c=relaxed/simple;
	bh=sisehN/4QuCzbsWzmoxiZc6cHoTne3AjNCp5iGNXN5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G9a+Okh+JLEHtJm8seYRUcUWawVqoegz2FMt4NinZzRSg0o5W5L+OVc7y1caWzKYT9ty9nmBumRdMOZzr4q9dyIb6wTQq84lc2oAzXyZQgKI1FUGVIjKVKl4Kz+iV3osjmmOYO4sX7qDGbd5x+5cd3GaNF0uvw5a9JUZC9pt2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxvFfpmd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxvFfpmd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad4170e8eso7412335ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674535; x=1784279335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IeNz5AGj+UIBvkfXtae5juJ2MCvtLuGuxzoWMGcxCuI=;
        b=YxvFfpmdsZTJZnE+Rh0V7Uf4Uz+K+Hw3gWnUqpIuZjTPt6jRbNzySZ9tVBf9uGoKxo
         lNewiZWHwz49dPFl23bjmocLm8XiAo2GxD6TpNr+ZIZPjP/ac6XlLsjgLbXeV6vbSj4x
         mrtuQZaRLiEbZ5r1ahrDTFuA2lemrJqWhoTn2qVETYTgnCszG/51tRqixvy0SY2HC0Lu
         QMwdtxtqrwJ1qU07CRcwerkmVQq9dFas7bX1k2Y59eAFHn+/xUayRDFVAzT0t0+WPPnh
         LGAOOtZ5xH5iEV8kNSpQaZI/2bplYW5aDPr1u+1BoDIiUp+g9o4lO141GdZl4hu0g/GH
         gVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674535; x=1784279335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeNz5AGj+UIBvkfXtae5juJ2MCvtLuGuxzoWMGcxCuI=;
        b=IFU1Qhp2sVHbqj6tkO3svK90Sr//rNhq6gkVlfemuf3Spdl+z+uuQT0eKDlDIb8Hab
         uL+PwQfLzgilK1ylwT9+LWTeaWXS1KKPcBX5l3N2eTp3B2GuKGzZpCwbrrYKE0dXJ5+h
         8UXP/IqHo2S0DiVjOzm5BsMKo8EFS8+XQFkWQlNkiuwXyRVpFv+NEsyxorxgV/tBzmg7
         i562LLkNNvWHqeHcq515VJT+3Y1sra+e99ZMnPThxl3fLVx44avVWSDyIot4uWPCrJFa
         dYrVPTJE48nIq+JH/Dg1kWH8De0e9RJavCZ5Om6x4Pix0YkaYcbVTfaROljy1hLwuUZV
         X0IQ==
X-Gm-Message-State: AOJu0Yzr8xErL5cvkWCUm09K1t+dnbkfWASaBAD1jmghOqlyKJt8yWoF
	yV464MHm3tb4odEk3W+sUsTv5bluT2lgUdeAoUgnuxhSA/B1Dpi2b9THSOGFDQ==
X-Gm-Gg: AfdE7clfumbecP8tuKP4jq1d2J3ypNhtsSmy0WZxXdKARiJWbGWazNqRw0SdNhAqkh4
	3LC+n3viiQz88DpjCqCDPTbVMeiYp6X3auFwaz+kBYnEPdVAUkiz1Mf1nz2Ret/hVRkfmCl+wBd
	Pq04G/tio7EtU/QV3sUTdgzWB6E5o+k4Kv8uUR2ILNvNqGT8gEhSq7eohTSEZ18NK9nkYUOLwTV
	CnuFOEdYRV8GIWy9j+XE88knY4utGL5aHNeDBUe/ogh9Mtxb+EWmlsLHxWp83lxT8mHP2K4+5E6
	WebhfENabvuWu1W+x/1vhngH8KZYj5ps/6R4yKE4vryPJ+ZK7EGTjssaVgFQ1CugguqhYGrdJm7
	WTQpKRE5PHfKE1Rw9E4cnS2z3Wf2zk3ZxnrXpAOjjwZG4EKRn9jldEM6RJ8QDEeMVoFL7AtE9+Q
	ReO0PB6iI+ZFBE5Aat9Ozr
X-Received: by 2002:a05:6a20:4322:b0:3c0:b55a:8103 with SMTP id adf61e73a8af0-3c0bcec16e6mr11327896637.20.1783674535266;
        Fri, 10 Jul 2026 02:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.100.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm37068716eec.18.2026.07.10.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:08:54 -0700 (PDT)
Message-ID: <6a50b6a6.eb165e5c.1817a5.91c0@mx.google.com>
Date: Fri, 10 Jul 2026 02:08:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1586085087619762358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [BlueZ] a2dp: Fix loading of remote SEP from cache
In-Reply-To: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
References: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1586085087619762358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125195

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      15.16 seconds
BluezMake                     PASS      369.21 seconds
MakeCheck                     PASS      3.33 seconds
MakeDistcheck                 PASS      119.51 seconds
CheckValgrind                 PASS      116.85 seconds
CheckSmatch                   PASS      204.82 seconds
bluezmakeextell               PASS      73.59 seconds
IncrementalBuild              PASS      372.53 seconds
ScanBuild                     PASS      644.20 seconds



https://github.com/bluez/bluez/pull/2290

---
Regards,
Linux Bluetooth


--===============1586085087619762358==--
