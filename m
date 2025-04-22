Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A6262FCC
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356714; cv=none; b=SQblAH6yE3smRI5Z7fehNqGIykg3/A45HRsad2WRd3pSD6vtTaNtyz6BPMiyNgUh0/4SPIUHHkBdHVvylhjIsiYjwgn+TMZKZTau+9Kes8fjGOvUOA34i1rZOGihQHYGKUMTQFWa7Pj8aZi7z1kO+237wvrW6C/xOXHDHfhRzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356714; c=relaxed/simple;
	bh=FQ3UOvq50hnPlAZ7hp/9kgjIjDLvyz+gh22llBoa11s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R5D9MlnCGofwZcazu4lP9iniqn4Fe6jStv2DIn8OVymW6GqR+xWe4dF3KCdHAOh0VYvMjvmmLipw3QZegviSIpWYeyMDWQJ9xLuemXQR06eClRqmOxGoESuvgAmod5C9sg/t90P61/WHdSh5jIkZu6UsxJwpjENU86REhaRELJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkMcuyEs; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkMcuyEs"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d69774081so2081759241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745356711; x=1745961511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PjDrgCVGbbgUs55dcM6Yt/rgNKKgfwzKAYqFDpCNSY=;
        b=YkMcuyEsosqBWSTFO+rYT9YLceCdwkiRc354zKJXAw5y3mWops3NKFyAYgRxB+8qld
         ydg7f2vX1JZ+luZjaeEOIYZYjNTTW10uhyflfrF490YwRlpmAMQO6jUDB3nC4H8X+Drz
         wA5TlVOFsZ4i/+PB+WnZSDmK2MIotONSJkh22dw0yalzwYDlAeIcGWY/mIoXDXaXGlNd
         yyvijZi+kLZsW2WDhcirVTbBpN/UFpNCNbx6DePJo8Kj+3qEY9zGEZcOVMNr2IvGgKUR
         aH/atvlHeLk4Q8lXsGHSUlXeEYdt4pHCX3btoBcSpKAsFG5qKyLqpGI240HpwKmdxaC+
         PT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745356711; x=1745961511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PjDrgCVGbbgUs55dcM6Yt/rgNKKgfwzKAYqFDpCNSY=;
        b=H/reP6znQEnU/sFpR4Ri7tWkk5JxHDbCXVG0qah9ZDnUlXeb6j4gC3Qg0pgvsEg/BH
         CayIEI74b0BhVGSWI4ofdIorBJ9x4DtG2KbQKjKw3aROrhuHh7VSH4RUFZHlEvmFFs9q
         xsmq6v+PXowyWaUM5N2hDODKFGPLBhfJQAglKj7fAFDBb31JkklDY2broiYHRqh/NDzM
         ey6h+hY7SG6XPHAty1f+NleikDMzweXnX09/9B0tSoY+iQkK4BbHzPe02jdvp4QxFYit
         WLiO/a/raeVl6L6DUV2ULeQdnz+o7R7ZdAKyZ9rUbir6dZ0XI5VJAvEY1CdGKq6C7jhb
         OKuA==
X-Gm-Message-State: AOJu0YxGg36cTzuGurPBv1nVM9p4Hikv6uTxGDEYe3Tgitm3a/GFGLc8
	7Cd+njlrow976+vPOXwFeOIr8WAfOLANX5zLMt2WoUz3yjNwlDWxLOdpgZV+mTo=
X-Gm-Gg: ASbGncsQwYkCNRwpdvgvnzWuEuuSfq1FcCFqpsNuURWPiy/pQMAhK8FpHy4kyD6pxZ+
	shJ0R05ov72jF1p0rZqSHR6lC9TbgF7xtddjqDQL3tDVwq6S32obQxK7sf9hC2wHrH/3AY2YINB
	dViQ+m8PDG1i+cYG+Qdn5z8rQttQ5BcSTH5G93esm29a79AfacMCcS+/7//J8r6jgL7j5Z+HNhr
	wOzE79h56HNY1kag076Eq0UCrdBLkxPWrIatemh9wAwXXjHAn4eZaUtarWJUGiQ6tmK0HoIZY3l
	0wD6MykSVdPRJi1XmV0M40z/6tjIlLxYSaTRBjdrkw0bN9OGpImsnJnHQASyri69syV66U1ixW2
	CsPtp+yyymg==
X-Google-Smtp-Source: AGHT+IEI+Az57yWzpT8boeDcTu9vZBEqJFbAa5k02T/rrpcYk/V7TraLRSkv3vW96KA6hE7TgFKwUg==
X-Received: by 2002:a05:6102:2259:b0:4c3:64be:5983 with SMTP id ada2fe7eead31-4cb8023ef61mr11495889137.25.1745356711384;
        Tue, 22 Apr 2025 14:18:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dde9b6asm2324981137.13.2025.04.22.14.18.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:18:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: Add sync-repo action
Date: Tue, 22 Apr 2025 17:18:27 -0400
Message-ID: <20250422211827.987293-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sync-repo which was part of https://github.com/bluez/actions/
but it gets disabled every 60 days due to inactivity.
---
 .github/workflows/sync-repo.yml | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 .github/workflows/sync-repo.yml

diff --git a/.github/workflows/sync-repo.yml b/.github/workflows/sync-repo.yml
new file mode 100644
index 000000000000..4b106ee4f68a
--- /dev/null
+++ b/.github/workflows/sync-repo.yml
@@ -0,0 +1,29 @@
+name: Sync Repo
+on:
+  schedule:
+    - cron: "*/5 * * * *"
+
+jobs:
+  bluez:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - uses: bluez/action-sync-repo@master
+      with:
+        src_repo: 'https://git.kernel.org/pub/scm/bluetooth/bluez.git'
+        src_branch: 'master'
+        dest_repo: 'bluez/bluez'
+        dest_branch: 'master'
+        secret_token: ${{ secrets.ACTION_TOKEN }}
+
+  bluetooth-next:
+    needs: bluez
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - uses: bluez/action-sync-repo@master
+      with:
+        src_repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git'
+        dest_repo: 'bluez/bluetooth-next'
+        for_upstream_branch: 'for-upstream'
+        secret_token: ${{ secrets.ACTION_TOKEN }}
-- 
2.49.0

