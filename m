Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F51F4174
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151453; cv=none; b=ke//QSpNg0AXUdLdIw75btgOPjU7Dm2p0sXtVJL4A8zmkkVuGi7w0jFNX3cYy+MImV3uchGLH10ZXXviSHWCAR0xpzfvPawgL8HfODbYYfWUK+G5cyZqJ3yFRBYwVxR0+UqvdHf+EZGdoKZQdyWWZp29pFTGXDxc0twFlD705BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151453; c=relaxed/simple;
	bh=1zyrLZLlBovAE0zfs5zgFr/vCRp3dszXgwSWERtapjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MONaCM1Q468Yt9/Sh/dEU64nAQeECRlzdRtPGUIV5EIXq53n1xDETIm4HYALsrkIF8OFfr+UVncDRoXiopMhkWEvhZ+ZxYl6Oy1IYcbAlsQG+dvfbPlOAiVCbX/5ZFm4Q0VcaRbLViWnqHAHDLfTPY1rGhkTiRKqPsOF0GazAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBxv/xV+; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBxv/xV+"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240764f7c1so425811e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749151449; x=1749756249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXA3dWbMYjMPkgl5Sx056TR7FaPIbzEG883Ro/fZ5qA=;
        b=MBxv/xV+gOLPVoSvNAhQXeszPrBel2w+0AJyYajtakjZYXLdtF/ataiimeimRl6meK
         653G5u12hXUUNU2133WyUnHVTUtIITsZO57E28xUadmC+Vacpw4fy80xF4Fh/SRLONTO
         1OwxtKCVVZzrpR+f3SIdXgB/1jx5je9vN0kQXHjrkYDWMLCPOFSjmU3oBQX3PtpnHQJR
         XfpE+YF/ccUrbgDnN3/TSGadmHd5WjPzOmwCr/4JJ3k7u53ciFXnLmLMk5/Mx7eHrvOM
         fRJLhTmlh8YGs+MOL/GPBc+3qVhYO3BU0xuYLdzQ0pnNgIYLAX5xWhfyTgu3+jMfMqQA
         QTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151449; x=1749756249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXA3dWbMYjMPkgl5Sx056TR7FaPIbzEG883Ro/fZ5qA=;
        b=nOWvuyV3Ux5KbIPM6OA8CWnhqR+TYwEkX2pNT66c1ge2BfSpILjU926+Zn4daQdbvE
         qYjNQb32y/xGJgJnFapb6y/qNbisJGWBKhFD4JangRr/EzleEJQKDFAoImEMTPq2c/Ft
         KEM6Zhhc7e6YYFXyW57nCwHUCPYeshbS2N3ndhLBLcBcsR4qxmbGphUpEJAIyLHYQjBA
         OzCvvlzQkzcn5vfn+OH4k+1FVJDKQ16mDhp1MfAg0pTHWA3NUcTlZSsbT9xwa2g1eFoD
         mvzHS9Rz+VGu4WfJ81jO1P5BYIal6Olr0JTBmkyt8UPR4uZXr0etToZFygkRYmLZ7frh
         vjaw==
X-Gm-Message-State: AOJu0Yw2wFCPsGWO4+uoY5mQoMWHy4Lt52rsIhfpbdd+t+G83Ati/sdz
	RV7JUfa8Z/3U/pyC4uAep+gnVj4UiOQdidVnr44odX6hl3bZsokz2RaOM2TcKjpUdN0=
X-Gm-Gg: ASbGncsEIYkLJsYiKmnyLzeHQ4p+lhxRvxlHfrmLZ5Ol+FmdnGI+gHhd1k9i3OANyiK
	2cc+tiqENleRvoqRlEwVDDUf2rwt/qTrFW6i4jmwmhVUrhZuaHws1EhYzeuk/axdToI2MwhCw4X
	aVOXjQ3NSvwXyGLSrreW9eoeUunKyeXwByT7lWWz7de1TPW07P8avwaDQt/A6L4ECrbrx6aRa26
	9Ux/0NfIP54w69HgG95ypsW1romvQctDt2svjRkZKC+0NVYp+JxVZx/2PptR4hwA0aix2xOtamK
	uy07EBQV0j+1PcXnVYQAqrryFH0iekrCP3DSJCzJxOB/Hy4VIZ5o0S7X2AGVZ0ClkhgCgBqOYvZ
	SXXXvcONk9JUfi9w5qAskua5HR9DVxsc=
X-Google-Smtp-Source: AGHT+IGPWmWGSisnxJVwXC1apBhPFru80WeFxJbyDZnUwCNDNGo5exWDw/JxMoUoTk1y8MnwJJ98fg==
X-Received: by 2002:a05:6122:1da5:b0:530:7101:68eb with SMTP id 71dfb90a1353d-530e47df5d5mr1076397e0c.4.1749151448985;
        Thu, 05 Jun 2025 12:24:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074c3472bsm13173572e0c.46.2025.06.05.12.24.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 12:24:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit
Date: Thu,  5 Jun 2025 15:24:05 -0400
Message-ID: <20250605192406.909397-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables commands to call bt_shell_noninteractive_quit with status
set to -EINPROGRESS to indicate their execution is in progress and shall
not exit in case of MODE_NONINTERACTIVE but it can proceed to the next
command for MODE_INTERACTIVE.
---
 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3e5959fc1868..6b4f7a7ef503 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1560,6 +1560,12 @@ void bt_shell_noninteractive_quit(int status)
 		return;
 	}
 
+	/* Ignore EINPROGRESS as it is meant for commands that need to stay
+	 * running.
+	 */
+	if (status == -EINPROGRESS)
+		return;
+
 	bt_shell_quit(status);
 }
 
-- 
2.49.0

