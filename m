Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8D1C69D
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743340889; cv=none; b=jmtG2wf3hoUDjFdRv7dx3l0YqVWzk0uUkVO5oO71y6eyq75mEL8DzP4KR1i3ulrqeEgaFedh6YPjMkxZt3q/gBsxUShyvbnXQ5ZDS1JAFjKPsHvVWoEO6hV2rRZ2U5nfRLmcbCAv5ozoaejRtVagfMB7BGfGB3NmjTakjM9/zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743340889; c=relaxed/simple;
	bh=9bU9CC++cDEeYJsJnfeZHx+6RQBjNe7Fqz8JdmX99b4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a1eQXQN5N2dOkegxw5bIv1/kfITOje9Xw1mtavvV/ZoHaLeuExan/gD7p49o+Tzy8dQTg6YuPy5pLW3Bd1CH4P4i5okGNrvXFiX/JimpDYoEVBf7ipWRnoETExFQbLTErdoiXAgR/X14/yYaMkVsBd70KzYnBhGdOdw5yU99I6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXw55jrS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXw55jrS"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so28701736d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743340887; x=1743945687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl8aRXradTq2SD6jVMMSLCgwe8zjfhlBGWdB0p47RiE=;
        b=fXw55jrSg9CsYGTLHEJnqWhECPCtJqA0B9LKRN2ntVMpIiR7r4yk2zll2zMfwHog7T
         SbJOe+EqjwTugoa8fn1BehBwL2Gwsxoi1dePxetM2Svz1bd2xWIi7J2OXR46JNxzFyLJ
         AfhuAghqEX1H1SSfE56glf4y0p3Zq3/0jWNGDz05fMg1ZSs8lMo6dkLlPf8cD6EJ2P+N
         a68ye54f+CriQR+2UxDy9Zehtc7AqlN4FnUPYb2v/7PYWgL/ioWllwUGKaq9NFUOeMto
         AHhe56xh4LxFMdm6ATujYJWU0AVV7lneLKdEgko0uIuY14C0lJZ44Xt8RwOd23hgjc/a
         V78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743340887; x=1743945687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl8aRXradTq2SD6jVMMSLCgwe8zjfhlBGWdB0p47RiE=;
        b=CvQ1buPaXC46wOHkiOfuU1gVsOtsKFW0q7/ywx08G7FIJgR6sEdZgQzCxG7iIXvnUd
         UKJgEb1KeTTlrFD+D64sHkMagRraj97TwKZQ48cjw7kXJhiJyn6zRHl/UNBVBUjvvPwq
         fXSnh1+hXC6EPk+UC6/vlZ3yZiw2dQO/k5wNzFqHIAbMndvIhKAYxOVyLrPr5e5dHpRW
         JoRtQcbMcqlhqBkw4TXsZ29jAPmNVRpkoaWR/O4z9AGG1Jbn7EUPClk18LBhFSfAPe37
         DfFdy657CsviJATRm9gfPhd9XGZH5gq3hefKWBwUNKNWG0RYZ0QilVXgayPPLvbaAPVY
         vJww==
X-Gm-Message-State: AOJu0YwCfN2dL1gtjVioj2/mG5oBk+bCySdEpP7JhX0ymQ45Lh0bZdQu
	lflM1Bj3JHT70JkT+DkWLuzDMzGw/vK2478H3mkPa3+MYzNtzf2WyuGiZQ==
X-Gm-Gg: ASbGnctRN0tB/oklYNj+XD/jIz+LCSpTDxwZCDk/j0z5T9Ncs4+/7aYNrgdiFjUigcJ
	l+YLj1JkyL6UOAMHb93fBTx12PfXULsf0gT43pyuasckrikNCIUM9EY3SSerg+86p6eEhMTDELN
	ZXQfECtwWDp2ZyOM7bTqigLyzj34udqY/mt7q3cWQlqeA3FdAKIXGbCF6kNtDoaJfCnVTiu75h7
	RwL/TwjCCJmOu5JTG8d0i4kJSCKDmQwQZut3eXIyunt/xG7OU6EbXzTuzL9MxuMHwqsu50VEuUC
	+8kGuP7eY0Lh95vxKR5kFnfkU6fIwJS06Cy2jvmqrUbeTHEvQ5o=
X-Google-Smtp-Source: AGHT+IGYtA1V+vc06tVLvPP8YqyIq9NWPz3JI8TEcpeSqYPVqoZGnQK4MFeCOO4tJSb684PqPLk10A==
X-Received: by 2002:a05:6214:493:b0:6e8:fcc9:a29c with SMTP id 6a1803df08f44-6eed66971b9mr81540566d6.19.1743340886897;
        Sun, 30 Mar 2025 06:21:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.199.126])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9771b42sm34183026d6.88.2025.03.30.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:21:26 -0700 (PDT)
Message-ID: <67e94556.050a0220.24adab.e6a1@mx.google.com>
Date: Sun, 30 Mar 2025 06:21:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2996731238135490454=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools: add BPF timestamping tests
In-Reply-To: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
References: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2996731238135490454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948351

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      1469.53 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 FAIL      8.87 seconds
CheckValgrind                 PASS      221.66 seconds
CheckSmatch                   PASS      294.34 seconds
bluezmakeextell               PASS      101.95 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      862.20 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'tools/tester.skel.h', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:12503: distdir] Error 2
make: *** [Makefile:12579: dist] Error 2
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2996731238135490454==--
