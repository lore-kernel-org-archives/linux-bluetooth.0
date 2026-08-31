Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5E2E62B7
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187564; cv=none; b=qFftPVUcXDWdDf1ECPdi+y+QkSPoHqs0lq9hZKKGj/7N9gz6R0cDp2dAdiXNoUwYQkqLsSf3GBnwwHlOzsHY/1viiJnIqosSR1IwGYMOHpYlRSOlwcpPr6Gf2b0nw3fJXn5G9j9OuiIhNLUipTkZ0H9XtBeKjNHqpyg0HRTv00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187564; c=relaxed/simple;
	bh=SoCvedDibHp2P+9Lovxu1S6IxrM3LMYBrAB0AzbQlMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4N4qystCmsP2BZW0A3b6i4qvdDx8A181pwXMKbVFf3bzpptL3+/Kq+slgdN4hUhOdpA/7hLwAl+cZoQhDzBwTjigws2x5bZGAeDjp7EEIW1JPaI10X0Hwl4mvypAKad1AxYdToYq1mWIRyehOV6Q/MtfEWq0fT1BAeRBSpmhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NP5I1Bcg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NP5I1Bcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788187561;
	bh=SoCvedDibHp2P+9Lovxu1S6IxrM3LMYBrAB0AzbQlMg=;
	h=From:To:Subject:Date:From;
	b=NP5I1BcgeYx7u4vkRIJzvmiLsG0fWzDYII2/gjdfUNllGwhe/+55rKLH/kIo/1cAv
	 ZP4DzdDlXBrUT891jscfmIDG8Q6fStn15mV1CDNoaCfrmA4Lt+QOf1sR6pD43GfaYS
	 nHy0DhJmZ3AalGjFFEjSdGayOgve7rivyLdOarLAtGDf90oNq9U5OU0ALVcKKJ/erS
	 gqOOoLaemSa9oI4YvqT89mGPiBHAj00ecAN2pI7XC1+73NYp/Ufrw8EPfAT1ceNRn4
	 aK67rRclN2W0Jf4zL46am7cLNYMCKuE1RcHfznx1GVX1gwlvBSoc2NP84I98RfeZ8G
	 jQcz7j7D+7nPA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4616917E0069
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 16:46:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] transport: Fix use-after-free when replacing a linked transport's owner
Date: Mon, 31 Aug 2026 16:45:56 +0200
Message-ID: <20260831144556.128154-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

linked_transport_set_owner() unconditionally overwrote a linked
transport's owner pointer. If that transport already had a different
owner assigned (e.g. its own Acquire request was still pending when the
paired transport's owner was set), the previous media_owner was
orphaned: its D-Bus disconnect watch stayed registered and its
->transport back-pointer kept pointing at the transport. Once the
transport was later destroyed, the still-registered watch would
eventually fire media_owner_exit() and dereference the freed transport.

Tear down any pre-existing, different owner via
media_transport_remove_owner() before assigning the new one, so its
pending request is replied to, its watch is removed and the owner is
freed instead of leaked. Since media_transport_remove_owner() itself
recurses into linked_transport_remove_owner() for linked streams, also
guard linked_transport_remove_owner() so it only clears a transport's
owner when it still matches the owner being removed, preventing it
from clobbering an owner that was already reassigned during that
recursion.

Assisted-by: Claude:claude-sonnet-5
---
 profiles/audio/transport.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 22a755064..e3f3df50e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -336,6 +336,13 @@ static void linked_transport_remove_owner(void *data, void *user_data)
 		return;
 	}
 
+	/* Owner may have already been replaced (e.g. by a subsequent
+	 * linked_transport_set_owner), in which case it is not this
+	 * function's place to clear it.
+	 */
+	if (transport->owner != owner)
+		return;
+
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owner = NULL;
 }
@@ -728,6 +735,16 @@ static void linked_transport_set_owner(void *data, void *user_data)
 		return;
 	}
 
+	/* If the linked transport already has a different owner (e.g. it
+	 * was Acquired separately), tear it down properly instead of
+	 * silently overwriting it. Otherwise the previous owner is
+	 * orphaned: its D-Bus disconnect watch stays registered and its
+	 * ->transport back-pointer becomes dangling once this transport is
+	 * later destroyed, causing a use-after-free when the watch fires.
+	 */
+	if (transport->owner && transport->owner != owner)
+		media_transport_remove_owner(transport);
+
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owner = owner;
 }
-- 
2.43.0

