Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD7371063
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662925; cv=none; b=JFBis5porGedomEZdJuGvGE6IzxNFBcZ3BhVqB9e7CZA4nzxAI5mvC2+IUe3Lo4AqJWLby7HvDvSnKugO97iOYHQMuODk0xZYp5pvOc/UKU99FPDpVOudGVFLFD1eX/p9CK+Fy69X9sZaiQ6P2gLXOpcIldsO6OzNRHTsaES/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662925; c=relaxed/simple;
	bh=OQ4nxT1B71WhwPoaWhkJLrclGn+cBAeQvJi0NvXd54A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RufUY6Ita0+EAN9CU9VeYPgzzGa7Ivdi8q0DLY0FVnE5pGRbaI5z/kR6pk9bLCHwjpgZkoyHzeiz5+5E5PL5z2B0HI+X4XfN0tpnODrXCLsTc28/emQivFp3IbSEBp2TkDrepf8fbfQnipPRd5HSQa2JSgYcxIKU4gnQBhBP5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrjpQ8oJ; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrjpQ8oJ"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6af798a83so511329985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662923; x=1771267723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RnmvKu+nUeI1P88bkX/Nw8kWOtEZ/b7CtxC+TkQsXZM=;
        b=lrjpQ8oJnoeYvXrK0VSomQ5uGEcmCWQhra1VMesx18Qf4rCPWIqWLEyerUKq+cABW+
         SZfIUqifDyMnKvbU7HrfRx7HfmFv7TWD9iuV+imE62bgROKppyqCO+1Zq7xRI5otzSH2
         /yrl2ddMOG8MxArd0iTthT0HudW1cVp6FHX8Lqk9NmC2qQF9OZYQRpxd6JtjryyLreHg
         gQFnm38DL1OPAtDpWDOXUQrdfHyixeLPm04mMOA2BXkzCjHVuszjFzJ0hz/hqiVv038J
         1rM1PheqCz5m0Tif57PQJ4xaMnNa5rQYO9B/tXJh9+qyeqc8GulB8U1GXHLGwRfYJVff
         UHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662923; x=1771267723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnmvKu+nUeI1P88bkX/Nw8kWOtEZ/b7CtxC+TkQsXZM=;
        b=Fl+TkYs99785m9vulLxb4xTienDXNLEOlHdy0Tm7/g4U5HZam0Q6C8zNnyOdkoOHOr
         xx6612wBmWbjyVlC5lkiwFXBEIa1n7i2Wz0Z6f9szuXRjUqAa1L+D+qJue0QbpuxINQ0
         wPjxglYZxv3CebVSnwOa5NENe5XvXj2lv7VvVekt4u/mvZMfzcmRTTTl7yp41XKC7Kqa
         4wc+0ihvhTK/N6hujaurL0hJM9gX2HymciaHGypsH2dEC6PfItOPL7BYAun92T1dKRy2
         JqGsxjK/F5A6Rt1jNyHknqzGXzFAN2iq8qNRoZja+198f5QQpxeEXU4Fa/6ptQrH41tG
         3Opw==
X-Gm-Message-State: AOJu0Yz3Yh/l7cSti4eU/BgbBXCbpfJcyhFMTlIbx0j19Ln6be/4Dzb7
	mN8Cd2cTApBUT9DCIk88zMvqIuAvtohVpd1Dy4sFja6fDes13Zj2tw10C8E5plD7
X-Gm-Gg: AZuq6aL+grkVi3ovq//4HbKyRxLMtQuEVgeCf2/HHoE8VO00Hw2DSG4nRa3Mep+Pp7j
	+UusdZ5mQhRcot5mqEM/ABSMIlnvpkwrbquvlVIanna2RyU+jmk3D3vceNwXslRNSqORsWAFBIJ
	dwS6X0BBZdbGJjrt9qLNmWKoDw6P6oZTEi06rfj8TcO5Aw5kap36ZsQ7wkkJmwIXdj7b7uGpyqk
	v7/Zs6+2JFUn53K4fZ5PUSvqM5LYKhV5+H8qUscvDbDQl+nWi3jQH3vF9HUdUH9MWuscpeKA650
	bH7U1PNQuKWPwoKRLRg6/QdE3JzyeY4f98iMHEEO/TgAc7gUS8R8Sq3sHoylSWp+rM78/dVgmMR
	HNbWataOE1twVOLbREpzSPPEq+KaO0UtfuOAwvSD6fx5D3dOS1gRIH5egAZ2whISGH2lVHWTPXM
	a6BV1AXmiSIE99UxJXSg==
X-Received: by 2002:a05:620a:2684:b0:8ca:3c67:8923 with SMTP id af79cd13be357-8caf1307743mr1542181985a.53.1770662923296;
        Mon, 09 Feb 2026 10:48:43 -0800 (PST)
Received: from [172.17.0.2] ([64.236.141.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16240sm873226085a.35.2026.02.09.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:48:42 -0800 (PST)
Message-ID: <698a2c0a.050a0220.d3979.1278@mx.google.com>
Date: Mon, 09 Feb 2026 10:48:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0309160550459170987=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] adapter: Add btd_adapter_send_cmd_event_sync
In-Reply-To: <20260209163420.844741-1-luiz.dentz@gmail.com>
References: <20260209163420.844741-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0309160550459170987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052360

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      19.89 seconds
BluezMake                     PASS      639.08 seconds
MakeCheck                     PASS      18.75 seconds
MakeDistcheck                 PASS      240.42 seconds
CheckValgrind                 PASS      289.97 seconds
CheckSmatch                   PASS      347.61 seconds
bluezmakeextell               PASS      180.75 seconds
IncrementalBuild              PENDING   0.48 seconds
ScanBuild                     PASS      995.05 seconds

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


--===============0309160550459170987==--
