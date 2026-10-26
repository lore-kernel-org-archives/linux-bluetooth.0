Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041343;
	b=qH3DP45kqdMHfwfcs+4kruv1rBWOSWav/aU/UtlouzSTS48QRHM4waMCNwkQZenEp345
	 gYNDk/R/b9U0Xx76pjgo9gRVrs9bPNRFUxPrTR6pFvMl6RTaq4vk/N4TbmUS2nBTMWG/W
	 nyRUdYCRBj2n9mI8dwzHmtREmGtpsx0TvSJ0OPypkNeIoNZSkKR7IDLq0/aSJSJajAQBY
	 twYIulMEeZH8fiEeHK1ym40cm/VLfQ4v0dNy3ABU3Z7kugdONc9f9p5IxvI9toTQ22jJk
	 y7meivAheMK2fbpse94Nlpsqk5Cy96EePEA0Al8oE2nlJ8KPYw0sfUmKNqxtB5Ku+Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1sm2hc3YWGgsvsgSDqn3L9ODNcpGkRux3zpwGIv5W5A=;
	b=3OWl9SYiNNHvikmPOjPjkl4uZ+qHYULrTeymFauPZpRacoO9vhf/iTmXrTwPVd+0Nn4F
	 BBot/9cLYThWZjrg+bFiYN4kraUJJAgLdgXsUXulF73lamC1nQbmsmKcVQdoEkHOKeWqn
	 Rcis7jW3gXpKH6HW8cZjYFRCugIReLrPP8m/RQBqVxvoCkKJKZGqzfpMef0JFNGIM1kM7
	 LUu226N08GpBxV9dKMCELN9ae/xHhNr49t2wJf5+F4I+iBRxF6J3/OJR7T9udZTDEMMct
	 5PT+/swY6Sreo+y52NMXqDQIE3d5C8hv1OHsl7an+ULs2zu/UT1TSyJ5ru0PUAppKLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cmPHazVO;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77576606A31D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 19:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77576606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cmPHazVO
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-5179f3beaedso1472230b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041341; x=1793646141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1sm2hc3YWGgsvsgSDqn3L9ODNcpGkRux3zpwGIv5W5A=;
        b=cmPHazVOA1lbB3YwiqwbLjY2d2mGU3jquCs/9PG8K/2F8jbjyuCBgII2J6jA1uv2m8
         jDLeOdjbcztMN7HtDv3HgDcMnwOXHZTzJdk36a/HoQhmBtnN09y4YYy0SbGgIGz3dPNa
         jxDkI59m5IaqDj7hAkVLwP70IafVQ0pkfV63zv1vFS882sKM4n8uh38s8MqFALohuFu6
         Bm18/4EUGaz6vLySOgb9fOCcQByQBgGCq21fBZOsHnsJh+Lxsu85o5bysn07aA4uwOdK
         Rif7E+u5AT1ulc5vD6IEZ/fAmAzEF4y6iJXVoeTBCgI+0qD6kfJvcTV2PzCoeORCBeMb
         bqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041341; x=1793646141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1sm2hc3YWGgsvsgSDqn3L9ODNcpGkRux3zpwGIv5W5A=;
        b=zYKr8CYq2yb38NCkqObuorUFjMXS/DZzbsTBCWgEgdFIPJ8hg5XzKP78Vg+ZHfk8+6
         +bQIL1e3092xWDVbZuZbUuKF1DLVyY6iwxzFpCnKnPc5DPVThU4C9kNaoAh9Tz/whDps
         HiFHDEvomDQOiNLk1k2nBoi+qafPwjKYqcb1SJ44NjbNahz2OKffRSDfu+1O1N6hftG4
         EQL56yAA8OhtvGzzNac7grQ18mdmxpr8zwPomYnW5Kp9cx1IAr9Vdkh2BFvN1IzY8KFl
         vpt6PrdN1pdvb/6cD+OwAbLt7yT+4bUjc1WVkFNvFdkWw+69zamHWwqJqayTl5ACiIX0
         PPFA==
X-Gm-Message-State: AFq9FYKDmMmgctMGq9Ou2OBkYv7MYN95AvXM2U5oc8GzgrpSRu+P84WN
	9H1kdck9cNxGKpkoZ6U3ZrOKrmRwIETKiZfEvQTHTHH+DWwnX/pDdDH+
X-Gm-Gg: AYBFou0YmakgGgUR18RpMbAhZ36Dl6hAUHyWzhbxWq8udY8O0nKxHlXrJG8f+esaIFO
	0xllyDfc09L6wY0An9oSRLWG8QbHnmYYXVOcclEVFHnAFRNtASPBMIubyWUHTHYreDn4EXGG9Wa
	rWQbbRicyvw7saaUxGwo0NScPEHOHIdSea4NT9W3Mu5iYQG0T95GeW3B71ww+VA/lkwMKtgodMN
	GKeMnGlY6baF9WmNlBorFujR9xXQ+WyXL0mIj10zZoEXNGSL4q0ZPLe+4NNFSbfVM0xoUKhyVTK
	BH8zZf591XLTlptqwCIL3RK5L+gV/iyY7w+TDqFa8I0/5U1eR+EQ6pILjoSRf9HbeO7/VucyD9U
	TL/uKQ8O+9FY06P7xlBkm9XpCnKoQWe9hvg+cGTKjQoIf9s9gJVBLcUQoyJFTmai3mIT0+lfAIt
	d70KQd5fy434pRT1Ka+dH66NxppAsioG1evoepzPQ5d5CmtT/pbt2PiOLXnz8Pfz623ivcG5jU7
	UziX9PFJihCjWKYxV9zfXxrocMyGJjtDQd43SVgNATNuH06aZdckldIJMuGZYux09bkmeznE+uN
	htuPQISuUROaw0dbTXizrA3sw19uzdTXRgC+DZ7bXwXNBQ==
X-Received: by 2002:a05:6808:1301:b0:4cb:818f:d571 with SMTP id 5614622812f47-55c0025b87bmr5612703b6e.25.1793041341117;
        Mon, 26 Oct 2026 12:02:21 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04311a8asm5958356b6e.16.2026.10.26.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:02:19 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btmtksdio: fix MT7663 setup next to the
 Wi-Fi function
Date: Mon, 26 Oct 2026 14:02:12 -0500
Message-Id: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-0-121792305f72@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQrDIAwA0KtIvhtQJxa9ythHO7M2bGoxtgxK7
 z7Yu8A7QagxCUR1QqODhWuBqMyg4LlOZSHkBFGB1dYbbQ22ue2EstIn1YL7Jr3RlLksOPfc35K
 4Yu6j9zcMIWkXRuu8czAo2Bq9+PvP7o/r+gHmIKJrfAAAAA==
X-Change-ID: 20261021-rbrue-sheldon-upstreaming-btmtksdio-mt7663-99d049724644
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793041338; l=1556;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=6qJwEv7Uc5GPnWb4YaFtFieR4chWToQkRjD2wM7nijA=;
 b=72qqkFwF9FgiJAEB+j5/HaEH0yUzFNF6BlW8rZzrGZefwnlyqwa2toYqOLqF+zVSUi5bAnqOU
 TpNXaoo33i6BwD3S4bBj2AcCfza4WGrjKTuBsJ5CxPaYuqTviIDkXKB
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

On MT7663 and MT7668 combo chips the Bluetooth and Wi-Fi SDIO functions
share one ROM patch, and which driver downloads it depends on probe
order. When btmtksdio probes while mt7663s is downloading or starting
its firmware, setup fails, and in the first case the chip is left
unresponsive until reset. Patch 1 waits for the other function's
download to finish; patch 2 retries the function-enable request that
the chip refuses while Wi-Fi is starting.

The matching mt76 fix, for when Bluetooth downloads the patch first, is
posted separately to linux-wireless.

Tested on v7.3 on an Amazon Fire TV Stick (3rd generation, MT8695, with
an MT7663 SDIO module), with both drivers built in: six boots in a row
brought up both functions, with each driver downloading the patch first
at least once, and BLE scanning works next to Wi-Fi.
The patches apply unchanged to bluetooth-next, where they were
build-tested with W=1.

This series was developed with the help of an LLM coding assistant.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Ryan Brue (2):
      Bluetooth: btmtksdio: wait while Wi-Fi downloads the shared patch
      Bluetooth: btmtksdio: retry enabling the function on MT7663/MT7668

 drivers/bluetooth/btmtksdio.c | 63 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 12 deletions(-)
---
base-commit: 27731ba091954eccddb2657053b590d2113e8d98
change-id: 20261021-rbrue-sheldon-upstreaming-btmtksdio-mt7663-99d049724644

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

