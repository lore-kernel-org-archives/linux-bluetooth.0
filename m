Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B44F391B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569105; cv=none; b=CsfcibGRL5tiqKlEBeHIvzjRk64rP39rZ51pG4J9Z/+cL2gTQ6wLFtHpmEmhO7yoMV6bVIDPJvzCySudsmmme+7xtRfBQJNT7souuh17+ywQFeHAJAH3jtteR9xdJHZsvRsO5rCVV7N79v2TJF+foWTf0zfnK1ukk0jYE4ijQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569105; c=relaxed/simple;
	bh=bwKOBm6hKSzhsCCd7DEaYJBFZ1fHCwR+BTpXZgB6Svg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA3qHJanzByIJn/wVgDQhfviefRJKnMmWfzhmm8TPOJJmPNUpTfqU0tJ7dBaZxWCh3Fvy1rqQL6K82EoQ4Ji+IXWqrqY02SvpeLPruRAPVL/RMgZJscRpfBrKUnn+9DpZo6LmXL3zAKQ653qttjNiX64C2xDELb34vn0cY8tAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=iEZRHC3N; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="iEZRHC3N"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-16ad92569b5so985949c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569102; x=1792173902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8JezxiIi3qKUt+OTQw4I6+VPylsUpmr8mmytM+2PnY=;
        b=iEZRHC3Nr8ttwOJFwpmieyG0v/pyiLZSDhBfC08kZY7gkeHokjCkXjBynU0H078g7S
         RxOF7NKMBAMrNCbyN3AGDHZAfvfFhfVUEF0w+RwMjEPE/KhAz7Z1Hq5JIk65OAt7HJfx
         YMQEW+zcY2tH7EKQxz+T1S2yGgUPBX+0ADytBimdpnI+Q1bP17J8kBgP99lkK+ShL/RD
         EABPwfirc/zOYXj83Oo0TiaLxL1pbo74BM8jf5jWDMhDAWn5VCcp+Z5TgYqmUFGVN2b5
         PXsHnNpOkyp9BR5lpjFQRrkHnjj+ccEkPucSiphMa08VRh+eD9J64XIT6lXL1v+NgyUF
         JstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569102; x=1792173902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8JezxiIi3qKUt+OTQw4I6+VPylsUpmr8mmytM+2PnY=;
        b=yYiyaTUnMVtHeF8unSqFA+DTUhMfHcgH/fxkfMvRuYYubbstzrE/ojpYtSHIuVD3x2
         KyKjNtifovZWtOtPnSXLTMhxxys2wR2an1QSO0Skz6Anp5+boyHhamZRb/bleSy+g7Xi
         Q5zfoB1XXOfMpOkEfmw145nKn3rqjq5hrFFCeDL65rc/lVkpJBwRUdHL2WJvc7f3JsPk
         1A1NC2oMrHVbOXE2pTqpSr3UizmkCMD2vO5pFvlRfs85iDIfMdesXPmg0fHFXig39Ktr
         8hyYEmF+ujIQGvskr4swkcJervRv1P/xmsn3Kx50xc3+1rTHL82YCziM7zEwHbzEwnO0
         TLfQ==
X-Gm-Message-State: AFuF++k/BWz4fs1JuaRP01MKZ5EKWEec5mJSDkvw4Uw6FLVRZaxuZhYO
	Dm2deWNEAivK3X//oGH8BeZwNjtgkpuzBDKUNHaXpokeoFvO9inrjqm6tjbOeMc2jxlQlLaplGz
	ubLY/
X-Gm-Gg: AYBFou2DzPXkKOXL2ElnxIS/I4uQhmVQovkt+EssOZLNCBZu6tQ7cw797+r4lCL7ORS
	fZuxpRjbyWOFFCUHYFWuhWb79KuF37wi1InAZsuqDfEJN20ztqFOKGcSK0tfWAwgl5IqE4+dauq
	8N0OCjgWX+21B/xEsVidkS/nSMs9TaWl61J9+byyW0ma2AU+YmH3cOSXWIJjqnKmrOlYXzC6Wnb
	gt64ww3asM8brEoXNwqR7l5W1y2uuOcWjwavlNoYg8wFlbF0H4c5qYcWAXCqTmXtoyzAwaDOY5z
	YvU/SoXCN8b9i3+ZfND+2SSkjRSCGeTBz7QF6SXQNADWzy3q8taOUqdfnBngeSEqLhzh5KTHUzM
	OnvkH0w6PkZ3p0RYW1+2B0iO63ECZ+XTcKn33VgGvPirYQtTIjRH1RNb1adYCgsAlzsRCC2r2YZ
	UAzxGjX9CqUOs+Ik+jcLI/54YFNx90SEn4Du/Ek1LRbUCbmQxLzrVxt4+akQYnWIl2/N4u6WC/p
	jqDgiXyRO1yl3cnRBgv+/NAoiJB+rHmkedNVuekNTVXVBAx59/lhnB01huAdEo+g6NRVcOHhzqk
	UN8o5WZ9c4jlAX3XLug9jSR4AUSy2HdThqoTpj41rtsWTKX3ww==
X-Received: by 2002:a05:7022:170a:b0:141:51fa:e609 with SMTP id a92af1059eb24-16a4c33923emr3124872c88.0.1791569100277;
        Fri, 09 Oct 2026 11:05:00 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.04.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:05:00 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 1/5] org.bluez.Bearer: Add Role property
Date: Fri,  9 Oct 2026 11:04:44 -0700
Message-ID: <20261009180448.29117-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
References: <20261009180448.29117-1-kevin@simpleble.org>
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

