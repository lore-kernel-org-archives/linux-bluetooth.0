Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDCB332ECA
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858723; cv=none; b=qQ7a3GpCgSqLw2QMcoEYyVp+DX0od1tguXvvchHlVsrOa4kWXxszdD9IX08icxUNfo6kHj4ck0il8tvFpPpLl/B6QI1alf0ayvlVyajVJa8cTHpYDSysL/QDm4DFRaasj8KMshVljcmZgG8PA7E6+W1eVql38482TUGXJ6A+Cx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858723; c=relaxed/simple;
	bh=lkUARFstihTZQg95A+fC3J8ZgHseAlEEcY2pH6SuUrw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h7//eIlM1VMGaz87h9bDD64c+2earbMiX2n0jzfAI6dHpFzy7bx3GEsPBgmyp6ZCLQ8EWFkA1G9GRKVLpmihkOedEa4VmYaA/pf3qZiLhcRKGeM1yElz5cG0rKy9oDhgVvSdBFWrKZ628mQjTCgaOoeEM4Q8bcWKJdo4b/Ovo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewi0NG+n; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewi0NG+n"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430d098121cso6839625ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761858719; x=1762463519; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciAjkUqodTN3KMLavUTDaeSWg8QZDjdGH0DWgEKNDqA=;
        b=Ewi0NG+nedziIQPIUpMZ9E/hKtw15psmN8SAKNjY3iS+MYtoyUyJSS4ZCX3HrgRLbi
         531XxhZlpP9OrDzEuB8OaP2fR8HNbq8xvNGAZy3Duy5tJ6LieGGauK9sORKwjjrHpYzH
         WcW0sluikUyqM/9Osd/ySQlt3/L0VeokyWhWUAuzjwlsRZWqVF6o8D2YaBwUPD2WPUQU
         M3OEnosA950yW0TR55gpzREWj625DauDgPEJ1Qi7Djzk0n06GAW3womOv5fjV7W0msfn
         PSOtXpW+5mbI+yQcfiEjq2xE/KD9UyspyRVvzSFkOtYrpQYCEKT6kaKgcfjhUim+plWH
         ytRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858719; x=1762463519;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciAjkUqodTN3KMLavUTDaeSWg8QZDjdGH0DWgEKNDqA=;
        b=GFxnRn8bkJEfdQG/BaaouGeG8KszxRhHCmMrHq53UBLTAxT5KKjP+Tg9z+GPWkJlYO
         erI7gl0XwQCx9tBBCu+7DfVCgNG1TDrgwsKvvCesAhtM3u+j2Xf2NEdUkYgahuypb7E6
         yJ7M1HYOe/GWOBgsWfJucp/KZEwDaOozlDZqz/0XhEaWAJbGeSBrw8x8lEJ1tXzq4TBq
         2U2yOfMj7b50QaYukR7PY2DTJPCCv2rD545QBiBBeP7Skle/Tx127Joys4z5wrv3GAnr
         s2h65HWIUX9NujTdSdujpU9hF77yn6NMNmDimo6Uo01OqmDO/ZLav+6nBfOtbM+ygKRj
         kQJQ==
X-Gm-Message-State: AOJu0YxZDwM4baTx0+A7zHcCs90S8NTfaULI/k69jmshByGzKK3LOOSr
	ZoWJWbzLYKisN4ZbdKslv4Al0uK7PNSKZDJjJ9b+iLl/78ECGs/163D+xuvwyw==
X-Gm-Gg: ASbGncuYTSVc3H4wKEqZedklllNu7hix0lUlcjjvASE4Z2J60uX8jBWFipO+fM2rfsL
	qW/HGSaXAGzcLwJvQVKW1T96R1/dwCi2rPs17XCfoQp3Fw2CU13Kii08UYsLM2WuSGqGSXdCXAc
	FR0ZhRRYJPMc9As39/OUTQKtXHL3c2wm5XtlAjWKx+nQoIQra2mf1852L9NUWALN4F7JBypz451
	HRFRoIGQo7NNm0OA7T1meHBhqhW6oN4Zf4ehNuxhtH/xkWLpQwQ86L3RaDDatHHHaMehKpXxH7T
	lsWptLpqgIkDmglv+fHf98R4wa7QCNBl9u03v8SJodoKuR+rrU4R6sb/zO38K+oqboWKantnlqF
	d5MDDqoYFz4SdHhPe3fPDYyNMb0+9FvWtC1TOtn82XpkgLr07xMd0sVbZFadn6xlCG3WKahj0B2
	jF2MZoIIqd
X-Google-Smtp-Source: AGHT+IGvXzQlK3q4nSffdvK7ZNpGRIjSYvUItnuHzSeyjx6RUauF8HRCIa//pML+Fni5hnW3k/mYgg==
X-Received: by 2002:a05:6e02:168d:b0:430:a38c:b767 with SMTP id e9e14a558f8ab-4330d2074e9mr21663585ab.18.1761858719348;
        Thu, 30 Oct 2025 14:11:59 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.116])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d2besm7076388173.48.2025.10.30.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:11:58 -0700 (PDT)
Message-ID: <6903d49e.050a0220.c95ea.c208@mx.google.com>
Date: Thu, 30 Oct 2025 14:11:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1909040073002246083=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] monitor: Add decoding support for LL Extended Feature Set
In-Reply-To: <20251030194856.296603-1-luiz.dentz@gmail.com>
References: <20251030194856.296603-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1909040073002246083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017886

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2783.35 seconds
MakeCheck                     PASS      19.98 seconds
MakeDistcheck                 PASS      194.56 seconds
CheckValgrind                 PASS      247.71 seconds
CheckSmatch                   WARNING   314.08 seconds
bluezmakeextell               PASS      127.90 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      906.71 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1909040073002246083==--
