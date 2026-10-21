Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606077;
	b=HwA259uGA96VjzsU3hjmuRYWOLPj6bIzhHkUXkp90hHgLMVplF3tOx53mvmfugE54TKP
	 MwJ8u7OkPNgJtRWJj/WHMGb40uR/w0670eVeLVfWbjqWhTb3JzGr+wzrv5lcQePC2WWP+
	 bSLNTguaOjtHpGXQtthTbyZ7kk2SjWLfmiwGXiX/v/viHOeQWpJtytYeGPZ9PX6uLkWcn
	 L3clMAGWk90QxjkD3sJtAhPzwCB/nBgJaYvVObpnOVxLdp46PBX1E2iv755RyHFo/B1aH
	 e6maLm8B9WBipKlCS95HViQV+IWo8UtqaAEvWkzL+gleGTOAXiCotK+aJW68SSORXOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b7p6neCdKTCeluMRnM5H89C3yI9zdGAWd2qYWaPcdKQ=;
	b=kBBkhkSD9+t1dVW1mbmZp8A4SG4oK5ID6u3jonno4lw9E/BvJD6+pCFl14LTLSmRIMqS
	 hHDeH+7csk2nBAkpQeYQaTBUjzyoVhxIGVgOFzujPOW3PgDl4wWTfLOP0lLWhseslVofa
	 tPloXLbm8u7c418G4ju/CoNrzjktsk9ETQ69yiTTjPVbaFYgbvII/fppafofZcuQonHNR
	 9pv7xrCWLk9MRHQe91/Tw6+c0pBH5PNIno6p1kl8S8fdPY4L71r/2iEKrYLOMisZdpRUz
	 +0I+DJ1wL7ZfYsF/wFVLliDPpncuDqkI7Dra98e19p1NeOxrZNm3JY8cEZuU70JO0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sjG5sJn9;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56675606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 18:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56675606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sjG5sJn9
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so2333441eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606076; x=1793210876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7p6neCdKTCeluMRnM5H89C3yI9zdGAWd2qYWaPcdKQ=;
        b=sjG5sJn9EhgUWy5TrNZwpamGHzIzoj9UaSIXy9Dwv1d9/vHWsmwUz8+GYFE2C8Q+wN
         t6T4QCQZrVJTqp5vsJk4NspjRmrGWHutUObUGznl4YW3h42s2Er9DrH7N5c2WHxlRH+s
         U588SCnfHXCl7RSJQtsSwiXAOK3/k9tIFF0BwRDmLbr7q1RHoa1elzOrKPgDCDvm4Ex8
         qCaJhduzYBExbAnQptUmfRiAQhMbfsMuA38AM5MypAh+5cQp0iSiI8lmPPykSJrJMJqK
         cHGGAEeDLHXgfvBlttFCYlGuHVo6o9V6Em55TsXe2SDirX06fjDrVb6AsNFMp3xz8lDY
         SOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606076; x=1793210876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7p6neCdKTCeluMRnM5H89C3yI9zdGAWd2qYWaPcdKQ=;
        b=lcvbrMi4L/ZmtPBzPCjSx5SDm9+5WVeJfNSAgHy2CKt1YzL9BNSPQh8F5ARkZCVmJ1
         h4f98bED5Eq4gA3NrxAxfk4sHidbTSPKMWAZXD71w6TFVMMV9uvb/07I0BnoqJVv1y+Q
         guTF6PJggK4EeDm+hF1F6zbWjaKwusnxpc/nsf6LbUWuxJcYju3xJoKwB4UJeWqq7Tuk
         vilsCG9vqGAM+JiWFoIya5hjkdluE4GFHdN/gpcpe6X79k9dNozN4T+zKtF/5MKXoy69
         CH5BB2ZcPqHqvR8MHyllf+wumRy1jGp7QOR+m14aw6K9M7G5a33tyeAh56hdtLobJlCc
         i5kA==
X-Gm-Message-State: AFq9FYL9aVZG0cu8pwvc5q58qotoEjAC44zWRrhGQrifpZ7nbLq1dVNM
	MUtx43WZr73h2CKb3+500qP7sK4vug3SSfFh7d+GtPZCJ946iXmuTiDP7wajnw==
X-Gm-Gg: AYBFou3ZrVkEMSk1kry1KnCBPu8xAGoIa4kprchMXbyhLXABWAmX7qzUI0Uhtv38WDz
	wnGk+RO8bQ3vpFZfGCq1O8AmdMnDLZDjfABQShTU9tvJPNwdvZ2i4s+OTEzOHeteg4M897Jh3yk
	XPtv5d/9IeE/iWN57bhqobYhya23a83DLTmYMeyvZGpshNLnqMdwajiVyVWVIJm2MZYjY1KwVCT
	bCysjLVllIlY5BPmmD2oA3ozrN4zCVk2gWuxoU+1IE2fD/9cNbPmLLvFfRhfqIZ+rU96UTnuUsq
	w7eq02MPna8ynCLODoKIlWRN8bwvxBBSWJQWGg7TL7THmrko/7+pgWPdVQd+CCIuNMIQeM39gKA
	UF/wCDymQPiU2n9YWJw82O3ArOYDrueCAzJat1te0qbEf5OVKxAPbc+DDtkgyG2iwgMqe1Vw1Ca
	XXjN1f37zbFw+eJUJfaVRKd3IWAtOMojYOFc/f9pcvPecmDIAs22X79oeI9nrLy/U0Zjbca14qR
	bohU2mkyNyysBOp6mUtlQzygqFarNANaPumL+WWH46XYeYI6XWOq6ZzxwAOagg=
X-Received: by 2002:a05:7301:b8a:b0:368:2548:c078 with SMTP id 5a478bee46e88-36825580755mr1666713eec.17.1792606076299;
        Wed, 21 Oct 2026 11:07:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bc89fsm11112195eec.16.2026.10.21.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:07:55 -0700 (PDT)
Message-ID: <6ad8ff7b.be2e0958.24e6b4.1a25@mx.google.com>
Date: Wed, 21 Oct 2026 11:07:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0414674285681999995=="
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
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: check FIPS status before firmware download
In-Reply-To: <20261021130424.3042597-1-kiran.k@intel.com>
References: <20261021130424.3042597-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0414674285681999995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190499/

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      7.16 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.84 seconds
CheckAllWarning               PASS      35.19 seconds
CheckSparse                   PASS      38.01 seconds
BuildKernel32                 PASS      30.63 seconds
CheckKernelLLVM               PASS      35.04 seconds
TestRunnerSetup               PASS      720.87 seconds
IncrementalBuild              PASS      35.13 seconds



https://github.com/bluez/bluetooth-next/pull/973

---
Regards,
Linux Bluetooth


--===============0414674285681999995==--
