Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C73AFAF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358167; cv=pass; b=lJwajP8O94mvLnfK+ZmA9Ji/Y/0ZI/UJrJOW5Gmdh6nXAHtZwO6lur5fcvFEwXaybNVoX6ijtkYpZbtT5qshqUlt2TWTktpaxmXvzMxroqvWa6ZEf2F0tKor5CtBQnGs0onxh0M0zxlbsDHHVEiCRZMy+4FtIBiku+T2t9l4jVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358167; c=relaxed/simple;
	bh=rRV9POQjVC8aZis+VjQpUr26fPIdWgV9Rk8TofohjFc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b3leB+bLRfbF6JoSLqdMXbf/SmDjHTvIhDG2P4s6zfue4NgOeD6UpBUDn55CLUGyeBDWgyx6ZIZ+AHlnIYoB20H1eelPQ4UGMHIXaMAzXm554h4DZGW+bojtUx6WIuEBtITxArh226oLkHyDp9JIWDHOOfrHZeBup2h+DHvA3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuufq6XD; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuufq6XD"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so689631a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790358166; cv=none;
        d=google.com; s=arc-20260327;
        b=rOI2QkxBEKcUEDHxZUJRrAxROXgy1v2D2UTYK+zbB0FEPCQWipQaq9KKPaQop/QLKv
         dqlNm0AHEACnR1yKy3ngysXxGZIEXmKYjcMV4QBikir4Xxt9VqxbmDFDuwZR2l58NEVH
         MuMqHFwRjBpM4QO0dlc8C4obqWfWenATv2pDNE/KGh8pdue9vfPnhO0zYHBxFDHTOnm1
         RMzA77r3k/0JoPH2hefs7RbM7awk1zOARmNT6I+gOzXcRs2yUK1Yx1sRu5Yiy5zkGvPe
         oVJp/HbWd1Hqi8bHDgtaLQtHl9PQDS/gEz9qf0gn9O8f09LLsXxhlWos8KxoedRS/vkY
         OV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AMGvl2ySrWuP5QnuCOG4/fzqLTj/EF3RMcXt7dXCXV4=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=Q6hVjZ7kLrm/FxJLmtDeZaz2O3RMEVgpWcS1YsiQGUJzVAYA3KMml7Lo/7PZ2Ds8vg
         Oi6knYLRR4nsYhZOafDbZl5/2ErZqNhzWNWKHE1UGladNUfjoxzfgwZ10sSmjqCEtrEu
         kllIvJ07F6DNjWhKKs80X4aFTnehYoRinCMpJUTW0IfI4vp2NBUhXfvjLrqy/k+f4sTC
         2LXiNmIIV3KO7Ycsujyi9V9IKW3BAKHw6h61JUkFa1vI9iwxkhq95i4MHn2CdrhSkDOa
         0zf33yes/0TmbYTdfF8oi1pCzS0U6EryOyEnr62lXpGWkflp+eeI1LrNMd6A2M/vw6M/
         ZiVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790358166; x=1790962966; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AMGvl2ySrWuP5QnuCOG4/fzqLTj/EF3RMcXt7dXCXV4=;
        b=Vuufq6XDYPzjk49SWUzXeWea0utr4hxy4UqJyYp4oEpv6K/VEH72HfM5LYOmbksRgn
         eFief9LPBhuj7AqaFNhVXrl1hRILV2A2N+qamWrtN3xvtnkX+IwE/acMeuhj4PgcGVhA
         3mrbg3z9N741I4Qk4b5HCswOejgALyggIzvIdMFlW8J/THKFa8MICZ1qBHzL+Dvhj5r0
         SveQMOTK/YC4bwSZYhbOVEYt84zUoZJ4vp3FDyhUlpGxdx3anSOWy1tAEXEp9B4b5qHv
         lhL1tGvrGhqENYrND/Y0Xkp/2wgS/futemjhBY01/U76UZKC6Z7n4UEWhdJvC6Ewe5si
         6z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358166; x=1790962966;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMGvl2ySrWuP5QnuCOG4/fzqLTj/EF3RMcXt7dXCXV4=;
        b=qy5OMTSSh17V9lIRaWEpBivV6Wk6Dy7ctEMOScjBe4R3yLWEBQvxVX0eVgp4WTYxjf
         vcSs/n7fi/5n3tqTwtLJ4/Ht5eVLFgTM0+dX6yvvCM9FL9p2K45NdC69ZKmZ01EuCGDn
         TEiTewE8c6pHImsFv8PKZfdxQuBFZGA/KvXwH2jKvwfrSP9NeXn1dxoUexSHGwfMKZRg
         N6/r8zFaMJzz02eue7A5mbiGyUd2Bz9N/b6PogkQyBRPIcUXOTONyJSmMXd8xKB0ofFq
         ugs1rDA6x84B+sgLJJIRugQkYwnNTiyvQfYsTc8B4GVF9fIfDO93yH8gYr/TXlXhijfU
         6ASQ==
X-Gm-Message-State: AFuF++m6AopmOGoyox2xErHi4tlTa7i3QTRfS3baH1lPWPphnKbfXUb0
	o1X6UxzyO3AF4uAY90zqwxwE15gD4WOK9R1asybaqXzOeZSOFOtvBQkCA3KrUuVRM86zakG6pvX
	ZbbMS+HtzEWV6ERXPmhM5b75Ete0nvzofWw==
X-Gm-Gg: AYBFou2X5/6NozSlb9vAEYwaot2hA9FE8ut+Vr/jFs23Q47Q3teim3JBVmb/NsMJdpx
	d08MKQ7MRy/M9NhJT1bnxsxP9RvYYGiyLySsF5+ZmFHFjafJ+pxjpVToUOwZsdMKW8n2V6G5kGW
	g1Txo7Pr3iRYjMad3+XTxpRIk1YrRYgitgRceQLkdmVtvFEr0uQrmtm8150bEfQQ0NYLjkpTmN5
	gb8m2bRzLnaiKhrSdC9npopuAFcL8FPzrzhaujehIn04RxRBOK9fvjhxgeR0Vaq0x2VnGcOsDxh
	6NpSzARS19xH4P3qA9EOrCgHVHXpzfTMoQBXpjo77vY2IlN/ygsafA==
X-Received: by 2002:a17:90a:d64c:b0:3a0:c13d:8b2b with SMTP id
 98e67ed59e1d1-3a0c13d8f3bmr1593651a91.33.1790358165957; Fri, 25 Sep 2026
 10:42:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 12:42:44 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 12:42:44 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuseppe Piscitelli <ooonea@gmail.com>
Date: Fri, 25 Sep 2026 12:42:44 -0500
X-Gm-Features: AclHuK9ScsXI0Wm3lltfWwpUriRceFgIyVaNjhieZTDTUxHC4fwex_t4gnDXeow
Message-ID: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Subject: [PATCH BlueZ 1/2] input: Reset report map state on detach
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>

read_report_map() leaves report_map_id set after a failed read. Detach
cancels queued GATT operations but retains that ID, so a later attach
cannot request the report map again and never creates the UHID device.

Clear the ID when cancelling GATT operations on detach. This also lets
a reconnect retry a read that was still pending at disconnection.

A socketpair reproducer fails to read the map after either an ATT error
or cancellation before this change; both cases create UHID afterwards.
The existing HoG and UHID unit tests also pass.

Assisted-by: OpenAI Codex:gpt-6
---
 profiles/input/hog-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6c75c60..2b6dcae 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1908,6 +1908,7 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
 	}

 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
+	hog->report_map_id = 0;
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
