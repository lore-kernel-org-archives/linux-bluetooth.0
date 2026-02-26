Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BF35A3B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139904; cv=none; b=jBq/3cMI9OtPPkDo/PTftKTCQa+gYySiyBkOqvwcwfvMR1KLMvlPXX5n1cpg7jmlpcIuzpASaJluyrF/mInq9xZ2cVHGvn3jvkukD6DQL/mAaFRSzmgD1J0mRso9gX+jlRwNB+ObTJsGPUZAYLXKDThfp+kib0RKo5VdFHXZaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139904; c=relaxed/simple;
	bh=mThtDgjmY7LW22JLDKukxK7iZZhoyW6iyHv96NrynAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jAgVD7Ve8f7T0YLFmUTDCh5FZqGgQxVNJPqFA+CUpiNYq3wp9MG4PCcUjs0P7iU9TvGRXrSx2SHBnJ/987sjhDOwYHmzfZniG5ycX8QnYOfp0z87xnZycCLMapy/EIc2ybj0SuB8Mbp2KUJc20D3xzFx1hnEkD8RxxmtDjE4EHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPvKZbBE; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPvKZbBE"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1346258eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772139902; x=1772744702; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5orPviFmBWdiKK66tWGTVDN+/IbcqtCMsXZquMw+yg=;
        b=EPvKZbBEDjVMduamLiYIU8si8BMF2/ztMjXcuUuFghrYxM8tcqtbfqCTLTps8HQ70J
         NH4FDjLBQoUTJKF5bk3Cagpe1BPtXefvZ/fPgV6nChnSCuJQfBFe8ynAkPmoO9RBPWRP
         hUnZ7TGjb3mJWLFj4lqRx+5lwadIKN6B5giFpcKjwMcIn3kpxME89Iy0gnp/p9GHJ1fy
         f40xTJgV3WS3ZycI7zKrCmuM53WK7RTkfMaOjhw2qBcFoCGvdBGP/XKoq0wr9XI1SYGj
         ngaQI2x3LAztt1sDFB5BASj/ib6cOQi3LVf7kNEMmr+WEwE+qH6c4llaM6xnbHIq+jse
         j5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772139902; x=1772744702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5orPviFmBWdiKK66tWGTVDN+/IbcqtCMsXZquMw+yg=;
        b=QB2o3NFqEWQM5CnUpKJTmGF77hD968ezgWrVTL19TKfqCTcVfRQ1mLCx8cr/i/D5Oo
         tKTD+bNwBk6CnLdMTgHic9hktRVYaipgT6uV2YRyB0xSnY7GkeplE1zTDE50M8KT4q8v
         jJ4mTfApytDM5IBgelTC4jl8JEIxZUZXVlaPXSwfQHfvR0l6jAnDw9SG7GwnYN07DjCI
         cuj7hettZ4AVfEFWoyVYD7X/4TwitNexlW05YhtgcGUFiPdVPxKfbc6W2qbYCcosiUz2
         6dutkc1Wmje1gxt9wEeIkVzWgmnDrizb/wHFm1jXE165h6rUU4kbFBDtt/wvCpe1R5yh
         bPgA==
X-Gm-Message-State: AOJu0YyLTBZZnudlDVmI+LdNCRvY+Gm2DsFkTljm6WQ37eYTiMuce+mO
	/yMpFbOKQ3GcFWfs2Sj2Fm3KcBqsdJVh1gvA2oVUFoigrzobdXTVQt6LsrJh2kNQ
X-Gm-Gg: ATEYQzxxJF4XIm1HaK9uh83Q9b4NhrGHLpTDkFjch75bbqqXjxDH7/V01nWz9jXxLk4
	6jwqNRB8vZuGFge1qWxZgvJMCRdMWGL8oQfAe+kIFKwEqITyHpjeYRyEVowuFB7zxDp6ykbeSvd
	eJ/X1+PTvU6n4T/AiU4Jcc6evcCzh5IarK9oodj8isBWqdzJx0TVUUNZutR1xwrVluKYGQw/mQR
	UAb0eV3Kgftq+4Pevwz/IU5qV88cvAX6xB/PSQ6cFmJDM43FbI6+rpUf3F+kUCEg2I2uEzIiCBV
	7jdXcC4kU1gZ/fYT3BNesREL9sP0BJruJLq92DWjGN8zegAvhE59QK25L09lbmGgJuMft7mK2k+
	GTbo3oLXd/FQjUkDneUUZfGZJkCR+yG3+faLUJ5GflhsnYU58QOEPXaxDIJsZTZBOH+pPVDwXCB
	GPMyUDjwdjOI56b2HPP2FD7kFs+Np7oA==
X-Received: by 2002:a05:7300:641c:b0:2ba:9e41:2af4 with SMTP id 5a478bee46e88-2bde1c3eee4mr183857eec.8.1772139902156;
        Thu, 26 Feb 2026 13:05:02 -0800 (PST)
Received: from [172.17.0.2] ([20.168.117.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c3csm2989198eec.17.2026.02.26.13.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:05:01 -0800 (PST)
Message-ID: <69a0b57d.050a0220.dd02a.5677@mx.google.com>
Date: Thu, 26 Feb 2026 13:05:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6152425227032283556=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] hciemu: Fix silently dropping packet if writev return -EAGAIN
In-Reply-To: <20260226200330.313530-1-luiz.dentz@gmail.com>
References: <20260226200330.313530-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6152425227032283556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1058640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      17.98 seconds
BluezMake                     PASS      647.73 seconds
MakeCheck                     PASS      17.72 seconds
MakeDistcheck                 PASS      221.94 seconds
CheckValgrind                 PASS      281.29 seconds
CheckSmatch                   WARNING   317.69 seconds
bluezmakeextell               PASS      167.42 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      934.35 seconds

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
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:945:28: warning: Variable length array is used.emulator/bthost.c:979:28: warning: Variable length array is used.emulator/bthost.c:980:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6152425227032283556==--
