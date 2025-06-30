Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A028EC15
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297625; cv=none; b=VmkGL+p52R+3ZGZs5ySRKwqpnwAlaXA0v+9buS+IYmJjKDMCJ0kSzx4asOuOQbi4e305nVXdRtsh/FmC6zwPU41904eiDiPwDNUHGwVzN+lphsfSrW58Tc9K7Tc47s4s0zSOfd0yRzuutIxor62O0PP2U8h7nVWR6gQkIhp6Vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297625; c=relaxed/simple;
	bh=IJAN3VWEUXv4lAgIZK6YCtf+T0amS5Mi7c2fbViV+b4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qyQqrtIeZWYgG3cFPpCq2ZmSgoPrAU/KVwn31hPvQ0IzODkPKqnc0o7mhBov7C+8mFxuORMfC/eeiU7p6c2Fhe0b8SlUNlbqCWd4M6+wy5mq+LUOiDc+ROqmULHPipZebrCxBCO5Er5kVfWscesMqtGPG4Lz1PbOEMazEOErcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX700p26; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX700p26"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1125956a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297622; x=1751902422; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWtOjsMQDMgJrTSlcLGRYTXSNviUbk+2FqhdNd8hoLU=;
        b=DX700p26LysarQqlgPKbuUYjXSAW5Ec/RjZvUo2A3wYfAU1dPLd0MwGW0iHAXs4YYA
         hHbU5CrMFVdJdWbNvJhEXI/MZhhl3rqZ8pX1Cx05PM7LJYjgGPuyQmhYpHRJkHZzdtC5
         wnVcwrYqZyTkGgdqkMhygaWBcX/5EXOOXD1l8syre7sQ3lhN/DDEaCgPIfWCVRz6wSJM
         tOigfKJHPFyRVIBia8nG1axAMQDL18laCTC1Vy4toYlV/5UUnX2fh9GvZajtEeD4Y98n
         WdWx3eHBXsxgrqE4V7LwRqCSBIKpZMTOacg1PbvJHRmVjEOgPp0Uo3IQMiV2/iZrT0Nk
         FeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297622; x=1751902422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWtOjsMQDMgJrTSlcLGRYTXSNviUbk+2FqhdNd8hoLU=;
        b=OcKgy6Mh776hA0PzqrtSnN5IIvmFLt4sFgQqutkx+BbwVfphRAZwKiuy7m3ITQp9Qp
         r7dLRHXbfsUuGm38CbNJcTnzbUJpAd+l1h2S7H+A9Ailh9Q7hwn67VOa/50KzuFwRQe5
         /bO1tTEWGEYRYAvpsKAAkXFVVylSKcl23oBTKvaSCzqgOfbgG/amM+DeSXkwWGbkScPG
         roaD7Q5vfx0DzvMoRDjQzz/4uAQIwIhHn7ckymlVwoELURUrANWINnVq2gZJU2aGT/uG
         xO86mr6dyC40xRGeclHdq5LV+qqVlcCOGZj5OSZSIBMCFShhXOVlLtkOFuAUcRH0lMTI
         ob1w==
X-Gm-Message-State: AOJu0YwGISkQvvXdHsf0NfLt/tw+TJqB1bZ4DQrgltAL0s5HEbaFKEYM
	Vbq7+zN+FY0z5/gqaG+csQuqJsyb+2XUdj8RgOG5RVtsRA0ENQvIa5yJLWusTg==
X-Gm-Gg: ASbGnct2i76Fk3PNfQsVR5aD5gAZnA+/DAaGMjnCpvn7j9TM3MtyX/ftERyt22BrCPX
	gwcFcPWo5zR8fxbUB6S0p/1ytDxdehAZNEoQGEDx6EXfjFgFJriboWLaAWqI7yOIN/qyZA0O8bT
	yR7B7LUfnfZirZBZMcutOjjGsq/i0/OZRvSgQ6FH600p6/pdRzWgAlQEzX2Fjy+UE78uGsBqbFQ
	f3OOesCDtk7bVpHR8kM4Bpyl7Rr+/I3+i90RfMDTqNIC2PiDuHV8oIeez50idaMSodAH8bE3rtS
	2sE5ImWKIZ+3ARK8ST0q87co90yLLyOwraWr9uN4XH1+TIdrYI9P1qIUslUN0Mai/aAb
X-Google-Smtp-Source: AGHT+IErLKa5humrh/jsB7ascfkYRETaqmjxHPA2IbUFEKInzAUCwguzn7dwm8VruJvC4nnpd4jUNA==
X-Received: by 2002:a17:90b:1a8f:b0:311:c939:c848 with SMTP id 98e67ed59e1d1-318c8cd690dmr23611131a91.0.1751297621455;
        Mon, 30 Jun 2025 08:33:41 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.165.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f51d7913sm13330965a91.0.2025.06.30.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:33:41 -0700 (PDT)
Message-ID: <6862ae55.170a0220.1df64e.ff2e@mx.google.com>
Date: Mon, 30 Jun 2025 08:33:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3909538666183529750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaochengyi@uniontech.com
Subject: RE: obexd: reject to accept file when replying any error message
In-Reply-To: <20250630135421.740-1-zhaochengyi@uniontech.com>
References: <20250630135421.740-1-zhaochengyi@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3909538666183529750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977338

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2688.34 seconds
MakeCheck                     PASS      20.17 seconds
MakeDistcheck                 PASS      200.31 seconds
CheckValgrind                 PASS      278.28 seconds
CheckSmatch                   PASS      307.30 seconds
bluezmakeextell               PASS      129.02 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      918.25 seconds

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


--===============3909538666183529750==--
