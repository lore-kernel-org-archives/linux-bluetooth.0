Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9D5FDB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023734; cv=none; b=Xv7ApuA4nNA/6ptOu04cSnE8FrHefS+5SaNerV/ZptL9sEbF13st/hkdlurIXaWK0ewpAFJD5IW0R+ufaNg8cLIajToX/xi+NNzbJ4Pp3bZctsVF7cK5kh1+n1topk488NsfiAFuLeaKLLTt5uer4zXoaG7WYRIr7jsiiGmkGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023734; c=relaxed/simple;
	bh=Hz/sQTkal72CIicSJ3PgwnCpkwcm7R8/SSPoezeooQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JQ+I8fy4VVjy9fH44/5M6tHM5bGtuK7G5G77WSdYVyl6cF4RRNHtKFLNc3DTFID6b3jEFgeIsdaOGWjRkUcSm8AxCyjjOvsVETm213FvGWLS1EJknDXSJ2nPyKZ4PIyAlz4wqwv+HzzHLy8FVkjph4yvZ6VYR6FBnI2ZmEVV0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoBcDfFR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoBcDfFR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ffa694d8e5so30508037b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023732; x=1706628532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/2ZF6jfLSaibnI8JVEJM3hBakFXvbs64Vo+kN0Wno=;
        b=SoBcDfFRTTkd0X4nCuckMa8mKgHZoX9J9iXbc0DxoGKMWMVCOXGTx/CQlU5l3ScgcR
         qZnHhI1+7vPSAzCNwVkIcJLNCirPqmYL3mJ3H4XywgR6ErieyqNVKgdSp0u4MEs0g1Vc
         /2F7ZEykPXY7Sg/2wCINewyNNP5tyrxjH18DlPiBXQYydzBTJncFsOLly5qQnHsz0gok
         ApV2vhF1TWY1QHVjMl5WPmurKn6mJwCmsj2R1u//IHX7vzhRnXzwGz5K5OFIG3/ugwuP
         vcXscosu0OhViYGzEJ5tYqbqK3cM3F9NQWhuh5x1GIvOcNZn24j2E2VSXM2LRK9FkbZV
         ARyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023732; x=1706628532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/2ZF6jfLSaibnI8JVEJM3hBakFXvbs64Vo+kN0Wno=;
        b=a85Enn5jeAvMcisUCu/NMGEwaf7WBm+GoXXyQU33iRPdoVhLj7CPvWC8kTcGrRaZVh
         pTuLhKNIDmRhC5E7fK9j0tv8G3TjrrYJTUiyukSwQjEq0egwKzRJK3Avntkvekmdwbbg
         Rq+LhLu1kBOgUscuottDjwhJg27yXAvWHP08DjJ6S+h+qQjQ3v6xfFJAVmLpeSXHCMt8
         /IMiHJ2wvNnXPpPvS1+Kzos1bgNlyqkhf+KrNJo6HdeVWVgKnWTf2MZw86awJcHm0Goi
         aH5PgzD0PeatYMDWvdGCQDGTeQXI5rYQGc9L+V/TCpuZKyig0ZUQgOUgh6wqjFWMTBps
         N0UQ==
X-Gm-Message-State: AOJu0Yy6joBiuqG5FmWAlbAg17cEou57DyEStQkF970iSDNdBbg2rHIs
	MaAic7vi3RA1Tig2Bjl39DIMXgIdWVXv3NHunZv6ssffCgY520wbgzshFHgQ
X-Google-Smtp-Source: AGHT+IF6dmOkmtEdJGi0LpeHvxzFbrE6pfjvl2D7ofv03Sv1VdZ650fQO9ool9KP6jbKPU4TNjmw0A==
X-Received: by 2002:a0d:d606:0:b0:5ff:ceed:10c7 with SMTP id y6-20020a0dd606000000b005ffceed10c7mr2387996ywd.0.1706023731860;
        Tue, 23 Jan 2024 07:28:51 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l191-20020a0de2c8000000b005ff9d3ca38fsm3203108ywe.1.2024.01.23.07.28.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:28:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] isotest: Fix not handling 0 length packets
Date: Tue, 23 Jan 2024 10:28:50 -0500
Message-ID: <20240123152850.2880226-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is in fact possible to receive 0 length packets since that probably
means their status is not sucess.
---
 tools/isotest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 771d24b6d2a6..7e875fa58b15 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -642,7 +642,7 @@ static void dump_mode(int fd, int sk, char *peer)
 	}
 
 	syslog(LOG_INFO, "Receiving ...");
-	while ((len = read(sk, buf, data_size)) > 0) {
+	while ((len = read(sk, buf, data_size)) >= 0) {
 		if (fd >= 0) {
 			len = write(fd, buf, len);
 			if (len < 0) {
@@ -680,7 +680,7 @@ static void recv_mode(int fd, int sk, char *peer)
 			int r;
 
 			r = recv(sk, buf, data_size, 0);
-			if (r <= 0) {
+			if (r < 0) {
 				if (r < 0)
 					syslog(LOG_ERR, "Read failed: %s (%d)",
 							strerror(errno), errno);
-- 
2.43.0

