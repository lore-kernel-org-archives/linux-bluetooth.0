Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000D386559
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466613; cv=none; b=JObRumpYKRUdx5o293jNbNcwNor828UkAPfuyExF3JjFV8Kq4cVGraUo1fvUZc6T56FWzvQ8IwJ8c0THIgkBpZBVgCDS/iVT2YWVcVgcuQlGzFzJC7GX1L1lHTUWHdZhY3Y+dmFtSbrpVazikdM6ykZzdOQidykB3C40gi1/g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466613; c=relaxed/simple;
	bh=U5b0jw7XXH+bhbDbNrE7h7Sb0u04FSftNM5hRXG9LHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coWQQs01DG47F2Tj3UPjcd+vJ0+HrJp+FAYp0BSFLaaW7TteAWjW0349GKFMqvP3olMWLqnAtFtUQzRpCjRyoy3SZlw+T0zXuITHY4drbnqxzApRUDT8pwEWxIz7tp1lj5qTh+U4iGToMe+/dySNiGtmjH3A7uuJkfs5yoQ1fnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=IL9hR+7x; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="IL9hR+7x"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b6dad2382so6863718eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791466611; x=1792071411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9weKXitx0h5ZQuT8Cl1fSUvhAslBN5eL4szBG83T8o=;
        b=IL9hR+7xQxKTwa2giTwbRTYqVaoTxlJWtjt99u0kxUKitrbWXg3eBmg9BtuzlwOkpN
         owUSeQozHtyGzsRVYFvhpEZrRYV4aucdLaPf1hqaRT0/XZIfkL2npsLMhR2WZDxn2VN8
         Xk+WV/uS+GyWRnBf6CFjg0b9tDQxPBkvhC07nBN6sP2bAujUuPb5YomFLZWFiVMSsgnj
         jTL/PFENWEI5q2Y7b6xwphBY4Rz29PgvYIoxqnyHOIk+V0SLzvfBC38PplqpsKtEJliN
         3UxbPF2diexljVTNqoF4f0LvnjUrt7vfDpJAofTt/vV8XFz22GJ6BINb9+UpI3/rIezh
         aJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466611; x=1792071411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G9weKXitx0h5ZQuT8Cl1fSUvhAslBN5eL4szBG83T8o=;
        b=oGNaTzAHlgM1azs+g0sa2J8ZrX1Ux/TnGC5sj/HsAR53uUaIs0oEAlhkCqjRpjPvVh
         YkIFjQjWAPorYS6ijI6tgnak01r+uh9ww6pwQz1xpLPs5A3XuyBxaxXXXfQfmi+RqLX9
         TkymqxtsVxP/NITCe2Yer3tMn87EqEGXgjA3p/EM0k55vUL1B46nbEOIqCFGsNQe3kzY
         KX55qYlP4ILV5oZInG7nu7MC2eheAuotGsjyAfvK3KBt0J1+Jf4qgCY4k8GlIMBHwwxR
         XK9okqiZLWd+XJ6OOKh7mkFWuzy3D/eUoU9YxwJMNmNXiz0yfgbPEL+xVuutPUAEK6Te
         QG4Q==
X-Gm-Message-State: AFuF++nXEEF8nML9ZWcnu9o4lUtuUcH6XEQCFA5+6yNuIhyilAg8Zg5Y
	d9s4i2gOeUGYjqhAVa1nD88pgktOxgm+NANM97U8q9ybfcIg9YKWT1s3mPfPwVrQOfG68QKdaNe
	kV1D4
X-Gm-Gg: AYBFou2TJwWoeaMG8l54Aptdi5xMYF36g2smcC8zpbjxaeFvL1nq6RrNIO/eoE3ELUX
	pHIIgSAYK/SWHxOsmucPNBJ6HwiASugdh3UUqlkDsCm1TRBfFkCGPbMvnv3yeg84svK8O3hsV+7
	hG5y1sCpDHwXUZEdkoqPFHiEwWdii+cE/vqKUI9PW3kc628VxQplht8EQ9+omiLJ1aT0SiKIvQg
	zYx7eWG4YjCd26SpIKOy0prq6N9v9ixsTtaX+lCNpakb9r5wNxsgRVeNPhNOSYfMOxmAGzICAJG
	r/vnL4/vHaq1jm9EUxCb4kSorMMjE86Uug8Tgp6esbTgfRJu1sJ4G+tWAOYYlaFuZcCDYSUJgnZ
	Qnu2G9XujQus9LcSenIM3C2uzQJ1k29S/hUXbP/VhiblpA1ravGtq1+LRjVYXpcMugKX4WPKpcE
	rM6Y9jPSqehHN8OiaRJDIUfOSVIhP8dGEsHeHZ77f5SdljCkkpkyy4wrDgzH7hlvjFPjRfE+siO
	LnD7aysamgo3gFm41F7pqsEquWM90wZavSmdbRqeHncT+8n61ggqRAfYQ3Ka8+m6xvz6MVEnhW+
	MevPFh2Qeh9fA8LLJYjcON8oNTPlueks+ggVZj9m
X-Received: by 2002:a05:701b:4588:10b0:158:b944:b20 with SMTP id a92af1059eb24-162041de5a4mr6601106c88.11.1791466610046;
        Thu, 08 Oct 2026 06:36:50 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f62a5esm15220725c88.14.2026.10.08.06.36.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 06:36:49 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 3/3] client: Print Role in info
Date: Thu,  8 Oct 2026 06:36:34 -0700
Message-ID: <20261008133634.30362-4-kevin@simpleble.org>
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

This prints the Role property with the likes of info command:

bluetoothctl> info <addr>
...
        Connected: yes
        Role: central

Assisted-by: Claude:claude-opus-5.5
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index f5fdd7d12..7f6b276a8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2044,6 +2044,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_property(proxy, "Role");
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
-- 
2.54.0 (Apple Git-157)

