Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFE1E2858
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938145; cv=pass; b=JdAHf+5qOHhn4HrO8W+Ep3oZA0WvJlToVXhSfUuq89WoCOsWPkKnQHVuj6KeUff6vL+5zuzVKzXcGKKu/4xzvdMElI7S28A09to6KyQHuZHYd4xtlcqarSy045g1ozjFlUtT1jfOMHwZMXFQhLduQNpIEPbDQoalPBll+zGf8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938145; c=relaxed/simple;
	bh=rn9L3pr2RdgAkyWXduE0LFErCLykzdXRd9Vs+libxr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xk5TYTf2eCWdJZcJAXZWK7GW57u0gKFPs6VbCgnsQObm4NCUajDymTEV1b3VySAtjre7ZiOwr9LglMppJrxRttHTypnJ7cIwcIz4B7v+2lxLEHOpCdU6blcXie/cz+iUujsAtFjCanBNCI+tITiGIWy1p10bChKw3tWpCxf5NJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GxdFcR3c; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GxdFcR3c"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4c13ZG3xs9zyQq;
	Mon, 11 Aug 2025 21:48:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1754938134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5QFAaBDGqLdn0K9rVhIkKadqJkyyryeDVBW38QXTCw=;
	b=GxdFcR3cS5rtdxhVUTSSQ1Gj1MmCDg0j9+LyvclU5YY8eNthxhJyJV44y1abjh6Hne0Chq
	EOqQF3it6de8LrK1v/vyeuwdyypnF+q8mpw4cqJGvaezZsM4e5h5YmS42b2KiU0SbxFD6C
	7zwT7wldy3myDuFxz8MVku3aUDlFkkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1754938134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5QFAaBDGqLdn0K9rVhIkKadqJkyyryeDVBW38QXTCw=;
	b=Ipf4BJ+mJ+LJtKm6u8bLNTAaxpx+Dfzwj+/BY9w4D9pZwxlJcVYzwyTqbvlrHSfyI3DSiW
	ykw99lKIYVwZ8fb3tzCY2Zxdke54kQc7k5IG/Mg1JgACtOM5GioP1wxsl60k9eiMDZoSSn
	RgrI1Se2EU+SAZr3Qyrn6cPD6woQD5s=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1754938134; a=rsa-sha256; cv=none;
	b=PGydpXRjH75EcYfOg1n4YmW+Yq7IzEkPdms0ZYvZEKO2oyfDK+6NtD+TGgBDR2mmE6ALSy
	IaL7XrcCEg/lGp/2yZyrqlbtVudZdNwabdZEGHPD8ua7++YtbtvlzIY1LuVSwejxF1yf/J
	kUe8zDVRgn8IkWyZmomDHouFamC+0Kk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] shared/bap: reset local ep state on stream detach
Date: Mon, 11 Aug 2025 21:48:52 +0300
Message-ID: <c6ee6b6a02993e4be6d534d023358f5231b43043.1754938103.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When removing streams in bt_bap_detach(), they are detached directly
without going through normal state transitions.  As BAP Unicast Server,
this leaves local endpoints to the state they were in, so they persist
if client connects again.  This is not wanted.

For server streams, clear the local ASE state on detach.  At that point,
the ASE is either already idle or the session is detached.

Don't modify state of remote endpoints (BAP Client streams), as only
remote server should do that.
---

Notes:
    v2:
    - clear endpoint in bap_ucast_detach(), for BAP Server only

 src/shared/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c0f0c4f3c..9b7395223 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1357,6 +1357,12 @@ static void bap_ucast_detach(struct bt_bap_stream *stream)
 	bap_stream_clear_cfm(stream);
 
 	ep->stream = NULL;
+
+	if (!stream->client) {
+		ep->state = BT_ASCS_ASE_STATE_IDLE;
+		ep->old_state = BT_ASCS_ASE_STATE_IDLE;
+	}
+
 	bt_bap_stream_unref(stream);
 }
 
-- 
2.50.1

