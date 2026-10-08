Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877049A3A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466610; cv=none; b=Qyxu//pnz0z3p5wm1WdH5Y1nFpz3LL7I0jgdb86y2087Jrxua6AHHKyd3GZBAmGithO0R73C01Mf9LIYj6LIZk5x7gw6Yhfi/aGpqyWOKSfamuh5JWp5BNtt2dGup1i5AT9eU4z+v2eUaTdnYwCfO1JIENauEhcK0Ppav4T+YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466610; c=relaxed/simple;
	bh=hvt6ZPD0E4jRtw1KYKS2AKv0O9qHAnbB9e439BeEmbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Vmcs2/n8sNjv8xOvUmJlAY9CZlWmetchfSUIEJ0/hYu445YoWlrGx+ViYElyvy7jS6xxoXKUlHZfhhg3ZFAgRXDZdr4d7la78p7xMCAWBR8iUmdbBfjF0yV56U+euYp9s1RIYRDg08kMz+YggcMfo8qIspajeA34F5dQKKjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=SzK359cO; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="SzK359cO"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15943c9c005so2103363c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791466608; x=1792071408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEFu1vHS8OT4wqBzCGj1n43JbOLHw7o46leSkuqXkVQ=;
        b=SzK359cO9y1JoCdvzZyOmn75xEvJ6hgkuhHrOTPYKCZcD2eTJqZuinzLMepEZt9bI8
         0bKreQwtdbtStK+I98TcqivSe2rkSTq2/EJ8huXaVWejjkvlVwXUKpp1mnVGKe/b7Zur
         nYB1IQj2eVd/mcdcAum4+ohyfLS4Nl7+tLHbwfSC+EZwCdLbh2IiyigJXW3HwwPmrHQv
         h8EUGG0w461OB9xY9+r0FW3mxeGYkgOYdYcii2EXYc4vF2d2jqz1ECca7+/O3B67Mldo
         QK3nqg3pmkbgcO6cp52C1RvWN3SfoLJ4CixzkpsozolfyfK+DHNgS9WJ7Ily2FfVZFOR
         BDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466608; x=1792071408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEFu1vHS8OT4wqBzCGj1n43JbOLHw7o46leSkuqXkVQ=;
        b=duVFpzWid9fYR7cakza8X1Ttj2cueXRwyxx7B7dC46G6xtXse5Kg0d0R4SygdOU2Jd
         Ec3nXCKHR5ZI0y2SzBx36W7ZeKKmQ7HNpQHtWw/C7S/NPAyDYv34Rt7POZh1+lWjSvC4
         qBFsZAslvyKHDZpJSHrmsh80mC5awDtkPwDo6Yw1U1idM/ohosixOZwPbFvZ/xLnZvj9
         9sLNEIFwIrlbJVt+3trcjfSYC5vulVjpP5o0hxy5k4AGwQ+RmnrGtDdiEa4BbCDpgCmG
         12NOoLf0xE1KM434ySIw/GNBnCOc5Xwb0ucv1ipQjOaqFBd8dNz/0gIokVcv/u89kPJC
         b3Uw==
X-Gm-Message-State: AFuF++lvMMHcpwP4pdEDwssok5wITJfQPCUjoiC2N19nfMV0GNMj5Unv
	y4mYJ8lShdS/JMF48Cl4W2mcXeidbnwd9wnTDBCN3mO6Uk83Fugrzi5ssMroKyz6ZGfpqtZUfoS
	+s+ya
X-Gm-Gg: AYBFou2fcIwYGHaXZJuoGX8xPKLVW1VEIpLqs7QYONn/HkFvb1Dn//obyz+AwFgAFKc
	6pYLxoN7r3S2Qo0FqVJIV6xRCtrt0x2m07DpsotxEao75YeKWFOLQvm1Rn3623tmhyvi8O/OWCb
	2nQeS2rkWbBmHhlobPZeQabhEEjp7a5rzUjaA5fkNeI3jWS5tq5jJftlHmXgWqTuN2BrjAP4c8a
	x2x5gn5bFQg5c3eESI1upvYghBU8auCRUoUgmy/AIdb+Adzf0Vqs/OTbgfV8hfdQFzJCFHqMMuV
	/1NccejkjA1bcYdX8uyUQScnuuP6ByP4fKbD/fyTAf9fsSYQ8VbZYmKd2jfUrvIkvRe7J7bGULP
	VOGhIrHBqQy/Z0biDGq2NfykgLlIS3SvN+ZmsteZbuiqae28OBFUqj1XKdW6OralLaI3sZ+qcoM
	bVM+lRHMwS5XtCSXBWRLobqlk81ZweR1lkjMsqpSJc03HshJeyaldYh1VP/i1Y991r/aoXQZdLw
	lUvIglxgntFBxqw2kFYyuMynfoMoWe5wPeBxu/oUKIsMiTRcHCZrICrVFxTFk7pk1mrej7DkyPN
	TuCGVDmf/4DY0Yie2Aa0aA3nqhfqYDtdvqbzFnco
X-Received: by 2002:a05:701b:4302:b0:14c:aaa0:941c with SMTP id a92af1059eb24-16207d7b7camr6900928c88.35.1791466607545;
        Thu, 08 Oct 2026 06:36:47 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f62a5esm15220725c88.14.2026.10.08.06.36.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 06:36:47 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/3] org.bluez.Device: Add Role property
Date: Thu,  8 Oct 2026 06:36:32 -0700
Message-ID: <20261008133634.30362-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008133634.30362-1-kevin@simpleble.org>
References: <20261008133634.30362-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds Role property which indicates whether the remote device is
the central or the peripheral of the current LE connection, so
applications can tell a central that connected to the adapter from a
peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Device.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f3e4bfa4a..27a225a9f 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -304,6 +304,26 @@ Indicates if the remote device is currently connected.
 
 A PropertiesChanged signal indicate changes to this status.
 
+string Role [readonly, optional]
+````````````````````````````````
+
+Indicates the role of the remote device in the current LE connection. It is
+only present while the remote device is connected over LE.
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
+
 boolean Trusted [readwrite]
 ```````````````````````````
 
-- 
2.54.0 (Apple Git-157)

