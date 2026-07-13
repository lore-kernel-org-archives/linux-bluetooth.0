Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C576433E6F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950649; cv=pass; b=tqaGWvKA/mJRJ1hgFUcskHvM0SDqX9nRlbF+Ayf87TScBtDmtg0T1x3E+HWqMjDxTgzeZ71eD1FgpbqqkkgZN0j8zSdrXJtlD4DlBY75otPa/Nsr9ze1d8ecJvPHHNHlY2t7EXue3hfVeCy2qr6klJlpcCEHSuLQQqMKwoSkoDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950649; c=relaxed/simple;
	bh=ULADuKsy+b/cW224tCLvO3Aq7IEhtZV39F3O83cbF8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdHq5kW8lmdYwa6V9s1JMTh3rmC9L0iuBgr1ut6Gg+or+sa8fMO7jFPETXGC3m5azRhE51MCbuvLg12G6w9qo1F4tUZXyrKhRB+QuaS09pQLrqeB/VMtd9lMg4D0pCcG6dM3LfI/lFAyo6FCC2icx9OdYGuTgrpc2rpLdPJN+HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CAXlT6wc; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CAXlT6wc"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzP351P2Qz49Q5P;
	Mon, 13 Jul 2026 16:50:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783950641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av8RzP0XBKu82XjAx7VPZQa92ZnZS4Q3dTFMHnswQMM=;
	b=CAXlT6wcT6fXgIJiFMMbzOVt7X9NDLJpWP1u6sTTXXWgbGILIrAkqMEzg7CyWL0+IcenUw
	Z8cZN2tXufFimxx/vPiEOCd1/0swWdokTowjdR/eWJ/dQlsdy3Bp4iqIDT2+Z5TxRa7qwF
	VF0CQWydan6Xc2BCAjA2geQOdBSFVwS1zXiOzgZA2cDE2FYWvA1DxxXoqpCgk5FVecRb8f
	U5CjFULvvv+yC60rsE9wONg4cQAicjxj+Pe0k+0lGF0Om8KzWSw5rQzxNa/0N8mN1yYiHM
	5qRbo7esf1K0ojIPJIHlwJxwbBYW1Z7Ne85Sdj4eN3ZrYCB16erBQfHi9uxRGA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783950641;
	b=Z2BP4zi7iHGHoDnkRYdA+6qYfWj9aoP4z5UNBjhaSOvPtcEbYU22oxMtZB1BLc1l7LNqIq
	szZ8f5FO5rYqPuE6C+i/UoJYGbLgdkiwzpueKpmQTtzW/nfakQq2QE/qk6wJrv6pRVATHG
	D+yfRc4yAsYeoYSoyLH4wdGHMffkmc8oYqldBgskjDLvXIatN1IkUianMq49Feimpshugy
	7tG/IRoqjUyoqV1F4P+UKytwPNHczy7OMZ93pcNBzqvTEyld2PRkQDBTWA3Wj+z+/9tBh3
	VMj+PRiMv3MKUmLXOzNzVn9V5mY407JBNwwhx0od6tIV3ssrFTXpph2F6iFLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783950641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av8RzP0XBKu82XjAx7VPZQa92ZnZS4Q3dTFMHnswQMM=;
	b=cVVo0x0x8yP7Vk0Ouke3NQ2qDx8yBnkNPFWrFWMDlWNFQh5ewxjZ3izWohjdI1AWdQjLkC
	Ms8hpNiQrktUkl730GlsrWk39sk/EQ6Z+4o49h9uTN2s0EGu2Br0MMWzC7sT6F58IdfHHz
	TdyqPN1ZiZf2qqNcPSBhtTeSDXYCXVrxRrJPABsOWXkVWj4lAfHtq4YXV53LfGsT4fx5be
	5U81dmV7yaKjgwSzpuxDkRxQOu/TC1AZ6dbe4X5kcOmQgWebYUPKhEnthFltK/WA77FsFG
	LHqZEFWQS8YXgnpG+/mZRcJc+JgxZiyGyXwTq1BoIamj/hpQzqvshVJeQeX1Kw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] tools/l2cap-tester: fix Set PHY test spurious failures
Date: Mon, 13 Jul 2026 16:50:26 +0300
Message-ID: <0dea13356b8fd5c9594689ceb628bc187ead2753.1783950503.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
References: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting BT_PHY does not take effect instantaneously as kernel waits for
controller, so checking getsockopt() sometimes fails here. In PHY tests,
use retry with timeout to check again later.
---
 tools/l2cap-tester.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a8cac3902..2771aee65 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -277,7 +277,7 @@ static void test_data_free(void *test_data)
 #define test_l2cap(name, type, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = calloc(1, sizeof(struct test_data)); \
 		if (!user) \
 			break; \
 		user->hciemu_type = type; \
@@ -1657,8 +1657,10 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 		tester_print("err %d != %d expected_err", -err,
 						l2data->expect_err);
 		tester_test_failed();
-	} else
+	} else if (!data->step)
 		tester_test_passed();
+	else
+		tester_test_failed();
 
 	return FALSE;
 }
@@ -1729,12 +1731,13 @@ static gboolean check_phy(gpointer args)
 	}
 
 	if (l2data->phy && l2data->phy != data->phys) {
-		tester_warn("phy 0x%08x != 0x%08x", l2data->phy, data->phys);
-		tester_test_failed();
-		goto done;
+		tester_print("phy 0x%08x != 0x%08x", l2data->phy, data->phys);
+
+		/* Retry */
+		return TRUE;
 	}
 
-	tester_test_passed();
+	data->step--;
 
 done:
 	shutdown(sk, SHUT_WR);
@@ -1770,7 +1773,8 @@ static int check_phys(struct test_data *data, int sk)
 		}
 
 		/* Wait for the PHY to change */
-		g_idle_add(check_phy, INT_TO_PTR(sk));
+		data->step++;
+		g_timeout_add(50, check_phy, INT_TO_PTR(sk));
 
 		return -EINPROGRESS;
 	}
-- 
2.55.0

