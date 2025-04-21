Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735D263899
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234027; cv=none; b=lRKjU7WaMkhbSxEvSYqldr6kqnAuEfTheJXkSBWG9PnK3AlqmefACkNl/nlz3A4QqXAiIw2+IEKpF+veTVQzQfo9i9gYHBEcH0lalnWg1AxTn/pw7h2ZcfFKuh82QtK4K2YN3a7QV6tt8E7LYVp1PIVvhZvw46Hf2zI9yMv0ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234027; c=relaxed/simple;
	bh=rEkISNblRcWOJgNCgm1vnNuXQKQ0gFUjSn8dHoaP1MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0Hwx5+K0WEd58hx0ztayzN8YWxvdgCRGXBtav9m76JGFNNTFfezAWhHtN+kSq71HQg7+SsvRBjdmwF2B80/9UdhncEbXs1egQJfSfSVQMMRXBoh9oT+yOonHhUqoGgUFmJIHRgKoqokJI7mtbxkXO5mdt5ld1JMTZtf6nh0QYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y2kaZ9hZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y2kaZ9hZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234023;
	bh=rEkISNblRcWOJgNCgm1vnNuXQKQ0gFUjSn8dHoaP1MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2kaZ9hZ3lPXBc8wU0q5rbGqftlmhI+/xNgao7WQj9XqIxeEIZK9gWykS0hldBnj5
	 u0GXBh+uDwkGqwoeW1qXIAI4YhXdI1XTqqQPBkDwe2+6ItUyFobMVRunBehtgZ24LT
	 mTuzkkpACQv/KOg0mny9U4hcuoUTTMCVLOLXN9OMY/VEPYk01VdyBultnj5yPvBlYY
	 iOZLUINwWVk0veaQQmXPL+UDGwhPGRBVDn800dOUeyNPjOhkEpbkoePiIB1zL6YUz0
	 cyhd9S7rx27MvZg0u4mA6GzkgURxYkUhsRtTD1E51787BOa2vef08yJ3Y4qP03Szsp
	 0z84D0D7iJpNQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE68217E0649;
	Mon, 21 Apr 2025 13:13:42 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 2/5] client: Print SixaxisCablePairing value if BlueZ was compiled with sixaxis
Date: Mon, 21 Apr 2025 13:12:48 +0200
Message-ID: <20250421111251.108943-3-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421111251.108943-1-ludovico.denittis@collabora.com>
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If BlueZ was compiled with sixaxis support enabled, print in output the
property value of SixaxisCablePairing when using `bluetoothctl info`.
---
 client/main.c | 3 +++
 configure.ac  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/client/main.c b/client/main.c
index 6039aa50c..bda8983e4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1705,6 +1705,9 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Connected");
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
+#ifdef HAVE_SIXAXIS
+	print_property(proxy, "SixaxisCablePairing");
+#endif
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
diff --git a/configure.ac b/configure.ac
index 1e089aaa7..ec509c97e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -420,6 +420,9 @@ AC_ARG_ENABLE(sixaxis, AS_HELP_STRING([--enable-sixaxis],
 		[enable sixaxis plugin]), [enable_sixaxis=${enableval}])
 AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
 					 test "${enable_udev}" != "no")
+if (test "${enable_sixaxis}" = "yes" && test "${enable_udev}" != "no"); then
+	AC_DEFINE(HAVE_SIXAXIS, 1, [Define to 1 if sixaxis plugin is enabled])
+fi
 
 AC_ARG_ENABLE(hid2hci, AS_HELP_STRING([--enable-hid2hci],
 		[enable hid2hci tool]), [enable_hid2hci=${enableval}])
-- 
2.49.0

