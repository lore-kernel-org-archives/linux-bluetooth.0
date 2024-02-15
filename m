Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B113FEE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986435; cv=none; b=f5vMrWPvcIaxBQx5cgEo8PvgbxGJR9EF2CovQnB5af8eGF96Un/G9aIiR3BgEKJEJgNm3+znkhz7T6uHASqTJLHEDnYV0MhPB6KzMaV1vwvri6ytEODwAIkQplXtWrQrrxrvY5gvff/n80cvyF+5hI3FLuBRmB0iR6ZNtgqE2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986435; c=relaxed/simple;
	bh=qBvGxcHs16SIfJ+Mve5hW7LDHDVDhcbN90/Cd6obXHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j8m+7uiljMA0rGq9VXYrFPb/v3uwgyGyWWB5W/f35+eqNfRDdVnh9Uemlp3bO64pqSoX6YbdiRJb0oSLCfnm84dfEk253/IDgN50Vx38NI456o2V2wnEfoAwv8i7lYPsqyv2clDA2iftV1MAzPnwYKCBhHlBDCKJJ4ViHFtspBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WqY04hC9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PUe96L+/ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WqY04hC9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PUe96L+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707986431; x=1739522431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puZvORcw9qnLxF8rzbQ1/miMhdi9Lrqp3j+ZxWqeDXc=;
  b=WqY04hC9NFcx9q+4sQJJuq2687N5HRQgvbzMWvbTtGSUzz+9aINur65C
   Swg1rNkUlfsjFx3nHb9F751dOztgdYZkMjWyIZwbyIv8Fts/uLfU4ilT8
   Wb4mYKGZ9hwDL29K3asxsBysqF/KW1ZNynY97Hpi5qxhjb6HVkX97tPBT
   Y3qNBk5KsRsd6IHnkA7TAS2lWIzSPZssXZgZ3V90tf5TT++AIUIfOyXxL
   zfIft6EbrUnmpZbm6x57wR+azM9F1QtcVrFC7mPXR26Apa13yTxMe6koQ
   oxr04yHFTS2p+H7HEc9T/OWbC3qbvfnrEfHa99TIXsIi5dRWeqSnILweN
   A==;
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="35418178"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Feb 2024 09:40:28 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E873E172201;
	Thu, 15 Feb 2024 09:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1707986428;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=puZvORcw9qnLxF8rzbQ1/miMhdi9Lrqp3j+ZxWqeDXc=;
	b=PUe96L+/ed570sKVzJHEKKV06TbmdSpWfQFHmKa2pnoK4pKHf5FX6sDeaw+qT8HJZWG7md
	TV7/pNTnyxmHhopjTEUQ2Qd6TlBgvQyRFPEbvvCgAxOlLku4ckHA1hif1XKrEwOl8pvrkb
	yUKQiTGS7aPUC2t2yhzrBY4WDv8ORu/CNN8vOqXDXHHPalhFCZp4QgB5J6+Ujp+jjl7kfk
	eJNoTLUWFKkWZ1m0Z/Q4bCEnaTbaz+u+QnjdHHAUxGFxYaig06vfoeDXMpU+SKj+Ja0wD3
	lzjIOHgqY3cIgsQJL1K7hXuUnHUzndNSpWrd83135yI8KSDGHLSuss05XXu9aw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH BlueZ 1/2] tools/rfcomm: reset ignored signals after fork
Date: Thu, 15 Feb 2024 09:39:53 +0100
Message-ID: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

rfcomm sets SIGCHLD and SIGPIPE to SIG_IGN, which is inherited by child
processes and preserved across execvp(). Many applications do not expect
these signals to be ignored, causing all kinds of breakage (including the
standard C system() function misbehaving on glibc and probably other
libcs because waitpid() does not work when SIGCHLD is ignored).
---
 tools/rfcomm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index e013ff588..f635d4aef 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -212,6 +212,7 @@ static void run_cmdline(struct pollfd *p, sigset_t *sigs, char *devname,
 	int i;
 	pid_t pid;
 	char **cmdargv;
+	struct sigaction sa;
 
 	cmdargv = malloc((argc + 1) * sizeof(char *));
 	if (!cmdargv)
@@ -225,6 +226,11 @@ static void run_cmdline(struct pollfd *p, sigset_t *sigs, char *devname,
 
 	switch (pid) {
 	case 0:
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_handler = SIG_DFL;
+		sigaction(SIGCHLD, &sa, NULL);
+		sigaction(SIGPIPE, &sa, NULL);
+
 		i = execvp(cmdargv[0], cmdargv);
 		fprintf(stderr, "Couldn't execute command %s (errno=%d:%s)\n",
 				cmdargv[0], errno, strerror(errno));
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

