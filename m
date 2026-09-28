Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D68502779
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635122; cv=none; b=riLOJ5GLl+jy5YPSgzQ60XK3y+3Ze/cKLKqtEE0Xspahh9Viw0A2kp2EHClx/OF379ErRxrp7LUYRzBpBqE5CEiIzc3qA4XXY7rBmVhwEL9HskOFLBlL5gCzjHZjnV4RBMuYxEM6xLkXfImRcITgdN3UGMGbMMl7FyzCAu4K7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635122; c=relaxed/simple;
	bh=Q7nNUVOM4qhmCj90VXzbx/Qlcnfp56PqAIfciz53JUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Q1KecOP7S68bihOOw9F33F9E9Dz8VDN3xsxYFv3PFtbXRD7tcS6vOfMwR+/pMjk45n1yrBBYuqByMehrhN4EL01gpfJiPspwtUQ6n7YoTR1ejKmLBjrgvlNuxj195KDQ5CBLsfKPydxC60WLNuATiUCjnIUkcZVrImfkd1pDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=PDoEqi47; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="PDoEqi47"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34abf779ac9so542404eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790635119; x=1791239919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2ngFijLUqlTZ3s19tpt1+h+mecZTgeEBRLhb472dkY=;
        b=PDoEqi47f1dSuSKR076Ual+K21tZKIjNoyHh8qne2P76eT48cGxnY4UwbI13S0UtGJ
         Px/aCWgQTCzns//aZkiQTA/dT1LsxbxVbtD8AhtoYFiNj/v9+Sn6LbOwxPn2JoIBPkyV
         5UgJ9K9WqOno0tO1g4ug62wkP3x7EUoGZUSTxLQFWUAS2gT1gWILMu3qwg34SsoPDZll
         e5EhGBO0Dcq/zuOW4OwceUfcUItxRk/V+NelolAPoOxauLD0mjxQUZgF9K/o5dt68Cei
         pKe+B2uFGQHQjIQUbedOJj1WCCkzRK7Cs6/qxq9YVhKg6UIdVgPHnxlMJ1YlIPJiftwH
         5IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635119; x=1791239919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2ngFijLUqlTZ3s19tpt1+h+mecZTgeEBRLhb472dkY=;
        b=t9fx9PQQJZ6qkBNKwv9K1SBFl8mhuUAwDzdstD/kEBTd1fzMMCJ9E0+DMoJ+aMBcft
         +7ZIG9vfZNdH9dbf252k7uKBigP6me8Sh0dCUoGLYXpuwqtDJY2QPvWikpyoIdQ6bFsl
         lIVrFhWgXpWI+VvXijCnDStbJNhxJnFntoxKCacP456ZrTsKtvqrzejRlP/U4ZOZYMi+
         dU4Ii/gI1dDFk5VTUwIDo1MWfkyPo5XbDIZnJ5CwSZqi9d+/+FMGniWxtCgc04RsMc59
         MxljxYF+ggPl89QOiibTAcFSf0ekpB0/nemmNlCHSwP1ScdK8jOJABRFtQDyfamUpyv0
         loig==
X-Gm-Message-State: AFq9FYK2yYeR7r9kNMGNJHaqesLfI6Hh1rBGTYgrNX6TCHocEzCKTQkj
	w+dxQZ9vBDx1S83cLHwBCAib6UUgJPX2d0UQaG+INU4U5iEsyYihP5KBEIVqlyb32JOXEdxiDIr
	1M9pKFbkkVA==
X-Gm-Gg: AYBFou2PknBu6dkrqkYFWucxz3+z2R/Y4mNimiCFe1ql+NOTLsXzZZgySiEzbruvbo7
	099NAJAjLC8dUsto1z94axSaSQW3OXI/U7/3bWZu/HfTSJUHvYx7Ii/NHVTZ6r54UrySRN8tcBG
	zYJwJNFhAC7GqtgmvVXpL0JRYmWQ0mTDfgTy7+lKZ21XaYWWKQc/Z2x9XMeFwX+cnGyhasX/2Bl
	gCZecmWDkfmOjbQaesRJzN0/UunOXSWqYutd4PGQZQqoO3RojvTKkIfZ7XrTzkX1JIzoQm1Nv1w
	AJsJI8f9xHTfyYHnzmPQviHOlmK+vdCCq3K/ZaSk2O5AjThMuggKfXaNTtCtsA/nV8D2cGaA5EC
	N5x+7evUBfC2/DBZYAqC7UQqEDT+pdsKjnSj5FPITP7uVKvo2vWe9RocaKqK2bPj1V8LBbtaazq
	yUdBm1cLBApSSwqT86zMWTUHlTabsvcxeoPeYv949+zvwQsLORMxB/ZbLcap3f1yMSVvSzIwdVs
	+dkxe3SRbWiyq0y4fbBlzyDUdjape7PAk/qLkP5RnTjEijDnHhD55rsrQzgfcCcuQ60qdHxm+Dx
	cVZVpOmF8HtVaweqRYpNx86Cly2XMaiZtBwhKxfB
X-Received: by 2002:a05:693c:69cd:b0:344:47a1:a93a with SMTP id 5a478bee46e88-34447a1ab30mr7252693eec.17.1790635118842;
        Mon, 28 Sep 2026 15:38:38 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm27182480eec.10.2026.09.28.15.38.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 15:38:38 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/3] org.bluez.Device: Add Connectable property
Date: Mon, 28 Sep 2026 15:38:13 -0700
Message-ID: <20260928223815.11936-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928223815.11936-1-kevin@simpleble.org>
References: <20260928223815.11936-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds Connectable property which indicates whether the remote
device accepts connections, as reported by its last advertising report
or inquiry result.

bluetoothd already tracks this per bearer from the Device Found event,
but it is not exposed over D-Bus, so applications cannot tell
connectable advertisers such as peripherals from non-connectable ones
such as beacons without attempting a connection.
---
 doc/org.bluez.Device.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 3e6a30a..abfd74d 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -395,6 +395,17 @@ int16 TxPower [readonly, optional]
 
 Advertised transmitted power level (inquiry or advertising).
 
+bool Connectable [readonly, optional]
+`````````````````````````````````````
+
+Indicates whether the remote device accepts connections, based on the most
+recent advertising report or inquiry result. For LE this is false when the
+last advertising report was non-connectable, e.g. ADV_NONCONN_IND or
+ADV_SCAN_IND.
+
+BR/EDR devices are always considered connectable. LE devices only have this
+property once they have been discovered or connected.
+
 dict ManufacturerData [readonly, optional]
 ``````````````````````````````````````````
 
-- 
2.54.0 (Apple Git-157)

