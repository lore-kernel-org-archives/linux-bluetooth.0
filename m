Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B57387563
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022026; cv=none; b=L+RZbWP6cAY9kzv7mp/e5rdt7640qc6Y8d87jliR2VKZFlCyCpNclr4xxktptL8jomoGVpyur+Psvkq7CSuJtpJJhkQeEk12LVtVx3K/Z+dg9jIhbeUg7bPA6/eexRKe1SY9IzTiFj6hwU7X5WcV4qM44tzZJLUHwyndv4HWUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022026; c=relaxed/simple;
	bh=Z3s8DCdtm3H+YTClSIKunm7+tgJv+UHVitbrUGvNyRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=racMEJtp970D7NrvA0qs1E6WDuyGlLuq/7UsrcTLSjB+2/TsqQsGWEUXyf6d7JiAqasb970olNpszBTzqp3eZaL/fXmeSx5FVUGofQx1LfdaWZ3ud1XsYH0O7w35fMJbaGRQem8F2Rx2jEOQOT2imn4cbUp44B69yBXMG74Yu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C14E93EBFC
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 11/15] build: Only build gdbus library if there is a user
Date: Fri, 24 Apr 2026 11:11:14 +0200
Message-ID: <20260424091324.3097084-12-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTp5h5ytTZDo28ic8/sTnCMQY+zzZfk3gU36YvfQeXBUiKO8hgce3jehgNUTXU/q+FXpaFPDqP52nMXIJ+C0EEFPj6Sk4n26nvcXZh9YMQ+8FADWwQJKM3yuoDGdas0csgTrX/xLILwhoBOcdTg6Wu2Oo7Lc005pQ+J9FJ3+u0xj+6gsMMM2OzXKlloWLrz47X/3GeoGR1XWmTxaQnrcA33fZakM0rJ3ZCeeOhmIOTlhsFN5kwW8iyuZpOWqK3yX4rfP/PJO+iiK+RVByYUoWcqJAsxvDcXuz3/enQ0Iq4RREYOvmoO7gZn2DWgeWgnxuGsftjTSJdND166Jv1GWe+6Q
X-GND-State: clean
X-GND-Score: 0

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b00e378d04ca..e034cdf80fb9 100644
--- a/meson.build
+++ b/meson.build
@@ -259,7 +259,9 @@ configure_file(
 )
 
 subdir('lib')
-subdir('gdbus')
+if not get_option('tools').disabled() or get_option('client').enabled() or get_option('obex').enabled() or not get_option('tests').disabled() or not get_option('daemon').disabled()
+  subdir('gdbus')
+endif
 subdir('attrib')
 subdir('btio')
 subdir('plugins')
-- 
2.53.0

