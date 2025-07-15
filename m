Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C681E5B7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592019; cv=none; b=Z9+5Q8Vz6EANBAyeXEvnlRQiyf9iOo2O/uLfGQ80KpqF6glKS7NcTznPLykILfeOnX4ERu7bFOo2XHpN+V5LbzXtXnA6dF0fxQ1OOHeMViqF5lNSYgqrFy4fFEEjIpLX2QyyiskIapZ9Hl9l8hifpDkX+Mb0eNPv3ZFJYEcgtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592019; c=relaxed/simple;
	bh=+GQ6y4CDHWEx9JmiM8j5EQUic8Wv/H6iO9d6eJLNgKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L/971yEqzmsRhXbpeu57AHMzMz8Fmlcdb52ExC4rgZv+IgjPQPWOJGAfH/uYNob8ewZQLjjbHRbO69IZi+lWxc2WM22O8GD2PB1wPThoK4Gsu/dQ37UBMVSQr9UJQT6/wmxnYcmS/R+gV0gKteZsfOhC9SbzaHLZS3VmgHL1iPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMQPuKnV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMQPuKnV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7426c44e014so5415150b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752592017; x=1753196817; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kKkKerHzCpVi4YZZiw99keVQSAzQc59PrKFeceIIgTM=;
        b=WMQPuKnVgc/NcOJ2yxoEOhb/t+uarSS7q1/MSY7alY8GXXVxyXaOhZaIdUFSO6vHli
         0mt0l2l4cVynxU+od8M4iM9ss1VkCBnxOIIbxluDp+SY0uNg9IlaLyk9ewu34iEqVSUW
         DboqeWHT8H834L6NhVWDYZX9pNsiGgEHpyeubpvnyEkgh+pA3igi74AkcI2G5krEPFk8
         E8BJ5tRxFhXQmMGh2sunImQKT1XfeWSm2GT23+sFHDBeitGG/WuwO5uP8UT3J4d9Bf7l
         sfjYHyI9SV3BT9j64GcmE8gz+qZY7UoYft4zlfQxQHiSaijkoPdJmaiKVZHBJUSw1X+N
         cc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592017; x=1753196817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKkKerHzCpVi4YZZiw99keVQSAzQc59PrKFeceIIgTM=;
        b=ZU2XF3unpc6XYpCq7+95ZbRyOXH+17KsRXeHqJgrry+tkWO0AKl8ZRWXX6eiQqB0vL
         y6MsE9Fnkc73Yfrpx5RUwGxw4CAjo2EEGYYBp21TnKrrU6mMHN6SucKRnSVCdxxHd5EQ
         WX6svk/WCbyx+sKTwjYmksRMGhZaOITANTNA59fvPjmdeQ8rIxDQeQVi5Eix7XX7d1d4
         SCFek9VAk8WjbiHWSL9M6WGfTKoYwAMEWzvaX4242dXiIXtz8Z2DZXWCMTecGbkLGIsi
         FrNYpVlm4QR/OhZraC00xaVNEJGvWrwsy5Io4jWEvkuu3OslymSksRDxr7yAD95KupPp
         JN/Q==
X-Gm-Message-State: AOJu0Yws+F2MtpA8tIClNma3FT+TW8H1UlBUBt/XwELbMdNAv8dczjMh
	Ag+vrenmW2G1/ojTPxaLWjacuVwR+9ezra+/dlDI3TpOv7PLGWwbUH5cJH1mzA==
X-Gm-Gg: ASbGnctnh8R65tX+pgMDIbea68/WWGXKTq6LBHaOfVQi1BcQNtWUFK9VpjE2hakma1b
	1D6A6PH8DqzZ1cf3/IfISwxZ1QLi6Tzg/I4z+6aR11zpgcRK73o0LdsNktVWy0ZXwNQjzzGsPXS
	QgO/MtQWfDzVCDisA70CnU7VHu1xmv0GYk62vDyJ28r3gE+6P3UTGfXBUENstGz9ITHsbRKPKMM
	V33n5qg23bnFYNnceBCpLyupjct8MHoi89xhseymakHHMWCCz8ya8TcUBhaoIBXMMPaiD7kwzWK
	aMviRJTZK4snjlUJrdeuHTAi3UeoXlq/ekeDpIxrop1Moe2MZ67VWCygbYPk/FjyF4jBoUsirHr
	XD4B3cKAUJ5Man1TukCkl+MyP0n61fw==
X-Google-Smtp-Source: AGHT+IGDM3zzTLms5kKAhHisvpgPGIAK/ggG5tYnmo7h0zgG6O6aywrZbJzVDSrQetU/yPmFOuPQZw==
X-Received: by 2002:a05:6a20:914d:b0:233:d31d:25d9 with SMTP id adf61e73a8af0-233d31d2729mr15698835637.21.1752592016789;
        Tue, 15 Jul 2025 08:06:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4a023sm11865422b3a.121.2025.07.15.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:06:56 -0700 (PDT)
Message-ID: <68766e90.050a0220.2b5629.4fe9@mx.google.com>
Date: Tue, 15 Jul 2025 08:06:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3457614560098799942=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] tester.config: Add missing drivers
In-Reply-To: <20250715133201.589025-1-luiz.dentz@gmail.com>
References: <20250715133201.589025-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3457614560098799942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982542

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2630.83 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      191.63 seconds
CheckValgrind                 PASS      237.91 seconds
CheckSmatch                   PASS      309.85 seconds
bluezmakeextell               PASS      130.41 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      938.41 seconds

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


--===============3457614560098799942==--
