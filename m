Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1911134C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986439; cv=none; b=glYgx/7vECWO8aZkzE/uuYOVAIsbaxSZ+NgtMya/sJkUFJjr3PyqbUgNyN+G/ZQPauijiuZpNzehm75JxJM5YUW0QY3o9ciY/lwlMvgg+nS4uQGlZLZj/makoPzdk661f6LMBIYj4PsJejDk7AMWevEt+dfmXyQe4swJhBGVfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986439; c=relaxed/simple;
	bh=l7gjk1oUl/83P+XdzIDHJaVGXIDigPODJjb4/ofdmU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtwROSqXlebpBk+O7Ax4KG/g/gvEkCCgX4yIyoCTI8E/JEDHEu3OGTUIowb3HiKEwX18cAlSRGcEAQMTrbDnJ5PnJeUwli/1CiGYC8Qm+dZ+lz3zvLsXDLh5HOyxL1Gpa2sJa8ZQW0f/Ht2CQJG9OioZzdciBNOxz2C7zTgm3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dsRLlnzE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Xd/vXdir reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dsRLlnzE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Xd/vXdir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707986435; x=1739522435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFr2SS4bZB9XrUiyjZsI9S6F2CKS7qQrFjyLbaKAiWc=;
  b=dsRLlnzE4lJ1BxeF4kabSmcrsIsoXzunlSIsxANnk5X5EMIcxTR8aIU3
   ttqBRrsMNX6NPKQkrluczg6t+KwTO/ZfHPmhqpF0cNm0BracCriKNEs5s
   423BI3wRJ9jYRzcSt8myCc8JP2jcMfuQjK1/lZpB6AJVnb+2CTN6Ok5IT
   N0sr3cAwB8r9FolzgOWWVXoU+fd5Pm3IAaCwCCy1shmlqjvSunOA6ERGG
   UWDdGLY/4jrwwnN1suHTaOCiF7WDL1T7qCOwwMVPJbQZnJkVRragDI/a6
   LFEn2ZAfYQ+bfOZlyAIdETCDlFKb07Q1HVvRuelWebRfYxWDoCTsvYn1P
   g==;
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="35418179"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Feb 2024 09:40:28 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79547172221;
	Thu, 15 Feb 2024 09:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1707986428;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oFr2SS4bZB9XrUiyjZsI9S6F2CKS7qQrFjyLbaKAiWc=;
	b=Xd/vXdirtFS8BrqP0dLFp2jBBh4cmixbFxMO5h6kPKNHpKsZhxmweOhQZI2L9EydcAhEUk
	YPvDKwONC+UOcESwWvCwrAvgnZucdT86VEQsbZ++LETe0JpfteIBqpIypVkXn3WqOw2Zdj
	+qXSl6U8+Q9wIknbAMcY6URRSgY3XVXB0kQ/KLb+jUJQP+rbEPzrFxkrJbkFRedrwMZbsN
	dvI//7B+K1uAzoNjpH6pQNGYdxgdCu2UblSRoC8Jl+dkGnkiT0aHhEhyWo+V5PcLZOwq1P
	HGELFEdXTH071xHQA8wRmyEVqcB+d8Q233qrzW+Dh1PBM7n+pHt98VTsMXAvWg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH BlueZ 2/2] tools/rfcomm: _exit() on execvp() failure
Date: Thu, 15 Feb 2024 09:39:54 +0100
Message-ID: <20240215083954.5233-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
References: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When the exec fails, the child process must be terminated instead of
continuing as a second main process.
---
 tools/rfcomm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index f635d4aef..0139fe69b 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -234,7 +234,7 @@ static void run_cmdline(struct pollfd *p, sigset_t *sigs, char *devname,
 		i = execvp(cmdargv[0], cmdargv);
 		fprintf(stderr, "Couldn't execute command %s (errno=%d:%s)\n",
 				cmdargv[0], errno, strerror(errno));
-		break;
+		_exit(EXIT_FAILURE);
 	case -1:
 		fprintf(stderr, "Couldn't fork to execute command %s\n",
 				cmdargv[0]);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

