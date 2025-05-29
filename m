Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF311DA5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542282; cv=none; b=Hy6sB09/Pyp3upUhEsUHc8ruWWY0TICIIcf+rREJYcE/0JWzLkRZk1LSiFdiyAylc9RJvtbTo4oURAy/1uY98EcUBUdzQjqlgp7nSoXhWrmL+A3auzK1ShzbQQGBkp/SWYqIWmjqYHAkxEXpRSuwHM2M44qOEDhLgEdDKBCWtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542282; c=relaxed/simple;
	bh=yQyroM7bDf9W29goO0yAyQDhNTa6hzDEZBs+0SMDkig=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kWenOI56F4ByUWMxBxCtwY/X20wdXRds+XBHPATJNzwlnlruRyiScaZfafUNAwzwOb0FzHvzdeCWRc/5oVQR99Dybar6PARawCZ51P5vC8Gbb8Yj0fBRGVKKeknEW/jhuTvROuQq8pFuP8SjHgugtdHXBE04p18/5VTfp5+FxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWCftuwv; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWCftuwv"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-861d7a09c88so33792339f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748542278; x=1749147078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAe1ExuEVyUfh62qgrak4Ufd8D1xhO2G0EjY92G+TPw=;
        b=TWCftuwvdzDgJU0Jmk18z8DlcfY8m3IHeaukZs2eFmM5sRKcURvrrrP8FGwILL1TWN
         yIrUAVp+3fjBXVBVn5Y3qWBDIiUHl2e7gQ9CbkTxGZdmNWnexioy9qka0HSKAxWWjPGN
         vUmOj3ert5syx44FioEI8YecG0rdUGzF9AbY9GMm1JheuLNIuCr2E/u7gxrQPZ5eXogj
         RyhHZkc0SlZ20gPreDhTCPa3FrZq6fbUJGfEkmoeOqq0hCUeCVNujmVczVly9HogYLFB
         ZOAEgaqn7Yb6v5pjzceCgeFMfCrFCoiqFTiVnlrY9X0/D1hwIsV97RfyEt7IA9RUDzgl
         /jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748542278; x=1749147078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAe1ExuEVyUfh62qgrak4Ufd8D1xhO2G0EjY92G+TPw=;
        b=Fiy7MGqK/ckhJ0ZOvc66r02u+NovLfhpvBte6oeZYgFbl6QSQHS6CqKoaj6nZREntr
         xM+L6rVWqg5Y0YIJ0Rz3KCHQm9orBcelCBekn3FgSquUwsmpTnm14Q8dMX7W/mX7o7p9
         tohWVwXU1nd0r4G+QOBEq43ugVjoMi4PUlPGKvC8Hx3kMupKB1zUKluhcMoiIwHULaB7
         j/z2y8/NeByK+rV1RB+lEISQNNTGzld77kB5TMinPcCrJkJoAyjreN+q56xxF8qkDBNH
         fhyseIzfE/si5yi5MJIxNj4NzK+5CUxkO6eSfKpN71JgUWyjFrqufGUwtqaIl3iZmXmU
         /vsQ==
X-Gm-Message-State: AOJu0YyDzbMvZXWFp8s33xGTDn86NLdXdFXp+BmAdXi1GAleDmxUZQ69
	EkTMDuDh0j34um9jkvfd+3FdjFaNdCZ9kQq4IKtowUpK0OWGaU0BE1iVCPJcT4Fx
X-Gm-Gg: ASbGncuANLbWnurS84dtRiIpPPZh8RNvKotVSdX2rWqtNSmEvPa4xzQWJEKp1cRrFnL
	RQSgwaj+AY2n/EvI36gRc9UJLVqea498zOScdwO0Rr7mAvEq1TaymGX+QiuTQNtvBLT9MoxbqtQ
	dgxV2r12loZg7s3GiDBCJ13ME8ZJovFIMqxCwouP27O/admC9PuiOmf7tLgUYNjAqM80X+Ou5HD
	J9FTzuWdPYO4UOoUdcRV7Mxg0BN4a4hUHjU2z8KLiyeAL2QIovRzfJyAr6TeNb67Q03uz+KDjJ4
	akz3Io77e7HV9NnzgCcp8ILexVz1W1rKcpKuKl1hU4uG4onQyAWUUwADIQ==
X-Google-Smtp-Source: AGHT+IECbskGPx5ezjGsTQoAOea1V6VH/nlenAEgCeqbLX6zrv5kb16pw5O41lY5kVlPwl570Rb35w==
X-Received: by 2002:a5e:8706:0:b0:86d:5f:d9a2 with SMTP id ca18e2360f4ac-86d005fda34mr75730839f.0.1748542278270;
        Thu, 29 May 2025 11:11:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.203.103])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86cf5e516c1sm36335139f.9.2025.05.29.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 11:11:16 -0700 (PDT)
Message-ID: <6838a344.6b0a0220.6c2eb.152a@mx.google.com>
Date: Thu, 29 May 2025 11:11:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5559678883393141691=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix not using SID from BT_BASS_ADD_SRC
In-Reply-To: <20250529164256.188167-1-luiz.dentz@gmail.com>
References: <20250529164256.188167-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5559678883393141691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967384

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2749.32 seconds
MakeCheck                     PASS      19.91 seconds
MakeDistcheck                 PASS      197.87 seconds
CheckValgrind                 PASS      275.66 seconds
CheckSmatch                   PASS      300.76 seconds
bluezmakeextell               PASS      127.93 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      906.97 seconds

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


--===============5559678883393141691==--
