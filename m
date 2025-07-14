Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0214D29B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507790; cv=none; b=G5BpPKUC52Ut+HPgbEQdhgyzliO5Mm3WHHJ4lBG4Z7xiPyCWnm4G2Rjo+A7xBsvexB6VDbe1oZ39nMC20IPVf7wC2O+riGntq/q3mwefVpGzayjKbKQocWjQZIJkNe6Itld9Ib12WEmd1E3dK3eL5cjOq9plrbSDYEKAYoMrupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507790; c=relaxed/simple;
	bh=HC2k4HovpahL9bbcr5g1Wqx55Z2/Hv8zjGmZQDrG/GE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RSKIJ/ytDRa3EO5Fj2NSJ7E8TSNGFE5bVTM0sWV4Boi+PPYSoPSsdY/odf6LwnssRa/tYzAwpoDujiCyX9iCNKSXGgKSfsx85Nv3IMBUO44YTRWj5mw1SAtcEnhCimdPB5A6ySQqr4m8VmX4ENz5SA5ZQXQ81xDAIc+1nC+tV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2+Phhnq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2+Phhnq"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fabb948e5aso52544966d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752507788; x=1753112588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I9b0+9gwU9B4tTS6cLGqmXyfLy/tG7eRCzUTgBlELPc=;
        b=Z2+PhhnqP01pTMMMff9l0lwgKWA15B4baQLa7JtmfQOcFvanh3DCS+VDbGP7V9HUrZ
         ynQIj6agZakQz8RJi4cvW2e5e5vHZCFOfdkJyw6CVK+BM6s0RkBvmRS4W5hPj2RBGbnn
         Jzmkn6/pVdBvlZbM0kjDjjcWR5tXapQ621VRukVGDpVZ/jfwVK0SMs5Czc1PASd/YhmQ
         xAamLG9iExUMnHw66V8JFDEBNMh7uPdk205tGkJJ2qpSv0+Q5odJphvyFLRGghOaUJPv
         0LqaT/Sg0pIxUyWb4J+nwXp5/cZ95vz8UhZHj+madCbqN6U0qLWBn4DhcjgEg2/Ycbwo
         +U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507788; x=1753112588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9b0+9gwU9B4tTS6cLGqmXyfLy/tG7eRCzUTgBlELPc=;
        b=etwmHaJ0SEXT1k9YS1s/AINs8f7JhuUgs8zaxFCBDIUR6STs0U0KfWN237yP+IpB9Z
         S+p1SS5rx5CqFBwFBmNNP3cKoNaK4Ctt9KiQXmMyleLo3pEeHZ+vgx8IGc0IoQu67/Zz
         OCjCjU/DEUY7ODkb/Ky4zfml81PR5+aoCIUgg2fmzS4dNa+W29ox8gXr3nBM/1dEvJdu
         xJcKxDgZIK2XdSYdeb98+zwou5fHbb838pWcbz9I5+0QKQuhMe5XWDvQnjuoXnFLYv2c
         7EYBH3Idba3p9gl1OqPQ5qwAmsupnwJY7rzePf4XG71FffKF44w2uHAda/qheUMPXCZw
         R/jA==
X-Gm-Message-State: AOJu0YyrpYobltfciB8ZVyPv0GfHTHhIXD8iKeJFktZHV+jfZTv0lVPx
	O7YsX3XjWJbqmE3JQBNNl6kaDSQAQ4F81Svo1iXo/8H4n6YfBrseNMbXP3RyW+8S
X-Gm-Gg: ASbGncuJNIJBajkArrMh+g/VjQK8rXDmKMQk1othm3CBFmUTT58TAESMkfjpoJB/56D
	lbWY3Gq0LzrIQpEbfkLVgoJX8oNqW1H+ZCm+IryTKZBK1ZGI93yvgYSM74QC80x5vfqMtjeNb1g
	dLqVVT8b9H+8QqjstffUIQou2GA7CP/H8ky9YdyU7cQRY8EYYKnFbOzT3ZT3EQk0T5gijtz949H
	ZK2Jdr3LS65hdKXD2xlky7MZoThbF3zLt5kixWidjMqj5PwzZIBGxgiZSMednnb4G/Lo3DL2KTd
	Rs63jlz1FtRzH+l2se8UedkrcU7197KMns+KoR/cbu0qbBt0EGVl1oMJoOQLp1kdLr2Jn61qtg0
	3ppNNHqdWtfUkMbLGps8WVQDWqe+n
X-Google-Smtp-Source: AGHT+IEijYbEaZOOAFT9000n8ZTNI8D9UhhrQg8RFKdV9hH5rErY3QGpJ69Kva5FTo2rwdRYj7olFQ==
X-Received: by 2002:a05:6214:20ad:b0:702:d60b:c037 with SMTP id 6a1803df08f44-704a425b237mr176248866d6.29.1752507787723;
        Mon, 14 Jul 2025 08:43:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.169.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d8eee2sm48204836d6.97.2025.07.14.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:43:07 -0700 (PDT)
Message-ID: <6875258b.050a0220.2d02b6.1d85@mx.google.com>
Date: Mon, 14 Jul 2025 08:43:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8171050931983460386=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/3] lib: tools: remove POLL_ERRQUEUE
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8171050931983460386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982089

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.24 seconds
BluezMake                     PASS      3016.67 seconds
MakeCheck                     PASS      20.36 seconds
MakeDistcheck                 PASS      187.25 seconds
CheckValgrind                 PASS      241.04 seconds
CheckSmatch                   PASS      307.81 seconds
bluezmakeextell               PASS      130.05 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     WARNING   927.37 seconds

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

##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
1 warning generated.
tools/btgatt-server.c:1212:2: warning: Value stored to 'argv' is never read
tools/btgatt-client.c:1824:2: warning: Value stored to 'argv' is never read
        argv -= optind;
        argv += optind;
        ^       ~~~~~~
        ^       ~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8171050931983460386==--
