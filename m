Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E462E2EEF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538873; cv=none; b=E9bgkixjLx7B6Fnmk1gvVoJp+SX76se+w8JdFFfPHh7bCa6DX+fDNwYxXEBqbAIB2jn4W396V9vJP3AwNeVNWkoM+cSWr6cXuaBWMdtzDtIS/AECFQT2g/CiIF1akXovXXH2LaF8ObqXO/pdyj3GCawqGSZvN4y8Cc61ozc4cMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538873; c=relaxed/simple;
	bh=5EEFD4sNyNfWzc3ejsYRIQEjpeX/Ppos6igqSv/aVxQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fzXXbFSKLIWUzgL8SCy0pZWIOrT/tM0n2kM+kc4OM3/T3KJf4igrgi0qqawXfcwS92kLeu1+A+4yGCXmQ/668q3sN7BOj6cXT3kAt7L2tzEdfuzWLS4U+ieJnxCBs0AbpnIFuyJLlFqWh7jZ2roqd+//19IR8rM8jnKiBVCdyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGK9Lz62; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGK9Lz62"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d467a1d9e4so83254985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751538870; x=1752143670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxLyUNbF144HdzXDG+b3MtakAOxVh0qXUqBO9qz+bLE=;
        b=YGK9Lz62gfW4VS6agcoGap6SK8+t216gKzlX8bS8eGoBk06BacgZdmT6CmpcH1WYXS
         LE7lOz17viPrVxJMmQOhECvxdd4cq9zCWqfFCfQW8H8ADcWqm90Ob0rvPjYQk31wSE/+
         hJmWxX/grf32u43PZPz/JaB6Vpp9OH8BqsQFJWcCN2LjPMPDtjw2qqWY4rsdimycww+B
         2LfpKMSNno0ZcsSK2RtrCgQkwEJz7WO5e6+RvFfHsd/jiV+K/40VFTKuZH/Fx53tcURJ
         ooWoNsf9QNFbTfx9cZ32LedhrZq0bDdNZXkHWvN/eq1BRBHe4qEbYLF19NmOjbVinKgG
         DLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751538870; x=1752143670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxLyUNbF144HdzXDG+b3MtakAOxVh0qXUqBO9qz+bLE=;
        b=QNzaNSpUExpvng9t1w2P0eXfvt5jjHOOOdM0sJkXNsdDKj3GOhuJgvR8ha0qCuOGkR
         e8Et8NrkCceO7SV6gtCGIwFLavclBXntqyozcgVfaXUlrnG4SDUSdcE+Ra+7eZ7slrW8
         FCiGdeH9GXl5FIZuDNG2OnDPMyRCudgIU/gLuO1SwwYbwUoxqrChIJs2A+IMjiU5g9qG
         eMmlALrjlwuhaqQ7OWqEIBZt2JykkJdwUzgRl9DCK5wODyrQ4fhgnCSAmlgFgQYIVegX
         gpLyGXhBJztvYtexuyCBTMFRGIPfEOeUhzs7UsvVtelhDOUEhWYPRfcmqerl05YWu4Ne
         9ocA==
X-Gm-Message-State: AOJu0Ywe8t/4nvJWHhvsz4xvE3u4gw/bBfALnzvzS1EsMk807oF/8eJI
	cIyKW/un3h09o5LLB4R8/kDEukv9DgpcJph9kgjGmTo8c06er/xaoj///SLE6RCm
X-Gm-Gg: ASbGncsfgKrH5a5M0ksw87weCRMhY47vsQlmcYJzgI5giNkbv4uBDnk6Xtvyy4OM5Wb
	zunn7ITexxs61RAsErYrGVGKBjmHCvPg0qBMByReFOlyNAaCD7pK00yxR+t9iERmcCaantxFDBy
	DF0XnbmjhEcLQvwbtxrVBx1KN5jY+kvg2V5ZxHgCWu/EodRfy8oa8RRHxamVB6RIqmw1+eiqWCW
	GSXG88NeXKhtkD8Ani6yX5kzdcFUvtvcwYANwyoOyJiQe3ly2prgEcRALVyqf8rq4zEsza91W/W
	YZYJ2020DdUlJ9U+VrK7oDJZb1fqDC5tZZaTHQCbcBkWegsMXK3EmO+Ka/E4fcLwMWWRNyw=
X-Google-Smtp-Source: AGHT+IGoqXtNTw/SSLEIWP8Kr0AI02fSQIhK7gd3N7NO1lDxQqtk8Dt3gC7+6h3+/zNJ4/qhW9k7vw==
X-Received: by 2002:a05:620a:688d:b0:7c0:af6d:a52a with SMTP id af79cd13be357-7d5d443cb63mr164354785a.26.1751538870272;
        Thu, 03 Jul 2025 03:34:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.134.142])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44323ef1csm1081026285a.112.2025.07.03.03.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:34:29 -0700 (PDT)
Message-ID: <68665cb5.050a0220.1f561d.588b@mx.google.com>
Date: Thu, 03 Jul 2025 03:34:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2294367704121339442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix typos
In-Reply-To: <20250703085630.935452-2-hadess@hadess.net>
References: <20250703085630.935452-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2294367704121339442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978522

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.46 seconds
BluezMake                     PASS      2789.69 seconds
MakeCheck                     PASS      20.76 seconds
MakeDistcheck                 PASS      203.01 seconds
CheckValgrind                 PASS      280.92 seconds
CheckSmatch                   WARNING   311.11 seconds
bluezmakeextell               PASS      131.11 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      935.69 seconds

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
emulator/btdev.c:456:29: warning: Variable length array is used.mesh/mesh-io-mgmt.c:524:67: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1918:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structuresmonitor/bt.h:3810:40: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.tools/bneptest.c:634:39: warning: unknown escape sequence: '\%'tools/mesh-gatt/node.c:456:39: warning: non-ANSI function declaration of function 'node_get_local_node'tools/mesh-gatt/prov.c: note: in included file (through /usr/include/readline/readline.h):tools/meshctl.c:324:33: warning: non-ANSI function declaration of function 'forget_mesh_devices'tools/rctest.c:627:33: warning: non-ANSI function declaration of function 'automated_send_recv'
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2294367704121339442==--
