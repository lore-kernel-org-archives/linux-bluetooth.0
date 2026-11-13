Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562504;
	b=PCUbflmBfW27XXU2a+veRqvxWGCSScQ2YBx7FzgGdVkqBrvrCHcqXRXLk7BX3bSlXgld
	 UbBK9iZhLPG2+f52AbHmbfAM3mLeV+/u7Rk6q26mmnOaQkA82SZWZ90ElouA7tQj+wblg
	 3DG3J5MVLdvaWjaPAcUvIYw0dZrASwfyiH1lleVjjQglWbYKtULqyWuGSPzqoCyjFAvEX
	 F4uSx3hKQYvpVZ7L3Khe27L4S+o/ruGmdEUv4/KkrTYd8YLf4769Iw3Xqk2DmkkibQ2OT
	 bz/S8SWxs8B8yZdraR4AScrl5bSvUTAe4uMmRhPmHYzpiYEjY4KJo6eWyPuXi7rcNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562504;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XgTQ8avpBIEWXxxziLNE2b94ZURvUiBPk3Tep1QsVgY=;
	b=Palef1o+CNy0JqTFYYdsy2uMn8e24+MZD+ifTzIKPX+1tKrhN7U2t5VDx5M9sEq4hjIS
	 EEOilnTWx4v1u/EzrklKoV5pTmVOq1WW/MCnlkIhjlf+y+o0r1o4HsgIPUySKj/HkggYj
	 7Y/gUSEA6MiGt6i2CzBOxcf/ExCmfKV5hkCflwo+y4iROv+dLCOvPEMIpWdVNsrXUVprQ
	 LNLp4ct4BY2njbKx9oSqBs0udnnu8jEOyMyP0qOvNP7PxHGO7yvjwcAhsT0o2UXw0KwT0
	 dclxGZ3cOokXt//xqHp95Wc9G4RKm0FEu8ZN5Y9daNWs4mKNYyAkCnlbZd0echvyeEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=ZwHfea60;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11338606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11338606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=ZwHfea60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794562494; bh=LXG80deWXBjNu8Ud2Ol/XTq73hbfjFczGjCMWR+rW7g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZwHfea604fPhW/dOCf9qbdBwUDce/wa1hcBlqjkGswm9AKn5BFuegoO1xGFly2JfT
	 xPNxTzpRISZVcKZB2PPFx76gKb17Ftkc0nsDFXCHuxHR4M+gDb7rzZbzjWW20L7fqz
	 nCE0mUBWba5eamYwoXX270zrC2vXLtFMgzoNxXNk=
Received: from giskard.lan (unknown [IPv6:2404:7a80:ff26:6c00:fb7a:abd8:86ed:512c])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id E990C247CDC;
	Fri, 13 Nov 2026 10:34:53 +0100 (CET)
From: Bernie Innocenti <bernie@codewiz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bernie Innocenti <bernie@codewiz.org>
Subject: [PATCH BlueZ 0/2] cups: Make printer discovery work again
Date: Fri, 13 Nov 2026 18:34:26 +0900
Message-ID: <20261113093428.2971436-1-bernie@codewiz.org>
X-Mailer: git-send-email 2.56.1
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
to GDBusClient. Discovery now runs for a fixed 10 seconds. A known
printer that is switched off delays the listing by the SDP connect
timeout, about 5 seconds here.

Tested on Fedora with bluez 5.88, CUPS 2.4.19 and a Phomemo PM-241-BT
label printer (SPP + HCRP): lpinfo -v now lists it with its device ID,
and a job sent to that URI prints. The printer was bonded, so I have
only exercised the known-devices path, not a printer found by the scan.

I own the printer and am happy to test changes.

Bernie Innocenti (2):
  cups: Read the IEEE 1284 device ID over SDP
  cups: Port printer discovery to the ObjectManager API

 profiles/cups/cups.h |   1 +
 profiles/cups/main.c | 618 +++++--------------------------------------
 profiles/cups/sdp.c  |  48 ++++
 3 files changed, 118 insertions(+), 549 deletions(-)

-- 
2.56.1

