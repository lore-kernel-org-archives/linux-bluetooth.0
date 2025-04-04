Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC0C8E0
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801491; cv=none; b=FGEEIFMwBb0AI0gAf4rtlOdTY7Gq32P4LE5Rr2JEKtGnvfTN8rtNOagf6JXbUj64iTsFs2x9IIKczc8OZ6v1TXaJ/rbXTIA9n6ybJ7dCRjISUtLwBZ8sQjRUx5DbxqD1qzFWc8fh4QpcYGZg/dORvvLk/t3D+bokJSw5eji3NhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801491; c=relaxed/simple;
	bh=6RRG+DKhXJUSp7Q6wTZS2eA6HEolEXL2o7yWG6y4mFQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QGdKqwdiY+nd24YZ19h1PAmZuNRHXhgchYyH+bxkmioLVcntOZmE4Ov7ENgMY+NKej+0Xnk6ATq31VvmXGZ+zSJDajqrTnYlEBe0lUS3CwwyjxA3u/Xlm3VwwbsTg5fi19ShrR9GrS7GZlF9T6PbV26rYUBx3cwFWCcw16jZFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC8u5osO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC8u5osO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22423adf751so25624025ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Apr 2025 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743801489; x=1744406289; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv8p0nDS9VH++ZRlg4EBgR9ksxEwIgbuwcu/BcmfFjs=;
        b=TC8u5osOEXK5W45qAEnZYt17A0rk1FxpgjMyR6zoXSMiG/1Vb+VfAwa6bf0aS4wukS
         9Dz2D0sPQdr9BNTOAwSoxd98+eSeQqVip6rds7J8WotiGM/CKJz+pNq4vQV7IaEdASTb
         KZ90ndR4QRLeBhazCjh0WYrp3I/51TzwwchXAy8yzTf3yH6EvKIcB5ywYEGl3xrotnlu
         GCno76sXyApAglIrEnsyd8kJxdHv9CAqHyoykzWtXvuZbFEQ9eqD4FRg0rpRxi7MZ0Ij
         ImDzbiERNhm9grOXy2ilivkNgzfpXyZ2OzDJHRI5m+zeszPxwELBtIKQcvTTGh69BgjG
         JZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801489; x=1744406289;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lv8p0nDS9VH++ZRlg4EBgR9ksxEwIgbuwcu/BcmfFjs=;
        b=pmNJkKbAwGycgBYDacFrnxAZ6OY4cmkJLeraO04BgVgaXP8r5Zv6ypJEB9B6i7+72P
         Qgz8sdtMVpnj+9941jHK2eONQwv7a5Pc/pdP85MGNXNzSTOi6H2q1FPJ5CwFI8Ntqom0
         cL7vFUnoyyfQqI/RWsV1OaRXUatb6sbXsgJ3RLwohBSILTEAyTAfP3hXzCORjMfq+PwA
         RSHSeO6ZDFkjSekT7T0+mDTImjXMK4coXTFETWKFGvUyoWMLTMEsXLKVTPtFaaiffinz
         p2eH7SlAuqbCuJMr3aVC3VAqVot6vKEJqdgRO6OLXL0M2hcJfrIQAEB5rcwP9gtLNFNP
         jxOA==
X-Gm-Message-State: AOJu0YzSc1BVDt9quHpNJO0+UcMgoVlY6KZtBmJIpaYYmtu2RKfcm3dG
	DGSwRufJNdRFMrXnpRtw2EDG8/Xyp3DnBM5PN4qjRhySppO5EfaBpJoLpg==
X-Gm-Gg: ASbGnctQopYAv8RXvs+/z0xdYkeHs28FF50g8QMqrf4fGC2ZJYH3ZvCWezqsh4XQlWs
	TF0SiVQurxnoh0BJwh2+DWBjrjkCGGr0jeKVcfzgWID7GQIQO0fsJUICdcX9kxXx5mxSPj+5sXX
	6r44jhyWmzfdLgG2U5iLWyeDAhi+XaGAYpsqqk3Qi59rLdpiXMn7UEtWRrkC4VQ2h0PuurSSMaL
	OSA2jBsxwHopn0d/ZaCcGAd8dOxj3/dULHB7e+rxReSbq8zoUQ56xPqvds/YVPO625XMfMv6k4B
	Bf/vY0y4tLLOGKCseLyTgwz0KouVBNGPUTpgK1djP2mGqC3ezrZdjqK5NNhTv3Y=
X-Google-Smtp-Source: AGHT+IGfa5u00NusUHv1RPqWM+m97DwmOy7XWrdNZx0N6jSM7s2ck+SNVS3e6OLO/qw82TFFr5q2OQ==
X-Received: by 2002:a17:902:e944:b0:220:c911:3f60 with SMTP id d9443c01a7336-22a8a0b4022mr57928085ad.47.1743801488685;
        Fri, 04 Apr 2025 14:18:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.103.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e612sm37140245ad.200.2025.04.04.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 14:18:08 -0700 (PDT)
Message-ID: <67f04c90.170a0220.11788.e974@mx.google.com>
Date: Fri, 04 Apr 2025 14:18:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5168842698724274793=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: BAP Server test cases
In-Reply-To: <20250404193959.359008-2-luiz.dentz@gmail.com>
References: <20250404193959.359008-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5168842698724274793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950067

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      39.69 seconds
BluezMake                     PASS      1765.80 seconds
MakeCheck                     PASS      15.09 seconds
MakeDistcheck                 PASS      171.81 seconds
CheckValgrind                 PASS      236.63 seconds
CheckSmatch                   WARNING   300.08 seconds
bluezmakeextell               PASS      107.98 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      865.62 seconds

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
src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5168842698724274793==--
