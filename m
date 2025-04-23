Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EE1885B4
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436559; cv=none; b=ZOt0fAY0gOQ84+6t4fpbKl/87Yn8RWAeImZMqtpO2MwmnIyaNHJsi6Dp8R/hOfOxSPSM9EnkIvkigxurVq6swJfdov7OOupx51oi0I68b4lPF6Dyvi4wnybrynx9wfaBv0rOs3zJn5iHsFAJ+/0XeULX42pbdABnKyw6mVYfMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436559; c=relaxed/simple;
	bh=0uBb6LFH2D1eDp3Wl8iZDrjVpcPfduQCXG9J7qNLMR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Yn1/oo5WoFGjh9K9tndXHlk6/go2v7ba2RPirEZEH3hjLk8E5jl0T5JXkjl+06nfMX2N6xdsFIAlx9s51VxpOch85/9UKCHO8DfVy9kARs+0a1skTnYfZP+GqNZYYsbzFPvuzzyjRkhd5ivZ/bgt2tND3Pds1Utxfz92PR/DBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi+PYwf5; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi+PYwf5"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-524168b16d3so172153e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745436556; x=1746041356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r2/F04EQGDdtu4vKHitTPOWutE6Y5l/YsjHzQYrZcY=;
        b=Wi+PYwf5oL/So3VAMXkjW1SBxvLNe/DmvwY8ZKxL8iAcJVjBEBIrcIpHvGq2TCyw0F
         aJMwcHAWG0wV7Pl2dwQK+ZTbNeUdUv4+ysPYa78aDV5HPLh55ve8wx/uEB2T/Ui09fYK
         UQXHW8jQQPbK7um87mzBfdU2f8Tkunf1+MVWue7uC1hOvrZ8DqVq9V1yEI97OPxdLdqy
         3eDk5zjo96fYJ0opffEUvkWTAq8hnzaPuVkTpZ1imBihB3kfPdTNppne1UX70NvE9akt
         pNM8NXN6K4H3buLSJHo0K3EfCFujHBIevmb7EgIml64bUyGF8Ke17bW+wg3GiBo3jXmt
         3HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436556; x=1746041356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1r2/F04EQGDdtu4vKHitTPOWutE6Y5l/YsjHzQYrZcY=;
        b=kzJzVZc52jRoKfaU2X/qPGmx5LKW/U4vOcGE4ASoXXM3ea2VNGfK+Zw195FLQvNJED
         RNe4SnNXSLz6cX53D3WotNXFw2r+w1o36xI4GFwRvtm6DrwO2a8ZfR4FtootIu4ITcp9
         y+oW1vig4PQjhcyrH8aJqewRMuCsdPzk0r9LTO8YryaST8FALn7Fc31iFfo2/DBMnrf5
         ul0EsNZxA3TF0lOkxo+n8u2OFKZ3fzFY5WT65J0ym0zI6re3kX5BVrtDE/cd5U3cShj6
         v1VcNThrWwxdKmLPUMkbuJKxoWMEb6VkYBiRnEYbbtt5XI6wlPUDPYCBdbo4l1Cvb/MF
         G3eA==
X-Gm-Message-State: AOJu0YxlhEophmgoqXkfPeLvAIa2AxG7616LuOh1okxXos6t3wAX5LyR
	VjYh4swtZW92yrUk/Mye5NISQvtfkLO5BR7faEjxF/hQQ0TeZ2VqbR9KaZvQ
X-Gm-Gg: ASbGncv5uMvZMG+5PjoIkcxiYoDXHnqT6tmbV7HETWc5fuwakCtrrpVmVjbWrYlbZk3
	GWREzpUsSTPtVA5WWhnfeIVXe1ZaUT974n/rWygsJu/UfuROFgyb9EZGcUQfg9xOh/WNgid09CJ
	9nLzpCt0f3wqMosOLVPX0HgwAoZyI2DTCNwdBPg+jMLfjj6WYuZkgSRN+/f/Ar9IZf3XO6rnpOf
	fdMURkDI68y7SYSZs6dY/SafBqxIG0v4Ks3rvX4afgfkOWaKqw3VehfzBRByIwcKD/Ilv7SY3l5
	3zfyf6u2PwPLEfuM+RbeavD0T06S2QdC4JZpS5t2KkshQc0pqMbIbi3bdX2t8Cr+LfQqmBQUzl1
	spS76zbDC7A==
X-Google-Smtp-Source: AGHT+IHYM5daknf8RT8cHFqMeJRwHclmlsyq49lKKTwmnpZffOkgop88jdqGAh4OgD4nYoDqfImwyQ==
X-Received: by 2002:a05:6102:3c9d:b0:4cb:5e02:7538 with SMTP id ada2fe7eead31-4d38f1eb4dfmr264370137.22.1745436556036;
        Wed, 23 Apr 2025 12:29:16 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dd7be0bsm2783613137.5.2025.04.23.12.29.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:29:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflow/sync: Fix workflow task
Date: Wed, 23 Apr 2025 15:29:12 -0400
Message-ID: <20250423192912.1182925-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sync repo from bzcafe does assume that syncing with master has not
happened yet, thus it aborts before syncing the workflow branch which is
required for patchwork task to create PRs.
---
 .github/workflows/sync.yml | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index 48def96b8aac..783e2369fd26 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -41,11 +41,14 @@ jobs:
         github_token: ${{ secrets.ACTION_TOKEN }}
 
     - name: Sync Workflow
-      uses: tedd-an/bzcafe@main
+    - uses: bluez/action-sync-repo@master
       with:
-        task: sync
-        upstream_repo: 'https://git.kernel.org/pub/scm/bluetooth/bluez.git'
-        github_token: ${{ secrets.GITHUB_TOKEN }}
+        task: workflow
+        src_repo: 'https://github.com/bluez/bluez.git'
+        src_branch: 'master'
+        dest_repo: 'bluez/bluez'
+        dest_branch: 'workflow'
+        secret_token: ${{ secrets.ACTION_TOKEN }}
 
     - name: Sync Patchwork
       uses: tedd-an/bzcafe@main
-- 
2.49.0

