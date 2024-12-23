Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC8198A19
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952372; cv=none; b=oRSUWUqmnETH9wdG5bxsF9HRXtBJr0Rs+AYi6hDBANO9Z17ioXTrUImzGfBYnT3b6QHWpkpYmnc3qKKCHNdI4Aw/wh2wvQDyVIrBCyu3OhoTVTo4ackYnCn8d5Xms8oLbq6NKXVjfukFEUDUYbTDa2gpO8DfVEhX8sB8RSzl9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952372; c=relaxed/simple;
	bh=Dzkb+woZbidBm0Azp6J4IffRlbMThUI9+kYzMf5h4O0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jTexpavSpl6CwUAF9Vtn6MvGvoSK6/h8B9giJzH7hMZuaCfsr7YZ7923N+Hz237f0sri0gjG5KTC85bhbsRnMWWtDTc6ZnnGr92lH6Jr/Xn9qBc4p7g3DfK0hHFrnmJhtIQn/fy2Q3/gqQLaus7pveHTC2AtVIWoFrWJIW1bJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQYAoBSF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQYAoBSF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso2828378a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734952370; x=1735557170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+nMOacyonIym6+jJSYa73Fqu8v4NUVgKeEtVBsLl4aM=;
        b=KQYAoBSFSKtDTZOJx/E7yh07AzHfo1NPNeClbDYZ68jljx0w1Fp6mw+Poe4xGbyId0
         OrBxtimigXpZeQuVxiSONJGtG5HgDQG3d9xHqfGpIajvpucEXSEUbEZUy2yVOYcaSVnW
         ccG4kJmLZeCWLBHJcjT7EcfnGKElME5F+F6aCOImkVp8tkuQ/XEgYIkNexD19cImNIUl
         bkiioZmc5yGHr9bUHq0KO1r0e1xn1C8e8egVzmyl69N8aPW1GzyGtw6bLKwIZ0rxtZBZ
         +qfumA+n3uzwB4+LTQupgn5L/cRGYkkIO29mEDEpNA24r1DFk1VBGRw5TIf8i9QTR56a
         kckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734952370; x=1735557170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nMOacyonIym6+jJSYa73Fqu8v4NUVgKeEtVBsLl4aM=;
        b=QaLQK3D0TY3igeMRnw6sM5xpCJcim7QOgrIlg6UxhH3zjG9eEcaJz3t2EVYgbUQsqy
         +IqwuFwq7OH+ynuSw3J9CFBGee677ShF1UxwScLNZqqQgf6s9YtAngmydKrcF3zZOUcY
         qSaJXnBj9WWBROmf3F6Jn+LBWDOECHLMv9mEo6TeuhE0uUU7PfKL+kUxX42eOqKgBgqN
         DUwnWixM5xf8fzduZC2VnuM5HpgtMEkV6fUXNLqpV51/Y/vPTg8h2GIU9Klbs4jfUx5o
         SD6WLtF5Mwig+gX751zWQT/35YiszyNJolai2DW1R3qQZMWfGrfge6frUxsQTOwq8myf
         IexA==
X-Gm-Message-State: AOJu0Yy9DreAUXx7Sm3hVL5sJlXCw5RPGFthVfyscYS0TP3y8RWE8w7s
	s9x/o8JULDTAg64t9c+WHBBaP6tyopJjWcAqi/kzVtYzrtnzHaACT2FReQ==
X-Gm-Gg: ASbGncuKVnBA32YP2soJTUe1tyNydemDvqOLMZbgsf51XVATkdsGrs9IcN6ALeEo3Un
	R9IVXR7QP843xuUnUTwevbZ+opuJ+VcTeshVx2cxDKS6YR6dKcj2q4/y1LzU8SVopv+vShthv2N
	x+25Sih1eJV2vgWGNxlZeuJQ1zfb0WwICfd9ItF4J3Pf/e3OUIFfgWjOB02sKDPAqRbnwGYK7Pd
	U3iRL7y5/0NEEdX0Ode5ZuNwtc6kv9rHb3nw17EZKeoCraF1UnwFqEUaY8=
X-Google-Smtp-Source: AGHT+IHtIgpexzUU06C/fEm/EizpVwNgmhMln2vI0ZjSFEPlZxYQzRbjGC1Qv4fpPGTgSdtPsGILPQ==
X-Received: by 2002:a17:90b:1f82:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2f452e0a347mr18917563a91.10.1734952369854;
        Mon, 23 Dec 2024 03:12:49 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644d87sm11103997a91.27.2024.12.23.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 03:12:49 -0800 (PST)
Message-ID: <676945b1.170a0220.1a7c8b.766f@mx.google.com>
Date: Mon, 23 Dec 2024 03:12:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1815003062318829022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] Doc: Obex Implement support for message listing format version 1.1
In-Reply-To: <20241223095552.2193911-1-quic_amisjain@quicinc.com>
References: <20241223095552.2193911-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1815003062318829022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920375

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      21.17 seconds
BluezMake                     PASS      1583.10 seconds
MakeCheck                     PASS      13.39 seconds
MakeDistcheck                 PASS      163.30 seconds
CheckValgrind                 PASS      219.15 seconds
CheckSmatch                   PASS      277.10 seconds
bluezmakeextell               PASS      102.91 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      876.05 seconds

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


--===============1815003062318829022==--
