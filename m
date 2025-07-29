Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940524290D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822428; cv=none; b=h2vFgUTvL9LiVHMatwWmGrpOESMT3m382eUK597feIB+190ZpdjJtxvG/o8vfqyezCwux8NZUzIa3GvxvVc4KojSJ1owbu1SnHoInElRZvnvXSoawLmKKMyJU4TkGNId5mrvpa17YO1maU2eE1fTaMsPlFDZ0Ydp9YXy+A1x5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822428; c=relaxed/simple;
	bh=F/cFfTL6m5PSQmlkxlCuwKsi/4NW549XNaILC5NJ7ps=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gq7BZHKMZyFAMesM+YjgoEyRzP8qk7tolJw9UDCjkyp/e5dWbBY1noD1eCBOWDdrZnq4PUQOrRG+A/EIF/JGuIyCnxgF2HIh1yYN10OPfup+mlKleolMLM4/LhFgfsey8kGKjh2ZRJUtyb0IDGx57S8SbDWC4PpwaKf9vKqxOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiO33GNM; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiO33GNM"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so38651675ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753822426; x=1754427226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p6vc0as4LWybBtF8koarN8yrtISXbKpekhNxH1OpmD0=;
        b=IiO33GNMRtiNYXEaa3DKqiBkpgNFJ6XGAcT9P/53PyLu11VmDAN/4nvMrMkzqu59Sc
         zY3ZGckveOoGYH5LgTqAddVAcNctnGVI7Irr0+r9uqcg06BTcLdSMoKRC5Fwtg9prcf8
         DKDFaq/Gu1N5IB0W38/tonI1RN46B/5BrRWKMJhdPKGE37mUhKj73lI8XX2NcXyiCaJO
         G0EiuW2c4xLx9xI+Oi/KdGdMCiKEx0DiwcmFXVfZZxqi7Ccsm+tJM0EtxKmofoI9l8rF
         xdqx4PhOEB6H8PXUVMbzK02XbmdIZyNyLpoFDrVP94IVqzArTrbo4YGdyvL7EE/9ozwv
         BiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753822426; x=1754427226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6vc0as4LWybBtF8koarN8yrtISXbKpekhNxH1OpmD0=;
        b=vTaErm4SQQ/PNUaw6FuRIF4DXx9aWyE2Exqy+AtF8kuN0wZ03qaANXEw7ovXzhUmoh
         UXgUvjUGKWurNt4H77zvLGobTw7aCx6FDu6ILlwgLrgvrEsiOt41u1v3avhJ0w3Azlcb
         3MEFu1M3ptkQyaY5NiRFKagFF0J+uzPPaC6Wx8AhkAigYf03eU9RdiNjaAokswI9BRQx
         FQBiwPPBBo0+0Vu97L+OTEGEN1oId1DshHnU7cYyBMSbn6ZTs77MQdzudxEBskOhykb3
         phDQxPt0iUL1zLJCPJJ2Bp38H9mRM3UcPFopEgLZODB6Fo/kkJ2q4dBbhDUVNohjRRqo
         HvTw==
X-Gm-Message-State: AOJu0Ywjw/wO62uTVcxB+VvvoRS/fUxmyPk65zmOAp6+WVtrZWxtQ86t
	1aSvhWO+eIah3RTtPITYorB3hv0LtjIdoN9zi3jOPvJ0amUGTnQ+rQC5lAmthQ==
X-Gm-Gg: ASbGncv9WYJXt9Ut+l8gPqtjH4Z6oH91zZ/Z9kkpted0wxYtxg+IKhTZ4KLkk9xjhqN
	AIuanBCXofmO9OsFlZ9LyKBJVJD48eB1rocK54NufDR4g+X5ZNAbcRe/SjRvhdwPIpPwuaoD3D4
	S0Adehgx5UvcEx4VEY1Nc9ENZF/uWphtXNbTDhKcmWvin0OUezBxq7VGzB15dgAU9qcgj3vuOoa
	zukhO5CR7hERM6Kf1NGMy6Pucom6fKunMTY0FCl3DCDGCjjU9Vr4/L2+P67jVtCzu+L3ZOZXk8L
	j8y1ccz7/SaGsopzRzceO8XEMqFPZfh6CJnZuM3Gtb0oBVksOmbMmq9gjUVhx9o/v0YuS9fIxV/
	EihDd9psDF9kynSIj7XRU6ePs9NXA3Q==
X-Google-Smtp-Source: AGHT+IG3YaFYSwOuFwcOY8uWjUr18EoZEMKNqgAx888v0Tib3wSn9rGSA08PwYYyZo1OYpy/k1KHJw==
X-Received: by 2002:a05:6e02:2682:b0:3e3:a1eb:4462 with SMTP id e9e14a558f8ab-3e3f60dcd12mr14598755ab.6.1753822425755;
        Tue, 29 Jul 2025 13:53:45 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.140.177])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508f06fd0b3sm1419468173.107.2025.07.29.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:53:45 -0700 (PDT)
Message-ID: <688934d9.050a0220.3b3ab4.2f11@mx.google.com>
Date: Tue, 29 Jul 2025 13:53:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2011722618181304734=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] btdev: Fix checking for PA on BT_HCI_CMD_LE_TERM_BIG
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2011722618181304734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986829

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2666.12 seconds
MakeCheck                     PASS      20.27 seconds
MakeDistcheck                 PASS      184.76 seconds
CheckValgrind                 PASS      236.29 seconds
CheckSmatch                   WARNING   306.23 seconds
bluezmakeextell               PASS      128.25 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      920.63 seconds

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
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2011722618181304734==--
