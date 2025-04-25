Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53F219A86
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607007; cv=none; b=A2E1Qbe30R+a9VsFvMb9KBNEPFzWRuXD34lo2lt+ByOvbwf65Np2rms21pfXj4bcukNRO1WzA/RBm6TbtqnWaAoDiMZEPaVQ6YLg2f+VasvEEEgnW4V3QydjnbxWfg1+ClBvxH067OW52AKzd/uYU0uAZ1GYR6GQoDvxBO0HfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607007; c=relaxed/simple;
	bh=AgVI4ldhP9+4VgQfMMz3XmFX2+UfKfjIqyMK8NEMVdo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fY2i4zPzb2+Y8uMvTp2cZ+Z1W2iDTZ6ODMj/2IFezxW4U106IZ4V2NpItdFVvLfjKNT5CiSEtd4dJoc2ELeLFV3ZjaquTfKPKrxH0jJG8qvWrQKHjjL0vPAPw7Pt7ZlSdJjqTsmTdFVfdq2XYX/eSVcFUzEweMufm5P4sVnWXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePXF284t; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePXF284t"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c081915cf3so398954085a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745607005; x=1746211805; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aFwVsWTJXNk3SzvhTUAHHkcEWkSwg/zS3/wGqs1mSgU=;
        b=ePXF284tjoe3nU/y4WcR5x+aS13IH8/05HcEeWm7TNC54W/kiRlrCXFDNl0fEtJ/em
         1Zi/T/okKn5EyIiKO7BgD0C5iA2VC5Nhia1RCiRMZqeTXJxIB7qYglM39qgtoq/rHVvd
         KDPMDU3Pbh/5TlxN3W1JgeRa//uVNfU9WSgWNUoLb1t6NQmwGL/sQg3iEaA4FURoF0e2
         xR79CSgPSQ3dyxd4HkF4aRE0EOMjPy66y/cEEVfZElzPHiukcA1jwFDdv7w+JhpbStGN
         JW5hhIddD8BhW7cu2iKGhPB8pjO+XjhLOidCCt/AnXakCBM3G8MW3jvjr1fabVxhp9ZW
         X79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745607005; x=1746211805;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFwVsWTJXNk3SzvhTUAHHkcEWkSwg/zS3/wGqs1mSgU=;
        b=ghNvmarIr/yM/SAOJruK58GDcJLdaClztqlYuhfHl4/EuexuJVRVrCGuy//btNb0Kt
         db87M8SSMQblDuh2gwxO9zkvWS5Pq5mTbic/wLzJ6lLxPw68OGcw3fRuvUUwRZPGhfC7
         +T+l/Gwq5hpz1p8Z85L3uTw2ydYknftgIvDXcbNYZkBoCg0q1AwfgNgZN9vC9pU47cct
         CRGM55I/+MQE1WC119G4aGfxflhnQLTnRAmz4k/hZH83ZEuA+u/VPuadhEPli8/rFc2I
         GIdWzJMjkitZC0nfaO743W0jfDP6u0e5o0k5ee4Oj89Qgedrw5TEqdkMFDR9zrqJMUqt
         0OYQ==
X-Gm-Message-State: AOJu0YzNY1CaQq0wH3IrY6C/elprVH5w1XMANBcAhxYRGhAhwF7+20ep
	3L1Gr3nFREXDwvm+SGDXvBc+0DoeR2TuQ6Z03kIAtUz73KIchmvybV7+4w==
X-Gm-Gg: ASbGncuXDXjhjGalsxbaTiQT5bK9BUgrik9UDtPuvIwitw8M7cnoRPKU0SE15JSc1Y5
	iu7vz00xX/YhBqEJqXQe/ZThnKg4SBRX/7WjyN60RShDEgDiy3JkvAGD3dc24RkhzrzGV4eX5fJ
	RTudKo4HxbuzkofRxyF8Asapj+o8xZkvb54f2aCuKkwrTUv0pEAiBfqdc8As4d0eOvVUpQMCk8W
	BHs/vkg7VVLzNA22ETyFtGh6IlULjqfQDwy3UP4SSabDsfcbv7l64BPY0x7Te/6eQUo7y2y2ii6
	+9d7BMTj2b9vpG/PZYG3peVsG5cafWynaAGrBtuGdulyRw==
X-Google-Smtp-Source: AGHT+IEdT4ADK3s2FwhYzxS4fiadekjiLqcEc7TYE7CDosZFsNhse9KxCTOo6dX+ZzFejZuBJ4HyFg==
X-Received: by 2002:a05:620a:8010:b0:7c7:b5dc:2e36 with SMTP id af79cd13be357-7c96686f7e4mr110642185a.18.1745607004520;
        Fri, 25 Apr 2025 11:50:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e9fdaesm250257785a.95.2025.04.25.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:50:03 -0700 (PDT)
Message-ID: <680bd95b.050a0220.1a9da2.f97a@mx.google.com>
Date: Fri, 25 Apr 2025 11:50:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0958523305002769318=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: obexd: unregister profiles when the user is inactive
In-Reply-To: <20250425171505.573271-2-kernel.org@pileofstuff.org>
References: <20250425171505.573271-2-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0958523305002769318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957129

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.80 seconds
BluezMake                     PASS      2817.24 seconds
MakeCheck                     PASS      20.61 seconds
MakeDistcheck                 PASS      205.37 seconds
CheckValgrind                 PASS      282.66 seconds
CheckSmatch                   PASS      310.44 seconds
bluezmakeextell               PASS      131.19 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      933.51 seconds

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


--===============0958523305002769318==--
