Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA11222577
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679061; cv=pass; b=sMlvWIZf6Jp/ZPVNI32UtHPfJizh5krYdzKgzWvENpa1s0/w2T7l+n6JEECSXle79tfrL0kpGc0moIVhmR8oQ1JlEWSbngHowquESHe9UbWCHIkWuBkJ6p9vg5y6VkVsiL8EY929j5M6QJCGtMHitGjYn88HmaUDSl4ki88ochk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679061; c=relaxed/simple;
	bh=HSm58GNmOaM1n1ORMxneqNLmh0TWEDWEpX8YrzeessA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgjFG/D94UWdvla5rMfcPYjr35iOlbklbC8FTmNT4w7sB/MUYXQRJdXqbqmUpat5/TBpjZ436Vx/ZeK2tWv2N879YMvMuO9PThmwVBFISNuMX0sX4SN7U1Q0Q93Y/33KPReQ+rPQW+D1Cb2j24t/CxhL96g5qE9t76OSsekLeKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nV/Zav/G; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nV/Zav/G"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzCly3jYJz49QFd;
	Fri,  8 Aug 2025 21:50:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhbtBlfhQf+slAGlz1Dci4B82eKrvIkvHSOq4fbkvPg=;
	b=nV/Zav/GTXb2UC9rRids4TsUHq+x/F6436uZYWScDiiGWczVSHRGB1UoQBA1AGxbC7oVjg
	RllQFfyITRxjeBPLjaLkgSPcWMFi0sCO5Dzm0nuOdUebEidw0q7j6nPbai7okty2n806CR
	OK+AZh0P/PTOmc1RNSoIkuZLm789a9LWik1X/S+kms9aSLdEzZ1fPeQvaklI+alLd6Jy/8
	gb5qZVBJd6x99LftyscscjOFN72apWdF1blrewYfVrIUfepy1d4a04mw4Q9WdGMQfdFw3n
	rdqzMnOdg9qgenUTaR5mcSkbS+LGbX+F5trhW8f2ZJ6X+a1HlojXOfKhOZBXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhbtBlfhQf+slAGlz1Dci4B82eKrvIkvHSOq4fbkvPg=;
	b=V5U+AwWrCVFWdm2viHC67yGUvKW0+dR1InqP+dvPI4mOflbhyzULMP/8/a0t5EZ1OI68wQ
	mEQxJvFRSCK6do+tKoxQ7AlENwobF1EyNGryF/Y6tN1kfWrOawkezn2k++AueEl297kr0p
	Pmm0S13hUVSkqdQPSrNu78IJN8mL8GinzG/HHq4rZm/wE0g/HmrptOcVs0IiVx2CHi7wK/
	970akwJel0CR/RwsEFkTSKtcG+xlsyc6PVIq4i0ZLRGUgg6KiRaGppvi1mEsdC22ueoMvF
	Tb485MbouFiDpKwWMjBP2a/lWzQY3xDtnrAEqJwafRkuOqDY+d/4RBfCzpCCiQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679054; a=rsa-sha256;
	cv=none;
	b=Dq2E/rbg1CxKXjlnZ21zBE9WUSgGJNMowX39J6ysUCvwCTGNimFGTK+8PEyG2sAjKx5GXX
	5NM53o1MrbVITCgLRRGfGNgi6PkrcAk/8FTlx2LVKvbH5o1zrVvA/h1FHYfm/jcovRGu/X
	Zhl55b9a9+HGy2Rsu7kNW25LqFYJnnHGW7k1kXhPcjuBiVgDPWeTNQmUpUtc9GRzJV2I2V
	Mxic/iEEv+QNUuEUcGXsuDxXt4Q6V5jPPw8nEZCL7A/X6meQ8faYOZHrUcU2p1wHoyx3++
	GbAS5a0hZXwxErPyx6BAV00kl49Au9FHtu9lnYqOJymsq7GWsU24VVRI8XW+ag==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 7/7] shared/bap: check ASE state in find_ep_ucast
Date: Fri,  8 Aug 2025 21:50:39 +0300
Message-ID: <c97c2ccf18f493a390dc656210e653e68069accc.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASE may be in non-configurable state also if it has no associated
stream, eg. as a result of failed stream teardown or other misbehavior.
Check also ASE state when selecting a "free" one.

Fixes wrongly picking ASE that is not IDLE/CONFIG/QOS and cannot be
configured.
---
 src/shared/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c27e675ff..ed5c322b4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6224,6 +6224,15 @@ static bool find_ep_ucast(const void *data, const void *user_data)
 		}
 	}
 
+	switch (ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+	case BT_ASCS_ASE_STATE_CONFIG:
+	case BT_ASCS_ASE_STATE_QOS:
+		break;
+	default:
+		return false;
+	}
+
 	if (ep->dir != match->rpac->type)
 		return false;
 
-- 
2.50.1

