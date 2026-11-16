Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828586;
	b=Z1b+lDtWEn+IPboXIlbDEYEk/kCsXu9x3zmGwXdqwr5QBnK83maLjxIjv4Nvy7JJ4T5w
	 OAWLuwJMGHLjt7N5LsKamEnKiH3K8Rbpmi1/q5y1sO4duoOPI1cp/VezyDDatWIBs507a
	 R4QqhJEd4FeP31ipUKunc1U02tman4ts4EijHfIS3oiIERXPZxNZtRRh0FHsXiQzyr7WW
	 xnffbDPdA7Mo9xyDjz/JK0WlTd02vky7yef2MQargq+YyfC3enJzeabFP5TzQGuFBsGQB
	 f1wAR1XIrifkJZHqIKZ65AG7p7pVvUrJGa1S43qy1LhTj+Y+x8EyqVFBU5/HmzLoRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828586;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/gUmt86KgbaypOh48i6Po+H96pzMDTNOMYur0/JPtcE=;
	b=lF0BbzX+PrzsKAxODHHc7vJ/EcF6uPwPI4IqNfeqhHBOAUqsTtKLxLiNIgCbo7cp3WIX
	 M5mCcuRUG6FXkjPnsyivC0o89WAZEKIxPWlObzaTP+I4qSiEKN3cXUpaChooURlY5aYGo
	 LiWjtvvI03HEvk9hXTOBr//kcUJTkfTwXP1bdfIoOU7oqD6WYaeyntiDU6wL1XcJ4gND+
	 w9UHq3pTmBpfEGpdNDS8VrSnpUkPyWi7Rx7cQkQNH3EemKPgBjAX2kylAsSKuIvb+HIVp
	 qSnlMTeAFnWRYUbH2oHO/xf6Rcg7uI3yVYRR2Xjvczbk8iNqCB8coLM6/t3Wv4DznBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=tQJWeWNN;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E010606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 11:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E010606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=tQJWeWNN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794828577; bh=BkrtVK9bpLbPFI9eRp5dg70fRoQ93UNuXRwRSpwK9ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQJWeWNNcQp6G87rUYcb+fQh1moP0qArBxzGECkL5wHjs9TStPNEsMObBz+0ziZjk
	 7v2HDuv9O4ASyjMz06q6PX32P78LfhEEDNq+sEdxYZwVgiWB75F/vfi+I3gYn14ZJd
	 uPHnbu4ozamL3eFY2agb1aEDp0DryeJJ5lkre4Eo=
Received: from giskard.lan (unknown [135.136.55.122])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id 88DDF247CF8;
	Mon, 16 Nov 2026 12:29:36 +0100 (CET)
From: Bernie Innocenti <bernie@codewiz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bernie Innocenti <bernie@codewiz.org>
Subject: [PATCH BlueZ v2 0/2] cups: Make printer discovery work again
Date: Mon, 16 Nov 2026 20:29:29 +0900
Message-ID: <20261116112931.1598858-1-bernie@codewiz.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
References: <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CUPS backend lists no printers, so add-printer dialogs never show
Bluetooth printers and the URI has to be typed by hand:

  https://github.com/bluez/bluez/issues/2287

Patch 1 reads the IEEE 1284 device ID over SDP, patch 2 moves discovery
to GDBusClient. Discovery runs for a fixed 10 seconds.

Changes in v2:
- Read the device IDs during discovery asynchronously, so that a known
  printer that is switched off no longer stalls the listing; printers
  whose ID has not arrived by the deadline are listed without one
  (the Copilot finding Luiz pointed out).

Tested on Fedora with bluez 5.88, CUPS 2.4.19 and a Phomemo PM-241-BT
label printer (SPP + HCRP): discovery lists it with its device ID, and
with the printer off the listing still ends after 10 seconds. With v1
installed, lpinfo -v showed it and a job sent to that URI printed; the
print path is unchanged in v2. The printer was bonded, so I have only exercised
the known-devices path, not a printer found by the scan.

Bernie Innocenti (2):
  cups: Read the IEEE 1284 device ID over SDP
  cups: Port printer discovery to the ObjectManager API

 profiles/cups/cups.h |   3 +
 profiles/cups/main.c | 671 ++++++++++---------------------------------
 profiles/cups/sdp.c  | 109 +++++++
 3 files changed, 262 insertions(+), 521 deletions(-)

-- 
2.56.1

