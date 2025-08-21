Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7D2C859
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781145; cv=none; b=juoI4CfFSXbTy6947NR4oNXGaqzLKcaDvxK/RYlrxk41xcNLovW2t08z7xGAJJjJKxQp1S8oYlX6jsahRpCl4UXCTjhdvTTaREF01y9I7PmdV5r3tgUenqQtZM5lA9ag56z29gcvHVJwgXfPp8saGG5ud46pUEepH+6hHdDG/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781145; c=relaxed/simple;
	bh=juQBixTOgXI65hlq3vIVFDz89GFrzUEHOpRc7JAJaSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTNU8ylx0cnLFjJh/sTZA9tG+3uoCDh8/ukwZ3G4dN40bUOc+2hkPSl0sIRKUvpCHpO6CXZhR4SG7J2GX+pe3AtOV/3y9l1bq1ovorEjn9F6lkqppHyDCiWidG7MxX99QLxFMu2zEwdJPYdyLb+mlHgi0PLCiqhuwZGwe4O/s2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FEEA44310;
	Thu, 21 Aug 2025 12:58:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 2/2] sixaxis: Initiate pairing for all cable pairing devices
Date: Thu, 21 Aug 2025 14:57:22 +0200
Message-ID: <20250821125844.963198-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821125844.963198-1-hadess@hadess.net>
References: <20250821125844.963198-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveethfelveejffetkeelheehueejlefhvdehteehgfeghfekgfdvfefhgeekieetnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshguohhrvghgohhrsehsughorhgvrdhmvg
X-GND-Sasl: hadess@hadess.net

Fix the cable pairing not being triggered on DualShock 4 controllers.

Note that this still requires an authorisation when connecting through
Bluetooth the first time as we're not exchanging linkkeys. Sixaxis/PS3
controllers aren't paired, so don't have that problem.
---
 plugins/sixaxis.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 22dc634da0f8..27bc09815b31 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -300,11 +300,11 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	if (closure->type == CABLE_PAIRING_SIXAXIS) {
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
+	}
 
-		device_set_cable_pairing(closure->device, true);
+	device_set_cable_pairing(closure->device, true);
 
-		server_set_cable_pairing(adapter_bdaddr, true);
-	}
+	server_set_cable_pairing(adapter_bdaddr, true);
 
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&central_bdaddr, central_addr);
-- 
2.50.1

