Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48201F4275
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475791; cv=none; b=gl+0jAYeRNpfU8CevXh2/J0n9hz5e2anyigJWefloRJc6jV0ejl99PdnpY6Azq9KoZZIJsRLpwBgxQjhEaHvUKPJSuud3Z9jHqNvqK70Am5sn79mj/7zBgiuHTKbmHdoTRetGFTw8YxIUfy6yJCc6oMXl91G6dgiwuq3elUdqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475791; c=relaxed/simple;
	bh=lpIncRwQ0iV/VKy8KvgJuSad0wNQbkQ8+xUH2rwMuk8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UPajwloGE6Q+kfAKDc/1ZMwj9elzbterhmCJOKdIJ8GeN3DWt9NEkB5Mo15cG9r5Lzc9RUWaeRKaR32ygKkqiomWBRmjBtCpjrl+gKttPvlzFwoVAd2jPgJs/rf16nKFX+jO1uQeF6DJXvTkz6AptB+9BAzW5rkYt2dz1oXitI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1fvY0Zo; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1fvY0Zo"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8edad9932so42743876d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737475788; x=1738080588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jfBL8hSNQ0DapzjnArUX9Uuac71QuQervD7aVfMkPs0=;
        b=K1fvY0ZoGxQeSeyhdrO/ZQhX/W2ZWWQaLvt5jLJn3M8sc0RhwQGq/8xWD4wvsb+HHj
         Bs+Rb+DLh00VFjFaY/SbFB5ZqhxHFokite6iZnpNVL1h+OqaMP5l75SjiCyp6bHaDy+d
         Vyg4GqVoS6Z7Z1/DZbGWA4HO0mmuR1YXgNiDKub1YIqvf/FiK06NllrNY3Frj4rAKY1I
         kI1hVNvZa6VG9UNOTjhleJw+KaECzvvCWaTvIhanmQsrSOA4q1xtfTure4ZdKKIA/jVf
         ET+hQjczGQNwF6pYKqTvgvclF8xuU7YK2J4N879CfzM4TkFhkv9a/c+oZMImQxDdGC9u
         prTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737475788; x=1738080588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfBL8hSNQ0DapzjnArUX9Uuac71QuQervD7aVfMkPs0=;
        b=cvZJ8CV0SbJIEAccp5pumamhiPoOTVI9c/znIBqO5RBeweuNgoiVf+klsYqdRWMahR
         nzz+LsJ7im8qkJajXPXpIDicPe34yWKxhTEjYV534kQ3yXg1/jX4kuOPzT8eZs4Um0e/
         RASz8ioMAa1IhyacaHXPjHs6Gi2xHPBfYp1Z8izEJmAaNvX6PX57KuMpwAsSoVsx6qzt
         H7KiBDpK7jHG+0xZtr0XGmVqtPajkV9AWFwQ87ifPYunrLH2hiERQxKQmmf+2x3NgYA1
         WTuTwkyHoJ53C4Q9Yo80p1FvH/6+le3gcCCmoyFzt4MMPccM/6KctlZO5bSe7XHmYmmx
         ZSaw==
X-Gm-Message-State: AOJu0Ywef1o0Eb7g0DeQZe/Ih4wFYM24awRjhUXkI0CQEngmvy5hb80M
	VVcnP/sPsM/mWua6UXGEnqq73JhSQwKB7DfOFcpDlM0Xny0IJwRlTmRdfg==
X-Gm-Gg: ASbGncuip9l9w1NXM9HfFv73vJrrxa6c60fCDf6hzj3sXzFLtSiq14d7RrEGa4suY1O
	kABCL8XB1zbitQT1ko/sX5AKrg/4Brk3yZwyijOF6qLu5uY/hYFoMIWVYSikhmP3IQbKMVNd7xm
	obgzQKnMdoUXJ43MgilTjqCl5kqnEogLTvXsJkWagxTQDVWsY95DqedhbcP4T0jLVgcZQV5j7LX
	YrBhwbysePVkapoU0w0DdUUoyLBnani/m0tYM7csqJ2UuCAGOa2v/riojuSpeGBBwEDlGQSJEw=
X-Google-Smtp-Source: AGHT+IGgujNru/NLPSep++vQwDkwEtdu1h6PoZHEy+Gm8eYn0/B2hO3ezbQIv4m4u7Eyxu5r3lFPNg==
X-Received: by 2002:a05:6214:5c47:b0:6dd:b9a6:e626 with SMTP id 6a1803df08f44-6e1b2170218mr326544386d6.8.1737475788243;
        Tue, 21 Jan 2025 08:09:48 -0800 (PST)
Received: from [172.17.0.2] ([20.75.92.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1de339456sm13163226d6.55.2025.01.21.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 08:09:47 -0800 (PST)
Message-ID: <678fc6cb.050a0220.20668c.6114@mx.google.com>
Date: Tue, 21 Jan 2025 08:09:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8956051195630906460=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: connect VCP profile to MediaTransport volume
In-Reply-To: <20250121144404.4087658-2-michal.dzik@streamunlimited.com>
References: <20250121144404.4087658-2-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8956051195630906460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927257

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      1474.84 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      159.05 seconds
CheckValgrind                 PASS      214.99 seconds
CheckSmatch                   PASS      271.40 seconds
bluezmakeextell               PASS      98.36 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      860.01 seconds

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


--===============8956051195630906460==--
