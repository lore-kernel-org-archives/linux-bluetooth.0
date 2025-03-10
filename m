Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6022A4E3
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613267; cv=none; b=mtydEimlacUHSctWr+P7qI3sw9hugB+LDu9umLioME/3jRGRZ4AP6KLuYxNJ0Ol4NiIBQTDK6XQBcDufA2MvKbsUFnFl6KC0neDLfxZCDiOClsk/xbIGn0Z5cgSpTz5gi0O/wKYii62BnYuiWMj+6oQqC9GIVeNDW1Ubnalq9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613267; c=relaxed/simple;
	bh=5hvEPM/n7/iielGHdV3EhWj8qaoCZC/7paGMknraOkY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iz3AoD/0BozlsB2AEHb13F/Y7Hlvmkm7SPyKkG1SpDw3OXndimdYlszraDtjg0aW0PYLDpq1etK1qayeyuAD9lvb9Ym+5B1COreJjgGFqrvX4Wrp9NITb5aCuyPbRY+SCzn8TNaZEPMstUGxUwHET6/PYcNzicMh9dwdD93Ovxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/EsULqv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/EsULqv"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e904f53151so20140836d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741613264; x=1742218064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6M96EzmIVQR81M0yF731qZy7B0HTUYereg8sLTEqNk8=;
        b=O/EsULqvVmRgg/ZSd7j3k7zaUT6pyb+Q0lhWAfyj/CTJ6hagymX4CTKDL2F4W9K5G2
         TQS9ARG7YAjkqFS3VFC+nuQJbrzKanwvsT+zLWcC1HrjSXivOz1hGCwsi5JCnsYxR3Mk
         LTFeW+6/91mlLnFYyAyssO8nYukBMXmrq8RABSVhfcUp4plJuN9nTlZmJZ+3nn0QdNjq
         Qr7ey4nkSc5qciypotlvn1jnYO6sfdrCQ3fE7VYFSjuN2Beus+kQheU/UGl3yMz+PR/T
         et9YUHzYTjJk8fk7C9uicsLcQTqpwI7VczMSn0Uk9CmQ99s042SxUz3tT/uZIxlZALbg
         o5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613264; x=1742218064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M96EzmIVQR81M0yF731qZy7B0HTUYereg8sLTEqNk8=;
        b=UVwU3AkijfBaaUUhWyDtS2zYV7zjgdMHbRTNm0KCBBRO812mPMw1ByqHzuck3ROWGn
         Ab0ZXPXqXohhZbmgBKM0XZNWV5oe/u8AU7TfonJq4Pxuh1IIvoeUPRLJXfoFfnruJntN
         ThvqMY6Q/cx9dmpuoF4NU9+fXtG71jTV2MXWB187wm43D6QzTxEhhMEfhcqWEkdFkJWb
         nlJO6Q3Z/90NPImb31p6dKUwECsfU3GENLjhlrv6wCAhVMWF28r7NXAEXy7KIRrfEnkG
         7vOZJMANHN0BupxVsedi1DyqNHW+JUvHy1c8GEAc1ZoTeko3Kya34ix2uRnb8t4E9NF1
         l+yg==
X-Gm-Message-State: AOJu0YxfBodPZNZcqPQ9BBHvX94tK8u84AaupK619r3y8skf/GB+o8Dc
	7A0nOrAwGJzI7ZitcZMoEmCCnOO6dxm4idaeccYvWV4VFuQlqSA2iif5Zg==
X-Gm-Gg: ASbGncty8UUtmY7tFMjP3r7Awr05Hh1pREpefTwQjTXA3x3DPtY4cFq6z2nTFj7YaWp
	IgiA+7z3HdueNRH1cStT70ftZ8L5eTyM3ZRCFG9ADnzblvxeqWZxsg3QzW2IGayYKaQbxMZ1PqO
	/ScXdYCFrFoZhRqGX6cksRAKQZK9rpUO5cyqrkurOSRvsKn0nBV35GhHpAomTgmmrrHBGmM78sU
	bkP+2ZpR2Sy0mVA+3EKDcVTrvdcKOSCWWiv6pPtDVdlD9ZN0vriuNNKbhZpNlQcaaMLluCiQ19g
	WPadrFCOK4sQhzMEntrSFjZAh+gUecSPwen8k4WSQVKgh5fD4zY=
X-Google-Smtp-Source: AGHT+IGG8yQ6eaM9MZq/Wt9Ki0KxONEaU0hKYhlJEYIohf/f8s6fbmpLE7ZN2Q6O1o+MzrJ4P046RQ==
X-Received: by 2002:a0c:fa02:0:b0:6e6:6964:ca77 with SMTP id 6a1803df08f44-6e900670f80mr137621876d6.28.1741613264029;
        Mon, 10 Mar 2025 06:27:44 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.22.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70909c9sm58185396d6.26.2025.03.10.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:27:43 -0700 (PDT)
Message-ID: <67cee8cf.d40a0220.2e404f.1d27@mx.google.com>
Date: Mon, 10 Mar 2025 06:27:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1638606131827104176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: [BlueZ] Avoid spurious warnings when dbus.service stops
In-Reply-To: <20250310114719.4141881-1-kernel.org@pileofstuff.org>
References: <20250310114719.4141881-1-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1638606131827104176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942219

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      1506.61 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      160.81 seconds
CheckValgrind                 PASS      214.94 seconds
CheckSmatch                   PASS      287.50 seconds
bluezmakeextell               PASS      98.37 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      864.38 seconds

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


--===============1638606131827104176==--
