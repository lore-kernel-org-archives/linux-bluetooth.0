Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5E31AF21
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781145; cv=none; b=ddCOMlqbmj0uNa6h6NOZX2suTzeGyKShdvOoS+6tIBVBDXCwnOxFyifx81pU4aahm+qu/ldEhUGAqkYiMFOFzI+7RRd7uUigThEI/9QaDjjzoXxK3quAjRr8uX9r3gbJw+RQq5cc+VliHO534V9wLf+O5pv2G4BYzFfLm+yIgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781145; c=relaxed/simple;
	bh=pLGoGZp8txV37djys/ReFdND6Mv/XsVOusm0QjJzzgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejurWBC1UTl1a8YX3ql7X3+DcvyRZBURRXU8swCBLPMCavEBKzOm4RapSTTbXXo8ZtlZYgTED64kGMBef7KuQXd5EABaS97o140TDfgzyRKlnazEstOXVINGO5AlnRXMVNxbyfG3LHLiONOQlYYLTHu3MI2YKB08eY4mGYpZXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E23B44319;
	Thu, 21 Aug 2025 12:58:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 1/2] sixaxis: Fix official DualShock 4 controllers not being handled
Date: Thu, 21 Aug 2025 14:57:21 +0200
Message-ID: <20250821125844.963198-2-hadess@hadess.net>
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

The devices changed names, and those do not match the expected name in
our list. Ignore the "Vendor" portion of the device name before matching
it.

This is most likely the result of official DS4 controllers now being
handled by the hid-playstation driver rather than the
community-supported hid-sony.

This fixes DS4 controllers not initiating cable pairing when turned on.
---
 profiles/input/sixaxis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index ab8831995e55..44e43b483bf6 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -81,7 +81,7 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
 		if (devices[i].pid != pid)
 			continue;
 
-		if (name && strcmp(name, devices[i].name))
+		if (name && !g_str_has_suffix(name, devices[i].name))
 			continue;
 
 		return &devices[i];
-- 
2.50.1

