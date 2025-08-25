Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90923D7F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136801; cv=none; b=Op7iFTWv2B2e08sApugrlmjRbL7HhzhiGN2IBAEI/seP2OupnRQ2GA+3zl+NnPRogGrrD2ANLlgxNx8qcyQFd+Ku86ijDqrgODYx71esDNprMg+JiwZ/s5ZrWjc7UfGlgB6QJD1RNIB0z0gc+KNyEn4GG+OhfLfpyGpu0q6WNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136801; c=relaxed/simple;
	bh=QPiHIcnjEIQXX8HvtF2dbdGI14rEMpqNm7Db/egGSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQS3oD2xGrlncHy42Qf6KCtWIn4I3pn0Reern1Y0nTxpQoLO0zLvc0rMc+W+IGb+Jyw0so0KgOKU7aYhMK7kCoq5w/M7Q4j4C4qV7ekPtAvpJc+pnx75b/0g3N5e0FOpcrYKhr9WE66q4Tnd/Z2mEVvDqnAJVxz9BZsqydzoUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4HUggix; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4HUggix"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso4608326a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756136797; x=1756741597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndXnXye3I1vPRdV1krfnKlupZV7TGlP/IChcvzD7xxA=;
        b=O4HUggixNZUgXclAsS+/fRvKaSuRkwnDQ/H8Nbd9QUlAhq7f+DkkpRzN0s+2WyFp5T
         eympYui88K2AExyB42bCN5RNFx/Ky4s0Fc5Ko4MKqV1+DNJIqRy4xYUT8IrDVxGHBqHw
         boCw2dY1zPeecnh+wPJ/gTPZlE7TkuELAeUcjdHKNh55gU646xeqtEKtkmUnSHINd0yx
         5Umb8hzi4YzVKr+tXYBZwTWvyynLHR9yJ8PrQwvi0tsL6mhsv1BCrJYc3GY0m4xc1HXL
         B/TrNKzQqnufT0dE2P3UYeRAaDMC/6OIzx7BZuoOsCbDVEQZ7fSiTzTpF8rHi8jNhss+
         7vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136797; x=1756741597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndXnXye3I1vPRdV1krfnKlupZV7TGlP/IChcvzD7xxA=;
        b=u56yjX0asfJnGLasyLXNCLu/2SHf45FU1j7tvoRhpcb+ZBfNu4DUlEfvcXWK5ECAbr
         dy3vygSEKDbvMYfNzv15JusrYVRrqjqeyyxK9RU9dtqwNNxCllW4ikf9vLlhLoosrrKc
         Rdb+4ofl9WBfHkSi1XJU2MZXGcFDI3gmDgcEIk0L71clA8jrR3hzye0aSsW5XPcAPH2N
         lRmfgQ/8PWLyeOJufKwwYOy8Ux634YJaAIBFUoUUGsXJ26CtzSVIpFt4QC3mBrDy+vCQ
         hTgjHY7zADsziHmTqOj9aXpk4MrslRrcqg2baucj6gtX8PNXBEz7KjejQmEtr8lNahQT
         q2wQ==
X-Gm-Message-State: AOJu0YxApmMfbHAey6q4ArNANjiWz8VCkEKeLJXj1BQYdhl2nfnIUyk+
	zdy5/Di08hd65fnFWPqKKuUVvJ3Gs4/LrEntMpqraeFIpkevAAJnkqvC/t+pMFu4
X-Gm-Gg: ASbGncu9AWh7vwKCZGI8hK2YBYlt+WEESy6LdHJo8RevOWTdG2m5DIWheT/wR5tVF8d
	n2x1nVmHg9TH084f4+9VZaEx1/RxAx05acb0bGZ6YXUszmFg48cS5p2r2Xp5frXno3T00PrmgWc
	j+3XzrabGpEEhp2vTtLTGlMlIQZnu2iCQqWeil1FaKcakYXjPjvKcwIxf69QVQq1rBTQUuQ1lmV
	2KiijOMqR8nyqRHE5TfUgFVJFzApbGhSX7WX2RhLQ/iuYwPrKSDnCPuUPtkyPRYXGWGAaCNEKJZ
	tqV8CkZcD16pdN+AeazioqKPOau8ta5hyajWQb04RT0krB7XmNMSoAIPMcQvrv2m7Kug7stgC8r
	/BPF7MmCHLdeDndMYtG8hTLMdncEA+JH1Ly6Ulm82QE0YH4bfQCgrEK4y1Pl7/o+t127HVAoBHK
	iUoEbe8NFYlKmh1f0DAA==
X-Google-Smtp-Source: AGHT+IGpIUUCQ5z/vBsufQMR8ZD5+gJIdpOIZixyROAxZn5X/wI77BTkHjYLJLuUYuh3yPD0ntyXxg==
X-Received: by 2002:a05:6402:847:b0:61a:a0d1:209a with SMTP id 4fb4d7f45d1cf-61c1b6f3dc4mr10460196a12.19.1756136797257;
        Mon, 25 Aug 2025 08:46:37 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c45040d6fsm4075068a12.41.2025.08.25.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:46:36 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] lib: Fix includes in installed header files
Date: Mon, 25 Aug 2025 17:46:32 +0200
Message-ID: <20250825154632.336611-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every public header file should be self-contained in terms of used
symbols. To satisfy that, hci.h and hci_lib.h need to pull their
direct dependencies, so users will not have to include bluetooth.h
before using for example hci_lib.h.
---
 lib/bluetooth/hci.h     | 3 +++
 lib/bluetooth/hci_lib.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 8f59a535a..732477ec4 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -17,8 +17,11 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
 #include <sys/socket.h>
 
+#include <bluetooth/bluetooth.h>
+
 #define HCI_MAX_DEV	16
 
 #define HCI_MAX_AMP_SIZE	(1492 + 4)
diff --git a/lib/bluetooth/hci_lib.h b/lib/bluetooth/hci_lib.h
index 2cb660786..eeb51411a 100644
--- a/lib/bluetooth/hci_lib.h
+++ b/lib/bluetooth/hci_lib.h
@@ -17,6 +17,12 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
+#include <string.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+
 struct hci_request {
 	uint16_t ogf;
 	uint16_t ocf;
-- 
2.47.2

