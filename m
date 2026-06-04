Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F039183C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550481; cv=none; b=ELOP+2dGF3acY3FbVpSMGyNr4uWthzwtn1B6QE/vgO/aDGKQftQvi/v9rx1S40YD/Vurr4fjzCdN8CbsDAVGavwETagL5AaAKuHMFeFFeKby0hJqSsRNPMAyp+ZMhWWJndDhee5hgPDtXVBTu60BR6WXLpjfCQpkEYkxCZAJUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550481; c=relaxed/simple;
	bh=e6nd00oBwh5kl8ZurgUvFZsTPUmfjSD6QeOaXTMm9g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkcmR/jP/cA4q/rpJgKV76sUPEleml1IReAepGHSqFBIO46goLZS8x7CBzcVcupuhs2prhWxB82VSfuMZURCsjcI/HllcPmtNkjLLQJCyji8NPzOqilHoRrPAWM8InSSWjtmLJo8vqp2y2qcAeicUX/Pzip6byC4N8lAGZsmZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kAQ7wuDJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kAQ7wuDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780550473;
	bh=e6nd00oBwh5kl8ZurgUvFZsTPUmfjSD6QeOaXTMm9g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAQ7wuDJuW/jX1JoVzCPkP5BR+cOjrKdUno/ZmSTVEYnnk1JvwOJC5xp/P5J77gVJ
	 Krjl0qrKIYm3SN2kGhEG9VNXEFFF0yAFLw2x4iPl7NUiuLDiHKLJa8zZcc2xvWBoKH
	 yGb12HRueVcucMzKZjX2BaVGk5vrOQhCvDG6SY/UBYj/0AJJv5BgIF0OBo5dXkJtbd
	 NLla8w25vP3tqZcNwRorrSN9Nm75IK4BG63timtC/4Fca6+ZO5KL5jp12ZNA7Jntp2
	 z34hu/eHt++nUglGP7E05A6yNbyC5AKrZHVhvmMUtQs6oDm3a6F8lyrMI0azRexHYx
	 SXoNQPAzPMMdg==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A89717E05B5;
	Thu,  4 Jun 2026 07:21:12 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH v2 0/1] shared/bap: add ASE Control Point error responses
Date: Thu,  4 Jun 2026 10:50:51 +0530
Message-ID: <20260604052052.10667-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZ+UzUk+MHSo87vttd7YF-s3Zuzsywf+wnoOboaD2bLhFg@mail.gmail.com>
References: <CABBYNZ+UzUk+MHSo87vttd7YF-s3Zuzsywf+wnoOboaD2bLhFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the responses that are expected by PTS.
This patch adds the SPE unit tests.
These changes are required to Pass PTS tests BAP/USR/SPE/BI-01[5]-C.

raghavendra (1):
  shared/bap: add ASE Control Point error responses

 src/shared/bap.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 unit/test-bap.c  | 64 ++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 2 deletions(-)

