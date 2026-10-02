Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B13DDB1C
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919987; cv=none; b=a5OsqBz4YZjJpiZxj0FzQkqS4ThDJhFnZY3ohakbmAzKed2cZK4/wOhckW+uoxh0dP0h34UFeIsmRULIwhVl3dkvtSHr91QaAaR3ArBIfNiDAfj/tU9QiDQgeAExY4BI3GMmA4I/zjzJ1m9ztlPH10h5oh1NwKO2xI0Hc74v0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919987; c=relaxed/simple;
	bh=rjaJTj6RoIbaQn/9GtVxmIdsxZ8LSH1mMtcxmdU8cIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3gy90VM2c87VGwMz0BSbRJEG0+wvMjLFo1Ge6a+7nrGFndvbQ9JMoEiewC1TW0IhgxrZbdd0ZicKXkTz3iTQ6t4I2MCOblJ1LO7LQyhOycWBM6u9l5w4yV8PnUbN12I0YBc5wBcg+Kxy/5IgP0TX0g8h6Ve2YR0sBES9+OJhXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=iNwtpYMb; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="iNwtpYMb"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso3244238eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919985; x=1791524785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qWnqZ/ULb7fXma5Lz6AfQbunHQrKcMDH1ofdG/miuY=;
        b=iNwtpYMbGGZFf/PrQ3ayuHw6q56faiQGAKX9yOqBxsZ5eFcLO6hg9aWHsHcK9TbUk5
         ubEAdTLRl9syuFYxLnqej3CbRvB+eKG5ovO84+iY0DD/GBZGcyyMl4Qb+4agBiqU0El4
         0veQ0awUaqENft9zvL3+1djL6HG913/yQfc2vBegitXBNc7YGol/yBJU+J2xEopfHctH
         VeF39qMTxNQGJMANgYi9C1ij4oxpCkgUmVZZzny7Vqi4JlqXRKQJYl2uWPdIGDEJ149E
         5v509VoZEknYlTBq76JtR61YVTYIWiOFPIQshvmnHVtx3NmuOmS48iJ16b5L9TM6V77f
         nfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919985; x=1791524785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7qWnqZ/ULb7fXma5Lz6AfQbunHQrKcMDH1ofdG/miuY=;
        b=scMcKe2+Ne4dQuRZjc9ELBfbjyigd+dub4CuCnSgu+zQSpmbopclmS1WgHzI+N7tBY
         52VSgFWKftih1cwT5sfbhStA+4tZ7ow9ma74q+PYvP3g+92v4NS2JR7w3VzeUk20gZ5n
         dfy5ij6b+qk0U3YGiuXSCUpnYwdX2cJvYg3pBBl9mpxSC89zwQ3R0VBuvKWK0UwWdAZW
         RFiil5RN2bfJSihDcjN+WRG+KOaktKLa3FWefx0MEZov65z4/j/+p76Tl7ftURwGyGoo
         ASLTebCWiuIm8ZavQJQ7naGf+wcS15uMUf9cWwecHxAiZR0y0BJ0OVumJwuYsl0j4rD8
         D1nQ==
X-Gm-Message-State: AFq9FYIcEJvis/di4I1Egp/8mUiAlSAEKiGVLzWefC3zEWWB4VKA5YU0
	x56jd+MYt6coLl8QaOL/BnwalR7gegGUt6ofYyixlZf6ARSJ0RZXzL4iD/ITddq4sJPkILLQEgz
	hDBL/bls=
X-Gm-Gg: AYBFou0m9hJROCRMWq7/0an8ispakgKqtYzCBTsVaJ4Ujmy7P7t5iFaIBxZCewaGtZA
	afalGG+tqFygAtKQfoyuA0UVIih8Wdv4Nom2TSQEjWzYlraSWS5Q9rYJWGXyyqu3eUs2GWdhvPE
	HXIsfBuaH+cEkZ73w6q4TzDXUb3l0gGcvZD70WiK5nXlTPOKu6ZzRRKuYl4xuJIXr2VcZYRR0H1
	sG1bYgWM0Nsc49E8X5baY+VoIWsXaDDEgLBUw2e23H48Q9p9GcE7Jn2cziVWN+ldaDYDXMKvu+Z
	GbHi3nkDIYuxNwV5zR20/9rMZLXrFUwo37AxOzRSdlloYoDWhk3x459M/ikLd21BigEM+hAm85r
	peNky0+R8dWoSkusIsUITOv1YhKDljdHrhRV8Xxn/F3p+KAiferrhvRB56hdGec990WCZbDcceH
	h7gBkXuLke6AaEYdoxX2Xy0h/A61XPRxe4la+bznlE0pGD1SCPHC2oiz6yGhdWY79wvxPd+xg3/
	FBrOiJYux4mtuHAkIxoM4T/y1au+u8GwgdoFYP6o4v2RHlL05KD+n2/dO2mCFHe8ZeRE6bqIEsS
	knaAFeSdEtVUbzhHLbXj3JkDSUe+ObwUA4vr7Fxf
X-Received: by 2002:a05:7300:50e9:b0:341:fcbb:abfc with SMTP id 5a478bee46e88-34f219c4297mr1976610eec.37.1790919984941;
        Thu, 01 Oct 2026 22:46:24 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:24 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 2/6] org.bluez.Bearer: Add Connectable property
Date: Thu,  1 Oct 2026 22:46:13 -0700
Message-ID: <20261002054618.30994-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds Connectable property to org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1, so it is possible to tell which bearer of a
dual-mode device accepts connections, since Device1.Connectable is
always true for them as BREDR is always considered connectable.
---
 doc/org.bluez.Bearer.BREDR.rst |  6 ++++++
 doc/org.bluez.Bearer.LE.rst    | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/doc/org.bluez.Bearer.BREDR.rst b/doc/org.bluez.Bearer.BREDR.rst
index 7794907..a1477a2 100644
--- a/doc/org.bluez.Bearer.BREDR.rst
+++ b/doc/org.bluez.Bearer.BREDR.rst
@@ -141,3 +141,9 @@ boolean Connected [readonly, experimental]
 Indicates if the remote device is currently connected to BREDR bearer.
 
 A PropertiesChanged signal indicate changes to this status.
+
+boolean Connectable [readonly, experimental]
+````````````````````````````````````````````
+
+Indicates if the remote device accepts connections on BREDR bearer. BREDR
+devices are always considered connectable.
diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index a465775..ec92a5c 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -141,3 +141,15 @@ boolean Connected [readonly, experimental]
 Indicates if the remote device is currently connected to LE bearer.
 
 A PropertiesChanged signal indicate changes to this status.
+
+boolean Connectable [readonly, optional, experimental]
+``````````````````````````````````````````````````````
+
+Indicates if the remote device accepts connections on LE bearer, based on the
+most recent advertising report. It is false when the last advertising report
+was non-connectable, e.g. ADV_NONCONN_IND or ADV_SCAN_IND.
+
+The property is only present once the device has been discovered or connected
+over LE bearer.
+
+A PropertiesChanged signal indicate changes to this status.
-- 
2.54.0 (Apple Git-157)

