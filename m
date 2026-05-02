Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8238228E
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740198; cv=none; b=mbrLuAEAyR5h5WnKeWMLueLj8RGHMU9ogrsKrQGz2bpKP4GoNKDRwVk0mr29yuCSFfM6TCnxAFY9Zy+RUFSganqTZQV2tS90zgBqpQZAJJ/mNSa4VoUFVeEST7qnYI97KVA4pjNJVnRaOwVaNlwqjvnLvkTVObFy5VpTs1p7nWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740198; c=relaxed/simple;
	bh=Xn2ePJ6ir3hW7Np1i9JbirnQGtvWil1VDjPekcFB8Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQX7tD24cqpjswIqwbityf7Pz5jbHT5fEKdQLFCQU9omzZs9iJRBGVVj8QCA8OexD9dkyjpTSXFOZmxvPamm6aDctVR3CC0I06+llli3W+Ohm9bnOFPiCNsV5LJcZpXKFga+oj6bWaXeZ6xg4aqK6WHcwtYrhCs4JVxTKeVHBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyuh8DkO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyuh8DkO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b5ee185facso11044866d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 May 2026 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777740196; x=1778344996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdDa/EDka8OJGu6cOD3sDFd08G22qIM4iCKN6j/lOHU=;
        b=Jyuh8DkO65AhutH2yEEu6PlennkBPqYGegeXBBD1ra+Hr/ZXYYe6TA0IPttQBvh0P8
         JOVvVIaD71oAOB5Td+GSDaurfxrfsn483fiRhuBc0lzUoucroE3Vi374Pz6eFTaDQWq+
         8BeStPBLHv9/DO+Qzen7Cyd5Wn623O+lwZQ63qW8CZHfaGIAkglV8lCqGYQRJoqc9Id9
         k1hz8pzrMzOQDuxbxAkwlOfmEhoqN/Xy8kTDqZSM1qkR2M0rolP02yAgEjt3RnQM09ly
         HLZtk7ZYziNTAPjx1PgoGgaRJX0wRwr2hVuyUpQzlcwFkUVhBhQtJ4Cb+uwkfioasAwY
         jEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777740196; x=1778344996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdDa/EDka8OJGu6cOD3sDFd08G22qIM4iCKN6j/lOHU=;
        b=kA47BBsmoix3IXaGDcD3BwoJ14Mc3lAQiNO1OBPoaWIj0gpan45R12sZxcnUsZEKBm
         7DR6uqVPKKaLx85qXbSJMaRx6XdOrf0eLPGwgLazIlT+j/j/BwQqf+0d5TUSib/qgYJt
         ypqVoZk8fRD23+mCnjxjs4YJjhWg353JHa+YM/5473yhlu5JBuELAjhu6SourRFt5czA
         tvalS/+zMy2w5amYofHE+2KOufbjW0S78XfEqDiw4X2cp2mHOkmFOsNnJ28aPVOwQ8a2
         HxTSS05mZ1XMZCWDf6YAnPaEjBGLkdWJ2FfHIOG53CmkBq5cU+eU0QrzMwnr6K1u1VR4
         uajQ==
X-Forwarded-Encrypted: i=1; AFNElJ9frSFNl7NrD6q70QxJBCBRQyFA/hWc38L8+l9ACDE6UQ4m3oGU/ReyMvEGugLX7HNFAVfyWiDWxMm8esj1QX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFizVQBx0zESXm5bgcFc9Xkfey1YGLWGIItGR1FrqYqqwX4RT
	jr/nE7TfmM0KpblhzIQhkJG2inx/1iTmO2hisgsmRWwK5qSkwcN6Jcd9
X-Gm-Gg: AeBDietkmbSLDWR7SMuMJSPti0ITAdR4JRCI5JBezzS38w2IJButBKxgIjjpsfmHewJ
	NGHvrHl5zITDDY+fsF+gpXIt7xDjzhbu+DjWpNJAKKz1H6/8juk7HzFl0Zs7Tjxc0BMx7HdFj2d
	9mBCB36kfC2Vxc8k9iIdnDI5TcKTgOTbcA9gn/CwMNbEZq/Q2e8fzrF7L+a2eAZr+c66U3O+8KU
	xSz1fN+5rbauxIP8Jkc0y2W8TckW2y/xRsJ7/8fz3JNANJlYHXgFXO5kxi6cigdfsgXwCk0SIm7
	5GATmIT3u6vSnHQu+S0m3kEmq9mrJjs6fMTuSze+fmI3Os+N7Ei8d9NrNORfg6PZIAocS21gxvy
	pXqWWgDA9uNUa3e2KvT3vnN16cSlYylQftLARP5lvR2pWSZA0XAJkJLNKp82F/Cz2deU1z/JyqV
	FSWBK6GxebTwbaSKuq1iD3VUmHfSjhOoptUPnhdE0TySUnMPBZkqKkAaUb3rH+MaxFaYmORwv3r
	9/7Ul2+cp88CZCYdzQ8ZvQjFcEw2Bo=
X-Received: by 2002:a05:6214:4013:b0:8b4:d8dd:b75b with SMTP id 6a1803df08f44-8b668a25df1mr76524736d6.34.1777740195869;
        Sat, 02 May 2026 09:43:15 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dc62csm72088136d6.23.2026.05.02.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 09:43:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem
Date: Sat,  2 May 2026 12:43:03 -0400
Message-ID: <20260502164303.2299816-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422011437.176643-1-michael.bommarito@gmail.com>
References: <20260422011437.176643-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF") made
hidp_session_remove() drop the L2CAP reference and set
session->conn = NULL once the session is considered removed, and
added a bare if (session->conn) guard around the kthread-exit
l2cap_unregister_user() call in hidp_session_thread().  The sibling
ioctl site in hidp_connection_del() still reads session->conn
unlocked and unguarded, and the kthread-exit guard itself is a
lockless double-read.

hidp_session_find() drops hidp_session_sem before returning, so
hidp_session_remove() can null session->conn between the lookup and
the call in hidp_connection_del().  Worse, since commit 752a6c9596dd
("Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user")
takes mutex_lock(&conn->lock) inside l2cap_unregister_user(), a
stale non-NULL snapshot also UAFs on conn->lock.  v1 only added an
if (session->conn) guard at the ioctl site, which doesn't address
either race; Luiz suggested snapshotting session->conn under the
sem and clearing it before the call.

Taking hidp_session_sem across l2cap_unregister_user() would be
wrong: l2cap_conn_del() already establishes the lock order

  conn->lock -> hidp_session_sem

via l2cap_unregister_all_users() -> user->remove ==
hidp_session_remove(), so taking hidp_session_sem before conn->lock
would AB/BA deadlock.

Factor a helper hidp_session_unregister_conn() that under
down_write(&hidp_session_sem) snapshots session->conn and clears
the member, then outside the sem calls l2cap_unregister_user() and
l2cap_conn_put() on the snapshot.  Call it from both
hidp_connection_del() and hidp_session_thread()'s exit path.  At
most one consumer wins the write-sem; later callers observe
session->conn == NULL and skip the unregister and put, so the
reference hidp_session_new() took via l2cap_conn_get() is consumed
exactly once.  session_free() already tolerates a NULL session->conn.

Fixes: dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF")
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/all/20260422011437.176643-1-michael.bommarito@gmail.com/
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Tested under UML with CONFIG_BT_HIDP=y, CONFIG_KASAN=y, and
CONFIG_PROVE_LOCKING=y.  W=1 build of net/bluetooth/hidp/ clean;
boot clean.  A KCFLAGS-gated test stub (not part of this patch)
drove hidp_session_unregister_conn() twice in a row against a fake
session with conn = NULL: the helper short-circuited both times and
lockdep stayed silent.

 net/bluetooth/hidp/core.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 7bcf8c5ceaee..976f91eeb745 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1035,6 +1035,28 @@ static struct hidp_session *hidp_session_find(const bdaddr_t *bdaddr)
 	return session;
 }
 
+/*
+ * Consume session->conn: clear the member under hidp_session_sem, then
+ * l2cap_unregister_user() and l2cap_conn_put() the snapshot outside the
+ * sem.  At most one caller wins; later callers see NULL and skip.  The
+ * reference is the one hidp_session_new() took via l2cap_conn_get().
+ */
+static void hidp_session_unregister_conn(struct hidp_session *session)
+{
+	struct l2cap_conn *conn;
+
+	down_write(&hidp_session_sem);
+	conn = session->conn;
+	if (conn)
+		session->conn = NULL;
+	up_write(&hidp_session_sem);
+
+	if (conn) {
+		l2cap_unregister_user(conn, &session->user);
+		l2cap_conn_put(conn);
+	}
+}
+
 /*
  * Start session synchronously
  * This starts a session thread and waits until initialization
@@ -1311,8 +1333,7 @@ static int hidp_session_thread(void *arg)
 	 * Instead, this call has the same semantics as if user-space tried to
 	 * delete the session.
 	 */
-	if (session->conn)
-		l2cap_unregister_user(session->conn, &session->user);
+	hidp_session_unregister_conn(session);
 
 	hidp_session_put(session);
 
@@ -1418,7 +1439,7 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
 				       NULL, 0);
 	else
-		l2cap_unregister_user(session->conn, &session->user);
+		hidp_session_unregister_conn(session);
 
 	hidp_session_put(session);
 
-- 
2.53.0

