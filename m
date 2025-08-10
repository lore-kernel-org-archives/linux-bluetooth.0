Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEE22541F
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830790; cv=none; b=XHypBo8qiVP+CWd72223Du/xDdSK2FttdOitJH2zzA1GQGjozzczBpYyS6XgPpql0uYU8dr2Sy17gbiUuYOLD7UWhHrnqWnbuoomyhADUuhunlRL9t8OkN1CtDl0JJFk/jd+13IwHswC6ep9ti8AkKxBGY9OPyI4l1N+ZQrntws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830790; c=relaxed/simple;
	bh=8AIUzqQv9WNU8QpMobo/EEqIE91XXuWB8g7iFtEhIC0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QeI97Kc4Fp8jk8XqbmfXtzzjoZMExj5PBeJBWzVE7UjBYthJtpSQGLXd4qOWfdZch8LeqgNsKyGpFk5FUfP7dqLz9EdXy9m9NJQJmE5ueZLPCuvy1UmoDmcGnPSHQKUfk75V+Fd4oLYePGQOExhF3eEJ0X6KOaX7I76qDAp9H3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI3HSkvD; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI3HSkvD"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e545880582so7621135ab.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830787; x=1755435587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d4PyvpKKbsfcUxHgnsvYh2XlS1ITtw29wlyq7TPBWk0=;
        b=KI3HSkvDAYooC3YTWrI+xStjRcTdFgl8BRMdUIEsmhG9RH2Ba7zNW9OqtaCLy1kegP
         MXpAeYDPylK6Q71CZYhaYYW8IPxdebbv3VzTZB/6GnuZYceE32CnKfgKAT+yVRUAJs54
         nPQS6TGfqB9ZKTZ8hM8i96McuUUMnWDrJ3y9M8Fbx244oVZc8gWBmkPYnSzplQkY62Ej
         oiDUsJCJmkve0Dbedg8heDrHWaP+4VVKQnbe7T1vAdXe/Pn5utYcFrTG9kH3g/EGHDZG
         9i0ZePzWcY+JFfdntRslO19YVLuI9YqBvOjfJh55npGMdA8LNf2fMy7cXrj9HP4T1Omf
         +Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830787; x=1755435587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4PyvpKKbsfcUxHgnsvYh2XlS1ITtw29wlyq7TPBWk0=;
        b=ey6Ncu5Jj5H4+wVzRk+YRn8NRhNtG3x/lBBo4ntElZxIR78HRtfZcFZCJdgJIbfzuc
         Ysi6ESstPGR4YuECrQfMcZWDpmOkPJpa+3VHY3H0WXc2ekMgs1XZKmNkXCnZduDuH4Uf
         fge/MkjtJiT6sch4KEm1HHhTc70DYCHBIxZwKfdoG8s2sgp7HBaFShO2jxS4O5DJ7Ujr
         PEzJHVnjbULQjTYDAUHM1nXstX7w6ALocVlSMvpQGxL1KSZI1xB3gZkYFoaD+934IVzj
         4AOw5gfNhXEliC4z535MZHhTJe0HcF1UfkH1gkEdS1btxXAqUIte7YsP+62vezUR0FKk
         0oIA==
X-Gm-Message-State: AOJu0YyEQcOuDXYPfOqg3aZjYnihp1p+Qgm6UMgpAlhFdJkIC8JNkEG6
	Ub70iF1oSDWWf8iNhm1+OJkc0zeTwCMlOZHrwFH9H4cCNu1jo0US6HFRMmH+Gw==
X-Gm-Gg: ASbGncvDgwXPAzrYkq5MOPeLAtiekK9opcRnHHYHoYz6+es+uHFIlh5m4j0rleV5wlb
	PnG7Xn7VgK+AXIXZjkNpQ0HD5Ypcs1VS2wdhc0KehIKLa3FbLMdb6Gk2z/ltBEqQ/PCV185sD6F
	aQvofMf6cxeazL2QzhVX+wo8A9/ae1qeEbKmOpmMUjNYLs79ETTxFd6e03pnBgHbsKdQpcwtvhA
	SLHQYlBUdoKs/fb7BMAKgkM9n1XOURhP6emdOX5cplfpY0LgN6mN5aY2k7cA9z5CohisHgaTfED
	WX+jZ8G1PV5TFHjZa3Q3EGuiWwJ7vDGD1rChBwHtwtDQnDIxAspJn+p0+Z+kTB1nygtEPV3xyyl
	laY3LOnHhsUgxh4YxrCR/OZD0D4v3eQ==
X-Google-Smtp-Source: AGHT+IEHpbSQ5t971DXaR51DFA+sBa8A1H/9klVoqFAR6t+qUPfBRlsIEznRbbIvXM2RGGtMrT50Vw==
X-Received: by 2002:a05:6e02:154c:b0:3e5:126a:d9e2 with SMTP id e9e14a558f8ab-3e533196f99mr173500505ab.15.1754830787524;
        Sun, 10 Aug 2025 05:59:47 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.32])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd329csm1622282173.66.2025.08.10.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:59:46 -0700 (PDT)
Message-ID: <689897c2.050a0220.3b63cf.2862@mx.google.com>
Date: Sun, 10 Aug 2025 05:59:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2723855193685113221=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: remove bap_update_cigs callback properly whan data is freed
In-Reply-To: <36b28eff897f6dda6872ce26a13ddc571a7e5ec2.1754821407.git.pav@iki.fi>
References: <36b28eff897f6dda6872ce26a13ddc571a7e5ec2.1754821407.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2723855193685113221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989695

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      19.89 seconds
BluezMake                     PASS      2576.49 seconds
MakeCheck                     PASS      20.48 seconds
MakeDistcheck                 PASS      183.41 seconds
CheckValgrind                 PASS      234.51 seconds
CheckSmatch                   PASS      303.54 seconds
bluezmakeextell               PASS      127.00 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      903.11 seconds

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


--===============2723855193685113221==--
