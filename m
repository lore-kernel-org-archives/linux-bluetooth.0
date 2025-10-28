Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11634B415
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674205; cv=none; b=uD+fk3OkHTyzh2K/jQfg/kiLpTa/GFP3xdS+6b5KiBmx9YsTlgz689Gl8VMRS28clviE8AuI8C6sRPaHIOajbWiN7c1pLIU02hhUWdl4+wqc53wYYMJQvnbsVVLBzS5vqkn6se7HqhEa8y26eG4jRwiY6GnbZ7NXueO9Mv1C9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674205; c=relaxed/simple;
	bh=C0BR6PL+GP8YMCwVuMw9JlDJh3keCCAtAr1J/nEK8K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBBnq0TFUg5f5uMFboM9NTR/B9kCLo6frY8oL3nSqemo1mbHuaGyVguEtGA46jNrFtMPtvg63qGrFmbgpA0GHl1lq9+oYjUs5T+XZImPvZd995g2U+gpskhlkhVDWYntpRX113TDoSSxsEpyFchI8gqF52CTaRtCOs0Dk7+nR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=U9rJbZYk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="U9rJbZYk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5731860a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761674202; x=1762279002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfRvHziFqkZObFlV8twnHWKmYqDLFJYI9I8WICLUIrI=;
        b=U9rJbZYk795ou/MWfByzOO2Na55crzr/3X3jfjhnsPqJcXvUh/EcHZTbJi9VMIv2K+
         9IpCEsIS5NIxTp3Zef9OV+LA3qDlKPkQy+YRoeXnABj1gp71tQCQ/pTfza/zevOdn+NJ
         0Dm4+iQb9Zvwcf0JYzQa27ziIrJtWVlX0nDk9IA7FoiCt8gYK9XRpfrY8JALKaNmdcxr
         6qQgl/f3jyyGCW5xBAgW4w7QlsznDApdZGcr+bP43G1oE8++Pu2e+Pw9UpPribJQFFPV
         N+Dz57JvUYP1qhAgP+TO12qW6g1tPjcvyosdKu0QOKZfYwtuE0FS76pzU+0kVJjudJjB
         gWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674202; x=1762279002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfRvHziFqkZObFlV8twnHWKmYqDLFJYI9I8WICLUIrI=;
        b=PQVHz7RGz8KjFyXLkk1aq90wUsgpRtojdzO7VBPzUOF+C+xhex5qkT/cOMVGJpuVtu
         SH8OJCg3DsaM91xLoxkK0ON9HyyeMryk8+cJDbBLd6na25L9EKAEHo6Esex8O3Bi9rFJ
         JY/VtEy585m+eiLkyyycqg4+pvuz8Sr5kX/WL8mAYRm27l0Mz5tNy/yKShQdDfbG/xGr
         Cmmylbw+x1m+Fp0U5oAitxsdHVR0LjSzTSPTA7UPCNrpiiRnhCLbUNE5LVQ4LNoKuHi6
         rZIH7IAAzkdmnzvG8ErnBdcfGvhRSL8jmnMH/g2qdnO3o6T9xm9kQtL3Hn4pKLTZJroR
         XpbA==
X-Forwarded-Encrypted: i=1; AJvYcCXfstgo4nY+wnNhZLRhrfSj/JqnQXPdMtNxjGwLeBe6AblVmc3Kp0sTQa/G20zkMMqan0sWH4kWGge5aNPQD1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40rJKI8DQLlkKCAmpOEvZlv5oLyj+np53l9j9HFt5VSdeNZYr
	iANhLCbMaLJmpOdibw7TWE4xxaYxfdMv+Sm8QFnBK8ULVcQFo6fCUlPYkXtI7UJ9WA4=
X-Gm-Gg: ASbGnctyyhIWAASZMveItzKyUHR4TYCFgXGWe5e6L7b/DPZ8jVJxGfbNc0wGYhY2Qta
	v2VL7d5jRE1aMk8bZnTc8+iV1zQOsqhaPGOadTW1KFGc0m5aHEuqjGbxlPcT6rixuoy56uRypEn
	fWJe2ooIVGLrz/J7yvLWiY2dl5VmuyRjlikL8k64YTWO1l5D+QWaqvqP2ZVCWSrVyWtE3vT9kMd
	lYv9rkHxE0Y3ahUGoMDVv+wpVVvxzIXhWVN5rqVZEDW51tExYWVqa7hdMMyWP+16LRNKJxrUm5p
	5FbIVfKj28wNTa3i4BtSDD6C2+YLRRDnsby5xbIYwUgh+JU9g03YV+K6ztMhR9HmwVgQIg9ngGm
	JQhn4RVDCNk3N2Qh0BZGx5+uNt0BPWULMzPV/eaLDOOeOZX4kJSarebYgZqtRVcEAeczz8HmapT
	Rt5MN6p1c+C/ye
X-Google-Smtp-Source: AGHT+IG8Yf1TJEydayMTVhRw5T6v7lmUN7tOxdDOQ5l8aU63IZjsHtT7xhhADx1jgM6h7hMeNYGC1w==
X-Received: by 2002:a17:90a:da86:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-34027bd07d9mr5254117a91.19.1761674202321;
        Tue, 28 Oct 2025 10:56:42 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9660sm12829033a91.10.2025.10.28.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:56:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: marcel@holtmann.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
Date: Tue, 28 Oct 2025 23:26:30 +0530
Message-ID: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for ptr using kvmalloc() is not freed on the last
error path. Fix that by freeing it on that error path.

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6abd962502e3..1d4a7887abcc 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -625,8 +625,10 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 		len += entry->len;
 	}
 
-	if (!len)
+	if (!len) {
+		kvfree(ptr);
 		return -EPERM;
+	}
 
 	*_buf = ptr;
 	return len;
-- 
2.43.0

