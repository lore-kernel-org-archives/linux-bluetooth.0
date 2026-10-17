Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5B2472AA
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273562; cv=none; b=dIA1tg/+7n0rtbigrlTP4I7MWZtlJ5//UsTOwsB86w1Ixz8kjFiRZiRmhReojCiCsKq94nupGNQj7I/URtk8z823EMjEZlNdqFW1Se5pdoCQKqCUScvOSHWmmH+exP+J3Sr9Gr3bXezxK08ZGtJdu9YS/gikzs8droT/ejBfiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273562; c=relaxed/simple;
	bh=/NBwkIibRNbsnD1PboLaX9YfZDL+MzTKv/d0W0tDS9s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qxkpATfLK1XX+WrL6GfTn7GoBA1LvXEvUjCmQptwRXYkiENdp6w77pTfapjy2RCNDFdlotvhYTuugmpt5mSwCYk+mY8b/xlxCxFq1neQNIQRNfgntWrcgvsbudi0yFSPl2Pwx2xsxr/yXunfO2eB/oL19LkrKfRyVKzAmtJZPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHAByvRh; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHAByvRh"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8439fe796ebso586280a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792273560; x=1792878360; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JoZiy2FX3olGCFu7Jt2eTX48YpfAOKsuUXWDakP1A/U=;
        b=aHAByvRhfbp8gBSefLijJ/fyZjz8YC1HpPjQoVwwHQ6mheUCVm4mSFAOrzWFKMtlez
         QlnpP19B3xyoX08KptsHZxJ7trArrtDVklOvQ7osos1Z4a/9Ld48x0pPggC6I5iMj2OZ
         VgaLEHx7cPWAUFeLjTScqt6Hq4kRddpw9ZLTPLY8LRSbE6ecGfm3w4VDyMxerBN8Vql1
         J4stdROaKhM7IeYHHV2IMJvYn1so37gI6f/bIXKG0t819U8k1gel655h6LzHCk7+J1nJ
         +Z7QKGIRGrgpQS1YkWkdvniB8ZQXbJuex53IyBeIbY+dVd+/7vXb0N8pp9XZXAx5g/0n
         Jmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273560; x=1792878360;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JoZiy2FX3olGCFu7Jt2eTX48YpfAOKsuUXWDakP1A/U=;
        b=AeJ1PyBzxwMbZgNV+0w4Rm7VlV9wEQql1SeZv0tzNL5hvlDovAiFegb5U6bWPq4jLR
         /pRmBj0B+DuCx4YMop5Jr839yTUmWltrZXmFoBjWuAj8fS/eChp+OPIedriKGLAi0Dee
         ACDSsPVXLTwSpbCuwWbMr1E9Z5UCIkcl4uQOBPcqdh48puAYONZA3kVSymUR+DqqXB6X
         MJet5SkfdlzrtMsvTdm3lDqvuc5a8pNSlKu0WaF5QkNpwQegMaZO+tQSt2pzGY97rKze
         qt+9xL5dUbZXRQ3atozOfGjtA7BHWo+3twMdvP8wa03Dn2kITyRrDGBiYhwfWjhkBbyM
         Cdrg==
X-Gm-Message-State: AFq9FYKJKuZ0xCdjTwHuOOlufU3coHz2qaYiuMsS6lgUtSGeyjguKjJb
	2MeSIH2b10l2EzJnGpHBzQbPMGw1xSHWBnR1GDK12mLu5W5QnecuSNSkXFLWeKeF
X-Gm-Gg: AYBFou1M90NPIRC3e3GgWWhPk2agw+grh503o31/tsO/phvY5wcIRhKomhlO3Pu++wZ
	nBpXRv2dy7e60P2yDrPKwcRIGY8i16X/RZEjfmyUUIycsJFx2xP8kDgw8SGsH1R36+EuGo/HNbs
	kAUYVYTeW4D/nJBn+RBfrcG8AWhlS9xu3zVl7wQw3h342jPjutMuY4bein7PYQkfDRBd4Vn+clk
	VKiwrE2/VDgLmEKYy/P19AkBefpEaVB3OH1DyRBIVX9F0U/eIhu+1rIibz4DAldfupc20YZKNpZ
	q/2D6zA83RrV++E71989gjircC1tpQiMsymubo4jbP0blBCLn9kWtj/FBXb63KO0u96v8SWEwJ9
	DYNbDc2SH1ZmlhPOOqC3OWTE7TRsw8VBhJvfB9C4oYvpe6fDNAFUT4kbgJ6Riqa6XXXvt0enMw9
	I27dX8uzbiW7yPQXBquwnLsQn10tEpHTkwooN1NshCsgQcFDGPcH3Qy1D9eBf9knHlP4SA4eDrf
	VXLvUxC
X-Received: by 2002:a05:6808:4f28:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-53cd1cb5c49mr3649197b6e.58.1792273560179;
        Sat, 17 Oct 2026 14:46:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.169.254.169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-538901a7b4csm4087544b6e.17.2026.10.17.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:45:59 -0700 (PDT)
Message-ID: <6ad3ec97.e5f0f813.53615.3c18@mx.google.com>
Date: Sat, 17 Oct 2026 14:45:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0504821581216640970=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [BlueZ] monitor: Fix legacy SCAN_RSP PDU type names
In-Reply-To: <20261002200025.4418-1-kevin@simpleble.org>
References: <20261002200025.4418-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0504821581216640970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] monitor: Fix legacy SCAN_RSP PDU type names
   Pull Request: https://github.com/bluez/bluez/pull/2624
   Created:      2026-10-02 21:02:04+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0504821581216640970==--
