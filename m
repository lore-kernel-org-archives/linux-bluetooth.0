Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF613A25B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746429; cv=none; b=VotXyoGVxlYM3B6uo9RZBopUpPRjhAUwEO7p1KqX8xlc+xtD0P9i/VRIaOkBqOog/CTn4exeQgJgRFeZUln30YnAqaHnL0jY0OmO5YJFkuOZ0SroSe+Dvk36do7hoC56JngodsPbFkwSowjzRsiKAzabmMi5f4tEQmb3dcLbOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746429; c=relaxed/simple;
	bh=yjtEXq420SRJEVHbmITc0AwDKKj7Dr1KXOThLfnTZ20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dB2/luySAfsm+LLo7vkfWPYZRdwvcTrvH2rpXQNU6I3ptuUtftZBwCWqjv4uqhAM6G0W7Jxt6ziLSuE4bNmf3TASIAfnqlv4R3xwjKBQfcZZP16pkNojQfsmkY0NsxXObEO4d16yyopWr7QDAw+sszmPlovn2KbzsULtcPStb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EaXibiSI; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EaXibiSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7/by4
	lPigBu/YYHSbM3s6R/ewbEyBH6rY96ySynw1Nc=; b=EaXibiSIyAElJdy/xl3Hx
	cdOW0V4R61YajhzUW5v2InqboMi+KH67eyogS5xL8hA5fd5gZ+1rt9e7hEVT62l2
	w8p2513WmbIg4/9IslEn5A8EriiKWcE+lwOhMXn3qbe2b15TUCTRANpL9m5iwvC8
	5Ws3sUiY3cWakgVRSL+DvA=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD338iwis1m5sHwBA--.59309S2;
	Tue, 27 Aug 2024 16:13:36 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Felix Qin <xiaoyao@rock-chips.com>
Subject: [PATCH 1/1] Bluetooth: mgmt: Fix LTK load error in SMP over BREDR scenario
Date: Tue, 27 Aug 2024 16:13:33 +0800
Message-Id: <20240827081333.55914-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338iwis1m5sHwBA--.59309S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1fWry5Ar4kAFW7Cr18Grg_yoWxAFbEgr
	1vv3y7uF4UGr13JF4vkFs2gr97A393CFn7Wr9IqrW7Zr98uw1UJFW09rnxJFyxW3Z8C397
	AFW3ZFZYya1xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUdb15UUUUU==
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6AhI1WVLdQOFEAABsx

From: Felix Qin <xiaoyao@rock-chips.com>

Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Felix Qin <xiaoyao@rock-chips.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25979f4283a6..13bba6ad5d95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7106,6 +7106,9 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 		return false;
 
 	switch (key->addr.type) {
+	case BDADDR_BREDR:
+		/* ltk over bredr */
+		return true;
 	case BDADDR_LE_PUBLIC:
 		return true;
 
-- 
2.34.1

