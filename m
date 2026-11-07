Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064284;
	b=2gU8+mWCLnUOU0wKNcCe8vTtEbNHAkSn09VBxBdq44LjPwTtEHdQogcpQ1QBeGQfwQVV
	 uOlAi4FxPiApRBpprN7i/6Etrk2/0hAoHEhVxVP0jXh8kC7sFkXZy2efxrUZkzB6NsDii
	 P34EgK6dmDc+0H2sxCpwY/IFleUKKVv0RLrVEiEUQkDNlj02KbyfBLg8uF1QmUUPewT9Z
	 BvD/5dRZC5FRxUOGPx7c3S2Zvxqp8X68AqsRNIOwU4zLP+UnkkPxxq/WytcXuNUnr7Gop
	 tfhs1QP2oci4OoWe+0KvDIccnl4z+TZ7pHn8TdVbLxZAj6lht5Pc998Jj8Ai+3cnoNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PAs2kKFjXbRzy8gwbWfghgOd6afTMZkrlPLmxf48RnM=;
	b=oR2Ufom/TVFc/OJ+iMdS60q2brt5zfcul3x2WAQKLTXDNuPBrshtJAf+j1cku00bv+mJ
	 YCkzvEbnxZD6k45px59kMLoEMzoDoWpmbYPKQYkoJmTAn1NlToz0Xs6GZ5xPy3TnTlt87
	 aqcIYtef2RnB0Cn1cR5Rx6KkJTaVgfH8ipBHFEktm5v+SUES6Euy2LA40T6XGTl0DueEZ
	 LF7TjCa2I6hc9vygE4Aq9Isrjcs8rLIo/dOMYSPxDey0HysHr8QzEwmtJOynoBRlh9T6h
	 d9vJT51r9vghgfcZWIhuA0RW4syAIPcParHPQf/+ouOzl5YQ9EXet8cnj2ttja0tUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjAPX3WM;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDE6083607
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01CDE6083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjAPX3WM
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso432196a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794064283; x=1794669083; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PAs2kKFjXbRzy8gwbWfghgOd6afTMZkrlPLmxf48RnM=;
        b=SjAPX3WMjhlAfePMRtBF1mOtt6pKOCZEKjopzZv9aQacrFO1e2vFtkLbGzO/AbuYFS
         QBhU23YFk4YzYvbalTACKEq+MbPOhzpU221w6SmCgznW/S/TAQFasiydYEE4zPa2TWjy
         Zrwl4yTN78A4fxttvIoVqzpWUiRZVXgFGWPnmib0hBe9HcuwLYbvkVU46GaWJuPjjN17
         oY3YFtDisnO8tyaf3YBJLNfKgBcxhlcCD5XFm2amrC71PoqfKWjE+c7uGJe1oqylE3BQ
         SnuMfgQ5JpF/G+CL5sT9vZetwowo65dZTCjNASjoU+74ccMB/0/brEK5LHSYHJkRNpZM
         q48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064283; x=1794669083;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PAs2kKFjXbRzy8gwbWfghgOd6afTMZkrlPLmxf48RnM=;
        b=L9zZLpCdYuwVSRAL1aBE5t9vi0B1nWr355bjBNxR3VoQY8cP6+XZErlCgyOF1N3hUD
         RnCp+6RzhTThx2Ft8HmPYytYXYCRxpuz/r6AsJDuBNihY0TijxGU7mpo8vdRLwXmF3Dq
         Zo2eypqE5NzsJ3bRYXP6rMZoJ2E4n9lgElDZoj1S7bqWWHm+Krn6CuiGNY1aGO5MuUEm
         7j+Pl6GtJeqUVLZQESsdqwyEWte+p2BA74azRLoZcnuq57V4HN4PY+tL8ixrQDSadEM3
         1tHUwaU/SKcIHfJldpyiaqXDpEPYSGO8C8Snk36EIdZI3dOiZc3ZrveaPFZZedpPKNCo
         q2jw==
X-Gm-Message-State: APuU4Z9SxEmiIHzCJb7fTzSO6K2/U3rtj5Nj8pPfIaJi0fwDPBE0wH37
	UAQD9WENsccpGTW69IWv1ncXEK7isQFIOAJDO6Va923bdOeiq6ZGiPt8KH4eXGcj
X-Gm-Gg: AYBFou1Wt7g3JM5uesl4CfmjrORPoP7IwDVUyoDRcANL0P9Px1dkbUZvNL9N1wvlL+v
	pc0ZcO08SyjtCM32eSbu8iI77skeG2X+agLxl7Nv8zweItsHq7wf3CCn6lM5YlU9UUMe2BqUjU9
	BywyYUBnUIKjIHrFrmyVkxPkYVlq9b3r99ObwuuVTeByQbXI3Z7zXkHbUO28bU+HCYxdcpmUsJo
	LayXAmztQk7lyRirQXhX2YBSC9lxk22YOMU4Nco5lk/cTjdlDi8/4uYRZQtwr0pascokyMp9c/1
	YOUwG9MxKZWii820UQOqkEcmpyFr2BqVPqvTiWN5n7w9gj4ubgTrFVkaeUC1cr7QRwaMPGeIOTm
	9Lj7hPLlPn3eiVZu5779d0fK0rTkU2dgFwyIRkij6gz5sL9fQP0vXKo+mj7rI4QKqieZ1X0mycd
	pr4RAJSC7FFIcsv6NHN8aMpxIZ2i9CIXfMC3eRxT6DOUJUX2fG41JrxIKjTnWQct2ppokg3UDr7
	xZdI34XBpmBl57Cierr1dhA/vhr9UInKzRZ7t4QCGaW76iuJ6IrGZ2vmNNlxCY=
X-Received: by 2002:a17:90b:554d:b0:3b0:9e2c:9b5f with SMTP id 98e67ed59e1d1-3b0db6218dfmr6027011a91.2.1794064283062;
        Sat, 07 Nov 2026 07:11:23 -0800 (PST)
Received: from [172.17.0.2] ([4.246.70.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b1fa8sm3680062a91.2.2026.11.07.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:11:22 -0800 (PST)
Message-ID: <6aef3f9a.bf2cc4d9.c7b97.3266@mx.google.com>
Date: Sat, 07 Nov 2026 07:11:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0702262984172553947=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add UEFI standalone static SAR support
In-Reply-To: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
References: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0702262984172553947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204807/

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.27 seconds
GitLint                       PASS      2.34 seconds
SubjectPrefix                 PASS      2.35 seconds
BuildKernel                   PASS      31.80 seconds
CheckAllWarning               PASS      34.52 seconds
CheckSparse                   PASS      37.13 seconds
BuildKernel32                 PASS      30.19 seconds
CheckKernelLLVM               PASS      34.46 seconds
TestRunnerSetup               PASS      741.17 seconds
IncrementalBuild              PASS      32.02 seconds



https://github.com/bluez/bluetooth-next/pull/1085

---
Regards,
Linux Bluetooth


--===============0702262984172553947==--
