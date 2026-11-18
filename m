Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011305;
	b=NUmbw1fsqxGGJrkHwde0NTsG3yYlszM5Hkx2VgA8JaHIXVHFi4SaAa3QL99uEWPlyFn0
	 mF1X5PDPyQ6Y9d4jZ4zFrAKalzSZjYEGbd6ykwpzqi0QY8GPMq/C1Tzw8ZkO+xNStnz1y
	 Mf/7vKjdG66wQP1/uzRE5z5kt84YM+SlblmJPYyUD5rZYZSxb/kCGAaYlGxW5NE2VY0ez
	 uKVpjV14OfRBrMn5SKTy/O8q9jD9V9u1osuUrSJXuCrPxY4y7k2SlzxQlv6MdYAOcq6Wx
	 ZA540kYOLwKkhAhhm8U7NSr2uOKhrKwzSMQGfp9RVTSxk2yuIquF2gfrOPiuiS9VHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rNpgrP7FADnjMSe3+q2bTlSKjsJzUZlAqVwOSv5pfGQ=;
	b=YBP5Nd3oFHtnD55IYz07D6T8XVGX1x/9cd240Xb5zcN/fnhcSS+p9oAetn/eV2vB3JPW
	 0Sroazy/Chr+GiPG8otr9PoD2Zj2JVF5iCxTo5y/R2svspfs8lpyUTQBJZbltUpxq9JKK
	 3LyM0vdy53YxxKjsR0bduUBT0od7uKeqb55IQWqzChfmKHoug3zt/DlQdac/C9ljMM1U5
	 N9EnQtHzypcIDtiSlhIMeEyBFfgm5F0ijNUojYPIE1ACf6Th8x8HNtOPQP6/XMcYoPptE
	 siSNpRngkw3KSyftRsSoGPHiNf2FWzH4lGpl+tEZrCfu9L0O6AaCeWQNwZo/WTBncxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUFLqZpM;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CD606A336
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09CD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUFLqZpM
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so8363955e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011302; x=1795616102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNpgrP7FADnjMSe3+q2bTlSKjsJzUZlAqVwOSv5pfGQ=;
        b=IUFLqZpM9PxrjcmZ+zkeoyBIVRaYdExgY9xz4Kkib4igzZ2qNvq6ly0c9vbYR4UUNI
         oz4g1dsHr1l8FwdnPce0e4Xn4oodS3Yd1LpHBUWT9YT4RqJnmnOdZcvEGPmdXQBs5rr3
         iu/eyAdnb02zGmGoxAytGFyF4EvUqYdQ9iUnBvIq6sJzIBB7//debCbSEYPIQ5Luc9Hj
         1+8JAei1jbl0CtiAyNiosoXwBa0Rjo9m6rtniRtgbzjFPAlubXz8Gw4DogrqE9tcqKny
         zfREungF3X/8HZ3yedN0uHwV7k9tcZJ1kUTswWmiOLPW2VXaZ2sBFgxUbsZqmMlPtZwZ
         /taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011302; x=1795616102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rNpgrP7FADnjMSe3+q2bTlSKjsJzUZlAqVwOSv5pfGQ=;
        b=fvJgLOxY4poyazEos9Ijd4/yvKLyaPJPl1EXgZvb0A1KwmA6QlHno+6iQJRBnwaaqc
         44jdJWgLqr40p1WmRBLywZWWVgt3iMb3d5/PZxFcnDnGVwDAEVSKscmLja5aRc/XjfhZ
         SSl3NRd4pxBi9r4pXViQidsgvdu8saFIJHBJGUTiH6u6dv71Ba76EDct4OcAZVWn35xU
         bL18kFRVQVBkrDc7JGuHquPr92sAOdY2W4kA6GOIU8ulLbdoinXTBWZUYQxI3DA6oBgM
         3FUPWGjUJhng4olIgtvrkZawl2nw6eWGS/wD641njU5F11kGM6qFqRjtPUjARzYZhgHK
         z4ZA==
X-Gm-Message-State: APuU4Z//9nJkkggYyNk6WOEkyoDk/65FDaKg5grmOpE6utMHQpavQJ7X
	UZjdPvZ2/LkW75SAnun+t2Kc5HVPRXTaZFVWCYOy/RUJmkEgc7uPMckx+r2U7DfHSUg=
X-Gm-Gg: AYBFou0YO+UNhvJOyJ0kgYKpaHXPF/8eqccSb0y/0vnP2PGk4esAgUFdpco75VKKWtS
	tNGGvqDHA1Njsj4kp34uM1IWxXCLsQk5170vGn6vSUtKhKGOtksvUaPEy8sfTKqZ/SlyIahhfal
	k8QDewz70EuQPLr4m3Q7y/iLbqIeccl6PBf3pIL+lANT/xoZokjcOMGMlQRRIIdimjjztx0OhRH
	NJkcmWErIQn95r3a+ammhQeRzDSV/LvCptZkGFfWIyN0HGWPciYcn4qiVUYoYdD5o1Midi7Td4Q
	LB0y2QAgzdu7Pg9PeiCbYFt+7igR3ymBGEHYrpoJS82ICurzqavqTilSH282wACLwEmZvL06wuN
	xVoT6SQiiHHlX/rnbbtd6ZwOZn7dVJzEW5M2HeJPXD6KM4QRgotGhICtcLFb9CuiIX5gSbN5DML
	eFy9DEZKBYhonKvzmrllN6MUMwg8OggBVn+ro5RtHN4u5QD/cgh7OqH0zNZNZ7hn+7ivnQkHuM2
	T1qsARpfKO6ME/CNOh+pIJ+fwyK4TzjKFIlYwVtXEIDkQKBTzM2G/8C3JXZbwfbW1T8WhW7e9L/
	te/AjWZ7lvYAylKrGm+SAOYG+o60wOg8ETV86byA10x4zcpLxR5u
X-Received: by 2002:a05:600c:8b46:b0:4bb:7bee:5496 with SMTP id 5b1f17b1804b1-4bb7da12a56mr54407185e9.13.1795011302049;
        Wed, 18 Nov 2026 06:15:02 -0800 (PST)
Received: from localhost.localdomain ([197.119.251.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e588884sm20894275e9.2.2026.11.18.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:15:01 -0800 (PST)
From: AuthenticSm1les <khidarlaminehamdi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: AuthenticSm1les <khidarlaminehamdi@gmail.com>
Subject: [PATCH BlueZ 2/2] audio: Mark LE Audio client profiles paired_only
Date: Wed, 18 Nov 2026 17:14:38 +0300
Message-ID: <20261118141438.308232-3-khidarlaminehamdi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118141438.308232-1-khidarlaminehamdi@gmail.com>
References: <20261118141438.308232-1-khidarlaminehamdi@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All characteristics of these services require encryption, so the
profiles can't do anything useful on an unpaired device:

  bap   PACS v1.0.2 Table 3.1, ASCS v1.0.1 Table 4.1
  bass  BASS v1.0.1 Table 3.1
  ccp   TBS v1.0 Table 3.1
  csip  CSIS v1.1 Table 5.1
  mcp   MCS v1.0.1 Table 3.1
  micp  MICS v1.0 Table 3.1, AICS v1.0.1 Table 3.1
  vcp   VCS v1.0.1 Table 3.1, VOCS v1.0.1 Table 3.1

Reading them anyway is what triggers the pairing request, e.g. mcp
reading Media Player Name from a phone that only connected to check a
GATT advertisement.

tmap and gmap are left alone since TMAP/GMAP v1.0.1 section 4.8 wants
their characteristics readable without encryption.

Note that Device1.Connect() on an unpaired LE Audio device no longer
pairs it as a side effect, it has to be paired first.
---
 profiles/audio/bap.c  | 1 +
 profiles/audio/bass.c | 1 +
 profiles/audio/ccp.c  | 1 +
 profiles/audio/csip.c | 1 +
 profiles/audio/mcp.c  | 2 ++
 profiles/audio/micp.c | 1 +
 profiles/audio/vcp.c  | 1 +
 7 files changed, 8 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..c383101ba 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4350,6 +4350,7 @@ static void bap_adapter_remove(struct btd_profile *p,
 
 static struct btd_profile bap_profile = {
 	.name		= "bap",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= PACS_UUID_STR,
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index fd05195f3..3d36d1a2a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -2542,6 +2542,7 @@ static void bass_server_remove(struct btd_profile *p,
 
 static struct btd_profile bass_service = {
 	.name		= "bass",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= BASS_UUID_STR,
diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
index fb85045bb..bdd685262 100644
--- a/profiles/audio/ccp.c
+++ b/profiles/audio/ccp.c
@@ -207,6 +207,7 @@ ccp_server_remove(struct btd_profile *p,
 
 static struct btd_profile ccp_profile = {
 	.name		= "ccp",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= GTBS_UUID_STR,
diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
index bbd9e4ffd..3c67bda59 100644
--- a/profiles/audio/csip.c
+++ b/profiles/audio/csip.c
@@ -302,6 +302,7 @@ static void csip_remove(struct btd_service *service)
 
 static struct btd_profile csip_profile = {
 	.name		= "csip",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= CSIS_UUID_STR,
diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 7522ca4e6..362d258d5 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -1109,6 +1109,7 @@ static void gmcs_remove(struct btd_profile *p, struct btd_adapter *adapter)
 
 static struct btd_profile mcp_gmcs_profile = {
 	.name			= "mcp-gmcs",
+	.paired_only		= true,
 	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer			= BTD_PROFILE_BEARER_LE,
 	.remote_uuid		= GMCS_UUID_STR,
@@ -1126,6 +1127,7 @@ static struct btd_profile mcp_gmcs_profile = {
 
 static struct btd_profile mcp_mcs_profile = {
 	.name			= "mcp-mcs",
+	.paired_only		= true,
 	.priority		= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer			= BTD_PROFILE_BEARER_LE,
 	.remote_uuid		= MCS_UUID_STR,
diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
index 3d39ef5e1..e65bf8461 100644
--- a/profiles/audio/micp.c
+++ b/profiles/audio/micp.c
@@ -299,6 +299,7 @@ static void micp_server_remove(struct btd_profile *p,
 
 static struct btd_profile micp_profile = {
 	.name		= "micp",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= MICS_UUID_STR,
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 00ee2b64b..07ef9fbcb 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -331,6 +331,7 @@ static void vcp_server_remove(struct btd_profile *p,
 
 static struct btd_profile vcp_profile = {
 	.name		= "vcp",
+	.paired_only	= true,
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
 	.bearer		= BTD_PROFILE_BEARER_LE,
 	.remote_uuid	= VCS_UUID_STR,
-- 
2.56.1

