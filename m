Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C4450F2
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746289927; cv=none; b=qNphhInGwNlrMEpeaRQrd5YFL9ufYlqcG5FLX3wvsh6N2zTjlTkYDDBRel2obkjfmhpd8VkQ054iYI1cxi7YLGBroatgrBtG6ryPz4oG3h7Z/IgEujoKEhTFXuh+0HphB76rYae9QTFeKr2EJnaQTsqh3lzMsDIXt+6m1Dp6xVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746289927; c=relaxed/simple;
	bh=8MHkP3RqrS1yVaqOLNf+4qFiGKmaUE5IieF9PSJFlW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qwgfs4X0n5o04qNukB4+PCDYZ+xA0E0jCxpGVHfhNU9+c+MWlrhTdgPvfTP/8CMifVG6/XYoQtVMEKhUgqeUWlZ0FO2fL+0UV1/Q/Jo2eskPJtKY+1qQ7rH5bN6H34IoJyl3nQsxn3BNBZf6JtJYbZKMNc5mo79F1EpcDj4JrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP8OxuMt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP8OxuMt"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so47529996d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 May 2025 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746289925; x=1746894725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1aOayH6/AIfs3P4Utl/IHoF3Nrpt8uipNC9LYV8e7dg=;
        b=BP8OxuMtkn4FEs/1OVYBbGconbH1KymUqMozq7z0MjdHD/FrYv5c59PdNx4z7vQbp6
         Yh164hFN8KJfkiPLEDvoAOf0cmLQof4fbrX88mS9ajxwH7k7d2Lh6ZkaOd02o7E1+k5b
         Tcv2vnx1tcZ3+2RVR/x0meRwxg6k6cedWBU3/YG0BJS9aV61pIvyT3XJ/5ALbNP+Uc9Z
         BzKF/XgpIs0cCOlSRk5YR6E5iyFoYBkIfGSFOyNvdrDVFeNPcPcNTUoxDd3peeEF2yqv
         PJBdwGQCa5jzAgXYY4Q7JBSfMdk4XgCWU9svdCtsnImGZdNw5GGNN5uJW2qDrGMtiUr8
         Ba8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746289925; x=1746894725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aOayH6/AIfs3P4Utl/IHoF3Nrpt8uipNC9LYV8e7dg=;
        b=NX773STjb2WDdKKd97S1ooGXdaTnYfFuO7Og3wZuys4+T6+0UN3/VT08+rRlY9UWuW
         sPzXf75HZFPaNDyJ6Ks7X30f5hEwIPqHPr8fr+SrVzbcbYXcnFVh7p9I7bVQsHkn9gAy
         gcDljVjufY5ZhqUXLh/95C9Wpfb1i40lB29SPYAfUIJeQGFORUzcktAjCrQCCjivntH2
         M1iss/x1CUP2zZIbxKP08/lem2gqfYQmAj+S6vM9YRNwyhKWAvKFlS/kmDK4hZtWkszm
         NqlShma2SRA3BrXPR9HFpDAWa42hAW3bKjYs3jkSl88f6csLNhArMnngpY8Ezfd9Pmzz
         96BQ==
X-Gm-Message-State: AOJu0YwnVap93FsYUxqbCMacwYyX5da0432TNFEcdTgfcKUb4Qe/ZTkt
	Hol5rCEeTyDb+c8l9p+dXxwrq8gkqbg4+H1qhkIXzx/3udsuFZ5fMmomog==
X-Gm-Gg: ASbGncslgGnq7CcR6rMeaq/msqNVcv2vU0+uyfWtUT56mtK5dLlO3tzKPdu4gWcC220
	fbrX/mC4napVRikqVZyXvGtpgmPfQL4TC8XkbCaTcEUfJCh9r41P3M/o2zhzjEx5Qq91NU/82A0
	35meCl5AUvrfuAgsJWY37uLLlgGGi47tSlbnpHDMIgDXVvldxtA2uEl84vZp0KiKk/5EJimmBQ8
	SsUKQ3cGT/oBpIw2tJTVquxTe8XZU6YRte4vN9b2LKvOTi3Fs2n2PcNOB9mU0TpqhFJwQrcVhn2
	QJNZLlA3IfnIF9jU6pT7B/83KN7Z5nhl1csaAOIjC0hv5GgG5Q==
X-Google-Smtp-Source: AGHT+IG1Pw6AiKHVIFNEGH1cRKtIwzhfGLI7jdVC0cLZbSvX30h1XCmNoOHDsu7L8yPUSUkoOevsrg==
X-Received: by 2002:a05:6214:5099:b0:6f5:106a:271e with SMTP id 6a1803df08f44-6f528d3d41cmr26466616d6.38.1746289924550;
        Sat, 03 May 2025 09:32:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c451csm32768316d6.45.2025.05.03.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 09:32:04 -0700 (PDT)
Message-ID: <68164504.050a0220.35834f.2b09@mx.google.com>
Date: Sat, 03 May 2025 09:32:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5486251980752099330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/vcp: use iov_pull in input parsing
In-Reply-To: <a401b67e1969c6987641108d353ff4cce3281d1b.1746284567.git.pav@iki.fi>
References: <a401b67e1969c6987641108d353ff4cce3281d1b.1746284567.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5486251980752099330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959339

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2516.76 seconds
MakeCheck                     PASS      20.08 seconds
MakeDistcheck                 PASS      196.18 seconds
CheckValgrind                 PASS      272.69 seconds
CheckSmatch                   PASS      300.25 seconds
bluezmakeextell               PASS      126.89 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      888.44 seconds

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


--===============5486251980752099330==--
