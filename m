Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [52.10.12.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF217C9;
	Fri,  4 Oct 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.10.12.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002305; cv=none; b=ohqAE3iCwsfGSCjzIvsdT1Cz9hxQheoBtCDMh5rtnIN/SiX4VUgDRVBVuQS3hTqeZvhrgf8Pwyiy7EJIrD+rA8jQPZ1nsvj5c00RxZpPS8pLepjjaDP9uxF8w+sJby5fh/8Yqm5cXb+9Ds+Vm/U423M0s1Hasj90DTSVOygIB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002305; c=relaxed/simple;
	bh=fy5ywXs76Pb+xeflNQJh6/EAulNeH2bY3Xst/VNsM8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9F0p/wNpnXOyM29nYR5YxilUuFukrOPqia/Fo4exXZispYsEOdI+Iyu731yV9307XaSVDkkh9Tsz0dMqxfnmA3fogMTmn2DASdzAUdn0wtkMJ9qoyakAfqfCdL/6vYz1CnHcbc42Fyiit1DG55Bmt54L1Yf6RQbaZ7l7T+uYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=t/xQ3V7/; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=HZhDi49H; arc=none smtp.client-ip=52.10.12.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="t/xQ3V7/";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="HZhDi49H"
Received: by smtp-out0.aaront.org (Postfix) with ESMTP id 4XKTxS6YtzzPT;
	Fri,  4 Oct 2024 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=bgzxjfijqntwovyv; bh=fy5ywXs76Pb+x
    eflNQJh6/EAulNeH2bY3Xst/VNsM8g=; b=t/xQ3V7/JUNuSxnfugRg9NFFiJ05F
    XRrxrE3GN+m49eqaqCbdgbYxVJvOzqBbN6ppl7dckFHbfiO9Ew3ZkrjBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:mime-version
    :content-transfer-encoding; s=elwxqanhxhag6erl; bh=fy5ywXs76Pb+x
    eflNQJh6/EAulNeH2bY3Xst/VNsM8g=; b=HZhDi49HiYGl+8br4vw/s3jqYQ+RW
    ZOKyybN/HC8Ju7qVJPl1IqoV6uIsiMABR4509oslgC+GrZQenCRO4CUKeVTs0DYQ
    WIzRN63c1W+AhpFG1VKy1YjwFF9SbUjQtQFsBiCkDhGO8+eFKUAa8SaR3N+3D37W
    s2ZYZ+TRMoiB3Zqmjof5UN2sJU9cjafcKlAZ0dba5vGj4EyQPlNXGmDDm07qGS9m
    uFepazL6HDZLjfpQzetjxPjEYw589TKXwuw2t88rT/rScybeXkewgh8Blg7bDrvN
    yxnC0hrRpny6RGaLgepjXi4mvjQ1Buv/ZBc1PbTYC/1dDTBZe4d1+KlVA==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aaron Thompson <dev@aaront.org>
Subject: [PATCH 0/3] Bluetooth: Fix a few module init/deinit bugs
Date: Fri,  4 Oct 2024 00:30:27 +0000
Message-Id: <20241004003030.160721-1-dev@aaront.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches fix a few bugs in init and deinit for the bluetooth
module. I ran into the first one when I started running a kernel with
debugfs disabled on my laptop, and I ran into the next two when I was
working on the fix for the first one.

Aaron Thompson (3):
  Bluetooth: ISO: Fix multiple init when debugfs is disabled
  Bluetooth: Call iso_exit() on module unload
  Bluetooth: Remove debugfs directory on module init failure

 net/bluetooth/af_bluetooth.c | 1 +
 net/bluetooth/iso.c          | 6 +-----
 net/bluetooth/mgmt.c         | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.39.5

