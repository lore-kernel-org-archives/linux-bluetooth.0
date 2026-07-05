Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BC37FF60;
	Sun,  5 Jul 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262888; cv=pass; b=t2rXffjabc5kBqs0tyNwf4ZP0hfAHYVSPR3jNgghFrxFxSsO1/sLBkwfnqEQ1Rc0Xy+re+3h5TFO93bgUVpZJ6rRjQfLD1M91Z+FKzjjOJLlIKcA7dArVR10T1zUJpvzvB2kC/tZqRCqVhJBHqRpmHgVwyuX9RpZrNemhh7ZXGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262888; c=relaxed/simple;
	bh=OarsU4AFDItynnQ/IVyZsD3y2w66Chdn2vWG11OXQLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8GXSJt6E9N2dAOLngYRvmZasxDEjjn0BtPYHS1lmaDEVXjc+YCQ8e10NdNE/m6LIt03NNtSq3EcAbTHRzuf90ErCnc+MN+iOVK5fzgkuE04+N7asUdF/C06x0QzMwq3NntAtPqxgoOoFx4fFK0CnmccJ9/2aTjpEpSUtGlVKgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Z/QJde8w; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=l6ZDtraW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Z/QJde8w";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="l6ZDtraW"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gtVhq5JPmz49QB0;
	Sun, 05 Jul 2026 17:47:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783262875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yjxxScepQchwS3esOTpvoKh/241FX2Ybqa2TUOifw=;
	b=Z/QJde8wEFjeCGJLsbGgwIzHtr1kpTq9K0kYUTd7MaujgAV+AFNDLIk93fYUoPtLMptfZY
	Ve090s/nfdZDrVUk5CXrPMpxtM1I5tx+fUCu2OJfLK8F3k3mgcGyKD+ocgFszpvCwGFeJj
	8N3n/AK7qiPQfCTxlkDRAstWhY/CnhbXwiteY+X4jrAKSNS9J/8OUSrBfnM9UtVqjqJK82
	liy1P/1bsLXKUUikUd5Iz7jjC+jxQ3WhapJjyE3Ah5u5+Z+0Mhgfin7rDGbwcl2IgxrzN9
	ZA2p0f1GoqhmJvsO7HxhqZzVHFbWSnwdwxJ7oP2w4C925h1QVRJoTddXmUPzlg==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtVhg225QzydN;
	Sun, 05 Jul 2026 17:47:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783262868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yjxxScepQchwS3esOTpvoKh/241FX2Ybqa2TUOifw=;
	b=l6ZDtraWfw7biubw+fma+f3KarEpTAgIagHVnUxeLPBCd1IjlxUw5d3EZ6c9yGw3aKw95p
	aj49x3KOCXew3vbnHEh/yri2QxKcIGAd7u0AKHDaI8qSwdLesuWHPeWXfYLGGI5IBLaHVe
	7ZQiqGLbTf5Wed+BntoCsgKnPbn2aJs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783262868;
	b=TlsLA3d361NWG/xcPSkE1HURTmBBYhKXoMZw/3LHdu54Z/pddwae363oL2ANbPLvLUw7wh
	cZSkW8zORIHw9M7lGjJQoCTgnigkpTuh9Q3H5gcraRE19Rgc/FLbxVkP5dRG9dyj/eV/Kj
	VDCZ18lzywBDrzqWbkiKEEIxRGuvz7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783262868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8yjxxScepQchwS3esOTpvoKh/241FX2Ybqa2TUOifw=;
	b=a8wH6kkhV2+VmereOjCDYBV//0AaH4I8sf+3Mzc8Xd7zbaLKGHbHJH0UP1MH5lQ0rQcwwO
	nUmTJtZUEh5z4b1G+zpGerbh1nezALro8TMNf/wOOH1jmxzHjX+qTi0VA1X3FElmcPPBPE
	NJENRGaRyr+oNH+pvApPKytvmk318pc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: mgmt: fix RCU use in unpair_device/disconnect_sync
Date: Sun,  5 Jul 2026 17:47:37 +0300
Message-ID: <ca1274055d6c705b5af808d81d192802ad68feff.1783262689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783262689.git.pav@iki.fi>
References: <cover.1783262689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dereferencing RCU-protected pointers outside critical sections is
invalid and may lead to UAF.

Take RCU for hci_conn lookups.  Since hci_abort_conn() cannot be called
with RCU held, take refcount temporarily.

Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/mgmt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..cfcb97badd02 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3091,6 +3091,8 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_unpair_device *cp = cmd->param;
 	struct hci_conn *conn;
 
+	rcu_read_lock();
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3098,6 +3100,11 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	rcu_read_unlock();
+
 	if (!conn)
 		return 0;
 
@@ -3105,6 +3112,7 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
@@ -3252,6 +3260,8 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct hci_conn *conn;
 
+	rcu_read_lock();
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3259,6 +3269,11 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	rcu_read_unlock();
+
 	if (!conn)
 		return -ENOTCONN;
 
@@ -3266,6 +3281,7 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
-- 
2.55.0

