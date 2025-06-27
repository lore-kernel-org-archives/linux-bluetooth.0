Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20082E92C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=pQJpUrippcH13UZwbB+prEbsNv11WM0fwdRPxxU1w6joUxfhojEAu9UYRzz/tlTqEAnt7BSEVcN6iSzwjpo2YZhRjaIufk68Hoo5MgkM12mhWBW3dnfRdn3E9u9KoWHTo5LuHzGqN4Wp1brc1lQjFEGw910DjnxU8XQfINQnm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=oZIg/WlOn1diET25FtE3H9kV8qP+datbboAmq2m2hKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5HVoFbQMRQFnNK1IEoMkXe38W/6WDqdv+COueNxlXSvALIgPBjVj6gYmxw530OuRjh8OgsoxQtZUsIfOCxNxy3EFzy/TCyAnhasQZg1fhCmznWxwNtr8WSZ+48bWcSphF997Fz8a0zxR4a9+j8ZGUjEhsBwf9eTSpl7YrB4b4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=npE2ew4I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="npE2ew4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035907;
	bh=oZIg/WlOn1diET25FtE3H9kV8qP+datbboAmq2m2hKE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=npE2ew4IKQ+7j/QlOYOBZtpWd9q855BcuKur+BrklT7PDJjvITVADnMZuTY78D1OY
	 dAKQsICPHgok9BO7U4GVBKkrmC4H38ABxEuFEjJS2nrfEm2w7vHu2/2AmzgdncXRIX
	 O6xGfC90pxhJ+wclvLtb9FnxB8X5GHePeDDrabpil7czCwObN6A3UT7SBj9Ll5/Nct
	 wd5kIQMg/wRnKcHREL1ZtVgE9Q4Z8/hquaQea0nt9JN7/02T9sUa7xbbJf71KEJimA
	 QHBifbR/w70QrJjBfu/t8jGmJTirRb048RtfjiZ5i8GT9qPEts5bdR7/8FihP65Nn5
	 mI7iG/Xi2tARQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0691A17E0B83
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 17/27] client/telephony: Remove IncomingLine
Date: Fri, 27 Jun 2025 16:51:26 +0200
Message-ID: <20250627145136.421853-18-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This property has been removed from the documentation.
---
 client/telephony.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/client/telephony.c b/client/telephony.c
index 5af88c008..4678ffac9 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -443,7 +443,6 @@ static void cmd_show_call(int argc, char *argv[])
 	bt_shell_printf("Call %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "LineIdentification");
-	print_property(proxy, "IncomingLine");
 	print_property(proxy, "Name");
 	print_property(proxy, "Multiparty");
 	print_property(proxy, "State");
-- 
2.43.0

