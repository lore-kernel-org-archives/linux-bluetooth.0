Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147D746E
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374541; cv=pass; b=sJ9Y8lO5klMBU88GHPvN7BzTQRWGIknTojgsdpzMtlqq7yM9VKjejv+7k4nTMNrIzKZzVPna5LVz2qxmPaqPDrelskiOEzT59LJg3LdU9ILDljMN/eD5uEvPvrl7JPTZNiAD0j9lBRWpEwzN2N+lhGXuC5wqGPHgzg4y8/1S71g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374541; c=relaxed/simple;
	bh=q/k+32eQUkfF07uADCynUv8GmMxyXNjW+VfHrKMBBSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxt0O5DKsDdBmH72Gxmd4sUOJJ1w2iKM89PNjqck7Gk2+XMZExcfsxsEYEI07FSieHjMiDd39jlfLh7EgqEQX0eA2sCQTyHLKif7Li2IF3w+ltIPTdEI0AElBehjVvLtVBOd5eI745RKElsLgIiFfdh8Zi1tPeYo6GGW4SksddA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JiaUBpoU; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JiaUBpoU"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yb2Vz0zyjW;
	Sun,  4 May 2025 19:02:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LsaaOy6w49amGE3uN/ijiZWFt0jKsYuBNPhXmkFGlGs=;
	b=JiaUBpoUsNAxsmPp7CHAuki/PqfqyooQIlh5l+09xX30TtNOAVJex+cQzEB8HJpQiJnLTG
	6KA7Wv8nS2A/l4VZ9biZnbJ9PBf04J1QzD3qj/FcXh/O8x633zNVKrCjrSHZPhyIzaMD5B
	hcU0j9FW99j/QOr9mA2vQQKM0EuRdWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LsaaOy6w49amGE3uN/ijiZWFt0jKsYuBNPhXmkFGlGs=;
	b=y84uihwDzPlPrXRGslWj8o3vBt5dbl4Abn6dai6tjyakmN223hwc6r/wAMfeEamMsalipZ
	+mXM1al1mXYJiLUUieNG4znY410ul2WwgcVIqGo6aDYN2gx77BrneZhJMO6iIg7Le9BZaN
	QXl/ns1WbrYyvwvb7KzN6S2yhJ0NY7I=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374531; a=rsa-sha256; cv=none;
	b=l60aVquznkW6HIF56rmGiT53wiTHZoRpdGTYCT7093IcUTpa7vA4tIM+4njnDu/I4OZ8P9
	FvaOSpAhlXRBlmlo1LL+JGijkguATqjoaXXNtTrOsWq+EEpcHrj6wGyek73OsmKPKSJ6W/
	64jSoQBj/TvLpCqrKOW9YC6y4+0h1mc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 05/11] bap: discard stream when no longer in use
Date: Sun,  4 May 2025 19:01:57 +0300
Message-ID: <52aedc2746a92078b74c06899ab6d82dd509d14d.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to lower layer that the stream will not be used any more.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee7c8bc49..dcef98148 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -860,6 +860,8 @@ static void setup_free(void *data)
 	if (setup->destroy)
 		setup->destroy(setup);
 
+	bt_bap_stream_discard(setup->stream);
+
 	free(setup);
 }
 
-- 
2.49.0

