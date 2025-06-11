Received: from mail.valdk.tel (mail.valdk.tel [185.177.150.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674A283142
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.177.150.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646506; cv=none; b=ZH8KP5wf3FrG3fezLKigmmBQk1G68cRZ698N4f21d+WAdvT01uIoTwyJD1ETe9oXtmYWDiMIV1uUI6JXnkFEt8cpms+7t49XAtjHoGurzFcMvxFZ6DnsLre7KwGgQenYh8muvAbyvJuQ7D0do3/EW7fTUN9djTPHsl/B4EAK3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646506; c=relaxed/simple;
	bh=BGwhANaGSMSOy01lv8ODxNNs9DzhrnzjSftJYpxsmHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdTrYhIV+i2LBbxBYifk2mgmGeY3SezInvueg5ozln1Hryw8GqxiKzj468aFIk46wf9D/y2WLydiJZi39qbRcClwpkjyumK0ay7c8QRJnQ8REYclfVA6zjUEtQIJall9h8jxY6pw3f3oxjFvf0SfcCYLFtd7r/2XQgIOoADIboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru; spf=pass smtp.mailfrom=valdikss.org.ru; dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b=OjJucy56; arc=none smtp.client-ip=185.177.150.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valdikss.org.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valdikss.org.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valdikss.org.ru header.i=@valdikss.org.ru header.b="OjJucy56"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F6941AA3F63;
	Wed, 11 Jun 2025 15:49:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
	s=msrv; t=1749646185; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=zhDuEJ8txuMgH7ZJlWUWHWLouDUBxUXA5KolA8baz74=;
	b=OjJucy568P/4zILzNsubd23tuv7j4YBGeA9xNhn3dljwYyKDhPY7qfJQzxM1CT10lSNeZh
	i5LlrZGCShrj7Nc9z3phkedmxRkO6U0HdlCezAjxRxVzYLztvvs3tEjJ9bGl1yYPMUXKKo
	554p7wEcKATknhSVYsM1B6Fwct+E4iZEcwBgKmrDBbDHdDtg7PmURujuFUkSX+lcti43do
	knv3IfJGtdEAd/WcyN6fboI8On5TyU0alwTse0tgI0VlAX4TbnpdwE6db5GzQEUE84besz
	Phr3c1nEIhLcTiaDLmgkJOu14CG4IIhf96rFexkjex/oCmmNhJMlE7VUCAzORw==
From: ValdikSS <iam@valdikss.org.ru>
To: linux-bluetooth@vger.kernel.org
Cc: ValdikSS <iam@valdikss.org.ru>
Subject: [PATCH BlueZ] doc: sco.rst: BT_PHY is read-only
Date: Wed, 11 Jun 2025 15:48:18 +0300
Message-ID: <20250611124917.1255095-1-iam@valdikss.org.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The kernel is missing BT_PHY setsockopt support, as of 6.16-rc1.
---
 doc/sco.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sco.rst b/doc/sco.rst
index 27072330d..a8fe3e87f 100644
--- a/doc/sco.rst
+++ b/doc/sco.rst
@@ -188,7 +188,7 @@ Example:
 BT_PHY (since Linux 5.10)
 -------------------------
 
-Transport supported PHY(s), possible values:
+Transport supported PHY(s), read-only (no setsockopt support). Possible values:
 
 .. csv-table::
     :header: "Define", "Value", "Description"
-- 
2.49.0

