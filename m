Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC5263C8C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583802; cv=none; b=cHigG2u7bcZs+UGOvYqpzfg9qt/nlvoUPhgNM1IsUQJjXm6dEtuLD3oTEVIExYCa1irUSSodUp/AA5AuyOQ32mNsbfbyi4bRiQVoBLAk0yDrw5UP8jn3LxNayio/f631POvuW9VXIApPRKwhWbIUSl3hti7s4mxvqZJuJUWSyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583802; c=relaxed/simple;
	bh=aiZVhCnC3rLrFEfPFCtpn597GLpvmmj1n8am2o+nUg0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G+/+Jix80sIusIBwkss5Re9SxzwAOc17lQAq9xX+bEcDNKKVUIMfZ4w7G62d8ilsRdj1E1PfqRe8CHUGydxvvnIGHw1J9IsPc9yqigw6j9DBeQ8h9FeSAtRM2EO58rcuhCRYVlq5AVm5naBixwDlSuaXI68Sa3gx7F66P9wtnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjpudgCy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjpudgCy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5a196f057so126322681cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749583800; x=1750188600; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3OD6j8TFJtQKEVCGiULhw3LCTMHqSkfY1wkvnKb9iuc=;
        b=JjpudgCyYdTJ8nqziM+TCWYaLQofY8ij2K56p8EqZ0l2GToyor8RJEOXR8GZKv0WfD
         Rphh64wfeNNqYIVKJrfHU1NbnCocJItvN2H4SxDw9c7IM0ExdYWvPiKgHVtCdqZnBTY9
         kJea480/yzAKernm2/tuFzQDtFsXAS6bF2mZCV9Vq9W1hqFibqXudpuYx4AMPY69jw+1
         EXtaSWrzc57CTz1MFXxMUaaZ0E4Zr+H0nBFZzcqarf6z73puJXtuJTOgzihmLuBSLong
         AvaeDSWOXNvcQlqs9No+EED1P9DJ1IEVEDdNNT1O/AbYZrn9dmEqYmUwiNR1ctfvUIA8
         sWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749583800; x=1750188600;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OD6j8TFJtQKEVCGiULhw3LCTMHqSkfY1wkvnKb9iuc=;
        b=smIBKg8qHBmLlkPFPJ4b3NJzghtSrTmKDXup5xl1Lm4/kVlnYXQ1rueJwRgmbXKG6+
         ZYT2Y6FIfYom3ESX3RyI4V3x2ZP+rGH3t972YhBoReR5JVXT96s7FqW+6IE6EKdPNd5N
         fG2diElGFUhrsO2/V5dK427NouASi9Wade5KtGWWAo7kuLS3Pp3N09RSmmARPs9qiBmE
         gmcwOjHgY5vwuHx4uNtuZfatek3QR33A64Km3nt9jOAzGgy6dmjygeNKFoUlMhe9Symm
         wq/3XEeeR21LMs6Ssd5wSrFrXzu6m/lujP0JuTzLnTP+vr1ip3akmV1ktJD5xEq+CD6E
         tofA==
X-Gm-Message-State: AOJu0YyAihz/NhAK++9tXLmpGpSm3AXt1WCqeUEBx18oHkmxUYt85DRV
	+13wwtIxSrxtswcVqms2a/JORLqzsUsAHXVNvRl5B1pfPNDAcbxpQmHWqdL3dg==
X-Gm-Gg: ASbGnctARInFHQ0JeAvE/o/oP5aScIEmI5CfdkQev9gxPp0HixZMKZHSGtjHjTp7P96
	BS/JDOa8SzzlTV2VtY8G78pdVkdm5RZ/O7c55a3OLCqoz5dMxju3t9Wx7SWE85M73xDnwptQ70D
	n6Ed6plppHg9nw/SzMuULgA7cqqKnqtQfCJ1qs7RRibcNZ82b/NhqU3acZLk0VJr3KtwbKSpinO
	NQn+Xg/0R4iLqHwIBQyLvPzqovzAvUTNnGkTPLoQYYzRj2YBEUhmGcuNIMDOozZOmvfkQ0faRDl
	TQemuVcpywXXQCFjxcAnfHWqo1a0sYsIxcsVK7CmnpQ1E1PUyFAY3vJ3jSX7ixIbJH/img==
X-Google-Smtp-Source: AGHT+IFOjKXK3IF85aOt5EgsYh1IA7XVQB7unYuN7sxesZAJ6empcB50OZ8TJPHxdSMWx7Lcov4HvQ==
X-Received: by 2002:a05:622a:608f:b0:4a4:4103:f301 with SMTP id d75a77b69052e-4a7149e9f27mr2305241cf.0.1749583799908;
        Tue, 10 Jun 2025 12:29:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.31.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6ed65aa0csm65872241cf.25.2025.06.10.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:29:59 -0700 (PDT)
Message-ID: <684887b7.c80a0220.c2777.fbe9@mx.google.com>
Date: Tue, 10 Jun 2025 12:29:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7012268152099924248=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
In-Reply-To: <20250610180244.1133512-1-luiz.dentz@gmail.com>
References: <20250610180244.1133512-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7012268152099924248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970489

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2677.23 seconds
MakeCheck                     PASS      20.83 seconds
MakeDistcheck                 PASS      197.11 seconds
CheckValgrind                 PASS      272.88 seconds
CheckSmatch                   WARNING   302.29 seconds
bluezmakeextell               PASS      127.04 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      899.38 seconds

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
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/bthost.c:668:28: warning: Variable length array is used.emulator/bthost.c:669:32: warning: Variable length array is used.emulator/bthost.c:886:28: warning: Variable length array is used.emulator/bthost.c:920:28: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7012268152099924248==--
