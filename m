Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9A3033C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615769; cv=none; b=ruz7d0w1JLAxbP8PH2CC+V+IcRRlD7E+S66m08vKRsGq0If4abUZfSFTDJBpXFJaLccWaOrjgeN2bRw3vkQwR8+m3H7/XO5muTylucSAIqhw8SWcgGrOgoH4BZAeOsF2W83HYdvgfWgJaH/h/yHV25mVaejwo+HPYuh3N0jCe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615769; c=relaxed/simple;
	bh=UXSoU449GkV844n2NXv9A5wGNFzr9iybE4niuM+7P6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3klMZBJMbUsFsDUHs9NO3Es0oyjXc9t+9KdSLfkn64v0ykZiiqkSCuIsxKN2bqufIuUgs07ehw9AdR2ihx252vLsxd4uj9ggu9EAPuJ74CHwjHCbzvXQMdtS0N2BHxN3AGWlnriJ1IIMH+XxAn4bUkhdbmGvgzMvRBAiCV3XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D996D43FFC
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:55:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 08/20] tools: Install gatttool if deprecated tools are enabled
Date: Wed, 28 Jan 2026 16:11:46 +0100
Message-ID: <20260128155548.2025252-9-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128155548.2025252-1-hadess@hadess.net>
References: <20260128155548.2025252-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeiudejjedujeegheegleefjeehgfevteefffeitdefjeehuefhgfejueejtdekueenucffohhmrghinheprhgvughhrghtrdgtohhmpdguvggsihgrnhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffleelieffgeefhffhvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
---
 tools/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/meson.build b/tools/meson.build
index 1c24f0fecc02..5e6911c94922 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -220,6 +220,7 @@ if get_option('tools').enabled()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+      install: true
     )
     executable('hciattach',
       sources: [
-- 
2.52.0

