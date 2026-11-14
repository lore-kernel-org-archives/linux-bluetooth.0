Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672969;
	b=1XYz2xTWRAgrzGcXOIFpVMPNkHwy9U7FNd8kQHU0Qe9uJ7Ru+XryYTsCJPnVg/xCpJq8
	 nb1Sjt91AGJCeJDAHsZBqIRpy9LXvOJtKXDwtBiTqf0UikSCzx4u60EH/K/eyy1jzPuMQ
	 xfI7cu/2S12YS+x1Axw0tY9oKDRi30HxCFwSwaufZnNtTCZsaIBSZGdAgHWxh8HUFUPtj
	 O4BWTVUKKiZmzH0YAMYZo7K5jDFIDZ77lr+hJDbdbS/GSoVUydEl7nZIehdu977zRQrDU
	 AwkoOvyq4UEtih4aPj7IDgT396TjT+nuLfNlS6fjHEXDVe+vonSPYh2Cv68lZjQkLkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672969;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=125l7MOxbVHbhGudwwrdjbz9WLUhsq9LcYtjiXE2fnQ=;
	b=IcxHmAAVkW8fEUNspyNrKJj95HGixSblmP4Jh3uTjppSOWhKY6qpjbsRyBztI9zUOBHv
	 GqGUh9TZnZVR84LZkzDoKLdquygAYOhDkp586dPxATfFCGBCB6RD0EUX3vK5X7/42FHit
	 OVjZSXX1KLLndmFkgJCqTJkQqz2BwHGiH/TlPNUwemF3nrx6KyXCSGOhqV+YSPNGAqwXw
	 0q4x0u5CC9eyHDDZ3sd3h17AYhqu3DDaeQubqJdvmb/Q2e5rWklUnZ3ECIqqCz+I/E7Uf
	 0TgAEskDPuVubmdvYH7Iw2wQMoG/h2JU3PaWexTAN5kd3teKN5vrnstxOLE0OBlj0fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=5hVpRiuN;
	arc=none smtp.remote-ip=79.135.106.111
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA22606A323
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 16:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA22606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=5hVpRiuN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794672966; x=1794932166;
	bh=125l7MOxbVHbhGudwwrdjbz9WLUhsq9LcYtjiXE2fnQ=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=5hVpRiuNFxPuNuHh65fJ41C4lOPzmdgrGlh32RVO3/RlXoj12CoMzX1yHkMSRv6Mb
	 0nYaF8aqAMWDlDF8rzi+6k+ZsCQYcqTO1D1hm53r05x6hOD1pMlaUYcir/Wwbtlp4z
	 LRM5LM7jlSSZ8tcIL0dOdCR3OKhhyDYsu7W02VyoGXhDgv3XNt/oZdkayq3NVcK7/O
	 xtveI+Z7JrnaDAERWkL9b2uD5ySFKqK756csFR3NzKaW7g1PXu0qu8+d6tmFm3Rj13
	 gBIbwQb3n5Y9edDynNuUFuYyaG00OLitWdGaIimtMVOFiFnbRkUd/U8nDni9atgaYj
	 J3trEDeurW3AQ==
X-Pm-Submission-Id: 4jRfPc4wTrz2Scmb
From: Michael McAllister <me@michaelmcallister.org>
To: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 16:15:55 +0000
Subject: [PATCH 0/1] Bluetooth: hci_mrvl: Fix duplicate serdev open/close
Message-ID: <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
In-Reply-To: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de>
References: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Markus, thanks for flagging this!

You're right, hci_serdev already opens and closes the port, so the extra
calls in the Marvell driver aren't needed. This removes them as a
separate fix.

I've build-tested it and checked that the duplicate-open reproducer
passes with the fix, but I don't have Marvell hardware to test on.

Thanks,
Michael
