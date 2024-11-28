Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411519463
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813991; cv=none; b=VBbTd7KRTb6iXw5Lw0aWpqBx3+24mp6E56KJcp2wGANcjI+s0OKREk8fnNeW6gA3Icm+M9YdceGhRYq70KYDlayPELPtuat4sOXVW3FlgslHQY6wHN00KOVMxRfTtwI50YbwHWnYAETgSar5PfUT9jCVKvqZGaaqneAVSPfjr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813991; c=relaxed/simple;
	bh=VMDiyBWivoyl6XyooBj/VSYaXCVQBH/6WxY0E5L3l9w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=btvAMID/8lTJZLEc7uxNnnZxZGRlzpJO2LR3XkOFXrXjSLq8heFOEn4couPIgFH1hjuhAKu0a4uMZqQ+Ii9pkPFpyOVYD7atfHcWpMoo7g4IKgVl4EYwrdAPjuS1WTC1MPQNU0S1ab82O+LdOaCMKmjET5dQ5xrv7TcX24ojWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYuE03pr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYuE03pr"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eacc4c9164so851652a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732813989; x=1733418789; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RIWKESb1N4vafSqvHrDiW1kqT0VOPYMVQ+O2MAJ/f08=;
        b=BYuE03prQc6rGt3fcijZ9yN0679uW3OVcLcs6+DTTzXtEmJLG+Yzkw2x9hU/ldHZUO
         zicmY3sM1SDzvB9QxxCaaOXkK44cBTNiUwoWQfvCwiklr6E3Ye+JlnbgLS1BWWyVXa8y
         Jmj4YlVh+sWouiuxFjy+YaHqUG6R73XgNJBV8kpmfT/9mDpf1vdzE5bRfGrNUH3Q+TNR
         mqwEbKo4n+KGwCY3FxP/GN9MPa6E4g5ZOWDs0aw0AHE/2PmjKeqOd7GfoQgta3SQOEd2
         wSpze3EtQXKA0Yl62zmn0FjYcpqpexPcThQGyPygkNeSOx9zduuT/Nts6YdIolB71qFt
         WzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732813989; x=1733418789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIWKESb1N4vafSqvHrDiW1kqT0VOPYMVQ+O2MAJ/f08=;
        b=r9VMOmX7t+mI4grnfkkVaWw48svR14Pkzw3Ss0uLuuiA/gMa8DpR6qMvmsUkYxgr97
         RUmAHAS6tdqydDiRw7nJPqTim/SmWRyxMdJIQ2lv26DBre7mgUoD37KPLIB5XJKkxJm2
         VBwqP9xUdvdFuWGPd8nl2NQJ58VZwr3EHeCkBx0Am9bTrGY1s8kcsBlg5qdhMyNlG7Kv
         U/qu9uxi4Z4x5of8f9kKp+fSLby/jeqfNtCpvVNvI5btr+wH4crW38QAKIfztkGuwvTi
         fpCC0FtO/D61ZUzFwXHWNwNvEihYZ22s/nRNXxdU3ZGU7qjs8g7cvx5GiyjH6bAbS2UA
         5O8Q==
X-Gm-Message-State: AOJu0YxdhYjjVB01iZgvfC6hfPCnSg2jM8tcwrKZqLRxXO/E/wNfArDf
	P6yETKeKPgACHwzJKiDRTfZTVgkRBf6JpQcdYxkoUU8J/zcOztlstwaqYg==
X-Gm-Gg: ASbGncuozgw7TOcV/lYcx3uZr53r+U2v2gT5NwvMDt+Pnv9EvybBQlf7yqnY6lGUhwx
	i3fInIl8hhw8ezWr6jG+O+JlvPwe0LNjMGarDYwXmFNa5Zlolxvp7bWJWViFCEBhPiA9YNj+BTW
	wO7eh2idP2M8duMopdCUeUDGlTWDMk8DqOGR7PJ6XWQN9Kgn6UQr8xC/c8+8KiIbQsjAcffVFwj
	xy2yLGEWr6jIKe+BpX5l6vChle+bLwdqzpdy2aGSXpbpIdPyFUzSg==
X-Google-Smtp-Source: AGHT+IG6OfIL7LdOcfla9GgbqFs7OOs6wT/Nvq8YYawKkz0vzph3ChPjTbEQA+MnjOo5jKoo7Llqwg==
X-Received: by 2002:a17:90b:2541:b0:2ee:4513:f1d5 with SMTP id 98e67ed59e1d1-2ee45141faemr1890923a91.29.1732813989268;
        Thu, 28 Nov 2024 09:13:09 -0800 (PST)
Received: from [172.17.0.2] ([20.172.0.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2aff1f11sm1704190a91.3.2024.11.28.09.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 09:13:08 -0800 (PST)
Message-ID: <6748a4a4.170a0220.23cce1.4965@mx.google.com>
Date: Thu, 28 Nov 2024 09:13:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5164217597287212231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect
In-Reply-To: <20241128160101.15187-2-iulia.tanasescu@nxp.com>
References: <20241128160101.15187-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5164217597287212231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=913158

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      1490.88 seconds
MakeCheck                     PASS      13.35 seconds
MakeDistcheck                 PASS      156.09 seconds
CheckValgrind                 PASS      212.05 seconds
CheckSmatch                   WARNING   269.73 seconds
bluezmakeextell               PASS      98.80 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      836.16 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:448:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5164217597287212231==--
