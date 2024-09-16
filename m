Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10664174A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518231; cv=none; b=ixWqSEr/dMoXVme/Z40kqlZSp0t3dnqrcXrvsjX18UhrOxBlZrYbgb6ptpzLLuZTxpgfO5fSHlKGOZBbz7hpOAs9V/rcbcgR1uXKV7OsO8PBSgAPJIuEtGsXfarB7RntIehSVPV+d4YmgoNLVGp5R00UX0c2biJP7b5zL0KqMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518231; c=relaxed/simple;
	bh=dE9ncddaBxqIHr6u+VYR2VArdd/tXGYl02HqWQcgn+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihzo0Gu6ynoE3mubK1sCcvhzi8i0vbBMdgb4l3Ts4olpKD5aGmKxFUWcXUC1TxcCpf+HQpDJphjyuNPS+6hOvGsv1X1Vk1quUSUVeJKbTccXjjiX3OPrjAEh8zpjr4xfEydH3DDhPzM1axRNbMMnwg0c4P/jJPH33Umx4HbkLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWZ7u5Di; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWZ7u5Di"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-501204753c4so2468198e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726518228; x=1727123028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfuY4LDsqVgg3sv4m3MLMlnvHz6GWqxzPzNtKt8TZ0A=;
        b=DWZ7u5DiGkcxEmLzBaGbfZFIc4A/5McieylqYF4LX8qTdNaJBuDgi2WzxFpWEix5Z/
         q3ogT+vqobGynn/IIxBT9mJqgJH1YCr8fBs4X8KPQ8mh/G2dOy1i0OzbBMwRwlRaL3HR
         b+ZnyW06GVNrLDQe/elPoa48vEQBnw/FP3CV/b4GFFGzLq1d3C37oIJFxwdUHcqceNz6
         uPrPV0t4jUTryXdiWA8UxUnAzgiBH9JL8eBlbqYOYu7SFyjqrSy6WPU0dHurTIPIgiGr
         aN16bMQBIt27DFwbaICawqWcGWgLTNKTZNRKW5MX671zt1qbFrMAFQ0XxT9bgwP/3pMv
         rSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726518228; x=1727123028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfuY4LDsqVgg3sv4m3MLMlnvHz6GWqxzPzNtKt8TZ0A=;
        b=pYil2wt9vkZnvRCJ5d8Q8iP7E9ubCv+Mj3X8bxGSyjMIKXwRlELXAh6CFwHGCqJnGG
         0HVDh1FxT29AHvsejm2a7ACCF/vjsH6i6J68oksjGHhgZN4pNTgqJYmX0SR08btOmLVk
         +37FoTrgAwmP64aLNHRFQMzuvCh6PRf+wfq1XPzfz6gDAxnabQWCEkzWQCco5vpnyoG+
         Z0s1OhhDuzZiq9Ii02i6IJ/mVBUcAG09EESehEXv7xWmA/oahN1bZUah55zNfgaai+ns
         POVqah+TeBKF0nYSF3foPL1HBnE3IbqLFKMedrOaTVU78NqyS0KzapRpayrlphXTJ2P6
         +aWQ==
X-Gm-Message-State: AOJu0YxkdVaL7e/gmFmRNmVWz6aQklqHOlCH5+R1tDu+DuqTMKsq2EE4
	3iGJeHwn2Mrk38VBiD4Y8NryvuZA/niZjZOY5tR3+9bpSNHQLfFinizevQ==
X-Google-Smtp-Source: AGHT+IH+hIznlwmvWNlkWb9PQHHLF23shNrXtdh53e3Cvda/q1Z/ZxEa2/jSSfcJ8fF+1VxG1pekKQ==
X-Received: by 2002:a05:6122:3111:b0:501:2221:a3c9 with SMTP id 71dfb90a1353d-502f70e13ecmr21283697e0c.0.1726518227881;
        Mon, 16 Sep 2024 13:23:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035b929ec9sm622787e0c.9.2024.09.16.13.23.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:23:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] test-uhid: Add call to bt_uhid_unregister_all
Date: Mon, 16 Sep 2024 16:23:41 -0400
Message-ID: <20240916202341.238735-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916202341.238735-1-luiz.dentz@gmail.com>
References: <20240916202341.238735-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a call to bt_uhid_unregister_all so it tests if notification
callback end up calling that.
---
 unit/test-uhid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 6871c22eeaa1..c5848bef97f9 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -100,6 +100,7 @@ static void destroy_context(struct context *context)
 	if (context->source > 0)
 		g_source_remove(context->source);
 
+	bt_uhid_unregister_all(context->uhid);
 	bt_uhid_unref(context->uhid);
 
 	test_free(context->data);
-- 
2.46.0

