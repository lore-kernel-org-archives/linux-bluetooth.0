Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551B7DA66
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637172; cv=none; b=joAoQdJh5SEBsFD3wf0H+3Q1VvTiIQWqqhovtC2BZub2U/qtwks9wTcLq0Sq/mdd/GQYx2Y92SPDRQ9AkSWzTZrrCY2M47+5nQXwIZ1fLoUhX+MFC3glceZx//eGuuf56m/LhiWxGXlV2w0U1saAHqUNjrmkQdGpYAVP5N8SKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637172; c=relaxed/simple;
	bh=efDa0WnX2uvaHnXaFbWUj9P3wFRzmzslAOIS4EOaJ+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mt0OEABpSdihqGIiiTHbce/92PStEQgUnBDrli8mqQqWubc3WQhVL5wOeeAq7xTQl5yExKQO3tLYnvlDsPb8Nrgeze2czogUeFDP8oiaWKTWM6mmH+CISKvkvlz5n/DWkNi51irvmomR37O+iSBM8fPAiW10dUK+sJbszwhQbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AF0E43ADC;
	Fri, 12 Sep 2025 00:32:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@accosted.net>
Subject: [PATCH BlueZ] transport: Fix build with A2DP support disabled
Date: Fri, 12 Sep 2025 02:32:19 +0200
Message-ID: <20250912003233.931520-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeelheefueejfeeiledvgeekteeggfevkeeigefffffhvefftdevieekuddvuddtleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhunhesrggttghoshhtvggurdhnvght
X-GND-Sasl: hadess@hadess.net

$ ./bootstrap-configure --disable-a2dp && make
[...]
profiles/audio/transport.c: In function ‘media_transport_update_delay’:
profiles/audio/transport.c:2653:33: error: implicit declaration of function ‘a2dp_avdtp_get’ [-Wimplicit-function-declaration]
 2653 |                 a2dp->session = a2dp_avdtp_get(transport->device);
      |                                 ^~~~~~~~~~~~~~
profiles/audio/transport.c:2653:31: error: assignment to ‘struct avdtp *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
 2653 |                 a2dp->session = a2dp_avdtp_get(transport->device);
      |                               ^

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: 0bb66d3d1abd ("transport: fix A2DP Delay values missing from DBus")
---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index ab149bcd728b..2fceb5121a34 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2643,6 +2643,7 @@ void *media_transport_get_stream(struct media_transport *transport)
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay)
 {
+#ifdef HAVE_A2DP
 	struct a2dp_transport *a2dp = transport->data;
 
 	/* Check if delay really changed */
@@ -2657,6 +2658,7 @@ void media_transport_update_delay(struct media_transport *transport,
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					transport->path,
 					MEDIA_TRANSPORT_INTERFACE, "Delay");
+#endif /* HAVE_A2DP */
 }
 
 struct btd_device *media_transport_get_dev(struct media_transport *transport)
-- 
2.51.0

