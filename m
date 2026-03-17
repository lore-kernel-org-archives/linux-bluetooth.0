Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906E37C0F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779231; cv=none; b=UxVe378aQiKx3RL4GquvsA37OAWkZOuu3H+uk30++KSFtBFusKrA6F4ukmuT2UULmIAhT5LmLiW9BHSe33P3NU2mN4BZzBVQFUhGi11e+68S+GJT7kLkQfeP1/GhXRWCwG4a0XP0Ug++PdELFJREZ7bLWc36M8Y6GypzWPkYb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779231; c=relaxed/simple;
	bh=1eUJeYG0CVB+h6Yf3pErieNNFEG42C60JJADElcMeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsRo4EfTxv7kU8MgqZw02B6SQerROdVU/OEBgHKKjfISKYxy9+MvfwTIplfs0zk9mOYq8JVYH46QrIw8veMpB4bg2co48dBIU3IdeT9FtjuAocQCOY3Xm6+XXg3enBpMhTvRbRud4kyG57W1rPpfRGlNoREwftvNgUCFXyhTUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=GdVIpUA0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="GdVIpUA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779226; x=1774384026; i=martinbts@gmx.net;
	bh=MDk0CEx99dnMaEwnBFA/ZNjp/u2aD5G4Bi9vq2Zf+u4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GdVIpUA0FHPzQ3iB3hsxZX5P08ySG1x8HNsE6T+BK581mNxxYMwGBYQJ5gaAlQSc
	 zjbnfg4BmgYxsOcY75mC6T3J6sG9Ji7bN7m8jl60Gt/TBmDy4/9A1GUxO2vzgj/CK
	 IiGOAvxVarsnQXMWLlGZEy8bYUsI4lZXrPvxzaSypbMCGv1QCS5qk91/b+F1BPqIS
	 kNL2j8FZdPLxDV8KUllNnmRUwXAgMMigdukRHbRIRB3ndAJuH/pD8NLGDyGdIToGc
	 GXNVN0kuKcNq0QfiCbJlzxC8AbDr3URncFbkO/zreVoZpxBONuM7j6ZcRw2OsAZT9
	 s8aPgCVuj471DQ9XmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1vsvyA3iIx-008kHP; Tue, 17
 Mar 2026 21:27:06 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 4/6] dbus-common: Add Gaming appearance class (0x2a)
Date: Tue, 17 Mar 2026 21:26:30 +0100
Message-ID: <20260317202637.158997-5-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZhSu6o7pq8ch6SnceojqRiRXvnvnwEkOzgioFyB2a5jLc4Kphs
 JDIfu+LLYnyV8WVwmWzcJu0sBbAUALiTgldfNTI68Vj030rWhZuf3p6dftRcRRXjCVtC3Gp
 /YbuRImwbslH7JfbK3quWxqtGJSUTriC08peRrQnEnu8qHNd8kXMzD8xDTlHek0Tq8CNM01
 VTBvvzx8hz/gk1vr2tNDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FfmLeTosSQE=;U2FOrsHb3QwLO2UpSlfr42J4Bpq
 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

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.
=2D--
 src/dbus-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..42539116a 100644
=2D-- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -144,6 +144,8 @@ const char *gap_appearance_to_icon(uint16_t appearance=
)
 			return "scanner";
 		}
 		break;
+	case 0x2a: /* Gaming =E2=80=94 Assigned Numbers, section 2.6.2 */
+		return "input-gaming";
 	}
=20
 	return NULL;
=2D-=20
2.47.3

