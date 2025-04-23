Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B2481CD
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419262; cv=none; b=TUVix/tfE8UW1lZ4STxt+qTgqDiiRyKHbIeB9TfyUAsRDmC+JzrNIM5o4QUnpVCpk7SpJhdpDRs9j6T+1huh+vGQR1xUbhT5mCBm1ZI6xTdblBr9u6EXF6NfIm/mlvY3cDNW9Xyrf99c7Ey7DeL9V3dlmzXeT/J5XKEGPKtMBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419262; c=relaxed/simple;
	bh=rEkISNblRcWOJgNCgm1vnNuXQKQ0gFUjSn8dHoaP1MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUHMSld4Qgc8JrGUv7zra/O0osKUKsK6mo/f9cNPUtiSpyy6yVdzaHWmM65unTTrbaI/J8qq7muHdiNHvVUICuuVwVEfe7lhbXg9HSMTGwrtk+8tbwWKwu3gc/qmO/S9HFf/M8tmFMYAlF/8Zw8fdIyp+WT0gFI+iyoom7Dz9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YtZveEQJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YtZveEQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419259;
	bh=rEkISNblRcWOJgNCgm1vnNuXQKQ0gFUjSn8dHoaP1MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtZveEQJu42JZp4D3O/OZGLUVYzOJbvAigplqtwSwJ4pnfLCUvUoSaY131c6QXEwB
	 7FwvsN4RtwuO9xw9oyGgUMxlbIINB6r9dYhAbaxnWpBkgEQjTIiz3rBdH8b2SB830k
	 Ylt1jMotyKFn42pMxFyUnLVsu2pNKslXm180R9psWvlHT8DfHeLTvFkmJY9X+DqbUT
	 oebTEd1igsGZkFVDWTLl5VvlrgEcMTvGrOXD4RLktNmOMOy/XwICridmJ5KXDet863
	 18Kh+BxMS3Ccq9Wj+eRp7JmfWM8fap7oKP68zpusuLYfxat6jN06iyj3wYp7nKxw4t
	 XcFksd//X8S3w==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD09417E3610;
	Wed, 23 Apr 2025 16:40:58 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 2/8] client: Print SixaxisCablePairing value if BlueZ was compiled with sixaxis
Date: Wed, 23 Apr 2025 16:40:14 +0200
Message-ID: <20250423144020.358828-3-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423144020.358828-1-ludovico.denittis@collabora.com>
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
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

