Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432028B4F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420985; cv=none; b=fCJzaiivmXi/a1YWsWOZtV/sO1+zjhumkEffSuI5DXnQACZ/hse20PTXElO7ztISN3lbd1mwqVFGJcGdeG5QxLaIORXgq7WuKwhmOpkykLiog9EP8RkoZyNmMFDB7u6GASDjDgUQfV35H7nyCvhNOEZOGfGReQsQAZ+tkRw0+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420985; c=relaxed/simple;
	bh=OhUawbqe0eY0E38tuXoB7L+XxX7bbIVNlg8ynS3mHiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU3OiSLWcfYkTezGauqP37U4AHxJv0qJoJsGtwAax5aPYXBLtY0TmK7T7Ud55rp+UnwuoEDBg/KhKzxVt7dIP6ewxLwvni7ncox6Oa7vf0ZmYbckr7qrDsDNU7FUoABfSoJrxm6Yj/9S43gt6Vlj5g8DWfbyd32trF6g1u5jJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=mmlupZo0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="mmlupZo0"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47692b9d059so96724351cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745420981; x=1746025781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvYijgrQ1tOKkPNmsgz5h3nwogafETxUQcPwDDOyHbQ=;
        b=mmlupZo0IV6vviek6RQDGxcCWzmUW9/QKp7Tcvf3v5L92PXCltAFIlqEa6sqIh5NTp
         g5UgR2MIZV7aAD1xnBHa7JDDN9cnbGUY3i6kBm+5QVWp0fGqfRaXnHFv6M6UBAuUhdJD
         y8y+pQf0fKBsBkyi79jSdTgGb4mPY6FCTk7qG3I3dkEHu4+zB9Tm7aC1s452ORDUCXwL
         RQv9vDzVBA6DizpX7cm49/eOeQmkgrQ7duGuydcyzxsAaovkGBP6+0/istfh1GTqtcbw
         JMlN44QyHjzcnt4SctbvK+ml7UjfTvxxRmleKaOhlletfZWhqm7i+BqPsJrGQxfmJKck
         Nmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420981; x=1746025781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvYijgrQ1tOKkPNmsgz5h3nwogafETxUQcPwDDOyHbQ=;
        b=R5NXIMKV9TRxuN+AIFCkgcqKNuQaM68KGUBP6u4rIG21TIsjmHFgjEi3T2hBhveZSr
         0NFtw4kLVpWoJeVoaCpJuir4KVejybet80lEj5YeeBgbkvwNXBS44vBCCfJ6hBXc3rYC
         u4N0ocABkHrbEgNTFAuvOxPk3FwQVPxNafFVk8igzbJH6MPjsyw15RkGskETuRpAYMhR
         kdhlj4r1q3KLjPL/+KP7EHHbnGhn8VLDuyIgdoXAfewuJn7Fffo51KVZ0KEmab6eeMOv
         c8dE6q1cypeqSAq/9fEOwhrX+hzlhphWdnQqUO6eFNBYHytdKyMjVMMiAY6nPZi3tWRN
         J2jg==
X-Gm-Message-State: AOJu0YzMyOwSQgqnJCZg2e/eF98l0mY+ygTuLdLZa2ZhepYtSJ3svKeb
	m8QWPQCRXW8KA7F8h/HDcY/vVFKNo4mBbCR4ufcC1y6Rtuz/7qPdivdqYcq/GKLdwPbIRPu0dC5
	Y
X-Gm-Gg: ASbGncsQB15A89DVzp4HtOmLMSKr8ZETWEXSa/PcRrvIpjvZjjUJeLoB/jH5sjDFKFy
	4u7rGvY/58PuGRNFlBjPpWVlFtp3M2EBjCvhWXg4BVVNmCxPH94kbTlQT8ZhevBy8HYGgd1WEyG
	U8P0K1NFNpMxpZhsqYDL6VHxOz1LQjvcZ3Zn2OC8yLrRICS2xTIP1OSuitIvEowCzFQ/c9feuK8
	CLHOi5mEhVNSwSCxLKATByVt9UlSrIB9SbNcR+o3mlL1V8FitAUDskmWhmQkdoI+t28eoWWMuJk
	1xN8A40D71L5O3N+I07mvi/ndERlCNC1gqiUeQ==
X-Google-Smtp-Source: AGHT+IGitCzM6qjirvIkdfvKhWhjpfMkJ7+6uR2Irnp1POYontNGRStdSu2YEIh6mg3m8l2qMQVChA==
X-Received: by 2002:ac8:5f51:0:b0:477:6f6d:607a with SMTP id d75a77b69052e-47aec365c6dmr284752461cf.7.1745420980623;
        Wed, 23 Apr 2025 08:09:40 -0700 (PDT)
Received: from andromeda.lan ([74.15.9.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa3f1sm68953601cf.79.2025.04.23.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:09:40 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 1/3] profiles/audio: asha: Reset state on disconnect
Date: Wed, 23 Apr 2025 11:07:40 -0400
Message-ID: <20250423150742.319463-2-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423150742.319463-1-arun@asymptotic.io>
References: <20250423150742.319463-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanchayan Maity <sanchayan@asymptotic.io>

---
 src/shared/asha.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index e7bba4cc4..fa6b489d6 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -174,6 +174,8 @@ void bt_asha_reset(struct bt_asha *asha)
 	bt_gatt_client_unref(asha->client);
 	asha->client = NULL;
 
+	bt_asha_state_reset(asha);
+
 	asha->psm = 0;
 
 	update_asha_set(asha, false);
-- 
2.49.0

