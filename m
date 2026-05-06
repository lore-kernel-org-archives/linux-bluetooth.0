Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2502C21D9
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077957; cv=none; b=OOoDLImrunXD94vh3zh5aWxE+coFuSVp2VLzJ4Rbb3gR0f3ew3U3smaRa26NBINyNtLOav4mPCsXaOqEGuVuKhDQzAqGeGPi3xZkkebKWgUejoPAEigKX1ynBHy9AwlKniSWeL/PJlprHXlkaFw4wHYzjeLHSpt4XwYG3oQZbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077957; c=relaxed/simple;
	bh=hDOtj5Nf1/urz+vU6PahUXo7HAFlCMAwJn2MgWVuFbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm07E5hXSkfp0rSpat3Jo1kbUSv6KYPk0UQmNZEcEjaE5GZ6Hsu+xyRwo1sg4p8WnKn0CLqydAz4rvRGHs+4X5G08V9htYD+Gspe1JrYex2diSwY8TA/R9m5pWZqqBOghNi4mMzry5qwptQYLKcjVuPMeUzzj1FQCAV61+AW9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D8DF3EC97
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 3/5] doc: Recommend using _cleanup_ and friends
Date: Wed,  6 May 2026 16:30:57 +0200
Message-ID: <20260506143220.3076135-4-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506143220.3076135-1-hadess@hadess.net>
References: <20260506143220.3076135-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEI3AiONlbGM76ajCdWYrpcp9I6rJ9J97keVCFlxgrQebY1wUG8XyLcf9m53KsqlN5m87sMS30eaRzKqJAt4LdVXCXXRWGjxi8Ua3NsWXct4eL71mbffWBBLR8onzmsb6rHZSotDsEnliEkVA0ER3FYUKGLqHvB9V5uo0cgN5cengH7nPlqwfvRZtX4BXHGQvPpLYOaq9i4gwULKQPJYYzKNHfIJFdRnT03n2O24fCkSrCFbXus8J5aNRLoMa5WSnLr0YvzkOZaMHPwCLPAmjH9KkEuOKIoOA2HbpxtmAt3Ds4WXFGndtL4bgW+YTwIFkXPdeLQWMFXljLbwr5JBkV1UdpFw4W7DohZakJFVmvqeUB7G4AUo9JIoRSqLfiVKbCkWaJJ+WAGMMvrTdXVm6k8U2RpemuKX2ewihP/ay6N3xvHNDqyuWgt89XyyVWJJVm0F+MViE3nAk8D3mTaJ0uiYV0JjOnfU4ngJO8ccXuFDmri5/SlKgS1hc3SjWI5yGR6EPhEePRLDZO+PkBqn777mriwePKuc03gh7LrgRpSjMwnv7cwI4OrNwDNMA8+sICTSEGUPUp9HqiRR66TWwmI4e57n5S6W6plbkOc/hG2Em/4DFXB7UHqip9jj6ZiETvfOoivUJYX8o15MZ5dJVTjnXAqIy18I81Do3Z5ustItg

---
 doc/maintainer-guidelines.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/maintainer-guidelines.rst b/doc/maintainer-guidelines.rst
index 44d3e258db6e..b67c6596f4c1 100644
--- a/doc/maintainer-guidelines.rst
+++ b/doc/maintainer-guidelines.rst
@@ -98,6 +98,9 @@ do this:
 
 The above assumes that a kernel tree resides in ``~/src/linux/``.
 
+Also make sure to use ``_cleanup_free_`` and ``_cleanup_(free_func)`` when
+possible. It makes your code much nicer to read (and shorter), and avoids
+common memory leaks on error paths.
 
 Rule 4: Pay extra attention to adding new files to the tree
 -----------------------------------------------------------
-- 
2.54.0

