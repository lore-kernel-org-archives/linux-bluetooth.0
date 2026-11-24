Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512524;
	b=mbfQ8C77zJeruDzUtnh7m0PUL+J8tUkHWLL9pcjZ+H6pQZPibPHVOYKMlcH3GAii3u+o
	 UFLWNg94/1etS08xI2LBFyZjvZAPwcf+h0NaXqzTo0kWUr9QaSmWu6dZMXPUPicspw35Q
	 zTf4gZ7BoBs2iREf0p01eOAOk59l6Ks+FbuEScY8+r22cfjOfgz3ccs7uIHMJgApZ95+e
	 HvBpDo+aI9XuDhVb1ts+MTapDUh70O5fM5xcEKQ4df6vdDldTbaWiTV/kFnMtVvLvCQ/C
	 eH31SSFzUJUzZLVxiBXTeAnSRSlXFFuORurlilItQK8TnNairAsyToqWIGG9Y3bbrqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
	b=5uCEK4AddNlUx6hYjRXaJMiKGUM/JqWtSDnFJU0zXLleeAqws/soHhgevURZEk3QLCre
	 kErmgSWgIRNK9AHmQdJcv6I86SNpE9pMV37bDMJ6RbqKcAXeKYOzCXVG8Njiz1RvjomPu
	 Hg2TNq/MOzL63Nhst2XI5xT46pLbQcwpXMFG6qjDeYyLu7qo9G88cJY5I7fWKFnqme8Hc
	 1S2pssyrZ5nY7LstTnXJkOIB6QHAdM5viH4Zqo0GKEQT41Jqgsg3j6wad6NugEee2mHst
	 sx9OB15//adhyBqhzLcAodFv4NvPuR2KndxK6YWY3ydCxRAKuhwpLMX8ORFfoZWcTtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=fgi0YGjs;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DB606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90DB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=fgi0YGjs
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1955651f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512522; x=1796117322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=fgi0YGjsF6IhyxgazyftXHO140KKB3RKOXhW4o5RF6Oy6pZqnLmQiMMXTRzY9VmTrU
         6AgNyKscIATgIsq63RDuhYvYcLFQSv+tgjxm0Xj7IkiR2TrV+In1Ck5HY1FwcNTSp5kP
         d0y8weaO4Gt+4s10XO0IpVhvniBYKuqkpGBPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512522; x=1796117322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ok36cVkgdN5+9HDWeupMbyoD3lHZfqjSHBscaD2voJY=;
        b=LuXlQm0mJNNqHHq6pZ6pbVk+LWuEXpIzM1dcmkGPhDd6yrOhwDfB2VMiteX//rOrpv
         w+ONyuZBed5wBv+5+z/baXZ4jSBTTDk9tnWtoWZ2zAHW7TgI+wS85a3CG+SfErpIdH0d
         whJ5ejQ6jsjSbVLioQsgekqKOa9KLxbI5hfL6aWI4nurCweeNXk1bvtVvYHVaiTFVmKM
         c59XAucIDS8YgeVcbDtIFOqIzP61I7+Y+hUllJnF343Z8z8thZGN1hxDQrlWpjfcBFKl
         JdzFE7f67KQ0hgv8I/7VAb2fFzajJq/h57rjCXiEM6+4bb/MuKaec6gwPOgZ9emmxkC4
         FaBA==
X-Gm-Message-State: APuU4Z+KuKjAWIGuf359fFazUaCxKuV+WJffcCHzZhZXDI+6Gk0VBfnS
	YdvDh44++n/JNXNSNOAZ1kphNl/vDS73/zaNbHRSMGkCFFaHnrOiB3MzP3SOJ7494pFUnb46gSF
	/nWJO
X-Gm-Gg: AZFdTZeoErKvb+DEsEEoYLwtMU8NqrNwpkoYN9Kjrc7X6atJRpEJJ+2aDBTZilr6btu
	MIk04g020hZ5QNBUXBiw1L/bM5BKThIT6Foy6L2vQzRJ38VQnMoyae52pA62ygdF28acRWhxKEq
	1bDYLlbM+3Uhjn3d3z2DMqyaM1TnXgmZzrAulhrwYYqVm/hpZj+tOKz6F5iBF1+kvbR7Dnvb1ch
	nAqZ9QWKVrgE0ARfqSU0Sz40fb0zgntt+5BmAwWX7vI/OXNyFrXDR15HsRSqOBHSIK0vZrShxcU
	xkxziBAZGrFQ1hj9zBgYDjFNQqG5Mh+2y03AoFW8G+GWIHywrDtjuhnQOX3/F9cQl8sUNpaTxb+
	QM1ik8YfyAcVM2Val1XsUHDwCj0ThT1JEdcQC8TVNWVkzlbyJ5Aca5xTgn5MRhWwr34XUswSpuv
	S0UG0XEg0p1EG7a4NFLVlqNlFPq0UgjFOier++0dzh5p5CPxFCdka9/mZzHnK0cUZ2+tnl8FsmD
	MdPEuplc/xAvN1sIA5nSQ2IKf6SIWQ2t2UhWkIMfbXr+V+KG+a72gRS+lodggTiOo1aqVRhtCVv
	XFTjTy2znUP3DOHr6nz6Fy6WFoBynpXQZgkfTAYdOe60kwegVg==
X-Received: by 2002:a5d:64ef:0:b0:4b3:e605:15d6 with SMTP id ffacd0b85a97d-4b3e60516a7mr9718926f8f.55.1795512522349;
        Tue, 24 Nov 2026 01:28:42 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:42 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 03/10] avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
Date: Tue, 24 Nov 2026 10:28:26 +0100
Message-ID: <20261124092833.1191053-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
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

The Player Id and UID Counter of the CHANGED response were copied in
host byte order, so on a little endian host player 1 is announced as
player 256. The interim response already sends them in big endian.

To reproduce, register for EVENT_ADDRESSED_PLAYER_CHANGED and send
SetAddressedPlayer for player 1:

  AV/C: Interim  AVRCP: RegisterNotification  EventID: 0x0b
      (EVENT_ADDRESSED_PLAYER_CHANGED)
  btmon:         PlayerID: 0x0001 (1)
  btmon: AV/C: Control  AVRCP: SetAddressedPlayer pt Single len 0x0002
  btmon:         PlayerID: 0x0001 (1)
  btmon: AV/C: Changed  AVRCP: RegisterNotification pt Single len 0x0005
  btmon:         EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
  btmon:         PlayerID: 0x0100 (256)

Fixes: 4827d6b61fd4 ("audio/avrcp: Add Set Addressed Player support")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3ab7b6d7c..aff1c381a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -803,8 +803,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		size = 5;
-		memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
-		memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
+		put_be16(player->id, &pdu->params[1]);
+		put_be16(player->uid_counter, &pdu->params[3]);
 		break;
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		size = 1;
-- 
2.43.0

