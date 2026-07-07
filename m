Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485036AB7C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436116; cv=none; b=Za74ryWHq0Y6vxiu2cyS2QwCVCo+B++ET6RXTOiqymXcoHVy3eu3cHSQ7kybGhjQic3BO4lUXfl1m91Frc0wTsracC8salEAAAL4h+SnwWRI5WfBS/x4a7Au7plIaiyFaH0FtmOXRzA97/Hpe/mUaoOHJKyInQZdVN8G9PuVi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436116; c=relaxed/simple;
	bh=ANEusjxaTpAHdCex1qp9gr3WysuiSpDcRDtk2AFacZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IcEovprAIUV8u8vDh21ieWgGfYv3FiuuLx7In8rYIKHF8bA1V3bJdIrIoEMw7DLKCDhNrJiW+1imjmF3OANiz3+mF0AMg6FEUUl4/g/YzN7gJbn8WP9m62WS3j2iNFA1xZRiDsU6DkLcyIHWvVcWsy2Zx/mj/t9fG2xvzFicwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYHEa+W/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYHEa+W/"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-963a722ed59so1205175241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436112; x=1784040912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlIBBp2e7HpXIuZYwR6yIvshF+mx/HZJNiwBzCBI54w=;
        b=QYHEa+W/4WfmdWHdIhJ8+DHWMDpKVZm0myQ9+JuYuJenGwZiBe8bNd3AW09APFEsTa
         KHD66n41lnO+yBopR+1GNeGY1BzKsygRmzvbWH+YcBgikVWVNBK1XOble4VbILa1etnQ
         VONbETN9fEfCAIrHhNUQmJK8J2PkAxssOZltrIPuTZPbhchmdbY5wEC1wpGDcBU0eUlo
         SSkowGQtzI3QXS/hWPXURAEYWE/AP5IZ+op+N10XisMyvjz7Wll/yJ23QCq5GUKhkBYk
         T750X04LavYqphFWM+OgMnhjR2bhwVPTEujjrEbQyd3ZHVf7aXNv+tKgLk2/lSa0LXjJ
         ShSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436112; x=1784040912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IlIBBp2e7HpXIuZYwR6yIvshF+mx/HZJNiwBzCBI54w=;
        b=fHuEiIanZMaPhxCge4568dwNiht7zLGLjY+QLAwF2woYgbITx7NHYq23QxG+Hi+MWk
         rRyW+PZy8MfggHcwGCFVsI4DrW0oexFVgevEh4TldOSGliGupE3XcqfxauGiJLS6hOvd
         33hS64qNoYLAI5S/6jE7qvPuC4kyuyXjzWZVhy1K6kd34ThD+ZwojVxwxC+MWAtY+uF3
         MWr839RoS6hSC0jCncvARfYsBel4pFoUUDFM/8PfN073DfkBw1dcAcYJkeSMgw/AK1ij
         dQ9KyFAdMopLAHRyGAYzpnwREYKNmD+lsPwdFqovO2lBJH5CVbO9HipjsJwp+SZPkIsj
         lzuw==
X-Gm-Message-State: AOJu0Yy/A7Y6x+dNvKPqgI7p9HbE+A22FMv5rT/aQceTmZb7ecVhYdFq
	C1KhW+jx9R3SR9E0a88RV8wmg+TYHBxO4UPpdclac6Gdai/wjHHprt9B8EwgJQoaUkvv5w==
X-Gm-Gg: AfdE7cnkLgk2itrjCodVYtlui8XLRcn2f4PUrBEw5UmC1PiOw57ozTiZN5POlzlMX1Q
	Z18YMIcDxhRwlVl2XHLQPtVyyZC/CpZ4S/LERYO27TTZB3UrkM/k2gule6vHAfNYPj//W86pEBP
	1won6FYfOiGrWiI4QSAIqcLRmE4oU4Qpte+XsoPu8cquyDg1WJCgcq1GaS18KvQLaN5b/WrwlQH
	clVRpsTjYvCx70AOi/3a5MMkgfInYTH57OkE2G+kNCsMFJUqcITTSAqfcB5BnxVMpodybaPucPh
	04tuGp3djt6X91KKk1ZeXNUVKpu0Gr9xhF8taSLp8BSSID0gJ80gqbz2wInZcsq+pkNgASvHRov
	3Lq+p7XFBlzKoymgBTdiflr6a4p0Dqu89POMIhbWPnXorO40UkFalkdV6+DFoiJHEGuhdOZAdjo
	aSNDwkU7KMQxBGrFe9PyhOgoFlRGty/3iaziYPT1xpkBEhSIAHflayTiV/gxI9RWWsI+lnIA8ik
	9ABiTQ=
X-Received: by 2002:a05:6102:914:b0:660:d26b:506e with SMTP id ada2fe7eead31-744b79c1be9mr3369240137.1.1783436112282;
        Tue, 07 Jul 2026 07:55:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-969839dc155sm7210715241.10.2026.07.07.07.55.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:55:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2test: Fix calling getsockopt(BT_PHY)
Date: Tue,  7 Jul 2026 10:55:02 -0400
Message-ID: <20260707145502.874602-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

getsockopt(BT_PHY) expectes a 32 bits argument not a
sizeof(struct sockaddr_l2).
---
 tools/l2test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index aa05f5247c5e..08d2269936b9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -358,7 +358,8 @@ static int print_info(int sk, struct l2cap_options *opts)
 	struct sockaddr_l2 addr;
 	socklen_t optlen;
 	struct l2cap_conninfo conn;
-	int prio, phy;
+	int prio;
+	uint32_t phy;
 	char ba[18];
 
 	/* Get connection information */
@@ -414,6 +415,8 @@ static int print_info(int sk, struct l2cap_options *opts)
 		conn.dev_class[0], prio, rcvbuf);
 
 
+	optlen = sizeof(phy);
+
 	if (!getsockopt(sk, SOL_BLUETOOTH, BT_PHY, &phy, &optlen)) {
 		syslog(LOG_INFO, "Supported PHY: 0x%08x", phy);
 		print_bitfield(2, phy, phy_table);
-- 
2.54.0

