Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92917137923;
	Sun, 28 Jun 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652842; cv=pass; b=eAkO7qWKgMcevLTDsKe6pscFGb6os/A2BQQt4++XWrlcHX6BAIqn+YfvUpKcepvz/37Bdw0tO94v5Q3Ft9ia8HAEvmzWBwaCJfaCiuE9BSdCvtUDgcVLInW708+VaYfWSpJm4KEeUcpRbRdRXefqemlGq2E55JLa05XH0slAgpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652842; c=relaxed/simple;
	bh=c2JhX6fHNqR/0IFc8cZkl7ine8KI8CUl/7id5FQr9wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=og549XPdTIwMI/yj8CJXODjQqR6Imln0sGWkJTxMx2W8DRg5C8xrsWslZp5ux+Mbmv+5tI7z4sUQPl3Y5TxTs53JjtuVEq2KQdmqIaD2jw8oQc/0Lo9/Xdd9pR+GWx47jwg3egvyrCjWg5qSAQEngrI1v2PgAaA/+s2H8gnXV4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c8EZvKou; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c8EZvKou"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95K3WWMzyVR;
	Sun, 28 Jun 2026 16:20:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=91Kn6RsSnJo2IcKfcI3HEhwKvjoZzPYC0ZKjvYc4VRA=;
	b=c8EZvKou2ljVyOeohQty6cvMpQ4+eDlVqmW82PU65ZEkc7Yv/fo1IIQih5OkdMvl+RFtMM
	Lc6pDAgMYC9vajKDVPcnnozQht4dKsV1m2b9nKRJKVCX4BTyPkxycXMHm3ZJyQvtJLO7Rs
	IfZZ8Vdm60gYSs0k5BuX+zCiOXt73VI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652838;
	b=sORl77NQHISX2VATwjiZK4jWAqLxt1zV1tLCdLExCIRFmQelOQVVvSwfH9+Uat2odYR0fo
	cTojCcGsEt5CSsBWfwe5EF5xMpvfqvw8yTAww7LS0VD3p2cl+ImUROAMvIxEzIJTv5pBPV
	qX/Pstg+CLc1HP3JgEa+U3UAxRn5wvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=91Kn6RsSnJo2IcKfcI3HEhwKvjoZzPYC0ZKjvYc4VRA=;
	b=nk0BdSaYvokTtWFa7Ht9nr8zgOqdO+W3MO74vMNyywweNjCi1I6khOEZnA0CBDkwvPSIBL
	7ZtJ+F1ceq04nR+xH7BbzQAiQfRlX4Sdl6t4eodpFd5ODMGgZeL5hFF5+L3kPiuz9KLMUA
	rhoM0H5udBZ3qfELx2W2Ua0Rwfvy26w=
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
Subject: [PATCH v4 0/7] Bluetooth: hci_conn: hold conn references in hci_sync tasks
Date: Sun, 28 Jun 2026 16:20:25 +0300
Message-ID: <cover.1782652695.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have hci_sync tasks hold reference to hci_conn pointer they want o use
later.

Avoids UAFs and passing potentially reused (possible even if very
unlikely) pointers to hci_conn_valid().

v4:
- Check !conn in hci_connect_big_sync() first.
  It's probably bug in iso.c that it may call this with NULL, but
  probably better fixed separately.

v3:
- resending some rebased parts from
  https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
  https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/

Pauli Virtanen (7):
  Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
  Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
  Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
  Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
  Bluetooth: hci_sync: hold conn in hci_past_sync() callback
  Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
  Bluetooth: hci_sync: remove unnecessary hci_conn_get in
    create_conn_sync

 net/bluetooth/hci_conn.c | 12 +++++-
 net/bluetooth/hci_sync.c | 86 ++++++++++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 30 deletions(-)

-- 
2.54.0

