Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8B3A1682;
	Sat, 25 Jul 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973577; cv=pass; b=jP+PGNL8Mi5WyL7sjBAqTJP2Zhzwr0ItOjSSD1IKpyEV65nivfOzTvUWU1UNecqXK/jC3pAI8qSqS7tnm2l5haxBU7x9ngzs+4LEhAxntl2w5cS0hD8B9dkovyvE/8NfUNTs/dVAvc9SXGqYdxIT35LGO+ObxRRjkTEHxWybzDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973577; c=relaxed/simple;
	bh=p06YDIeTQ5PAqLoN+X9xKmF2o3no+kD+t2dOm5R3kjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuCvk/+e5KSclX5rInnRn0P2+bv1jXOwZVTfjwpVC1rMw1ewCHqgX+Y6sZBb9F03LpfA8k54TopkHSt8Wq94TsZzUanQcfyN5uV3I9G2/fvwaU0NFt/hGc+PFEwDOxaoMVYPPyUMI1SD3TxN1VMIf+SvEyAvQq2gRctPsJgv86o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BoQF7ncn; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BoQF7ncn"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLs0dTXzyxd;
	Sat, 25 Jul 2026 12:59:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn8PVBex6ncl+2n5vZT/lfaFmqqGzayug7xteuZxBq8=;
	b=BoQF7ncno3bG5RgNs53Mdh5UkmWnd0tJLa97wgwq54X7p5/8FHnFQbGc6XhVIQpx1OqcBU
	8kGazHYhEv2hgvwlIDi7i/UdQYzUqbIqn6SJ+1hxw66uvZqCYPjXah/M/PBy2pRMN2tkMa
	8tyd7UkJIweTHw9BUL/ltHJWh0+elYI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973573;
	b=k3q5oR8ND160WOWXnTIkW7MKW7LyACNZVoMm6BFzN7jubYjwBV5uUFbQG6Mabb4iy92Eus
	PuA17a/Hdf6HZAjZT0xowvUWftL19HxHLif6ZlbLHYkDfWW7U01neSEfUocBr2iptJMWFr
	PWSzVdFjqO/ZvM4IGA0zka7iVxLGPsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn8PVBex6ncl+2n5vZT/lfaFmqqGzayug7xteuZxBq8=;
	b=aVBM2YIm+n3EMECbQ0UDQLS/q/vqdzsagr2lFYdAeFNiZIfVkLYMVYjIRxReGiQ36xrMUH
	TrSumXH9qJNOeAexShK+AcPLbIzFgiYQHRfwI9bjj/Jxc2ZmWBczWX4CJarZzV7vZrR71H
	TLSfpjAPuo/M3DzvSTo3SoLGAoZmR1E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
Date: Sat, 25 Jul 2026 12:59:20 +0300
Message-ID: <124ac68e80cb8e6911a8ab7ec7855b780360682c.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
References: <cover.1784973264.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - no change
    v4:
    - no change
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5610ef00fd0f..86c865306d21 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7312,7 +7312,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7336,6 +7336,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7486,8 +7488,11 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync,
+				      hci_conn_get(conn),
 				      create_pa_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.55.0

