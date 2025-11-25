Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231F30DD12
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066928; cv=none; b=VPrhIwmW4dytguxLlAQWA1ad+XvaTxC/stpcRI4r5yfxg4NZ/w0nScdWSEcbN0kmsh437vckZvnDhQdV87/cFRnx2Q6cSN4JkRk1Y/QZQkgYfGqEZi34ZPQUQAr1uW+WDtLJ1RVfOPun0TOBmKy2oegaEfrFWcLB4HbqhPDFlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066928; c=relaxed/simple;
	bh=zy1uqMtsdCHvFni22YwSNwz6tEkONHgZ4jLSrf8ld/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=onlVgrxtPw/0/ujHfaioWNWgnBjDde7pfumYffw4+vJlQttRG1+qUfU7Aoyft2dmQ94YuXiKEC610CsTQc5VzilMIvuMuQKKwOcrLv29NFZn509HjuXFkNAquteJuSmRbab0MD1tZTVOpQi8yWM60X1Rr3G2dItLrEmwrAiDzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtD4ZjVU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtD4ZjVU"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4336f8e97c3so21763535ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 02:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764066926; x=1764671726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfrnc42cBzIjuHKiCZijKhPAQlVNZTvaa22iNfuehBk=;
        b=gtD4ZjVUZ+jdPios8kJrJKLrUSeYUeZy1VlrE2ZGYXGlyobjJxNVdQoEVFCFLo93C4
         h1z4W7T509Fvf+lUlHd1qYMRNRJcj56yNwfKUIOgJFLTEUzImMnuV3fmYnnHzH7DNTAc
         MfajWqpJXrvjgalBps7LALIRK/AZ5KpWyybpXhDsD03TCNs969D9Tr87l1YDQrwIC915
         yfZm8VxPa/xDHwZC1YV/pG1VxSPws9bkG4JV+vNl2ZYMGnw+dx0DDFFnR8UYlHBe0uOw
         gVeXnCEb4igAIwlKpXLx3txmmqIJVoKPDVWOj6+DscN110/qIiYeYfKKhLCOaaFFKxll
         SlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066926; x=1764671726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfrnc42cBzIjuHKiCZijKhPAQlVNZTvaa22iNfuehBk=;
        b=mxRTi9Si+SiLI8fKYzGKMEJtTNX57tMhRDA8UM6sFMMaCer/6hH3HbkwkIKp40kqF9
         7L6GwiUvtyT6T09QfRmr3HyHVj6bgWAhMd+02k0JisvDWP2CMWX8Rqkh/FC6xeZu3Q3r
         yvfEdIayvzAsC7ARwoU61jtsrMdwvLEwYEHxUuyObh0gsYzz+fdLw7n+xx6244zK7UmQ
         MLaGWfZCcSHPLTrA2myWBRpzs7cltLawDV1zY6MKbAdegk9hj7o1zFtW+FYCqUhde9Ia
         +W14QdPUNSJOurS8jY39QhNGwv6SbvMaHwXyGDl5fKe62ZzofJ5xjdfmjXU+hC5T9rwB
         wTPg==
X-Gm-Message-State: AOJu0YyIagFZNLWzzAsoNeS6DydqHsx/VuldGPe0/fG74942ZuWeEySa
	NF8tVsZ4KA/HylKetqM0V6+bTvqkc20rIXZZsN9nJVw3ql9F0gUlzYmn0c7biw==
X-Gm-Gg: ASbGncs6im2vy5uHlidg8gqH0lQNGwu7SFfbi+SvFcRtHDpYGx8GJ/aFVm9lF/2ls52
	9EsfeMq5DjTsCEy5I6C/2feVzqIjvUoJVLYkpfWyEfRKSycQwZoR4wy35chvrJDIcPISiW1f9C7
	SYVelJbEf7C1clbw0Cl5Lfb3icZ7QVbc5k/48kA4Cyrv6b3wjif6tphavEwCY90DDPfpN6urrLA
	xtNg2ZLkiVuvgittUeOxqoa4HzmJgJ4Ig7PxF3K2vYyj15oGhggC2S8F28djZRLOW16QAcZGDZo
	npyLrFZmxOCuE2tlfVF6tKpJRACFuhN7YHihJvr5F+Owz4M3bcBFhgExcOU+bIHc1DL2J+49spP
	Hzzrg57IXLixHBzy5M09SfnHmwg7ben/BWJ1+A9SJF46DPUKUlgDr+EuI7WSe/k4PfoCRo0YAqC
	JH87I=
X-Google-Smtp-Source: AGHT+IFPCpe5YfWGi9ylaxPlRaFB0YU37oDMexTfb8UcOB1L9h+KsY1yXU4ZSUK/8RuHRA6E8OetDA==
X-Received: by 2002:a92:c26f:0:b0:434:96ea:ff79 with SMTP id e9e14a558f8ab-435b8e6eacdmr142924575ab.33.1764066925647;
        Tue, 25 Nov 2025 02:35:25 -0800 (PST)
Received: from [172.17.0.2] ([52.176.138.178])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a905e4bdsm72685865ab.12.2025.11.25.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:35:25 -0800 (PST)
Message-ID: <6925866d.050a0220.336289.c23f@mx.google.com>
Date: Tue, 25 Nov 2025 02:35:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6622534550446401187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.samburskiy@omp.ru
Subject: RE: obexd: Fix transfer status change
In-Reply-To: <20251125093835.17472-2-k.samburskiy@omp.ru>
References: <20251125093835.17472-2-k.samburskiy@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6622534550446401187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1027279

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      630.43 seconds
MakeCheck                     PASS      21.64 seconds
MakeDistcheck                 PASS      238.55 seconds
CheckValgrind                 PASS      294.69 seconds
CheckSmatch                   PASS      342.73 seconds
bluezmakeextell               PASS      181.58 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      973.81 seconds

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


--===============6622534550446401187==--
