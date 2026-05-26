Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A35421885
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818831; cv=none; b=FJLkem9v7d59gViu/qeg/SYpqtZxgIGwFGegpt1K+KC0tjGDiMLi25an00pFkV5D72UGGaIXmhE475BFImFEVJJdLHZVPivPJ2J2W7Hjo+Jez5IJHY9rktQhJMWoGBluWpd+o6x4J0/Svj15bA/cHhyBVYqjuZ1EVp8MiBmtTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818831; c=relaxed/simple;
	bh=n6oYkISxc4HvlVG/VC/UTxkTu1QnMjx09fpYEFsji0k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AHz1k2T3hRCQz5OkerLvK/yJVjkZ0Z3PbdutxzbqggpFcUcRRYSBa+o2ytRYgzxE8pwGg7N8+2p6hYDmJGff8GYKxDrnD2I+hlRXrAtSCHKWVumcYupV6NtNtRErbTwWm4vEz5j7OJ5ylaohoIIOQMBX090ELHq3S2oQj7TsPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejG7M5dk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejG7M5dk"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cc9f97a124so34477686d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779818829; x=1780423629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GoqnW2f/eYkTUVrGzgUq5hFhzFmH64nb89yg3y4KNok=;
        b=ejG7M5dkWavnzLjj2w+7rezOHuIPGj8n4+punYpohxdLro4sKHqlVN5NYdSA8QQ9Gm
         AerzTEKvU4pawOGSnTCNX/X95/ASwUpGfwg6ebhKzGYFoLSU8aatVZvHZG/m6n7znANC
         RkFqNG1J085Q0OPVpTeVp3wlJfSAf2jYGsZghpPqKb6MugH2UbDPLD39fcW3+n2w+tm4
         yGWx5PaAw9lGMop5KYD0iQXLwPOUD6o3uTLZUe715s9GtNjxtPYq/kznU9KEHm08P5go
         EYrvtmW6CVma4cwbaoShMDQ39VsfruKNadkMqbBrF0DBdhAEAI5BNZ68P4Hsutq5sMBY
         /pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818829; x=1780423629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoqnW2f/eYkTUVrGzgUq5hFhzFmH64nb89yg3y4KNok=;
        b=a29fvYYUH1W1kCumpzlYJZSssQ1RP/TfHRoRnjBTnHcOJ2guI+fhE9ZayzDopSIQa+
         czpsy07qTsOrcsvf1Jgt7s9UwTDM5kCDqqC12LpgztkATrs4fgnELZytVUkUTxX3pm5b
         P7bd4VBkrRAxwBEn6TKC9tJ5Fokc0DehrYr4L+elD+Klf+L5Uq9k1+Hvuf37IRgQhQpt
         X1fs4VY+d1dCk9fbnsCSlVcbwoIOP30EEkfTK9rVOmgJWb1TQ6SkIG1qSi3AxEEWlMjl
         9Lqq4imo9zms7BYEUkJQZggi5FwJrJjuJPjf3xjsV7fe70B2REi3IyUAMI68Uykrt9DY
         oRbg==
X-Gm-Message-State: AOJu0Yy63SNR+vW7qc2LbAUP7oveh1SsUCwCAuuJW2oBakS9GIatPYlt
	X40trLjNaUqP0ZR2hAjYUt0WpXyo47zQUpDZmTmVHWx7TpJmKYJ6Toqj3HkdZi+Z
X-Gm-Gg: Acq92OEAl/6RuP7v5LtBHPekblKrO8mOPnMAiMyr3gpPVg4R5wbZZ1ePHV7B9uRHHZx
	Zmn1UzjWw2b8QF4eRXAvYZOdywgq1yo9Ifx10QpfrahcOabDZB0On2SicLSOSWTB6Qf7y+GVL+a
	Ca6u3HDrVQHo0u1lQPehRJayMUXymSb2RFVtizCnPhfNKf3VTSeQHrujOue1DtWudmiS5aJLnNN
	QLjBkDRKqfOC7/xCtX9ve7IVcaYjpiuu5TP+qyT8dfg/sSe89Qm7um6Rj6k3Z4hEljc8s9lInyw
	LDUmprQvl3WIL5rVVGpw7PKjPBsOD0ND/upG7Z8icYnt35CCQfyELP6EUbVg56wlGge6vRKgZNk
	em3D3P4n9uDk+wxV2LoUUtrK8eXwIJqNQmKRwSHzzygNZYOx6wGURK6JT63I/6MiDSyD7oVUO0E
	DW8byABLSeYVLuRXNpj00oKjJUM9wncXE=
X-Received: by 2002:a05:6214:242a:b0:8cc:d61:3c07 with SMTP id 6a1803df08f44-8cc7b583e56mr310051416d6.8.1779818828786;
        Tue, 26 May 2026 11:07:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.237.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffc87dsm148864846d6.21.2026.05.26.11.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:07:08 -0700 (PDT)
Message-ID: <6a15e14c.e7f291e9.3c4747.6fe4@mx.google.com>
Date: Tue, 26 May 2026 11:07:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0723067956904376699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
In-Reply-To: <20260526152650.3487624-1-luiz.dentz@gmail.com>
References: <20260526152650.3487624-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0723067956904376699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101090

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.16 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      26.45 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      523.22 seconds
TestRunner_l2cap-tester       PASS      58.41 seconds
IncrementalBuild              PASS      24.30 seconds



https://github.com/bluez/bluetooth-next/pull/245

---
Regards,
Linux Bluetooth


--===============0723067956904376699==--
