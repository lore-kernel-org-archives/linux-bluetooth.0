Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D3143758
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850234; cv=none; b=Z0FCagpti9Bz3w3EKJXeHR1DZthRHbTs4EFYSyRbRmGeErfmHicf96YTRoZXq9uF7r7Bh4GDBtwh+Ts4DbE+qRw93nvjk1bH4Y1XfPOQPFupJt0VwIBEq3mxbtDIwAirP16m1Xp2GiRN3nZrJIhfOUb+ffQngRLnQT0EVVeWcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850234; c=relaxed/simple;
	bh=6z2Ai1Je6gdzEgUhoN0CkfwGrcsjJ2hvvIPwUXANVB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoRd3ILQzWfI0uA69QTEG8HdLzGsbDCvIKxhHbNgs48NkJNaaAayiQLJgA/KXuxSqREz9SCeM9JcWatJyYfiiMBZFsDMRo7DSVj7gaSb2AUrqwXfdv7nEcIxXXGELbTVF0paGfY2c5uVqLnPlusjPvlzYb3R4kLvvYXkCR1Uk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49C3A1C0002;
	Thu, 16 May 2024 09:03:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 11/15] isotest: Fix string size expectations
Date: Thu, 16 May 2024 11:03:15 +0200
Message-ID: <20240516090340.61417-12-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Verify that the peer is a valid bdaddr (and so has the correct length)
before using it.

Error: STRING_SIZE (CWE-120): [#def54] [important]
bluez-5.75/tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
bluez-5.75/tools/isotest.c:1459:4: string_size: Passing string "argv[optind + i]" of unknown size to "send_mode", which expects a string of a particular size.

Error: STRING_SIZE (CWE-120): [#def55] [important]
bluez-5.75/tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
bluez-5.75/tools/isotest.c:1476:4: var_assign_var: Assigning: "peer" = "argv[optind + i]". Both are now tainted.
bluez-5.75/tools/isotest.c:1484:5: string_size: Passing string "peer" of unknown size to "bcast_do_connect_mbis", which expects a string of a particular size.

Error: STRING_SIZE (CWE-120): [#def56] [important]
bluez-5.75/tools/isotest.c:1198:26: string_size_argv: "argv" contains strings with unknown size.
bluez-5.75/tools/isotest.c:1476:4: var_assign_var: Assigning: "peer" = "argv[optind + i]". Both are now tainted.
bluez-5.75/tools/isotest.c:1514:5: string_size: Passing string "argv[optind + i]" of unknown size to "do_connect", which expects a string of a particular size.
---
 tools/isotest.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index fc1c26b23c3b..f98f25497b85 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -1456,7 +1456,12 @@ int main(int argc, char *argv[])
 
 		switch (mode) {
 		case SEND:
-			send_mode(filename, argv[optind + i], i, repeat);
+			peer = argv[optind + i];
+			if (bachk(peer) < 0) {
+				fprintf(stderr, "Invalid peer address '%s'\n", peer);
+				exit(1);
+			}
+			send_mode(filename, peer, i, repeat);
 			if (filename && strchr(filename, ',')) {
 				char *tmp = filename;
 				filename = strdup(strchr(filename, ',') + 1);
@@ -1474,6 +1479,10 @@ int main(int argc, char *argv[])
 
 		case CONNECT:
 			peer = argv[optind + i];
+			if (bachk(peer) < 0) {
+				fprintf(stderr, "Invalid peer address '%s'\n", peer);
+				exit(1);
+			}
 
 			mgmt_set_experimental();
 
@@ -1511,7 +1520,7 @@ int main(int argc, char *argv[])
 
 				free(sk_arr);
 			} else {
-				sk = do_connect(argv[optind + i]);
+				sk = do_connect(peer);
 				if (sk < 0)
 					exit(1);
 
-- 
2.44.0

