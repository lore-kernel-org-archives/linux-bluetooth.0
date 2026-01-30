Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDF2E888A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802005; cv=none; b=iPuBmAGqkNMywYTIa8imgg1xGWJrdDL5Z8Y+PGPXxKfdPk4y2S4ahx8RlurLfMSKuUEW2wDTirGqveCiPRwnu4OO9j66OFnq4fgrpoaFCFCpk5v3X22MIyz6Gjx1wvkK7GUZBofYmLpP+z5JRALrjIUZXzvDvzylAp/KvEZtvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802005; c=relaxed/simple;
	bh=kwk6k/ctfiyQfHYIaat2af+JvecLYox/Y1+gIsf5X3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1vHjwzRs+SPMSNRz14xc09TfL7jojSFzh64054HQZ9UOG6lO9dYziIZo9X1XY728NgXPrvYCSGwCv4LG0tEy2juXVAe+HN31krlu2qxBt6ZskGEU+5zXsHGV0PDq84Kd/Ty+SmMuJQRnUNCM+Y2WkjHJeZWRV+PUcA6qUo7Vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+qkP439; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+qkP439"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5663601fe8bso1973080e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769802003; x=1770406803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOmQk/M/Uq0ygA7FXgsp5BU8JK09dvzncFpgiXfgF+U=;
        b=W+qkP439O1QsWV3KwrnyHNhngWjHqdae+vC/yQ0TMIZskbSGp7szpSAqtKRJ74jc/D
         IxRjzekJSGBpVV9mNYEZ1+HCaHuUYicuYu9lgJTmKIXgmBYUTt2i2hPV1V9tnHd6+xen
         ub7f+NIrnI/2IrgAkEFJoBUK4owFHlJoXG8rYZ8ePuwYy27y3VLSAeezqtzf6DZZBbb8
         b/bQfKHTGS9P0hOtjhNqRMcR5N+TWfin9RN0rzGzpF1PKKDHkdO2anZsS6KNJtyUWTid
         yd80XAcPnLphLBTDEBpMwlAok9FhM5J6d18kvFUmj1oKlQWYaFGiQcsIAgl9cTFRIKOQ
         ImHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769802003; x=1770406803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NOmQk/M/Uq0ygA7FXgsp5BU8JK09dvzncFpgiXfgF+U=;
        b=Wt1fbGhlf+EZ4PQq9P1j1Ky/6pmhcx4Zbv+3QvrFN42k5be0MTI10xJFvttO+/C3pb
         03IVzn+767tIACzqrPXrAFvt7pddWAmjAPFuBX932g7fNE6yc4hQLjdEbGtwlzwVFwKV
         JSd4jJX8eDuUBYsfTZvkrm7ED3czf/q55QxfeuLlCVO51fATe1zgp7siemAJKaNQeMTV
         4HBMEgJnBQe/5J9PPGjKcSllWIyDQhuzfA9d68MR7SqITjFUy+VRSo3D9+kAgU5tnitT
         +EaqW63ZTfrofTOgmYAuDGb+b/cazpaR9P3bSqVZDggeJexCNBKvB0BkgZzfqi4hrV/D
         gXdw==
X-Gm-Message-State: AOJu0YyQJT7dAn85TOkWaKOubwqthZy3TmQJmt2jT4SuaP7HCAaB0cGv
	YrXlSQGFBBC1JmQX+oisu3ESipmby4Wf9a3BKvqH7qE0n7eT8tngXAUtZ3AFvA==
X-Gm-Gg: AZuq6aI+hmJMliePX7n73Hi995CNX1WNvK/Aa68ZPN3zqBlm5qXSE6Hy67RkQGL5RgU
	WCrfpLLEvmhVdNzYDtW+K/3wLucRhrFalZpniSbDHQ4CsJ4N9IFrobMeZNNRb18vxpX8wVh6Oc1
	XFBpQs5Z8y+47iIaPa1LYa0YvEhV94NJKvPl0guS7kCVeymDqgtGlDYcxtaGBS8p09tK1qCyoMI
	jYKlXrxRnFKS3qFaB9Beh1V2HGJ/QiIaD8nXv0o8VjZSDgeaaPMQLuiOyQE1MqVHv/HOenlXlNL
	4ahdUJaPhBYda/kGc4L6uOj7C01+bbQhNbHwS2g5hWr5xjsv4ikHEV/eAWAnaRxDT5YNYFVPCg2
	KE4Drzt52hlTIWcEUDWdS3n9iysq9RYCdy3UqidpcGvegcP0diQ1FyQCBouLWO/0ctsF7OA/KjU
	XmUUfHd2/hAiw+B/+zJOm3FifG+zns4BqFFTYi55Ru6S3h+qPEnwlXSp72zok+SxbBo0ShZKLV7
	c85OQ==
X-Received: by 2002:a05:6122:2212:b0:563:5143:e3ec with SMTP id 71dfb90a1353d-5669ffb3f0fmr1333559e0c.2.1769802003201;
        Fri, 30 Jan 2026 11:40:03 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.40.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:40:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 34/35] doc/org.bluez.MediaTransport: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:16 -0500
Message-ID: <20260130193921.1273263-35-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-transport and Examples
sections showing corresponding bluetoothctl transport commands.
---
 doc/org.bluez.MediaTransport.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 3d1e8c5b5a40..0525caa91169 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.MediaTransport1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/fd#
+:Used by:	**bluetoothctl-transport(1)**
 
 Methods
 -------
@@ -31,6 +32,10 @@ Possible Errors:
 :org.bluez.Error.NotAuthorized:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > transport.acquire <transport> [transport1...]
+
 fd, uint16, uint16 TryAcquire()
 ```````````````````````````````
 
@@ -50,6 +55,10 @@ void Release()
 
 Releases file descriptor.
 
+Examples:
+
+:bluetoothctl: > transport.release <transport> [transport1...]
+
 void Select()
 `````````````
 
@@ -68,6 +77,10 @@ Possible Errors:
 
 :org.bluez.Error.NotAuthorized:
 
+Examples:
+
+:bluetoothctl: > transport.select <transport> [transport1...]
+
 void Unselect()
 ```````````````
 
@@ -84,6 +97,10 @@ Possible Errors:
 
 :org.bluez.Error.NotAuthorized:
 
+Examples:
+
+:bluetoothctl: > transport.unselect <transport> [transport1...]
+
 Properties
 ----------
 
-- 
2.52.0

