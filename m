Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AB2FF646
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802001; cv=none; b=YygEyvy839eFjcuXSyf7mmCfO2Cs2Yvglt4gKOvYb8GJvP230GIIVWyoFGBGI5dHmhFwIjgIO0JCPbY5NZn8n/EEJhvnj2Lat2hoEPxiqoUALJc/prIfH5hUlhpWUUi89nhlX8cE3arKQsTqrmgzXSX6wbEar14jYgZ3x4acYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802001; c=relaxed/simple;
	bh=FuImmL5SOmcNzR9J6lB4H7SSHh6LEFObjDuv6Y13NKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr9iVpciQXthMeI94k//+Ym0qpF0Gs+cvXY65qIiAn7g9knHoACKlVI4V1lYC7gPkDJ7BHBV+t85LjFfcU8DJ8L6IqWE6im02XiiNcCjL8W/cdCs3Nb7dTM6PKht3XmkLGpzv0i7+d/hMJYOGMUL5EuRfFUMmtVcEXd6Mo8i8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECsmpHig; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECsmpHig"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5664393d409so934912e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801999; x=1770406799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKNKb/EYNKRv0NlkjnoR9KgabqoViI1fF7EpNEVPT8w=;
        b=ECsmpHig0jUantKF4AUMKhZJV788p9TkOSJExiZ8rvNrIGFj8d71nk5yLeWoI6xT7o
         WjG8XSLdYyRhADea80z49NB3gJUkWY4dXjt1v1jtZebgI9p2B7Rky1uzdiUZAoZe6LzI
         o6cci9+NozfovDlQynUotqZJR6WooPRtvalRes9YNNUMYrMJPoew3SVA9cLMPsoODMPF
         oY1M7KeKZcvyEyEfMR7h3CPeWfPZT32LhD24FtjopyhQ4VXyKqwXqMPlX+gL8XP9oLrW
         Oq2hkZpsr9cf1lVFVXTlU3T8npj0kmXzCGF/dRoibSL4qrYMo2EZ8YRq6LjwsEwFwCMU
         rz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801999; x=1770406799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JKNKb/EYNKRv0NlkjnoR9KgabqoViI1fF7EpNEVPT8w=;
        b=GcDYnba8oyo9YED/5KbbA3ZWnonJfw6OP6iFcuvI5KwxoQelEbmJ5T8n5zzf148pta
         iaKG0dYN1E0oN+qWnSQuda0K4Fr2/zXIP5FdVyutL0CWhBN24GwEwWLYavQave89x0jS
         Aunn3Kpa7U45r6jPqFY64lSzOdMdshaf2tMlCv+wLIxZITtjQJrWP3rxgwmZKaNd3Cz9
         09h1ZIkWXAxDEZZkgaS1u0in9cAs8qIjDihoo8RBIQVd41RTy6l6v1uMpiN9ttzxmDwv
         /K3y7bCSH+xWH7f5yw4xRH0lOWMUy7JMKc+R54j7/L/ffQY/DcZQvKV6ArB1YVvsNE1W
         DT6g==
X-Gm-Message-State: AOJu0YyaVHFWtejoTtCDDpUEab6Ldnn5HffLQiEl5OCrzhA8U2sQlo9o
	XtuP7aN49QSu+4waUItF36+n+KgWlMXG0ex23xSajwaYu5THsWYaHagc1Bqdsg==
X-Gm-Gg: AZuq6aILCXBddlzwZ0zRAkyVsUSgi2ACtvwBsjIRQ6GePoiFE9zNZ0xjgrtP/NanC3R
	t6xOPuj5kFwgIvFrJERCWIlgXOo0G5ynNZOcbga+uhxLI/IDhTRKwSdajSzIoRlidX1ptfUSxK3
	V/P55ihoIfmpEBUFKAB+LDZ5b3WpofLuLgYr/yZpCyd8g9NPe4B1xYrbiYFR8iVsb453yC1YrIc
	6/cIGJ6IdmrMO3ZRCvBjPCgHJfsgwnN32TLnyPC7Rf4YzZAwEfvqIoO7QTnZwuB9h5q336nLIlu
	g2kOxq4oKbCkakJLTV39kKhHY8/S+g4Ju+MW989WgAtb7oYus/qheJyoUQ/hG2iSvbQF9rvjALA
	TpRNAtNOGVEGaUnYfqKNlVRnKuZpTiJ8xWU/N7yaT6LjeqEEu/8X8kO1kMw2aFoghrlzmyRWfPb
	H9R8UNY40NX7Um8LXDy/4e4C30u6iq5VXp9dWjF4K+WAP6Iim3/PwralcAnhCBoApGKj5wtqzSl
	thazA==
X-Received: by 2002:a05:6122:4697:b0:563:c868:a32d with SMTP id 71dfb90a1353d-566a00345f5mr1012703e0c.2.1769801999456;
        Fri, 30 Jan 2026 11:39:59 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 30/35] doc/org.bluez.Media: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:12 -0500
Message-ID: <20260130193921.1273263-31-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-endpoint for this interface
used for media endpoint registration.
---
 doc/org.bluez.Media.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index dc265d783cbe..35aef2646ad6 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Media1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-endpoint(1)**
 
 Methods
 -------
-- 
2.52.0

