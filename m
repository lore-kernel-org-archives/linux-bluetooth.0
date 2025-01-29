Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B21E25F2;
	Wed, 29 Jan 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175479; cv=none; b=KUrBNqlkITzGvS4RkvWV1GG2QdX4NrPnA/6f8Ya9cPvY1nvSD8ykVJcBuI3tVcwVJwqE8JO5y/ZmZ+ob+b0EUnHK89RHqkiPcrZrLSBu1BYe8zH/KywGTWgXFUy2jR1EWgmj9etedTgg33iNNw8tmX8aGkX48bmc93L99SUEoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175479; c=relaxed/simple;
	bh=g942N+5cFH8Z7ggAYbYwuoCxKSmc/5Ox8xjlY1inj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1+Ft23KyqXVZQLkPg50lWzLwclU8TBo4z6yQyz9yJZJ8qUQzev3lb1tctZCVpeJ5iCOMxwebTNDUBzDRGizUuBLCvTzXD30J6azd67eVuks/xSLkfXpb8Iu1weO6CzW7WCOE/RiqdPr22z4CkTt+cc+wioYIxnwqh3ODJiiG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZXDzSC8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZXDzSC8"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fcbf3d709so2278823fac.2;
        Wed, 29 Jan 2025 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738175477; x=1738780277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBAmHsVRYatgodxfmWfN1c6yV3AJ+2DuOOOfnLu1pdU=;
        b=HZXDzSC8Saz00xl0hcohGZgDp9ljJVWPF+nhDiJx+EOPigEHqTl0GhNL193NptPvzy
         NdXNitjFRQWDtGTTarl6jKtZpO1ieZDpa+8vVlBYtTe+L9jCKUBU6l1L3W6hiMX82+Rh
         0HQBG4AnTgbKuBOrcKNDh3ePrcBBvkDpQhJ+nJCh3KF9Pj7/zB485Eg4KBJVfkHlGkdV
         XndwBlmAkSulCQGj+vhY2lbYY0GRtgKM5WUjFFp9JeXRCSYwLt6tHC1Yvq5vz8WV9vTO
         e2f0wOpU3hbYmUeB7Siri1HCNQd1cBKZ+VE4t0OQjLe1FCg5lpKv9NZoee9yuMszqqRe
         2FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738175477; x=1738780277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBAmHsVRYatgodxfmWfN1c6yV3AJ+2DuOOOfnLu1pdU=;
        b=KnPDmgSC54Ce3TfHVWl3rmIAVLWH254sCEbQ+tWwaCow4FjuQyEwZfieXJ8eMW0trY
         BLnnaifkW577Zmm3a2t5C4kKVHaDp7k7Z4nDzRXv3Nual1JNTXvFDW/f0bgOpq3MG7Wa
         zmSRp9HvjWmFlukqwCscFGUPfVNMHoAzmLayEogV+2Q7WAbaIV38Apkv7XvZN0jI4PYe
         ecPtsEetQ2+JLWME15CyOVP1QtU7kJ2KPUwhZwRMzdVOihEzR7E+EijhU+F5Qsi+qckg
         KauZoifOgVRrpoxQBszF1RIpDBLTL2yxDvYTxQvNLFaCcyjvsTKdGlP0du2HQhUSi1Br
         EsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBm0hSfH6KQWMb/Ud7+nplQMJMLxa2fvV283z9wvzh7qnRDjDSiSSQXCKusocSrrgaD4srpEJiZh65Dbsg@vger.kernel.org, AJvYcCViH8y0ZItkclEmSEJ3X058POtGGaB9nOZDErJQhmaFj/4cGX7CGbMtJLM3IdT9ztTGZEkDkPKkftJ3MUZPhqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgoyah1TL8109Ig6xftOiWjnMFXlk0cM62qSYJmO0XYraSxMpQ
	vcqF9LgHWD7gF7QpNVPuvcIMs2al13NWVx28VSR3jrtfdLLJEulNL4I6Be7W
X-Gm-Gg: ASbGncszExizJI/JCWDQKS/sJOR9nEZrx5Biemn9BJV/uTk95x9G8Ws+Crr0fdBOqHf
	I3BdBqApUg5qDUXBJ7SaUA4bNsbZAMavXizqZdb8HBNUxEanvS0AUeDEm7SWSi5whf2+KgKGc6x
	+ddZD8pWY7XeFYxaSCXWBna5kX9s6hpzth2XN0o/vwyeWcglZ6D9HitRCh/DvGnmZnfMpOsDRC5
	LAxqOZijRSc0hpDZoF4Ln+x5R1mIpdQBZvaFCjFRPDxAvZhjFSEiRbRox03XAYMbQXR5ehGcNiZ
	nDXKs7wPlMRrQvLmExtkmo6uSHawyz4W4jLi
X-Google-Smtp-Source: AGHT+IFoQgrhZqWDNWjsi+GsbUHYEMoaVrN1HbdaP4CDNbX4DiAKWLHn2kW1C0kpPifUGxx4C7Cu5g==
X-Received: by 2002:a05:6870:2a44:b0:297:2479:a35b with SMTP id 586e51a60fabf-2b32efdb093mr2435058fac.1.1738175477149;
        Wed, 29 Jan 2025 10:31:17 -0800 (PST)
Received: from localhost.localdomain ([23.151.240.73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f4134e0sm4482433fac.40.2025.01.29.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:31:16 -0800 (PST)
From: John Glotzer <jglotzer@gmail.com>
To: rtl8821cerfe2@gmail.com
Cc: Aaron.Hou@mediatek.com,
	Chris.Lu@mediatek.com,
	Deren.Wu@mediatek.com,
	Hao.Qin@mediatek.com,
	Sean.Wang@mediatek.com,
	jglotzer@gmail.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marc.payne@mdpsys.co.uk,
	marcel@holtmann.org,
	regressions@lists.linux.dev,
	sergio.callegari@unibo.it,
	steve.lee@mediatek.com,
	tiwai@suse.de
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
Date: Wed, 29 Jan 2025 12:31:09 -0600
Message-ID: <20250129183109.10770-1-jglotzer@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <585f1075-a662-489b-bd5c-cf9f24291804@gmail.com>
References: <585f1075-a662-489b-bd5c-cf9f24291804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good news/TLDR
   Yes, so far I have resumed from sleep 2x without any issues
   with both of my workarounds disabled (kernel command line/systemd rfkill on sleep).

What I don't yet understand
   This commit
   (https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/drivers/bluetooth/btusb.c?id=v6.12.8&id2=v6.12.7)
   was a pure USB fix. My mt7922 device (not a USB dongle but built into the motherboard)
   seems to be both a bluetooth device (bound to btusb driver) *and* a Wifi device (bound to mt7921e driver).

   I remain puzzled as to how is it that the issue that is on the USB side was *also* fixed by
   adding mt7921e.disable_aspm=y to the kernel command line (since that would act on the wifi/pci pathway)?
