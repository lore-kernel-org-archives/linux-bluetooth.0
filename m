Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D327605E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440496; cv=pass; b=KA0Z/zRF61coaNntOb6b6Mrv1CnaqQ7kaiSLEJm3krc6ZTkzHnWJD1OqrPeFbXTp3xCVFkDjSb8ej5nbHXvRNy9z99G4WJNBSu2WKJLo6h9XOetE+LecCXT8i5A9ruwq1rVVY2Kp5yePSdmQlKKJV3qenuSetizyvfv0jGg4c2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440496; c=relaxed/simple;
	bh=8YwhylR/VmehGNJ+Gx2c6nFiAmU+lHFUEiAn6SvqEYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9kfUidgNyeGdXzExC5y89cIYqzlx7MD3jdfRDEpzzDsrNsWhrXTEgKKnOVuVURdBddarnHlMoZJ0eFtKEKK1UodjW8oKufF+SkeVGCE9+uiFDSFREMRECQIP/o/T7RcdPYAxgbgJTGacWUnOgi8659v8ymoV4yaR4XAdOTu6K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rE8QNT/R; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rE8QNT/R"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLG0jCzz49Psp;
	Thu, 14 Mar 2024 20:21:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JaZ79UACtlMgPYt6vsXWBGciZm8FyEZkGS3q5DgTAXY=;
	b=rE8QNT/RXNFu7BFdWT/dBoSgjez2OXWc7SCZR5YqFR9oXLli7qNxuHsPkItEzgMtKPhl++
	j1w4/ChJsx3YaYfVi9fDGzdW5JbUWbCMED7XxayYBLFMvxwMvaW9CYRVr+iw4quheXKtKe
	UmChur+ryW/ytrAowttKCxNrg7SWrAfY2B7biY0vWH3k+eBwQLG6CLMONYTGOC4TqotOEA
	UOESsEQpLvZXQRlEnM0qNtXaDKZGkKva28ktJWybSjEvgwfhR5v6eEhMQSZNeNkwy1kwiT
	bAyvAg8rJkLQkTvePlUG4oPAuuQII6SYshp04RpD6sjWg+AyU8Giyiy35OqAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JaZ79UACtlMgPYt6vsXWBGciZm8FyEZkGS3q5DgTAXY=;
	b=onB9XVlRcijrtiikRqjGVDiLiyz7jnicAAzDmob37U0atjTODpbOaSWr+G28/JP8rKNMsB
	t+8ejFJnojzV5K6MIxnU6BUtqh1g2IsCKk4A1/O0IDj2myxKomqdxiu5qhm3Bg9r7qhUvU
	+jH2xaxdz4ylGnmFFuZfwMYE1iIau1SunI/CBqseFNIDnCNOLLDVEGtBx194IER02bnN5G
	BQhWUjVg4w/2CodEbqRGIQlSiiqrmXNHrQikPilJb3NOyp/XGtzGXcEkhVp36gQjcfedZj
	YQCfo4sr8VL5iM2cGEj5nTU0xxUryOG4znU/Guac1GaEwQtxts91omGkY6roRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440486; a=rsa-sha256;
	cv=none;
	b=M08bNm6ijqBDEpKtE/6ZrInQ2XxLHy7naat5tF7RdbD34eqHmlKqmrgEDtL36MOeQUKhx8
	2hOmOoW2NgJauIYidjGYvo5t0IeuFa103WvdkgtHFXR8TI27w3wDlnWV+4cDD5CIfEEEF5
	h8dEgjxYG42LcFOv2RFQMuBbSjje/Iz0E2zpzLUJHil506Ld05Dbbhn0BRieEBBo9ojFso
	btbfjC8PyQR/3XJyWcZB9Ag3ZQG1aC2zgPAXTOoS2tfZInmFe2XlAsctnig7RT0ZyvpqFA
	Pl6Kyx5u/i5qDW1mme+qLmF71iPBndYPdvl7HdKxvHJdk5PExOEhYEXinY11ew==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/9] tests: add TX timestamping tests
Date: Thu, 14 Mar 2024 20:21:09 +0200
Message-ID: <cover.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

v2:
- L2CAP LE Client tests
- SCO TX timestamping test
- Fix emulator bthost L2CAP LE credits send/recv
- Fix emulator SCO send pkts
- BT_NO_ERRQUEUE_POLL test
- Tester command-line option -n

Pauli Virtanen (9):
  lib: add BT_SCM_ERROR and BT_NO_ERRQUEUE_POLL
  iso-tester: Add tests for TX timestamping
  l2cap-tester: Add test for TX timestamping
  btdev: set nonzero SCO mtu & max pkt
  sco-tester: add TX timestamping test
  shared/tester: run test with given name
  bthost: handle client L2CAP conn in LE credit based mode
  l2cap-tester: add tests for LE Client read/write/tx-timestamping
  iso-tester: add test for BT_NO_ERRQUEUE_POLL

 emulator/btdev.c     |  11 +-
 emulator/bthost.c    | 205 ++++++++++++++++++++++++++++++++-----
 lib/bluetooth.h      |   3 +
 src/shared/tester.c  |   9 ++
 tools/iso-tester.c   | 237 +++++++++++++++++++++++++++++++++++++++++--
 tools/l2cap-tester.c | 147 +++++++++++++++++++++++++--
 tools/sco-tester.c   |  94 ++++++++++++++++-
 tools/tester-utils.h | 166 ++++++++++++++++++++++++++++++
 8 files changed, 826 insertions(+), 46 deletions(-)
 create mode 100644 tools/tester-utils.h

-- 
2.44.0

