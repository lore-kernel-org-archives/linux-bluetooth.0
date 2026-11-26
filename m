Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664564;
	b=yXvhVNnTqoddtZGGLa61++FWTrEI/UDIOGc2/YiJyYYsMEazvlh7C3mmIsTeBHIFlyJK
	 Ony5OijpIpRpHXFHNtBeK/eMqBc5tHBpQDNdxWOpL2S3cTVoMSJlGyKm323Omy/UUmK26
	 Mn8xm+r7ScpqmVmKKxzp56kqxireCSlkVlo2d5EajJ5LrOZySn0hbDEl2YTBY8gGZpLDg
	 8AJzwzir2WQSiiS2XWJMyOXbvlFsVLaJ3Y02aAn0olHT5xO2wmxvtaTxSOf2SStpGJv/9
	 5iCR+v+/26+ZtYN9DweN/wtv/YM7ARRphnINZKrvjt5H6G7rtHCGmwX4NOvI0RmGPwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=vJPdSVuZzSbaKVPPWB25k7jAjhNyLJmmKRDirx6QXrI=;
	b=ra+gAx4t2NAAmHNDQyKB2hbKF0qIV+MrUajMcBxxQesIzeZynLvaIIwCaHpuGD8JRlkA
	 B23tDfsMYiWC+KTTmg9f/Ux3zZN/cOT7T93K9lfydynUJjAfCaByFArqs4yH+HwXVmxAw
	 P6DlS4vGNq9ec/mByf1bcG+owSF7FtdUW2ANO0dk9HVZGpyf7uKft3lnx/Cu9lgcWeM3/
	 +2YKCObXclD3JhJ2l2TnedwVLGNVaslGo80htKy6bIeoP2rur0ErWMTofML6nb3QhCVO6
	 kJzR3/3SvCb0Hi91/XGrk6+jPrBKZj+ce4+FRJ7UNY3HqBiO4jL5I7/zpTdMIZABU4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbCa6YR5;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188F606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 03:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2188F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbCa6YR5
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f0426a65e0so41458445ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 19:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664563; x=1796269363; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vJPdSVuZzSbaKVPPWB25k7jAjhNyLJmmKRDirx6QXrI=;
        b=gbCa6YR5TNU+x0At90nxg7cEj5OEmzYcPMeTfBIKpmHNFw2OVP/JKsmpk564rCtvsV
         cK6nGJn7ncTnvQAgWTgziebuxSqYMf2gRyj4qaBZQeE7RLKT5H/85aTO+1a43eMm6h8V
         y5e4jj5qiMFG4ehP7VEeapVQJLrFsVnvTedbONwtNyNTObYUdoqY0Oi2i3CBTJKAXKl1
         VmvBAXuauSD3TN11PuoufWwpWf/HDE/wAd2aWP3tt0dg0AW7h1Nt/pzIIyhNEHRFQj83
         iGUFIX7IDspdXa6dCAyxtXkK1hQ0cjfb02XmuDIs8IOHa4B7HQvDatxEV70Pga4fwmic
         2r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664563; x=1796269363;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vJPdSVuZzSbaKVPPWB25k7jAjhNyLJmmKRDirx6QXrI=;
        b=C9b+dD9edCVwHzmnE9WlkwNOKJQE77mUq4JmU1TPjvOf9iHLCKsLUGcSCyvPaZC1Ei
         YBgeSHqX5CU9RgnmO0Ua5oIohadqRwuPtvSlNWsgM+qO7zGHnBMyowDfQj1HjugYghuu
         PsjcSv8Ig8mhAhN+gcHndyMl4B8hO+H/b+TLF8CDkdNvX1pQk7neWwQNl7131ucjtsAl
         FBhhfXDZgMUzbh3JmfLOrF/1jeRXt9AJssLujXHpVlk6FX/Xd6Ik59Xrjqdfb9+SeEPQ
         RagPyZdvTXGFMuyFZcJ7nEmB0IZz0/sbKd8QUQFzrD0i7iJfFWj2XN1zm8SVCGMD+ubU
         Jugw==
X-Gm-Message-State: APuU4Z80i/gtsQlzGQoesiqE4yoUR4FJ/CfsOB52SQL57BCG1TRCxX+Y
	kvlbxMQmmdsgNHwyjkj6CchEkMKSY8hIcoR3tvLKZ5qp7sS2IQz+c/Ynwq/xOi4N
X-Gm-Gg: AZFdTZd+R6IGzJz2b+EYlOf/ZjDz6l0qf4bxYXLfo6IteUR6ReK79F+fyCo6meBRkfo
	EiXVlqxsCks+HnKyKfYScIubbB8PRWWKODgg5kpY5IEdiSaIeLHJAS7fKJG/kgoBRz8en/xdorj
	IWLIh+4Hxttu31Mg/hAg8+UD6KS6r91RuH6f4O3RzXYHKtrbTX6Gzm42N7EVZ/GufjYUL9DPBoG
	IXj0LJ6EuOFOvH+VfNmxjPVZEgBS4sR3fGP6eeDhriYO7A1h0002KYLPEAlQ5BPHMeP+PsJsa1g
	rbehS7grdZgFgCM99/fB0JSn5bzSUZcHu/VO6vB8FD3Wv3V03qBPCbmNr1JgJCIbpw22C8dBf0l
	4KpbG4mnu3DfgvTzGn22UxQoJGQDLyuuH9jWC9velJLh/3setn7urGCz10KZNFuBSBU2L04dIY0
	mB5YXOFrT+AfGoKrgxcwK0p+vDuZmI7eAgUNbTn5WX4Ro6fupptTs1yfSBUdtVyVjdcFuA2PBmc
	vmT4xOCtWshqeBsMJEfajO8m2rHHIh+ROZffCYZ/iG9EvUyFPwX1Ru4UGfj5eRSNU+lCYRKKgKn
	0xmg2zU=
X-Received: by 2002:a17:902:ec8b:b0:2f0:3e5f:2a18 with SMTP id d9443c01a7336-2f03f21cebcmr161218135ad.39.1795664563486;
        Wed, 25 Nov 2026 19:42:43 -0800 (PST)
Received: from [172.17.0.2] ([20.236.14.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm96903585ad.75.2026.11.25.19.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:42:43 -0800 (PST)
Message-ID: <6b07aab3.04260434.40df3.04fd@mx.google.com>
Date: Wed, 25 Nov 2026 19:42:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7858545630847264883=="
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
To: linux-bluetooth@vger.kernel.org, rosenp@gmail.com
Subject: RE: Bluetooth: btintel_pcie: fix context analysis error in YoYo config sets
In-Reply-To: <20261126000439.318058-1-rosenp@gmail.com>
References: <20261126000439.318058-1-rosenp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7858545630847264883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222708/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       FAIL      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      23.40 seconds
CheckAllWarning               PASS      26.86 seconds
CheckSparse                   PASS      29.00 seconds
BuildKernel32                 PASS      23.88 seconds
CheckKernelLLVM               PASS      25.74 seconds
TestRunnerSetup               PASS      552.92 seconds
IncrementalBuild              PASS      22.06 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btintel_pcie: fix context analysis error in YoYo config sets

9: B1 Line exceeds max length (154>80): "  drivers/bluetooth/btintel_pcie.c:1052:12: error: mutex 'data->mac_access_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]"
10: B1 Line exceeds max length (142>80): "  drivers/bluetooth/btintel_pcie.c:1110:4: error: releasing mutex 'data->mac_access_lock' that was not held [-Werror,-Wthread-safety-analysis]"


https://github.com/bluez/bluetooth-next/pull/1232

---
Regards,
Linux Bluetooth


--===============7858545630847264883==--
