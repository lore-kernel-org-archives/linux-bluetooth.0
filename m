Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EE6BB5F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491379; cv=none; b=hN9iieJyBFjvGISsc9Af1KrNxbwL1CAyJK1eaCQdN9frvAtm5E77AazI8WF+8P0IohtQymUMXq3/WNY5D5WeftYS2RvhIv4bm6oni4ToxJiUJ8q/52e3tKYVT/E0HZ7ppiJ2hTw0GAnNL9L9tc+4f+bJSIdwrhgINyzhw8tXBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491379; c=relaxed/simple;
	bh=zv7Nu66fm9BGM7BXpHvcQE5IrQpxctDP00lMOF+NOa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BhybFeADeIUaVt+Qdd+huHmzYqkYQB4ErNC9wLSQe587aVRxj/N5tTpLzDJH+j3c2QQTnHD1h6H5uChUETaqavGxXLQCJmLaxRPbYP4XPTwYXeE6dH8Qilnlo6oSaB1qolr36eZMit15m0WScWjrcAfn4Am24SStIx8/AMj4TXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiUshoA0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiUshoA0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a38a1a9e2c0so130131666b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707491376; x=1708096176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eurr/v6k3pWi7yB/sid/mxA/9t4UiM3B9onmwQwfiT4=;
        b=QiUshoA0hx/ohGIf+YhI/pmviA5tZyNhePKudltsr3+Nt8mggwgRLOT+3DYVV7ofiv
         dWQNZadJ2hK8f+URMIDXeKyk6sn4EQ6SxDOBl9e9k7boPZWUexVtaDKthG0zJoef2Cpa
         MFZBO0FeaQljQVCMwhvJlGYRY/dlqm+S4bHEzExP8lbgAMoGv69UfXFbUz22iceufNmr
         nEdydrG4ZnM3rsvnI+jGAGjSNsIr4X3UNaHagfbG4nNd9lLi44rhVD/ODcf9fFTP2x4M
         4jmIDb+dd49wvhoQPlaaV/gk2g0sHkPlq3fQ2+wBmJU/yN6cj1IzyHWMw/JGJDihPwHa
         D97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707491376; x=1708096176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eurr/v6k3pWi7yB/sid/mxA/9t4UiM3B9onmwQwfiT4=;
        b=TE8sG4DH0rgya7CXfdf2zHff2qNikfOMqheHnyRz3XQooZ+xq8WafgK/Rl7U94yJYF
         WD2Stv/OM0hNKpmXOn+1eZKufG2RmLHiamOR++w1nekHFQhESsDqvAX6gQ6kIH35e5uP
         B8zz5GuC5x1cbxm2qzD2OUYfBe80OUdILhDZlpfTB2YJewL5TY6yig8JRuc3AO1BhC/j
         Lt5ifRzAZzvVmfA6NmxPwpO3inE9OiFnHpVwid1IPfsTFgdcmoggV4UGAWpDRpzZ6/Is
         dAGVbK5ZTIpXlX11aDcPCT9GUBmFBblPnnD+wicph/WZYsmKCnLg70sJTTmK7/sQ46sW
         DKpQ==
X-Gm-Message-State: AOJu0YwN1BGgSj2AhmAvg/kOeoL7Uyx4g7Yt0qNSd6mWlDo+U8Jk7eKP
	jbQh6sZxGI+jSVtCaEtkNetk7HfISHWohc87CU+gdXLEwkLDLJQcf+WFhxZv
X-Google-Smtp-Source: AGHT+IHWzJc81volZlMVpSl8WQD7IgZW9NVzXYlGZyXSnv3g+hRVcTh77mI4AZGwX+LiU4vgSTQa9w==
X-Received: by 2002:a17:906:818:b0:a38:449a:a375 with SMTP id e24-20020a170906081800b00a38449aa375mr1601086ejd.15.1707491375603;
        Fri, 09 Feb 2024 07:09:35 -0800 (PST)
Received: from raspberrypi.home (46.205.193.64.nat.ftth.dynamic.t-mobile.pl. [46.205.193.64])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b00a360ba43173sm846410ejm.99.2024.02.09.07.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:09:35 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] hcidump: Fix help message for --timestamp option
Date: Fri,  9 Feb 2024 16:09:21 +0100
Message-Id: <20240209150921.1187294-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/hcidump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 011864bc0..d517031dc 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -610,7 +610,7 @@ static void usage(void)
 	"  -m, --manufacturer=compid  Default manufacturer\n"
 	"  -w, --save-dump=file       Save dump to a file\n"
 	"  -r, --read-dump=file       Read dump from a file\n"
-	"  -t, --ts                   Display time stamps\n"
+	"  -t, --timestamp            Display time stamps\n"
 	"  -a, --ascii                Dump data in ascii\n"
 	"  -x, --hex                  Dump data in hex\n"
 	"  -X, --ext                  Dump data in hex and ascii\n"
-- 
2.39.2

