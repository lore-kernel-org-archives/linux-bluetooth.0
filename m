Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119453;
	b=Q2akc/GczIRLvipFmpiRmr3udxpQwOBhr7qOsg04weqembGu+Xq3jhC9+bLwr4OaAwCA
	 ho9xeGXGW+/7+bDmFCVy6fY2bU8I++9i/HZYug7D9epiI/O3Lzmyv0buD5twYa2uX0Rbg
	 xnHebkm7p/DyEgxW1G+Gjgs1LqNkrug6H50Z1YWtRxVZLiE1DlHqLURzWXYZNW7bq6kFm
	 mA/Ho+agAD32yfaztXhekd23qWTiF+dk8kVietZTj6Wbxc9NGHsX1Lc13yzqmukvU17sV
	 BGnRZuoTVSsnqM2/1MKGed1IbS17A6R4V/wYliiXR+2ezKCzVofjcf99fJ5JgrFjUSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tQklWwazXuLl2h5900rhiisfIYkwsZXEN9+WIwcbPKc=;
	b=Qcgi96+QFkrPSTgiucZU5SO/pBaqV5K6/M+yKn2a4VlvRzMdHISDlZniewurnnRqpU59
	 XarILd2piwnuC53Xa/ISl2wNi9G1wdaR+6tJBD96aGUXRxfBpMIlevyzMvsUL4vtyPxXq
	 Z/PFObKcKuh4tk5zgH9Yt38zQtWmhvzMJ56gr1zcxz+OvMDVjPiGYjh+x+Y3Z+95XF9Dn
	 zJKHPnk0NR2s0Xx1V1Rrwkic7G+xhRhlAtj+qNblUo99KrpzumUhYwle7F0MF1JyAC+8L
	 XD0uUhxm907wcPUtqtnMSj8yNMhb+DIHVNGrACq5DmCy4rByfxgiXHbL83aLOAcXB7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZoLcb5sQ;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A719606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A719606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZoLcb5sQ
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so53971241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119452; x=1793724252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQklWwazXuLl2h5900rhiisfIYkwsZXEN9+WIwcbPKc=;
        b=ZoLcb5sQGhVeahlAy1/G0wMZelWsouH7kOs8hahp0B7EuJm1VNvEAY3JLJH0gD/qj4
         bSMFSLpzbcplDitHeSfueVJG6A39uekiknj2Ui07UsmdfzXP9OwlJSKFxnpnJiOLrMdB
         GLYqu2Su72HCedWMVxjLe60lVlLAfv739+AkipWhHCNkdTzwuXzH2GSA9WOd/w2Ch2Bc
         WjntYmTaY5ru98HYzeW/kJK1yiTvsxzJwrzay/kS3I9gadLbsNZSfUr0xGqJJ2qt1ins
         fiWFtL2ws4IhhhzhnKnoOhs45DmSfW7bwdzk24B+1NztsPqdStaRrFCj/6Kq7MPaCMON
         Uazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119452; x=1793724252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQklWwazXuLl2h5900rhiisfIYkwsZXEN9+WIwcbPKc=;
        b=aAn4XmuorRxZqnNPkt/vP+5Z/e4wK72FeZkq3IqYz/R6aKLIVYyLcpyA4a6y6JzovP
         zcQ17B7oJBSpbBzbEhWFksska0ZtH9duMysjgHdBimUBE1NZNZx0ir+ws02P5eJSFF52
         bdq1joIPIatyjtaZTyZ0rC1rfveY8IWyPHlVgQ7RjVceD8kSfjrXVCRzoOP238q9oGxS
         Qopmiy1xNlMXPS+Z5Ts62OiLc0JR+3omJuciGqjNpNp/Ng2tiWF1KlUnHgPQgt/wEG3x
         vF2bXitSAHWjkHHT+GAIy48Vrx0aXvDfAwDwtS6DDF67BJ/1q/QQOK0+GZHTmocs/eeW
         LVKg==
X-Gm-Message-State: AFq9FYKOgSyqTXdMKPb0BGTIizm7rveZWqGGvpPYbYNUwJ6UQMOJjn17
	rnDBr455jOqVeJk16RhsIu4JcHgOb0mwCWQwQOi8uVi4OqcmA271xR40
X-Gm-Gg: AYBFou1188NFNAr3cPLAPgVT1qautTcd8/KtoRlWQ7SSaL4mhBT60ibShekZxLYd7kB
	VqtNSq2SleqXa1iOm+xXtDm6dQ0Qfwd8ciKuVWnRd1hD/UJ/CDNupoymgqGUA4NCTLF4xZSfUnI
	qObOoCs5FBA3mE4KBmblmDDviNvdmerR106AB8BdDkjupJelhnzKNjYnIeqK/NbmkZu1kwYbsRh
	5uDRd9gnHEEdVbzzuw8TsDuM2rQMWCJvbbS83hl2Ed26OIEwZikiZikkLB5bLBKZXP8Z6MAcTcg
	2Mbe6EK22RyndtsxYqMY+WLIiECcU4Y0lvUo1CVvbEFtE0oCAOXJ4Xv3BLpGqke6rOVzUcqZaWW
	f+Mk40zB4rYYJ64SLplZ/dTXjwFmnKd6fZ9vyWCdCabTkYG73U8boPuvRV6NQ5Ub7n3EalbRg0E
	qvmLIBIWlp1tt2QLzGTUjbhtw+Q32M/zQRyK51b1qWmVPYp3UqzQCKKWQ5UjSCAO+i9FHBIAlWu
	P+Wa4aSYE0EywRimuYOBFmWiiLo0SjQPWKHKFUQTxCQQ1l3Aj0=
X-Received: by 2002:a05:6102:c46:b0:7cc:c7aa:106 with SMTP id ada2fe7eead31-7ce5cd91867mr3358935137.18.1793119452105;
        Tue, 27 Oct 2026 09:44:12 -0700 (PDT)
Received: from Notebook35 ([201.37.177.8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm3023920137.3.2026.10.27.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:44:11 -0700 (PDT)
From: Diego Francio <dfrancio@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add HCI_QUIRK_BROKEN_LL_PRIVACY
Date: Tue, 27 Oct 2026 13:43:58 -0300
Message-ID: <20261027164359.460369-2-dfrancio@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027164359.460369-1-dfrancio@gmail.com>
References: <20261027164359.460369-1-dfrancio@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some controllers set the LL Privacy bit in their LE features but their
firmware misbehaves once the resolving list is actually programmed.

Add a quirk that makes ll_privacy_capable() return false for such
controllers, so that the resolving list and the related commands are
never used, mirroring what le_coded_capable() does for
HCI_QUIRK_BROKEN_LE_CODED.

No functional change for controllers that do not set the quirk.

Signed-off-by: Diego Francio <dfrancio@gmail.com>
---
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1c992e8..3554abf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -375,6 +375,16 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 
+	/* When this quirk is set, the controller is not treated as LL Privacy
+	 * capable even though it claims to support it in its LE features, so
+	 * the resolving list is never used. This is required for controllers
+	 * whose firmware crashes (Hardware Error) when the resolving list is
+	 * programmed.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_LL_PRIVACY,
+
 	__HCI_NUM_QUIRKS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9d5d3ab..48fcfb2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2066,7 +2066,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
-#define ll_privacy_capable(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+#define ll_privacy_capable(dev) (((dev)->le_features[0] & HCI_LE_LL_PRIVACY) && \
+				 !hci_test_quirk((dev), \
+						 HCI_QUIRK_BROKEN_LL_PRIVACY))
 #define ll_privacy_enabled(dev) (le_enabled(dev) && ll_privacy_capable(dev))
 
 #define privacy_mode_capable(dev) (ll_privacy_capable(dev) && \
-- 
2.53.0

