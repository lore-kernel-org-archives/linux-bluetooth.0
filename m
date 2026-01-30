Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786963542CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810598; cv=none; b=G2a2O3/UOZo8RrcCpLYuO9QNzp7oxD4G5PwTrbfuCdNDipO52eOZmgEzjG8JpVvK4uKgGAkydXVR8bWAjckaFnMNMV7L/hG0y53UkyAXm+mMAPjrP/D0cOH+L1Z9rbr0CjX8sscexZKuwfsrq/jdKrglVCdRiQrqrGC6BZi0Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810598; c=relaxed/simple;
	bh=3OjDM269rLV+aM6gCBpNng8PdqoQVIHEBjwiZUa8bEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lidBuHsmsYAqIyG5b7be35FqEKe31Yh5gbc7HBI+4UXwNUql5eZjcGIE+JNeX9dbbgmN7s5+dfuchI6Fnc4Z+LWhYafK7NklYRdxrjkoRosnh9YJW01axrBOAEt38YG8vpLhNMREG2aGomdbHchoovA9RvwIJq0TfUudnIjo/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emCpB9nK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emCpB9nK"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-563497c549cso1434976e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810596; x=1770415396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n79dACPAQpTUkjH2Eg2xBt5KRpOFdyIjPBM5qhv5LJ8=;
        b=emCpB9nKHvEfmxEmbyFN/k8pQTua3pJscMeKry5D+/68sS0j9vj+Yt7vsPtHHP3Y1O
         ZaASFN7VKi7O5P4rRcIPjWFcOEZJ8OBQUnJDUZVyhhiEcUkCqhkyDkn32MGzHW3tuyQb
         rWnLH5pZcrhddJ2p2hcZ0nwGNygLlW17yl42ftWF6ZTvesnYqAgSGSQv79noChGHJ0Ez
         4W1cAMIgksQoZdK3tO8PkjHtt/ZGN0yEbK1sG3dMvYDE7GHoiv78hucMAUtPeZY5UDKc
         FKCZ+mtphjA/ZnFf66zhnoDH9tYIvJDBHaHK+jNjpF6+Plc1moECDfrz30QurmT4PHaH
         VFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810596; x=1770415396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n79dACPAQpTUkjH2Eg2xBt5KRpOFdyIjPBM5qhv5LJ8=;
        b=OS9o9mOZ4sxdBn4G48wdKh3+qKltAlKkZkNJoC6o9Eoa0pC0TphaoivW2pge40isez
         I/4mYKU8K4LyeiZJPCEkHP/aEqrM0L03YUx8GPpnovgNxIeWIOMuYR03cAvf6uMNj9Ds
         GFzz1b1/SeTrGilULuNitexvXJhCAp8Ywu2i6hvo+XuCvLkvl/P/54yS824bUOgobPCG
         U0ivfPW/3DKPRIwGm3SxLRKkzUfuzuHAdtwJU1RI7kQurUWencwfGYFODrKh5YM5okME
         6/BwCNe5VmAJtUoVdJ+9BTbigHpI3pc9ayzsQH6HlKea9tXY/oQHGqDowNnI+4gb++1l
         R6pA==
X-Gm-Message-State: AOJu0YxaFBPV1sO/HwaDW8YPLMleFNNkUf+fXUfvnacZLU6ryYn1FqG4
	uYrHq7t0n5EyvfjGi92csvR+ZN/e+StL8LzPrLNcJzpocch11ErZwI0BNECf+Q==
X-Gm-Gg: AZuq6aLcTsP/TDQ8DPO1JHBLuqcB/NbbOA4XBDMsS3e215YAYpTL4ZZn6Ww/LwIHwDD
	N0zQyjx/2OkgZeCFh9rSDpP5rlbvS5T/QEO8meXvGNGySewF2lWNwWfQ9yITU5aANcPF3Dc3/Qd
	Y4SMod+ClaUoDDQ7LC3RdQlRES1lT1q08kjvRcYW+1/MhTZH1q2sAiocbGeIav5qOilHU/72uzk
	guuYbUDaXaEueSchOu2Ze5uz9bs5nPKjMGGj+Mb5jK8VRPbXE/yku8tZnPPqCrQQQw9018Zkk/y
	o1TDhIYdUxhRnqNTQbfaDTbeDAn7PyxPnBv1oqsSn8bWkTt0blwV5r15VThpuc1yWzG+shAJuqg
	Y/eM49PFvbGMdJ41CNnNeoKLcP9wFURXHDre+GME/nuAvHoDwpOeHPpUl11fqYonUF8W6IdCB2I
	VOTmA1cnGaJT3iE6UWAjiRF5kq5EpS9xMIQlfwwmW29Zj8Z+dJK8kBCosUdStpvYYgg9q21Ttcn
	YsF2A==
X-Received: by 2002:a05:6122:884:b0:559:dc01:8cd9 with SMTP id 71dfb90a1353d-566a00d62bfmr1419740e0c.12.1769810596206;
        Fri, 30 Jan 2026 14:03:16 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 30/37] doc/org.bluez.Media: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:21 -0500
Message-ID: <20260130220229.1346261-31-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-endpoint for this interface
used for media endpoint registration.
---
 doc/org.bluez.Media.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index dc265d783cbe..1352a822d7bc 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Media1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-endpoint(1)**
 
 Methods
 -------
@@ -67,10 +68,18 @@ Possible Errors:
 
 	emitted when interface for the end-point is disabled
 
+Examples:
+
+:bluetoothctl: > endpoint.register <UUID> <codec[:company]> [capabilities...]
+
 void UnregisterEndpoint(object endpoint)
 ````````````````````````````````````````
 Unregister sender end point.
 
+Examples:
+
+:bluetoothctl: > endpoint.unregister <UUID/object>
+
 void RegisterPlayer(object player, dict properties)
 ```````````````````````````````````````````````````
 
-- 
2.52.0

