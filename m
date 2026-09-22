Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FE4A260D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106525; cv=none; b=lgZ4Km8q/dkEhbqUV2zXYKK1sb++2SkzRUgZDvv+jeXyVTNwlaMBxV0L3UdCJJx1a65F8M0/8z182oh56ymhOTqplkR5L5J3yLBCyPvZEd2azau3kESKmaghpgcsOcMphbBdQGArLYRTT3kHirFKSIM2/Cf1DZxmPBVavzrUlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106525; c=relaxed/simple;
	bh=jNQfUoCT0rQsQDqvqd6O5D53mFke1F/vMOIqT2BbWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQ04BcFL0rIQEx7VbV7/Cg7/Ex8KXJDU6SYvdVhYyL4Br2I4aXp9cs2QdOZDAWBgWnokx6J5ReVGO0c5oYqz+lpUYynpIjoQNtll7QhAVZOGijUofo/f+FxBXZJPkCTvpgfMe3fHjL+5GladmNJX7JZLfuRqUJnz89mJ6DIC3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gU8c5Hm7; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="gU8c5Hm7"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1437b77c274so114731c88.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106522; x=1790711322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=gU8c5Hm70qVVuw24l07nxO3NySfo7ayObbRajNacpN4vIqkrQyUEiBW72XVJaNrHYV
         vQXwGb42GnE2asbbwBf6YD8PB4l1z8WN3+fjt2mL5vIZVBJo0ZHghTh5ckAMM1MHfA3W
         HzzBl5BnlfDPKT1K5YUFXdofQtCUkDDOuKuYqs8V9XOZ8Ep4E+w+3Zq3v1E1h8h0hlil
         ojGePFK4+P46QfDRBYKs4+ufujkWeaoyf7mUCMplo5u69GWI9ddv+5Bn100Eu9b0PC5c
         m09kNZlohBxIbiIFAS0hFP1Q4sZxGSR29WxLh4v13ATFxKw1NbXcRwzP81SLLCIOGdLx
         F0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106522; x=1790711322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWpsGs8VSxj7CDadxY03DnkBRPzm3FWyOuoPzRkUTdI=;
        b=nHOyt5EYeZpfFT6yeb5sAxOWXf4OAbgdpb4w0h+UHj25fNxEfLWA9KKaPpaFN6G4it
         xo/tiQhC/mhOY5IrtoobOA9DAj+v291Vv1W5HDKzRUZ2CGFbjtxtz2xE1IquMtAHUxY1
         OEGAH1i+Zj3+ElM5r2arnq+6H/Iflq4DPFCMumFkcPlnNLHrIS1Vao8t5LQLCvS4341c
         B04ym96JHksU+eNNKur2sWCAL271RBJCd1MmCMYqDZns2CVTrYyRJiW1YWHBJO8CgVhv
         nInFhZQJXkDB2hUbvBPg6LHEhbxrs6aHoZbfDaRFjXz7l6vO7tb15soLR0kuNV5rBVZj
         lf6A==
X-Forwarded-Encrypted: i=1; AKwUvByiPrYBqez17+UEYKq9uNRj1x7SHofHyHwapdE6paCSCVkDzemyYnhj/w95SsHlc8aLVhz9pr5P16SRgC/kpyo=@vger.kernel.org
X-Gm-Message-State: AFuF++kWWvSJQzHCRI9pujVDoxrLy4VJtXjk85/lzVx+02Z8bJoqxmQM
	masTRwJvr19bRnix1w2YQRS3qBmJMMJGdzRqv05NTfgxI+RhyYOM80gIwxIAht2fQAo=
X-Gm-Gg: AYBFou2EALdRG5t7JnlA2Ch12Bwmh6ojTUgJqXPup+FygtiWLO+vf8p4zqzBpSR7v9u
	gJFAmC+kvch18cDYKIXkGfysCyR/91y3v1xOaatJJMI5EsPQfXhk/0CdJcPaD5DD3K5qBunasNr
	Izc8Mp+7lbhrSH8I0norMOjQqHX2fHeTik4oa3G6CliFiugCSMxaNutSIA0PGXauKxtKk3NsODF
	EpWisb49iynIBmnKfCnjSkNYpEqCBH56eQoL5zW2cv7DwWrN2HZjFgjbv8UC/99OVNKA+E53yie
	QitHlowi7EsbukqonqTTWEOoZpqOf6RiHRG47Z4s/t1CVnf/n3VnbaOBFVAKmksLxwxb6lEysbM
	CzcgNwCAyhkPcC0YOeJp5DHFsTa9IvVufBVyXYHjOhponBEpuIqee0i29P3Q53yzQLVzOSkt7ci
	bsOQlRfbpQYmz+tbwg43NLB8B8Bpg79jOTMyNib+sgxwy4xMv/CMpgGahnLfFsJh6VIjGj3FnqO
	QAtlLuZF/vrlu1w7rpFplf6XNe/6w20NNgfcgBIo9Qhi2ucdWp2FwPKNX9bYfme/K8km3Y=
X-Received: by 2002:a05:7023:a5b:20b0:143:2973:3cfe with SMTP id a92af1059eb24-144f91cb630mr410014c88.31.1790106522287;
        Tue, 22 Sep 2026 12:48:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm708550c88.13.2026.09.22.12.48.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:48:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6.1.y 0/2] Bluetooth: backport CVE-2023-53762 to 6.1.y
Date: Tue, 22 Sep 2026 15:48:32 -0400
Message-ID: <20260922194838.26223-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and Bluetooth maintainers,

I am backporting CVEss still missing from 6.1.y.
This pair handles CVE-2023-53762 in disconnect-all cleanup. The
second patch is the immediate upstream liveness follow-up to the UAF fix,
so I kept the two together.

Both changes are already inherited by v6.6 and every later mainline
release.

Could you please queue the pair for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Luiz Augusto von Dentz (1):
  Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

Pauli Virtanen (1):
  Bluetooth: hci_sync: always check if connection is alive before
    deleting

 net/bluetooth/hci_sync.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

-- 
2.39.5

