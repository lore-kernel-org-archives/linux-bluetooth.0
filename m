Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390733939BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329290; cv=none; b=Bkm0/z2ElA8tCh2D78aYFtJjUzpN16dPpkWxKjYAnqJbrnjAEZiNETZEdwIsIP3FYCqHN2bRhmMupQ7b//XTS3TT7j2icb8gMLxJoE7odpikcOa0nfRfc2ifBFOLu6pgRvKOfGucBfo7pRROi8Dx2Cix+LSb/fRUUlNYiMPc5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329290; c=relaxed/simple;
	bh=87jyZpTIb0xObMT0Iiqcr9k8Icp+zYGSsTuvwmcpBzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dkuUGBgtSz5XclF9XFPEvw5GNQUJBo36I/rWIXZ153q7DBN7g/cxZUejmmVsbxFtA8NY8ZOpGZPq2a+ykY8U6oZEHtQ3ZQCDkbcw0EYoAYqWqjg/36NsUjrlTURPzpswoAr5qQ/RSg1B1+u3791eumxemW9kYa3UuppIv1QfWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE0B33EBAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:47:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc: Add missing btmon-cs doc to btmon.rst
Date: Thu, 16 Apr 2026 10:47:41 +0200
Message-ID: <20260416084750.3735103-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
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
X-GND-Cause: dmFkZTFiUnZoRGWtaiUHuNWPW3jxN+UwuapbWaGXtQ50wq3T5uqH5oeCuLIfY0drfDTByDey1btb9AER+OEQGWTNUHxbPDYgPoZtichhmcygi1E+amwqHbiC837DYHRcjs0kH77qCimbKLlSIrYlzHxsxS+XTo84+5bPlR1aBZMdlrisUZVkRn5R2UJ3kZMMtQOkZw+mU/+v4DOo89BQK09Fr72jYS4lx5ebbjOJ+oxmYhee0HIA6siKIEXNYJcVGONB1z3vL0AtSx0ThmbTqcFJuXPzMNGW+tevRlAF2RJt5B6mYcHHRfJ1mVO6Az3GxRRwZCpiEtsmycrhs7l+jtXomOmpSoZ0rps/l1HIeuJYvKbeM9+791N25fc6D3yaKYJ1VToZpkpMmmVyXAAB1UE+8t8sMTzSExcIQTGu05sSgCq4pOy8saD6L/qJrvVB1erSa/yRgIAS7V2qmweSRbDGCwwpJmDJSd/5mS1Y8IQk5Nao0H7acpYYjhCz7ihcbnUBu3favKDaJA16oRh5AAS6JvOssIBD2eui0ej2dQ4NQvkPxAjoJ19ctnpph+J3lktmUyLA06NQj4p30F5FlQHJud6CdQjEebGwGrsddcWCchvOnr0sGY2np4rM4QOtO9EBHCtAW1esIFlGJNS6wWfYxntwpc51SwJdtKxL2WqiZ80C3A

---
 doc/btmon.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index cd08ed3d5424..f701454e598e 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -767,6 +767,8 @@ PROTOCOL FLOWS
 
 .. include:: btmon-le-audio.rst
 
+.. include:: btmon-cs.rst
+
 .. include:: btmon-classic-audio.rst
 
 .. include:: btmon-advertising.rst
-- 
2.53.0

