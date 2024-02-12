Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCA3FB2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777114; cv=none; b=X5iEGr6hFXG4vP+SEp887OmJ0lsYlQYsyHAHedP5VoWz3y30Y2CwNld0z0OZ8+5QIn0nHxjkODCsWh9Iucc5+S8CoQm3bgljjunu0d43jYswUyTqKsRtyQNAQ6vmaRKJ4UXwv4k8VlKmgvi44qb270qviG8ActBa9sanQWcmy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777114; c=relaxed/simple;
	bh=j13zusx1iNy1VSpCf0/7Uh5Vuxv9p4qo5PlC9S9RetM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFv2vpt0enWND2TvOCRLVp095Fs9nwCNFWrRZloHGxOwMFezyefOGLJ1lp/k2SreW64Uh9GYVMVp6TqlMuAqwLIMSmfqAmkAMBau/MnVnCLNLi4HuZbra4kRr+P5eojnlpWnpsS4OLqWtTGdWkH0/LjeSFcpCnx7F8yqnmWIBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llliLZ2G; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llliLZ2G"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c0819bf523so644875e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777111; x=1708381911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kAGhHA/F4F4m8PaN/GFfvTrWCN3YPm3thn164WVswE=;
        b=llliLZ2GqkOkMJz/U3aX5rSeK7Ga7Fg3R2F3vYsh2RZrnBrCC/E3XGzHz1qSBSyK+Q
         S9U5avaHPwyAiqZMnmPbyAmeZlpgvjuG2u/Fp/sFi4rvox4W0zxoq0HhSWfnlSdHk1W2
         rTTR3Xa91N8H3w8OyylluFB9gjV+KzCI97MTzGqhbQLVcUt3NTUZV3DpCxR7I04I4YE3
         oIuuEtceaem5khVGoz6nE01Q7/XYfFB/wcbBdNE77Xp7D43yhx+aGO8ec8IGrdXOO0Lz
         IXpEeOe+YldtvkgKqUiPe7BmrwkEpR+rbXgX32SSvJclROhjZEdEiIfuCQdLYoDoVk8e
         37Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777111; x=1708381911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kAGhHA/F4F4m8PaN/GFfvTrWCN3YPm3thn164WVswE=;
        b=mcyvQwsDYM0l/NQIdFlf0OmrMPxQi2ib+Oz4Xih2QxbU1k+MIyb7oAozBw2Psy2wo9
         AApS72OwX2h69nzOxJpKHvC6+de2Tx7pDXZd7Bpf4DNu5mqPU1BQFbGXQwHF/BoNYxN0
         kUEssdZAqv/QlwLLJInxDYD0kastoUvl1HtOZczUia+QqdOE/75Rh3u74iBWKQaQ2Mgc
         PgzAlHimjvYMyzF9U4fbASNTGZJalye+aY2k1BxRYc1aLbSbsrflU9/JRTgRyvF1r1UR
         0Z9aNYHbckb5xSAc3wqNBqdm153BK7kGzKSsXYFxX1aoJe7JIoT7QiC2ic62DKAsms9v
         wnqw==
X-Gm-Message-State: AOJu0YzU/heo4e+h765px8MO7zOLufu8qw39bNk0tQ76LL4qf3gPqfIW
	xov4IZn35FMx6btkOagtG9xEFJVHfy4lAQaGEG4F1Eewc89MaZpE3xilPdOg
X-Google-Smtp-Source: AGHT+IGyijZh5LhAGLAJr9H+rh0MI4BgZfK1i1FooL68nL6fejHS3zDBKjMpin53ExsJDqXj6AftYg==
X-Received: by 2002:a1f:4b41:0:b0:4b9:e8bd:3b2 with SMTP id y62-20020a1f4b41000000b004b9e8bd03b2mr883533vka.2.1707777110935;
        Mon, 12 Feb 2024 14:31:50 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z13-20020ac5c18d000000b004c0460eeea3sm840483vkb.43.2024.02.12.14.31.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:31:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/3] input.conf: Make UserspaceHID defaults to true
Date: Mon, 12 Feb 2024 17:31:45 -0500
Message-ID: <20240212223146.4142264-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212223146.4142264-1-luiz.dentz@gmail.com>
References: <20240212223146.4142264-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes UserspaceHID defaults to true so the plugin has more control
over the input device lifetime.
---
 profiles/input/device.c   | 2 +-
 profiles/input/input.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6c64ff1c1c52..ff7e3482d0eb 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -81,7 +81,7 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
-static bool uhid_enabled = false;
+static bool uhid_enabled = true;
 static bool classic_bonded_only = true;
 
 void input_set_idle_timeout(int timeout)
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index d8645f3dd664..00a34eb63de1 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -9,7 +9,7 @@
 #IdleTimeout=30
 
 # Enable HID protocol handling in userspace input profile
-# Defaults to false (HIDP handled in HIDP kernel module)
+# Defaults to true (Use UHID instead of kernel HIDP)
 #UserspaceHID=true
 
 # Limit HID connections to bonded devices
-- 
2.43.0

