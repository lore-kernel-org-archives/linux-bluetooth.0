Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B85FDCC
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023724; cv=none; b=gB9QBu8iMeX+wrVkZ004oAtxDqwXLFYCrfsRKgkQN7uqh2J0JF2W/dIOCBLty4W3vf9QMNX3zeveF26Q58FqaDrWG8W6pceIq0L7Hb12Z8TQqvigIyphPMxml/jQMKnR9XKPXGqvb6++Ko3eHbEtIr1FHMjCS0iW7nObt3QxObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023724; c=relaxed/simple;
	bh=Hz/sQTkal72CIicSJ3PgwnCpkwcm7R8/SSPoezeooQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k6rW+NB7KcL5BRxWw3okmZsYsHpK5HTg3xKmz6IXLToxkvoxHEtu+n8BiB1AmaFPv8hVtrs+RQBEqQ+59veNA1ATp5zOEmiaHpmMl+M2hWp144bxXtlfg+CRxKOWwH4PS5hvLg5Hhk1CwbgNhmwBahGb3g2Ps/rX4KBJKd6v77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNrIFDav; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNrIFDav"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598bcccca79so2452684eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023721; x=1706628521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/2ZF6jfLSaibnI8JVEJM3hBakFXvbs64Vo+kN0Wno=;
        b=YNrIFDavq8SDNwmUWv7+ANBgcYmjEjhLcs6q+khJiUaZ9mc72JCHMEWoZOiEeVq6RN
         jPS81qM10rHCdz2G6czKjHGx3CmEU5GB1kq/anbHd/xlicvam612BdlOQSblyVZs5TaD
         Jv+4a4UgtbSJRkJ/00Lo1NYYX4fyrWG6fRIXCqaIZ2Xd8aLqS1LNkbh6ReEbpLSYKN4t
         cPShAl+CKpOhVeUpFfkbOApdYyNqiMytkFbTOlrR5N4oCMlgq1WzIhfWyFLdTwUCV2oy
         +WrZOkIrdIsz24DHiT8meuHhGOTnJyHlpDDZ/C6X8Z4XS+tECgcdI9DjWbha53crVUtz
         v8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023721; x=1706628521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/2ZF6jfLSaibnI8JVEJM3hBakFXvbs64Vo+kN0Wno=;
        b=mNUE/bDvBsUNu+6K0pYOOi4WWuF92RtTERF6ir13N5WU7b3qlg7g9r6ixQUiLQXKdf
         0X4XHDeAkQqXUfhKcGvzLUKFbkyoMGLRvRCLooRMnnLnQZfhzvzv1zymSEQE15CfusEg
         DWgxlTUaUkvgss5AcRqnaZBihKdAhJWI0e94gHxxipsmdV65GNRF2tBktu5D+3Rlvk0X
         aSayjAJXLCJKAO67761fLbFWq7xuLKxZBgW8oWuiNwPhNRcphBEu9utpbMHe+yNLWuo0
         YmnDwMJoVgFL7R4BnP0CSZM4BRaADypUla1CrwzyY2lioD4dTXli07DX00JurWIXe+lk
         UF5A==
X-Gm-Message-State: AOJu0Yw6PJNXN5E2Dt/faWc0xtsHvjA/N7wFUnOwuUk4T50SQk2LihWj
	i4euwm5TRjx3l4DFHgao/T85Nggps7JTxk9xQfZF6OoezBkhW9gi1yiKn1kq
X-Google-Smtp-Source: AGHT+IG0SSumI+y5SVNRd4Dk/uTy/yDLTXGOW4zGi8+TQ6jXVqRyxO86M+CQ04tTTnkA07ADmwQRxA==
X-Received: by 2002:a05:6359:4c05:b0:175:733f:32a7 with SMTP id kj5-20020a0563594c0500b00175733f32a7mr3423781rwc.14.1706023719785;
        Tue, 23 Jan 2024 07:28:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id c68-20020a814e47000000b005ff9deadf0fsm3130280ywb.94.2024.01.23.07.28.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:28:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] isotest: Fix not handling 0 length packets
Date: Tue, 23 Jan 2024 10:28:36 -0500
Message-ID: <20240123152838.2880053-1-luiz.dentz@gmail.com>
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

