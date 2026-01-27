Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF5238C1B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537772; cv=none; b=dDPp+cfbgVcpekewck102TC8q1xA7eO4rSpAEdiMju0XxYx3oitcXKsuClTAesYks/NzhHIv282cV/iRyoBs+YS3iLyLpmTW6veBYVdJSY+GT00Yo3vhsD7si5zkwa4mJrOZuJlm9yvG5zrCpnzxkpKQ39t9dx9uFQ7rWVHs9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537772; c=relaxed/simple;
	bh=l/KYUFlxDyhz6kW2YU1x/Y0RwifVRKR98nEiaQNL7ok=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uki2+YC/XJMdO0B6iiMk6mcXqgkHWsEeNIeorCdR3j7bm/OcABKHuLQ3nksBp/1K6IWxnJgVPIAT77EsnoHT/U2RW7BIzPSCvks1TX8sE/52EmmR7bYWIT0oQygTcyGzM0gpW/NbPo7AzCS7Wq4E0ZCSFNFCizr9VORka7gzIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in1q9/n6; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in1q9/n6"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c5349ba802so610684985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537770; x=1770142570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YCjb+MOB/pGPlFZ3PJFLSJ9I7RRUTT13HTe5w69j18k=;
        b=in1q9/n6PHJ1KdyiCzyDUhBENY1xKlMHil7VIqa/WKr49M4BtGa1EaRgEwau5o91T8
         YVOl62j/aQrCETTAby23Gce0N0Bk2A7sPsXMoIrna5HS7yCxVeMzv8pC7fJsc3H7wr5M
         TQjZrdvpmixzrXr9XME3ENQaqrr3XDp30L6wykRk9eFD2IJPRkSbohkekbWHNc1vWkEy
         D+hMkS+NhuD08fdC8SxUyqujVCI6UVXK4ptBPK5cLHvgAOufK8GJCrFTVHoMkO1MoQ4A
         NQNMfAyn0lATPHKzxfs0ICixQEYqe8alKREqe/WL1wKi6rC723WnL05O2OKPuovBgRRF
         it3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537770; x=1770142570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCjb+MOB/pGPlFZ3PJFLSJ9I7RRUTT13HTe5w69j18k=;
        b=NwXvy1VBe8T989UD0zFQfoVQMahfHJkbb1Jq0COjingE7almT4bMdJ6tTdFCTCKtcz
         5wy/K3L6u4S4Gr/JlM/bOEFm5Xz3CEW1iRBhD5LE3mTOLJR2NfuVa0b0e+7FBVy1Pfqb
         cnpltDNJkJTcowsecyDxIJwRU+wrqk02tYO+085XViTiBa/vLfNsgYSsdZ8ubZlL8+qp
         QN3afrhnjjCUiUnuxCmjeburt+jRvocsvsLBzwP0JE0JtwKM4FOFIyp6VaXW8eOe+KU9
         GnduQGeeOQjePsuCBkFlu3Z/daFa3fiMBuSJEc0lE+Ybw7p5fariyEDMjwLVnhTNnh0h
         XJSw==
X-Gm-Message-State: AOJu0YyqigMsovD2GjH5kHlsAK9msmNx0MCjMUbzz7MLe00DmIPXw6e7
	KCGnKJIai0jNYg47U9xuYCMcF7bQM3Cox+Ucxo21SbhINOTPChQNOr3JY/cZmjCq
X-Gm-Gg: AZuq6aIo6ROR3T1eaz57h9jcEq+l0x3NPbJQFPit1pWxfe2tXFRRfZjLh8XAS+N5NvG
	dFce+GTsDSBD3bwKQ5QM4fHGiabKJwANgTgs5bgA3/Y6QKFdR6+DpnDmx0UaWNWaymECGvva58F
	jGMYqSUzpAnlNBZuth8HaE3RVm4vZO+F7wmMdBfANHBzHmz3o5Dzd3h+JEoiNKOldOKVNS8qouV
	0tegu65nsNiCdIOpVlYLBI0vQ642XCriubMBsWqbqQwhK6nnmjragvhzXa0J9pITMFZHUCqiXLD
	cio6uiql4rRwwjIavLHaq9MhGhku8d8k0yrnFVDgeOBvGzjW7mm5cnNK0SChr606GOjA7tSbwN0
	L8k3JH8i51KeK4yiStw/kYCNy79duLLEiLV5y5wRRoxiAitHNkkBxrNS2Ldtcj0P+zRU3zaUUSP
	oLnUfmBbQ7DQXLWp0F
X-Received: by 2002:a05:620a:7084:b0:8c6:f7ee:b334 with SMTP id af79cd13be357-8c70b90e846mr295956185a.65.1769537769703;
        Tue, 27 Jan 2026 10:16:09 -0800 (PST)
Received: from [172.17.0.2] ([20.55.213.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b96fbdsm22414185a.14.2026.01.27.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:09 -0800 (PST)
Message-ID: <697900e9.050a0220.1fc358.1bca@mx.google.com>
Date: Tue, 27 Jan 2026 10:16:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3931081359855313856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the HID qualification
In-Reply-To: <20260127171208.151197-1-frederic.danis@collabora.com>
References: <20260127171208.151197-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3931081359855313856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047695

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      638.53 seconds
MakeCheck                     PASS      18.72 seconds
MakeDistcheck                 PASS      245.15 seconds
CheckValgrind                 PASS      297.29 seconds
CheckSmatch                   PASS      353.89 seconds
bluezmakeextell               PASS      182.45 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1027.15 seconds

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


--===============3931081359855313856==--
