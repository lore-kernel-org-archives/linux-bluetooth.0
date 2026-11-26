Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675695;
	b=3GBgNT4WHKdjIxY6JBddx/80ghw+UKJFrbk7/48A1+x8iSsJX8uALogLYwSCluggT8Hr
	 +3nLQsE/8vq61SUigyxxzqE/7vdQ54tSw7w1VJEDXf8FGNxsaCvtr1btpzZ1USl6zizcV
	 oeFF/bXyP0e6T62i80uZFdQfAV/92AdEC1kjQbqU9xqYoPiwK2iLbACIZfkW61hyoFWEh
	 eaO+63wOhzFlG79StC8xK59KiHZyAgGNO1UEasExdeNAbBZgAltQS3MohGY3m6xEym/QA
	 KYj+SJEaoNZvhkArUCHpjf4Zus5wOUvNwCUWp6EVN49kayFW20EynFAPs0okr/BKvGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675695;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jomht0ZwIA00EnoMqIhdiZT52fKUzUkgHp2390iWoPY=;
	b=cFAf8KMMkjodp9XfIRbqOCNgMDSpTie0wit/G4e8fMXFXKSR4ujcCtvicwie5AV+99SM
	 EwIvtwertsziFFGD1Mw/UPT5cnfvmCDPN6LMyWzO2QG90ZdWxy0/JmztL2ph37YI25jRe
	 Ms7x4eIwJZ/u0GNWFHyt2rP+mxXcOIxHK0EVNWineI+3WtlMRN3F2/y2PnVEahiWakJaE
	 5LGCjZ2ueogImPvjnOvLmZfqc2abVgEcHLaJBnemzRCALXEE4Ik06vGkZgw1OFabB/k0y
	 mfzk5EXoWiUO/PojRIQ3QYiuAjho9hpO3en/QX1Rk7NmwRyTL60iVL889MZlUA4DEfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=R0cMTq3P;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B6606A69C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 193B6606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=R0cMTq3P
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B75473FE2D
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795675690;
	bh=Jomht0ZwIA00EnoMqIhdiZT52fKUzUkgHp2390iWoPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=R0cMTq3PdZ9gB69ucYurfhqyJ41+U9XaRZeNtMZAzPNCY/13F+BEBe3CE1mSOR3Hr
	 LeNdaOrqwQ0gK5Xj8f4NVNn5FN9b6BUgi9JV/Mx9FcbPN2PpTQQGOuj6uR637GTPvz
	 iM77K7s07WM9DPCf/99Y7dDcJs7TddFqrFp89qM0I7pd0SYatUZietX4nVWElUankx
	 eD+5/tfcl/ni2609AEgMm3ma545SumRe5ww0ilwiIPQKyRJUqax9cTNk4NXA3fL6zt
	 5RvVPwpVBr+VzaAm2jScx1eBdEiXZ86F7FFvmN4kFNbDtS5ePg39E8hXqd73F8xKzn
	 KjKu4NJagfoufW/Y/0dhIbJGXFO6xGXq74GuJtacu5RaRAsvU3+t1DlSP/jqVSLt9k
	 NL6kwn6ONtQNai98KOmVysSVz1Lx8REnmjGo3CWOR3sAiJa40NtlmObMgEtv688lHz
	 Rn5pMNVc00HuCJ+ZvuXh2vaFBjOp4i0yuc1nw/EQgzmBILAbYruIr7PDYd9EwZFooD
	 vPbKVVpa+K4hHrf4vgyOITt6IKbYAfKI2tj8vaxB89hfvs9tD/bA+onvcolMmGt38z
	 05/Uk6289DObHoU6uYJ66mcKsEXNrb5rADi2GC4f0cgmg7GSgqOBWGhS6AH9+8YPhD
	 WAexZF4nDmo76K9/aJKQ+rII=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b41b099809so5750148a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 22:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675689; x=1796280489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jomht0ZwIA00EnoMqIhdiZT52fKUzUkgHp2390iWoPY=;
        b=bbI5TY2ulfwOjTxaHkeDPoy/dHvy0hh7jh94I4AdOGL7pGpLPN4DHyhWkQVM8Io+Xd
         7nVJws4DKX6sj4DJla35wcx+OvIUiSVUBpPYh8sA0yWeobuEB2zxSaGL1PFNkpM20DiP
         T/KLXC38tzq1DlcEQQIrrpA/OJMM9hm7yroqs9bXawjTFNLQ2yO/9Z83lad193dQDTyW
         itXgB0O0T4lMqnfLxX5YiqH720z2EX9Rq8thgFqiH4IMYotCeHRJKgw6MkwmGzBqH8bL
         Pq0c/8KDC1zaZ0mpfill6uzHKTAXqAOl/pYnY8G5XSr15JZGsUbIvDPH0IaV4IsYNgV3
         Q1zw==
X-Gm-Message-State: APuU4Z/9aitn+1chi2n9vOWXwiU4oetDZQufKFXjm04p+/+fbu8oNYYR
	lMpaA32oghtdJLx7qD6RnBZH+K9vpSqCg/RChc6Rp77racqWgrx8am3FONzNyn1o3Q1q2YpMlBq
	MW7m6BpkM4AXpMSzDn6xHdIGH9axggdgxjX8R3yHm7l79cMMrC1iW+Xbu9SoZMTk6aVqbxE6BRd
	ts090xj0TshEzaztWvbT5R
X-Gm-Gg: AZFdTZdpX8ERbSrQ2eGu4lVmlykHlEaOX6gtfCQHh0dBV8Roq83RB/k4it1iuEOd33d
	9mvCMr4gYNGVXcYRpHrz5kkM5J97ERjFPQ3t00jrwH8NkBO0JLId2e8B9jslwNzmLiYFln7VipW
	9TsklEqkDb1agDbCLzgxqP4hNnJFbMeKvuCAQzX0gYv5cKWTR4kKvEvZTDVJAQK93dahrHGrK1r
	q0tNkePqJnhitaFm+CI+mc8YrT2fgmvFch7IHVqd8BPVpSyXZ1NJTXRO/qO7TPh4MNGfHAJS+56
	X6vgzzv/YguLLk9gVDTDPIIR9AfzYyPIvrQy0x3zOXu+ykuxLAMomLVstBYlx9biRNT7JKhBNHv
	dYMxOgSx7sHUL+O8hmAIVJ4fJvke0X/D+KNM+NEcMGJ81asYY0R1gXpgNgR8/tPmtx/0xhBWvH4
	af917OX/CP7bqfJqY3Q+VVvyRKVYq6JCaAcg==
X-Received: by 2002:a17:90b:2f8c:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b41c92c175mr18037850a91.26.1795675689219;
        Wed, 25 Nov 2026 22:48:09 -0800 (PST)
X-Received: by 2002:a17:90b:2f8c:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b41c92c175mr18037840a91.26.1795675688839;
        Wed, 25 Nov 2026 22:48:08 -0800 (PST)
Received: from kchsieh-C1-X14-laptop (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm13787468a91.0.2026.11.25.22.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:48:08 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net
Subject: [PATCH BlueZ v2 1/3] mpris-proxy: Fix possible crash
Date: Thu, 26 Nov 2026 14:47:57 +0800
Message-ID: <20261126064759.95429-2-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
References: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
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

From: Bastien Nocera <hadess@hadess.net>

find_player_by_obex() doesn't check whether session->obex is a valid
pointer before dereferecing it, but all code paths that assign it use
create_obex_session() to assign it, a function that can fail.

Check whether session->obex is null before dereferencing it.

 #0 find_player_by_obex at tools/mpris-proxy.c:2819
 #1 obex_property_changed at tools/mpris-proxy.c:2929
 #2 add_property at gdbus/client.c:373
 #3 update_properties at gdbus/client.c:399
 #5 properties_changed at gdbus/client.c:537
 #6 signal_filter at gdbus/watch.c:416
 #7 message_filter at gdbus/watch.c:566
 #10 message_dispatch at gdbus/mainloop.c:59
 #13 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
 #14 g_main_context_iterate_unlocked at ../glib/gmain.c:4516

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2466640
Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 tools/mpris-proxy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e06b9ea3e..79cd52706 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2816,8 +2816,12 @@ static struct player *find_player_by_obex(const char *path)
 	for (l = players; l; l = l->next) {
 		struct player *player = l->data;
 		struct obex_session *session = player->obex;
-		const char *obex_path = g_dbus_proxy_get_path(session->obex);
+		const char *obex_path = NULL;
 
+		if (session == NULL)
+			continue;
+
+		obex_path = g_dbus_proxy_get_path(session->obex);
 		if (g_str_has_prefix(path, obex_path))
 			return player;
 	}
-- 
2.53.0

