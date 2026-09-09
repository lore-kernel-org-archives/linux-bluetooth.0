Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F64EBAF6
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981810; cv=none; b=hYfZugqxiEpu4q95fZH57HOHOVqFpDLTATgzlbcjEdXuVThExYYJYGOcl3dPcj7gMzTd8/HeC1Fdh3MWYY3oQw+abx5SY/TZ1OpmaiLcPlDzr2mtnz9El2AjCIGcI8IkW0h927zwC/90Pf/SayxdlGXikYGNl/fIQWeA/GsSCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981810; c=relaxed/simple;
	bh=3fjDFDoLJ1LOe1PzWKjz+mzKIVniJ5UssNXzMLhj2y4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUtxATl18E3PpfsyhGXNLbWCD8jPchWcUHO4996pDWmE59nPERIEU+3qDKn6YM9XMqzry8V7F3mstsbpJPiR/lGigx8jo5eZ2psqZJ6yhde/fLr0I4P2xfAjzL4TdrgTufgFBsvWIaWFkzaHgCJPhTA3sBUSMJme7v2vgVTq1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7UvzACP; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7UvzACP"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-78fe51a2dbeso716945137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981806; x=1789586606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nirYpbVIMypASRXSLTU9WwN++i4RfUWyLKUlwkoWZaE=;
        b=k7UvzACPaAxBsUN5muB7mP5zeC9mbK4N7B5USAojp09HQMN6IsUWHKqHr0Vkooa+wN
         n0+uAVxGg4O+wiCZ3XaptyZ/dbCZ8fXvJJFdHu+2/7e7m4c4hQXh5cLWiSyjW9JYk8sw
         1iAd54hPj+gPLECRAm25soqFqznSLv8CUDWDjwSG7OOPlP5/e8C09tJi+afYTKZJJD6/
         HtATMretccOtWYa/bH5Uywd/f18abQv+cBYG2feI4jNrvFFKmTFfj8nyj57PFM4dFOWz
         2dInfP1pFvn3Bm/cHUQztrsAys4ldp+uD7rXqxTYVRrNMBmxo7GUFx/eLdirwNw4yFtY
         K/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981806; x=1789586606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nirYpbVIMypASRXSLTU9WwN++i4RfUWyLKUlwkoWZaE=;
        b=eZEAQA5Vhbroq/ifkePaWNS0GogbGcGrTyrM5/a1AkP0HDv3wFsJ0LMK0cP3ZjrGr3
         Pfn9UK4s+hvwA5hfnMHMcA30rmnnrP8QDW4eyVAfGzQiwBQcvCxnRejPwb+zHiIz27+j
         xnQ4tHU48OrxWoJ/RD65Xbm8F5/4nmQDD7n7XSJQVC3Zu0GV+DB7SyKScUXVsZOGP9F8
         si6GEKIS8ylqnWPcu82HrpOtmbEKP1xbJCRcq+12/KA8wCvgxBDYV1FZVl/ZKXaK5fr1
         NcPTT/WVEryAUueRJdF3S8wWAf2jrFayufOxbMiXrOnzU5CXVTHQHT4Gu/oSQ9neuj6s
         EgCQ==
X-Gm-Message-State: AFuF++n36+CuLCf45DHzCQcm7sLgb5B/MIY7Ue24y7B+eCBQeuH8GZul
	+kHZR6SeoY62K5tO4+XI1c1bsJxnCQG2s6ebUAI9BCV4+O2qw09DVk6Lkp4U8flH
X-Gm-Gg: AYBFou3IsT6U+Q4JG4hNHNMUBZtxvUC37s4WRx+PG8DMw9f/ahXY2iCYaxMo5BjOCRG
	qi/Xut+h6LBDRP+2aoW5HP9mXeiBeeyceqOr6TgpYr2aBH6hZmZ8MIYzEU0sw6YBqGcL0Z7LBmz
	+JdYga3TIy7ylgpIZamvGTuO/OltJ2AoK+RKpaaV8Wb/VBbI8ZUWMUSxlXro1s85MWzEnGIVQdz
	RIciilKhSr22OOZcKgt0CVZqs0Fy3gyo/CjtJ5XOyfZcGbsmFqqZ9hNE/jqY2hIeFAcIBV0bpB/
	dkrtdcuYi6B4gcIHAmy84ApZYz7pyAQzP6DWXthTkA+tInQAxFxqZNbh6BpUZdK0vwMHk0/6/K4
	USViTqCEIjoC4C5xt0sNfMcCltb6xYfNKlZoLK6XDOM1drPFJ289WhEuoKLfa+sIkCvtpyo1uhv
	CQZ6k/4TVIJUNop9BBdO1Ft3ceLG9/Ibr/k/g8Wjas+3RFCNkZMasT4D1C8J++jl9/vLjTcOJAq
	I1tMKOuDzHYl8gNV+/YeL9yzpBijZ44i9ADYzMjfuu9g6tfdlUrupGAo50wwANKxHk=
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr22419865137.2.1788981800997;
        Wed, 09 Sep 2026 12:23:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/12] client: do not prompt for LE Audio settings on A2DP endpoints
Date: Wed,  9 Sep 2026 15:22:59 -0400
Message-ID: <20260909192308.1306567-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Registering an A2DP endpoint prompted for Locations, Supported
Context, Context, CIG and CIS, which are LE Audio/ISO specific and
have no meaning for A2DP. Worse, answering Locations with a single
location pushes an LC3_CHAN_COUNT LTV into the capabilities, which
corrupts the SBC capabilities.

Register A2DP endpoints right after Max Transports instead, and use
the same helper in endpoint_init_defaults(), which compared against
A2DP_SOURCE_UUID twice and therefore left A2DP Sink endpoints with
ISO and broadcast defaults.

Assisted-by: opencode:claude-opus-5
---
 client/player.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index c5e4beef0ed3..6cd5aeb4a175 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3506,6 +3506,12 @@ static void endpoint_locations(const char *input, void *user_data)
 				endpoint_supported_context, ep);
 }
 
+static bool endpoint_is_a2dp(struct endpoint *ep)
+{
+	return !strcasecmp(ep->uuid, A2DP_SOURCE_UUID) ||
+			!strcasecmp(ep->uuid, A2DP_SINK_UUID);
+}
+
 static void endpoint_max_transports(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -3525,6 +3531,12 @@ static void endpoint_max_transports(const char *input, void *user_data)
 		ep->max_transports = value;
 	}
 
+	/* Locations, contexts and ISO settings only apply to LE Audio */
+	if (endpoint_is_a2dp(ep)) {
+		endpoint_register(ep);
+		return;
+	}
+
 	bt_shell_prompt_input(ep->path, "Locations:", endpoint_locations, ep);
 }
 
@@ -4629,8 +4641,7 @@ static void endpoint_init_defaults(struct endpoint *ep)
 	ep->max_transports = UINT8_MAX;
 	ep->auto_accept = true;
 
-	if (!strcmp(ep->uuid, A2DP_SOURCE_UUID) ||
-			!strcmp(ep->uuid, A2DP_SOURCE_UUID))
+	if (endpoint_is_a2dp(ep))
 		return;
 
 	ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
-- 
2.55.0

