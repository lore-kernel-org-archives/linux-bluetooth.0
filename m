Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64C1FAC34
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942965; cv=none; b=gfABSh+5pPT5c5zNux9OQa34Shm91T7c7Xy3KhVSHathAiksuT55bCQgnBiYyR7Im6eCwgs3H4pk/KrPVn98mj3SsjLQk5w5BwOvoSH6EDodNII3kcdkWOry3M278HweWmf3us7ADug4X4K6SZju2rTPPTNbdKItvW3VKTwru8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942965; c=relaxed/simple;
	bh=SR6hauy0KPwJg23mUZdl4x3ImWKIjKbcnuA+KSlKtQc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Agd5cNmF1revCu9zD/66remJfkXimHxYM40gLbqb8e3jg8p+6JofcOwQiXnL9Atic+W7hjLNwOt5kvLa4m8UTLJF38yM5wwT9YGOUQE2+SrHlTrEKgn5ypYLNCTXs1wvPzlo9mV7KymWy1S84uHQ7p/nF0MZILIjmo94yXyU+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alWFlJdR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alWFlJdR"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e5527b96f6so9054235ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942963; x=1755547763; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hs8lwvvNkDIrGaOs8UgZ2FGY3NTtnp9G4MluPtN4FOg=;
        b=alWFlJdRABVnj8agVD7ETZYZzvkm+eeiHb69+JxFRfkgV8PZkQu5xQggpgv8twzoIP
         udNVCUOBpKlG0FdVaagOo1/OWRI84FZkAAa3i+k/dfMLMdto4+Cn9VzFm0BGMYLsHSVC
         O5SWY3/ocwvrZuhGjwHWMRbrWuWdxoex60HPseuJ9IiXrP3md7a719WjGX5/rOd6bNGH
         2zRO2DW8sIbrqe7TtY+bVCKwP91vaiK+X2fnbwLBTdNQEeQkFGJgk8ox3n4CHrT0YtdH
         nBNnQVC0Z8vu9UAtivQqPStD0cv+59fZbQSUUTUIaLBjRQB2hddZ91BHGebcFxlbuRYv
         R4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942963; x=1755547763;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hs8lwvvNkDIrGaOs8UgZ2FGY3NTtnp9G4MluPtN4FOg=;
        b=s4Gt6uF5XIjYX9g+uGDR1BpGZ/tZTVGR4/9cQZ2rOkvzAfMcKVLbCK33Xb9wou2IsD
         gT0DZ4Utit0eisvrm0ibXI15+FE2vP6bsF0plcnHX31Auh+FY94JNUxrKubjzbJ3BU5n
         zq3OCfRMFtaQO1J6Siev70kV3eIrTiTS5xsk6M3JYjG1QerAP3jBk69SJ9szkBxTU60k
         Gi1Ax5b5JWjcctm6OTZH0PCgB8O2uewvZyGY/roW2hdc/qTvpZ3LIWDuxLexuP9pjRJz
         YXN3fH8/WRgSP4+HjRgqLD7/r4t4DRh7cf1e2NosA7T2yRuzvgSMRkeSuEFXkxP2QTov
         a3dQ==
X-Gm-Message-State: AOJu0YycZkkzhPOKhISG25qAj4jcVRBApqV8TPeKU6kwiI3KgAGLWlM0
	+E8Xtnwn11gJu0YsXBRRC4OfDb7ODgP3Y/Dhh1PrrgpJzimrOjefbJJx/qUJCg==
X-Gm-Gg: ASbGncvA9/FAM4AWGv9jtqSMqU9NnB7JLeUZD0T3xcEF+/YeI4c76iVM1ATwyOXvvJW
	FRp35DKHCl91j1Hjc0WwpG61cu0raGSois/BK9s4fN2eoYHUknQUtdrkdXpYpKYSWJ8B36VNYK7
	/MkeESRf7JkUM1w6S1kBcLcm71TEQBm3WaRQQYcWMTRR8YQnl/3jpIqz9V6Hxxs4xYeGoIcZqlE
	fk+4s3JbDIE/qLaJGrgXgoVozrJV4bJOmJMv/K39f/VxkokBcg14grZ3VPg7jtU7t0esEN+ExZE
	nUaDL6iOeoycTJnl05ccF/OXKdoKH+0cVezcAU+jU2ltgJrFJ6vlooEcVFEH+Y6Q2IAShZYkkvb
	IJFIMnO0ouLwLlt2MtEHdL0Ts0E5T
X-Google-Smtp-Source: AGHT+IEfPn4SEcJbbIVWBuAe1ega6nHfHc4jA9jxywf0dWpov4wtLOKwovcbcRCHUn8HsTF0vv/jTQ==
X-Received: by 2002:a05:6e02:3a08:b0:3e5:3ef0:b0e5 with SMTP id e9e14a558f8ab-3e55af453fdmr12524215ab.7.1754942963094;
        Mon, 11 Aug 2025 13:09:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9c88892sm2422182173.86.2025.08.11.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:09:22 -0700 (PDT)
Message-ID: <689a4df2.050a0220.1dda5f.3d34@mx.google.com>
Date: Mon, 11 Aug 2025 13:09:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2310085002443068333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] shared/bap: reset local ep state on stream detach
In-Reply-To: <c6ee6b6a02993e4be6d534d023358f5231b43043.1754938103.git.pav@iki.fi>
References: <c6ee6b6a02993e4be6d534d023358f5231b43043.1754938103.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2310085002443068333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990189

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2590.39 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      185.79 seconds
CheckValgrind                 PASS      236.93 seconds
CheckSmatch                   WARNING   307.43 seconds
bluezmakeextell               PASS      129.76 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      928.09 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2310085002443068333==--
