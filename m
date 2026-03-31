Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB3E5EF9
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993069; cv=none; b=B/gDUJHSznGMikl84NNPYD52T3AL8zgoE4xTMIQCKb28rNoSoSureDi/4uriJYY8U+joS/xDWQ46RZP8h6apYVx/+sjJEu3DEDFxrPMJAI0egORKnmIGgf2KYm56bS6d74jOd5YIzOQK4hDLEl/sja1WbErfKKJR+TIS27P175U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993069; c=relaxed/simple;
	bh=FO6qB8UwBFA4bF0XQBUOqeBcwRmIzN1i0W6zIM0zVeg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QlaYxur6sSDtPlByLFBI8Hkwv0yNuIqMFYQSakSlpn6D97lgNb6kQR8msbeO9Wc59teJjVFCUz2TApCII1XxFdzJGSaWBdPL6V7wbcBvCueOE95Hz0wYfXUI5RsNcMBnEbFF3LFvALxKYQEWD+y2bhCJ9KT2rO0Es91giGS4fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69BE23EC80
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] shared/util: Add MIN/MAX implementations
Date: Tue, 31 Mar 2026 23:36:35 +0200
Message-ID: <20260331213731.3895736-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFbagU3r5IVVrz3KTXy9se4BeeTIOss4WKta++NnS9Uy5ebKu/NicH6ujLt9bYZrav3MHXPfnFiFMiME8pFi68Dl/fHSF/jY49RgEGwRzKLi0EN+KNLuIa/38FcOQ3rRm3s/U66vdB3o+dhVeovX2xv7m7wWwUCVZ8TRvhHO03WOVter6TYsK1VGjfZm3ok2XGTswdfdd1e1EDi1cqEFTxqpDpIckPkZJ8wA1njG2hjzb8mfZPq2E4Q24ZIflubL32qiXHIguSERFEP5/PannZgO9/HdzYsK3C9hwxacZnyv840opyHHE6pvtnscEydyuO+rv66100VI5J5obiSeYsIntkFQ0ur4ok73M/aAFi98TIl/Eazq1Qs+m6fLYH1Qp5S3wIGXCIwq0PG76MplsBipAUKTDdrjxDEdOiKCmHD3zDNApLIFC9LDGXZh+Oa7iiuPy6bhy6ciJR0cUUo28RoUhUJDYIFQzrQ3cVB3s0r3MrxogUvBENiH0t8CpqoG26SPngTN+Sdu/Wx8hQuqtE2Ng5uzcm23XlVVL2qJDp/6dxJERNzBWI9uBnO8gQxwprNRQzXZrDccFKpx/1A42R9PFrVZQaerlEw7qT0fMg1n2rpHkSxw08rOF9ykPtAq0La0zVtQRzMzUEA05XepnZP8psZWQbt7Sa3zpM47phKJQ
X-GND-State: clean
X-GND-Score: 0

Changes since v1:
- Fix MIN/MAX implementation (tests all pass...)

Bastien Nocera (2):
  shared/util: Add MIN/MAX implementations
  emulator: Remove compile-time header only glib dep

 emulator/btdev.c   | 2 --
 src/sdpd-request.c | 2 --
 src/shared/util.h  | 6 ++++++
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.53.0

