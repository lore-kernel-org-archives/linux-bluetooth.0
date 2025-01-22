Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258D213224
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552260; cv=none; b=ZViVyobILxbHjF5U2OwdQPnO4qaeX6jrOMXQaapXMYz3L2lZFSnUqwKisb23c2y4sD8Pr3A6ONl0qJiTz/SsoR0JKT2GrtOBux8fa0cbIzpvdUhKj5xY7icYKeT5vqaXJEcBEdQw95ATdCfg7THR3r1ro6xSGcTLk/ztSuJjkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552260; c=relaxed/simple;
	bh=ptkwhp8H2pmNgHZ/FI27vgxTRE5kQvwGhYkQuhLF9GI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PRTPPEJWqk2nbmeyOvdaQ/5nxQNZZ8wYNaSxVI79QNfs4kJZmeVFs8jVm+XUPR+eltPY17wsI34hBYJ1F1L+P1362yk92SWCtgK1IbyxQyPQe251SmbKxrlGsSSaMJcsKWzK8jF6wQLtAzTBRZ/gU2sMJBCUoPXKeODlwk8+5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2BdPHfy; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2BdPHfy"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e1b11859a7so32287536d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737552256; x=1738157056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7SAmhjJSEwWoPjoqSwpWEtuWGukUsO6bOTpj+S1CZ0=;
        b=V2BdPHfyWuGqaU5Pn9Z6WVv9W4Ml/zeRVgjDBJUhI6bTbkeLbU7uoFLV7lZk7jWVON
         aybHlNY34Ki2M+fj4FmveHUmAGSlYPJyGgm8ZYz3MN1xcfGImfXXhBfTcjRZm69jnBMB
         VXYxixvOJDyw6k77/5LpZbYLIYQCY6PFxMoA2xpeLGLbgIPPEMPtwRrYu8JvPeYKXYal
         ltW5v3hMeDuezs9csiUVBtdGMcGmuEI3E391LL5H6Iivh0or0sPp6eM7rC9ibn7cLrm/
         4ly/EX02attlRyav8z8kAErepr+ouoNHPzfQjXlvwhno6etB+oTrlfrLWXzegqDpUe3Q
         HEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737552256; x=1738157056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7SAmhjJSEwWoPjoqSwpWEtuWGukUsO6bOTpj+S1CZ0=;
        b=kK4WNYKy4so1DVSi0Xk7lOUDk5BKjzpW65FKD1i211vX/ClR7CaI2bbc2nYW7zPfSg
         iyxdRsCuQKEh1ZWvEi4aOKWPP6Zmns2CSiDLTyMPrxJIjRRyAsQPlheASiRa8ALf2gZG
         3zxyK3eAIbEwCkWkzKUpBztPTf7dQIgMheG6x8RdBKA/tsi+6a6BWfAyRpVUXfTNz+vI
         MCy1773bR4KhwuME3pZQwu4tK+vMH5Cye+RZt0IQMLqCP1DbzYlI4/07BsF1ntk9AfVV
         XMfeMlLej8l5s0Hwgk2dcOj/wnpHNh8g9Y3wfNb6BnUWaEeQOSRxNjit89Zo76a2tbBY
         5fcA==
X-Gm-Message-State: AOJu0YwAKX2Z0uv66esHpyNvudETkFeGnqJA+j43Pnf8Fk6pslPfr/PK
	ZkSghYyx3pnq3DrQe/Ot9L5CvNeS7IkdUgzbzIj8QkSLide7eMpJnYolpg==
X-Gm-Gg: ASbGncu7vLkFW5NI/2izw459qothrPzRRGJMHdzIu0lgFf9JM30HoJ0/Q5dURS0H0At
	IIx0EMN6M0z+yLeDy5ubiVnfLnDzM2PkqyFzx7y+wa296mgaYR4O+1jl3je+dgzSqfEl+h1Evc4
	g3RZ1/y6fXxwXzz/PPtaZZmFUOkPi6hC9vztosIGOnRz7vduhPCr2OzG4A4wFl8NWS+UR803ggw
	8l1tl1ca8Cuz9cRVipR8JCYVUXKV3NPSDKt90Hb5lYApuPRPYaBe3Nybx+BFzadwAJHRksjoMQ=
X-Google-Smtp-Source: AGHT+IFx7PkOI4f2a8nCFXtQ+/ZMLk/GaMQydg7ejJ3nqhSrJZI41q4XFv3uVdP+iHZqX6pNR2PJFw==
X-Received: by 2002:a05:6214:20a4:b0:6d8:aba8:8380 with SMTP id 6a1803df08f44-6e1b21e61c8mr345479086d6.42.1737552256563;
        Wed, 22 Jan 2025 05:24:16 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1f46013eesm3207196d6.46.2025.01.22.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:24:16 -0800 (PST)
Message-ID: <6790f180.0c0a0220.60b50.0f6e@mx.google.com>
Date: Wed, 22 Jan 2025 05:24:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5420578729509390504=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: device: Better "Connect" debug
In-Reply-To: <20250122113103.1106793-2-hadess@hadess.net>
References: <20250122113103.1106793-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5420578729509390504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927510

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.58 seconds
BluezMake                     PASS      1499.01 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      159.69 seconds
CheckValgrind                 PASS      214.64 seconds
CheckSmatch                   PASS      269.96 seconds
bluezmakeextell               PASS      101.52 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      857.18 seconds

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


--===============5420578729509390504==--
