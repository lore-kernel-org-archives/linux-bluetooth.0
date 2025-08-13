Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2F2D781B
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074223; cv=none; b=clprL6Ytozgg6toKDdLgoHDF/61h1uDJlCz/zBisxpdhq4U4LEZm3rW//YXQcL2hBpBvd/PuMfql0v47FCS+gsfaarFcUhuGkvEsUshXIeXGvnD9PdItSSbJpAakJEG1gXMx45kBDpYc322XtKZ8cnvdEhvtmAwj/9+3uXC7Tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074223; c=relaxed/simple;
	bh=Er6EqZVmtCoAO+g22D7RuDLIqkk07azJ9+7ee0DcyGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TtjXUkDgtHIPSxPLGjz+Y8ZRTbOHhAUBLmUi13K4PX8wi6P1OAqLzMsO7FeojU56l97RBfTRJtXTyK2iH90Kzx2poa3wpSYgXOd7/vI64lUdy0MjRg4oYeBtbvL3iDUgaq663XHxHEQ2qY01hyqhf539PAzRKWV/F7rnY5V6BxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/NA7H2J; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/NA7H2J"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88426ff60ffso64630439f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074221; x=1755679021; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KoNPzIsfdg3d4jhwXN6A5mAjMULheoyH0ks6Ca1K4ts=;
        b=j/NA7H2JpvkqSWMtDs/g1QQOxZdORdVsvp3d6BFABWYmKryF/gPbNel9kfW2gHxXni
         eU6kyF+Yfj6WWF3uVnxQOTIhJIoZkfiTvg4He19qk+FtTK0aIUXnK3Wh/8RYGQJMKgRn
         C1czNT6HvDFIKe3RLiw+kQ+4zprx+7tK3pENlF3ukccreSkPoWEzM7rawrA/YenIb/wX
         T6LD9zyKTSaAt9CEgGsXTPFT+oAVeArAXJUcMbMBAVJnajGTQ7owF8Z70+oXgA0o512X
         rcofO894oowKvq0FlIPcoXYTOHuqolRzdGeDt5beMLsqyEI35PhADMFUTwoSYTgN2O3Y
         BiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074221; x=1755679021;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoNPzIsfdg3d4jhwXN6A5mAjMULheoyH0ks6Ca1K4ts=;
        b=eofGRj3PXk5PzIOUc6dBKo8AqRy/7zMfVyKEMz7+qbrFZetJ+5ekS+lfaFm9FyEeUQ
         3doi+Wo66ruDpKDcNRIev89l1fObZApog0vg/bL6FmysG6tomG9u6bNs1lcTWNJjJBQY
         6PZUwzylZXP8bFKEmyw2vsT85tRBs0ZPgI/gXTOjFIwexspeALGzgtG1FWyZKJHVgyO5
         MbBwadlYEcoThSy7gq/hGYh9nvlZtigCOlc3BVQ7wCr6Qn6fOqSu6ahkVq6WcKj6RHZ6
         3Ce9oohaLKRNtbJx2CBLcBAT2n8UMJCcoD8lFYizvXqLIoZiBTBmfK6SSDCN34tqVSSu
         1ibQ==
X-Gm-Message-State: AOJu0YyNZ8up3t+vvhOZfNC6+0B6DiE8Thlv/Btu7c6+ZLRarsS9IQPe
	ZMAoc/0db6vlFRkixfLJT8bwabKgALqAMC1rjerSLBU7BZF+a7g22KGyBHVD2w==
X-Gm-Gg: ASbGnctk49wIMIzYP9FxT6Jv0Pmn0834lWmArA9Dmxz7QFm7WdNTgkHyPZBYLR+1Qpa
	l0EyDHPbRofMSELeZ5UymqdA8+gXy0rxuncqKYSWxHzwJEclDw40DztGehwkvsQsStKKAZq7Ncf
	kaAzayoEEcZbBib0lU7nMcweaNDRaG3cMJedeWdG+6rsaeAG5BLHt8LdCM/JeRd170NUEEHYz2Z
	lR/ZUOV2vqoc6slLce224sydZp7S964duPLlibwJSSfDJI6NwcaCIkyR9qm0V2+PhUk5bxnsFdY
	y2SBzPYGaCU4ykKIYF5L/9z0G9Ow0zmceWdLCSwOaKP40BqfRl4hT+EMlXVeLWKDHG57juz8Am0
	HXjZ9JBF7PUiCzfKnFJiKH8/QBl0y1oIeT6KuqtTP
X-Google-Smtp-Source: AGHT+IF6Ip1h7EU4tT/ut5L/HvDZcgWm5aH02dS9ipleBdvCTc0MTrCr2Vkr22jqXxmx3e7XwviS/w==
X-Received: by 2002:a5e:cb07:0:b0:881:776b:62b with SMTP id ca18e2360f4ac-8842969ca92mr361488039f.13.1755074220570;
        Wed, 13 Aug 2025 01:37:00 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.160])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19b34aasm433883539f.27.2025.08.13.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:36:59 -0700 (PDT)
Message-ID: <689c4eab.050a0220.22f01f.6f98@mx.google.com>
Date: Wed, 13 Aug 2025 01:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8786746013445328397=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] As a BIS sink role, BlueZ currently defaults to synchronizing with the first broadcast source device discovered by the le discovery procedure. This behavior may not align with user expectations, as it removes control over the target device selecti
In-Reply-To: <20250813-adapter-sync-bcast-v1-1-4a739f99c156@amlogic.com>
References: <20250813-adapter-sync-bcast-v1-1-4a739f99c156@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8786746013445328397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      2636.34 seconds
MakeCheck                     PASS      20.26 seconds
MakeDistcheck                 PASS      184.20 seconds
CheckValgrind                 PASS      234.85 seconds
CheckSmatch                   PASS      307.49 seconds
bluezmakeextell               PASS      128.51 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      909.82 seconds

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


--===============8786746013445328397==--
