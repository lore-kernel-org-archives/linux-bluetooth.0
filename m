Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46A1D7E4A
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301049; cv=none; b=nk0i703T1k+HIaiapitMRp2Po2ViNlbRA+averDVajZl2R+HqaTfxSoenZaHjW2Cw8WYyJs1TQPjM5SZ/rgfuzbdlWwIYWK7jPrM4PRUAafA/eI615/QVw21KdMynOYYFw7jp2UEU7SkQMnvEPQKqKl+H6POkEcmA7UiSgdOXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301049; c=relaxed/simple;
	bh=M44nxH+9uUZnxFA+j6EJ9dq6dBZityFp8hT0pbNWDBc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uXiSvw1Zs1BTV87dOh7o1Y5ahzlapxiufGo1t4oydCEUe/k/uVfh4JqkFBAbebhV8AQKSo5Uw5rx9ZALHDhhJiQhB/MvYXlBwQLkRlcU9IK0XLq8WlQC/an/0CWxix9YB3JFkxgp5oGJQuYBbnZUUxZJd4jJKkO9FRhw/SMFesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf2+lGmp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf2+lGmp"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab6b3e8386so3024271cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753301046; x=1753905846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj7DgCDDA6ryefCF59hErgp/vUFa2+vrR/4CJ6JexWo=;
        b=bf2+lGmpl7E4RIhHbadUcPYGi+iVyCIMNNFt+EwB8/RP7sZ+8osqEUCi0uqQEoqGOd
         g/Zj3VZ9k26hbhUm5w/iQkkqWecgylniOnIjoIPS2JSjHk5/rXU2kgUxBaiVx3fddvkh
         75byFoRxThbRGJFKo9Epf6ESRMlFGkmIiKId1B2GFDdKztvHrVJSO+J9KwrVJOOmbPJB
         pC55pe/KaUypOSRaQ7rGG5kl3c+UR23wSP+7AQ/BFlUxQjuFTuhFiwf+b1A4JdaIPs2O
         Zea0U2OdwBfXSfpYn80/x9QOsD1nikpr1jedcIG+vKX3VgVZVzbg+neYNyfReAcC9V2W
         u82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753301046; x=1753905846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj7DgCDDA6ryefCF59hErgp/vUFa2+vrR/4CJ6JexWo=;
        b=WQ4+VMG8AyrzVpgGa6jt4tQ0W8Ox4RGhezGV5GWccpubyKb5/qoKc23CsVX6L3WJt8
         wY80/pWDruM7SbdCbn+ue/KJM4omEKctID9yTFuGZDfJFspxD+Zt4xpcYfS35Vx2tIuK
         wic6Pxl31ayZRn/vXmn9nJrwgmj0lZNRN0c8VKKwaTku/MsWjFJUT5wRabeDqaxTk+Vh
         UohXdsHoY4+Chzjr1Sw1lDX1E5u+q2vx2ktMORMcmYwrJMvnJM4+pCjwZk2gC9/zL2A1
         +63XJGZdOsJMc4+e3ZS5yFm4TBsDZ/U9sCc9OJ3geMxwD+JTh1TuBW22iuVlIf0Yb9VD
         eaGw==
X-Gm-Message-State: AOJu0YyGLHpGfd8GpKH/AtXt/VZDleeZ9euGSBZHohT1xs3uv15ihYz/
	NxdzS5wffTVrd7oqcOL9qsMwNW9MVjzjlPlwrWbpEhFltmbWbRacLZrGVYjeNA==
X-Gm-Gg: ASbGncsBKvxoqoUI9QfSK+NCY82yjYAO5U71OFXEuk2OS2tL6u+d0G2sKs59zZIQvRG
	LWx6ZpPmGLUzHM7Kjz0Cev7St42GhPjhDSis09n55y1qACgN6VK/GquSPMw6QZVnLWBuH07GX3m
	DHygLZ4jiYV9GbieW+/Ix6rINKWv73zcawFaM4T/PgHAy6WWuAypULictgUT/MJw8u3qwx7a0MK
	BqlFq+J/7RACLK3y1h1C/wE5YkYzkMeULivR23F3JP0K0IUWosadICauaS0kw9CSBJhgz49eGu/
	wlqhDuL3jlwf79kgLtq1N4Tzykwn0MYG9Vk+kLMwRfZbZn2OJAptQhmK9Te4D3fYgC22et9ihjz
	2E7YyLksoKEoSmWAgnqFz8gnJww==
X-Google-Smtp-Source: AGHT+IG96U6IzKSb4+vG+iEtPXx4cBj9vJMJYVaCBECQkZgW0Cr+s4cMvm45vnpV1zlcU++k2KRDHQ==
X-Received: by 2002:a05:622a:164a:b0:4ab:5813:e8d with SMTP id d75a77b69052e-4ae6df38c1cmr64786521cf.32.1753301046270;
        Wed, 23 Jul 2025 13:04:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4af1e84sm72225861cf.48.2025.07.23.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:04:05 -0700 (PDT)
Message-ID: <68814035.c80a0220.2d1dcc.a44d@mx.google.com>
Date: Wed, 23 Jul 2025 13:04:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0723827744440273564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] bthost: fragment when sending ISO packets
In-Reply-To: <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
References: <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0723827744440273564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985227

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.77 seconds
BluezMake                     PASS      2595.69 seconds
MakeCheck                     PASS      20.45 seconds
MakeDistcheck                 PASS      184.68 seconds
CheckValgrind                 PASS      234.71 seconds
CheckSmatch                   WARNING   307.26 seconds
bluezmakeextell               PASS      127.60 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      914.16 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:678:28: warning: Variable length array is used.emulator/bthost.c:679:32: warning: Variable length array is used.emulator/bthost.c:896:28: warning: Variable length array is used.emulator/bthost.c:930:28: warning: Variable length array is used.emulator/bthost.c:931:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0723827744440273564==--
