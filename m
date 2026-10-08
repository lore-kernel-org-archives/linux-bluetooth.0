Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5A3AFB18
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480611; cv=none; b=C1R3zRUgeTw8DtHMiU9XwVs9TuJ0Hnk4wns1g3O9CdaWJmq61PEErh7ZEtrhP4Tiv59n/Z9gnOXiM3lf35Ava/ON+KiBAeDnWJf4aWkO21+tRHHPdUYnFRpPc4TJGzvrMkltodG9v0I9RHbFndufRrgDbtWvGF4dl2L1TEdwIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480611; c=relaxed/simple;
	bh=bwKOBm6hKSzhsCCd7DEaYJBFZ1fHCwR+BTpXZgB6Svg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJarlxemEKE7+3kzums86FGvn9b/27uzq4lajPUKwr6twJfHuvU0n3vlEXOJXD+t6rVCKiOm0hJN4FrHptQGnqNhWKvCmfzCcCKrEmPm2jMmcq5i1MLtp7cLTWsRVX7y2cv2LMzOev3ujsWVZvh1sPHslQf04yRcK1kPtagBfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=OEa/qFUK; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="OEa/qFUK"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-351767ef18cso1034758eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791480609; x=1792085409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8JezxiIi3qKUt+OTQw4I6+VPylsUpmr8mmytM+2PnY=;
        b=OEa/qFUKrLs4fHeGVd1i/oHnIC777LIBt7iMrViyA2cghHQhfUQdDbIei/cIOEBJqf
         eqpSWd9CqEFavcHa5CKSnyQ7SOcSFD3+KFRk2C65eON7V2ZbACq43yveZtNqzGA2wqAN
         wO/ljPAPU7cdLxXlk+DaMRjZ2+gOLPmpakA/B/WQsaLC5/kMvrax+OtXzGjJ1HB44V8f
         71XtfYTAHsI40iKcbCbRSKa8kDP1d0tr0dYfl4RPvnP2acVtWsC67p7/5C/rDv5Xr47P
         E4dnSO4X3vnCuOdaeOlD6+7FzR1W29UO+/5XBOurcOpLcAebG01oJPuyQC7WX+Tp0fWm
         SLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480609; x=1792085409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8JezxiIi3qKUt+OTQw4I6+VPylsUpmr8mmytM+2PnY=;
        b=yHYdceTETsO5W6cMNdKmiOmc4QBPJQwBNPT2nIvN3JYyrnNJPuvo+JH+Jb22DOO9hd
         lXyWs/cHebdI//+GOVP7n4tje2S13xFOEWHXOhujV9A20ZSNoCUN8AWl9ZsX8O/FkYCr
         9l00aONNKXd7nZ+BRg/I7sYtMvNqdhWot7cJUFvJ8l+SKnNQ9KsgjztpwIjJl1484+mf
         kfxwLjA8eEmDlG+UbUFCjz9KRKDm2zmwC2XV95QUSarHCAf77tJ6NJ1943o4+Wyz/13/
         FXE/qIoFH32UrFRuiTpMdjyl7TKvAFcN0Q1SAcU+07viROTTNgwzE7B7g6Tf4hNTHIw5
         Ys8g==
X-Gm-Message-State: AFq9FYI8KGonybky822NQz+r+iVq4/kyGhC+wPX6vfvkIPOLDkkz2ep2
	NxY8OA9xx/kwAWUbAWyrnXqY1+UXMIK6qP444iv841SCHa58z+YYA11fzrPqWqQK02ygC8DmoTN
	EnEqf
X-Gm-Gg: AYBFou12KWkgAxN1KkPLV9oZxXovWlnILWbYU/qY0VGrVpNkiJtK7v7PpzzoPezSpdW
	5yjTWcbxUPZNPj4UyWWKwVMQLQOeHyS8DjT6u0H/pMVYx8Q9XHXHuo7Cg0Qt7nB6HymdF6KPCVd
	bp0G8b7xBflg8nV14KWjB6XlRCFB9IXQxN1iuMWIfm9eJfqKhSGMFMpuV9odGH7PzVjsXup4WWH
	rFEUPI5Mz7Qi3vBUrwF8bu/sWz6f/FDardOTNrD2w/ybWc79fhQ6BXRKEewvQfIro35khNEqCpi
	UYozMg+bhS3wW53gxT3Fpjue9v5VHqUJg6blqDG/s/OmS9JsTxDJAunJpu96TH5p/Oe5C/emNl/
	YaFY9of5f8uvZnugZQlYUi2bD30sVclmFhEzS3pHlXJZTYGa7uFT21AQ+hVSuoQO9KOor9qE3iY
	+Wjp6nk5S0Id2pgw3yK9lQD+HUMNg6WzV+tQUTXiDiZlvYoQU97c+ptB+vtmmHS4BNYLvD1YJdz
	xQhvbSpz6Nkk2wgTHy9b1Ycd/G1/ueKgV8qf+4hIzFxip8iwVf+26ShL9iASrZX7KfP1NFen5Oq
	gQP26MEuNKlqb74fXn9XS8LC7UzKgFumCtkJVSAm
X-Received: by 2002:a05:7301:162f:b0:351:79dd:52ee with SMTP id 5a478bee46e88-3535f32ec5emr53735eec.6.1791480608426;
        Thu, 08 Oct 2026 10:30:08 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3535f385672sm41804eec.0.2026.10.08.10.30.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 10:30:08 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 1/3] org.bluez.Bearer: Add Role property
Date: Thu,  8 Oct 2026 10:29:58 -0700
Message-ID: <20261008173000.3615-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173000.3615-1-kevin@simpleble.org>
References: <20261008173000.3615-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds Role property to org.bluez.Bearer.LE1 which indicates whether
the remote device is the central or the peripheral of the current LE
connection, so applications can tell a central that connected to the
adapter from a peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index ec92a5ce5..dfd809739 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -153,3 +153,27 @@ The property is only present once the device has been discovered or connected
 over LE bearer.
 
 A PropertiesChanged signal indicate changes to this status.
+
+string Role [readonly, optional, experimental]
+``````````````````````````````````````````````
+
+Indicates the role of the remote device in the current connection on LE bearer.
+It is only present while the remote device is connected over LE bearer.
+
+It is the link layer role of the connection. It does not imply which side acts
+as GATT client or server, as GATT roles are independent of it and both may be
+used at the same time.
+
+Possible values:
+
+:"central":
+
+	The remote device initiated the connection, and the adapter is the
+	peripheral.
+
+:"peripheral":
+
+	The adapter initiated the connection, and the remote device is the
+	peripheral.
+
+A PropertiesChanged signal indicate changes to this status.
-- 
2.54.0 (Apple Git-157)

