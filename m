Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4491CD39
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jun 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945591; cv=pass; b=Wus1N0/S9pAYkmYItGqDLF+hxhkwIobQkG6+OYM310u1QXH06zS10jfBqL9avJnPJyIMC5aCRXdyRdLpXcU2ar6sy42yIuzWcoXapLwZDBEeJgZ4r9RCxAH3+TRf1oDJT+aTt2UgmJP5sHcvzXFxH6WCYvS0M9gwQbn9Kkz9FN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945591; c=relaxed/simple;
	bh=VSlKgT7RsWzDeHBJYkDwFlw3dCLKx4i/ocpT+WeNJHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg1UW+RF3AEHZRkeeU+8sgtTkFHHbZAGnCtUI7m2scI04rUpeR8ubAlDKMV+Ye808bJmZ+vcvB51yvkS5cVaK4/8n8V2tOzvWUsWo5gCkv2+clp71aIeS+252r+0yvMxMVWCA5q+ctmpIh8AW6OKC0XS9eLCm3rCXiLyK19OHWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rWif+wR2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rWif+wR2"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Vxyv554qtzyQL;
	Sun,  9 Jun 2024 18:06:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1717945586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWdjrq++B+FOCbuXHCPq7PJ9s19J5GeWTrapYXSiC0U=;
	b=rWif+wR2Zs7MsaHSfyUdEGYYd2HXQRdGlPk17QnaakIajVRGKqtTbsaTs8eCkJL08ElhWD
	/rIeeD6aBcoNjUTg0oS8J2Dv6GL9xM/Vi6sGXDJHIHInouBVfhE3jdmkP69Hbdi/OgHMny
	0V9ysdg4YNVuqUV7HhziiVS9j/vyNX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1717945586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWdjrq++B+FOCbuXHCPq7PJ9s19J5GeWTrapYXSiC0U=;
	b=IW85KDDqcppLLKrjZlwg4VshMvx2C8mzdOJAod12mNi9QPYBgmzqpYF5L1ws9s10ycMcvZ
	hlDDGSk0UBCliqx+Q7vvA37le5kWHl0TIfnOEVrbLztPSb1A7vHHUMKkzbi+UXPbUtTwrh
	lz48QFTqVdiTi+yEGA4w8r5wilADVqw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1717945586; a=rsa-sha256; cv=none;
	b=FGrnCCrOwW4rC35XJYVawqNi1mFXhhk95IlIFr2jMZvf0qQtkuMILeN2+aE17aIwg6HsW3
	B+t1ZhR2Ew0szt2OGQ4BQtcFeAVNtUOjJmuolPF+rtZFYqVUI4Da3EKpp+WDqqHZcBlrT4
	sM54plIx0CnX+s5+s2HWroYFDP1jh94=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	luiz.von.dentz@intel.com,
	der.timosch@gmail.com
Subject: [PATCH v2] Bluetooth: fix connection setup in l2cap_connect
Date: Sun,  9 Jun 2024 18:06:20 +0300
Message-ID: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amp_id argument of l2cap_connect() was removed in
commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")

It was always called with amp_id == 0, i.e. AMP_ID_BREDR == 0x00 (ie.
non-AMP controller).  In the above commit, the code path for amp_id != 0
was preserved, although it should have used the amp_id == 0 one.

Restore the previous behavior of the non-AMP code path, to fix problems
with L2CAP connections.

Fixes: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: do the change in the actually right if branch
    
    Tried proofreading the commit, and this part seemed suspicious.
    Can you try if this fixes the problem?

 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c49e0d4b3c0d..aed025734d04 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4011,8 +4011,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				status = L2CAP_CS_AUTHOR_PEND;
 				chan->ops->defer(chan);
 			} else {
-				l2cap_state_change(chan, BT_CONNECT2);
-				result = L2CAP_CR_PEND;
+				l2cap_state_change(chan, BT_CONFIG);
+				result = L2CAP_CR_SUCCESS;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-- 
2.45.2

