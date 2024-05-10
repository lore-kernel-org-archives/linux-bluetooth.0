Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFA16F829
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343257; cv=none; b=AugFvVFW5QhU8wKTBneX2en5uRX3lJT59W/OSnfyKxquDfMX1fQTfvFGcKwTR79kNRWVReP6gPVAbvtO8sXTyPqxXCuDJE6rRoP98U80NtVXhstdwUnQTDlx44rtltZkZ5kMArbFNsoH5N92bttj673bwWvT0RY0FzPjcMkVk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343257; c=relaxed/simple;
	bh=XL/7SxkDVsEMuouDDcQaTT4AwMz/tx8Nfzhai1nup08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvQMiCWRWNgoqTEfue5yu/G9k+Im4WOXSHjlqLxgNuYoKRT0ZCJEKXft1mDN/tiigXACHkBb3l/BHaDbtVcoJCZHQRBEZ45q+eKs/egnKQcvZKQyNdVYUXW+kpR8Cp7FHQqfePKY3T1Lf/XSYYMvVAY0SenN2ck3JS3Broayfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CA1160011;
	Fri, 10 May 2024 12:13:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 09/20] media: Fix memory leak
Date: Fri, 10 May 2024 14:10:19 +0200
Message-ID: <20240510121355.3241456-10-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def47] [important]
bluez-5.75/profiles/audio/media.c:1278:2: alloc_arg: "asprintf" allocates memory that is stored into "name". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/profiles/audio/media.c:1291:2: noescape: Resource "name" is not freed or pointed-to in "bt_bap_add_vendor_pac".
bluez-5.75/profiles/audio/media.c:1297:3: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
1295|			error("Unable to create PAC");
1296|			free(metadata);
1297|->			return false;
1298|		}
1299|
---
 profiles/audio/media.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 07147a25d532..4bbd584deaba 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1293,6 +1293,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 				&data, metadata);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
+		free(name);
 		free(metadata);
 		return false;
 	}
-- 
2.44.0

