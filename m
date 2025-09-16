Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AF28468B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063631; cv=none; b=F85GCGfGvvEpUYQ63obcfUeJQB8vbwFsEVEWrHr3bv2q8ly+QTV6nqsJBpaP+HQC6EI5ZpXO0m2xAt9X9bX1c+fGd6mT4+Quy6mNhgFiyPBN09laTZ1JvM/H1X/gZ1MjaB9bqVttcmAe4vfGdu5NZtPDvYPIAZXR6X04U/NzQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063631; c=relaxed/simple;
	bh=sj96tjA7/2Y2BQNFdo/bJJcngxOnHvrMIqtNOzR+zok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1ve5DfUvGIAZMfNvLmjtLdGtjpLKWS9Y+3NRmAMOfE1bi15W67saVC4IYMPz1rxXA+ouW934bQUuKM5EkwdPUOv54htPyMGJOgx+/3vZScxnMxsXWBXmf6uQmTyU3vM0+fkEzYnn9uQsVd2P/unT2Y4CBtjyV0QX9voVv0xoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04B3D43387;
	Tue, 16 Sep 2025 23:00:25 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@accosted.net>
Subject: [PATCH BlueZ] transport: Fix build with VCP support disabled
Date: Wed, 17 Sep 2025 01:00:14 +0200
Message-ID: <20250916230017.2216629-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghruhhnsegrtggtohhsthgvugdrnhgvth
X-GND-Sasl: hadess@hadess.net

$ $ ./bootstrap-configure --enable-a2dp --enable-avrcp --enable-experimental --enable-asha --disable-vcp && make
[...]
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_set_volume':
profiles/audio/transport.c:2275:(.text.transport_bap_set_volume+0x11): undefined reference to `bt_audio_vcp_set_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_get_volume':
profiles/audio/transport.c:2266:(.text.transport_bap_get_volume+0x9): undefined reference to `bt_audio_vcp_get_volume'

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: af8266af13c8 ("audio: connect VCP profile client to MediaTransport")
---
 configure.ac               | 3 +++
 profiles/audio/transport.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/configure.ac b/configure.ac
index 955908621b6d..9f1a96600a7a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -215,6 +215,9 @@ AM_CONDITIONAL(CCP, test "${enable_ccp}" != "no")
 AC_ARG_ENABLE(vcp, AS_HELP_STRING([--disable-vcp],
 		[disable VCP profile]), [enable_vcp=${enableval}])
 AM_CONDITIONAL(VCP, test "${enable_vcp}" != "no")
+if test "${enable_vcp}" != "no"; then
+	AC_DEFINE(HAVE_VCP, 1, [Define to 1 if you have VCP support.])
+fi
 
 AC_ARG_ENABLE(micp, AS_HELP_STRING([--disable-micp],
 		[disable MICP profile]), [enable_micp=${enableval}])
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 2fceb5121a34..bc550b743981 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2263,16 +2263,24 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 static int transport_bap_get_volume(struct media_transport *transport)
 {
+#ifdef HAVE_VCP
 	return bt_audio_vcp_get_volume(transport->device);
+#else
+	return -ENODEV;
+#endif /* HAVE_VCP */
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
 								int volume)
 {
+#ifdef HAVE_VCP
 	if (volume < 0 || volume > 255)
 		return -EINVAL;
 
 	return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -EIO;
+#else
+	return -ENODEV;
+#endif /* HAVE_VCP */
 }
 
 static void transport_bap_destroy(void *data)
-- 
2.51.0

