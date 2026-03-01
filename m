Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E331222
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378982; cv=none; b=p9OBWfkbe7eWWRbqBF2zmLU627g9MopI0HTsDhpKpRts26vwBcuAiOwtOilrverm+3pshFaxsJkRv8B2tZ/neROtxaJ1Rf0jtKaSk/KvpNHNfRyLnS2HvKZLXBHUj+3LOMbiIF5JfJKFu7VIL5JbVlLZEaZd/KqMPoMCbSEHpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378982; c=relaxed/simple;
	bh=uA8auxPeNhKrDmasUoVQHx/zBEauX9UJxRpQkgHkxxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/edC9wF4uJqsubXDJy+c/IR1ufLXRvYRNaQFejX/wYIj0sHq6B3MJdwI7lmC0Fzted9FKxcOcQcOSStSByEPd4YHn+ZhrfaEG7c9o2yi6/4+jFxAai2IrmhDWz9ALHzZKoNON/SGmVQ03lMXueridtrvoOkbvm3dJNVqEyDR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=Pyg+IdHO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="Pyg+IdHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378978; x=1772983778; i=martinbts@gmx.net;
	bh=aVh1J7kcE3OFLVSZ09JnEvyjoBGa60VwYrJZ9jWLqaQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pyg+IdHO9jZVlsFnE2zrHcWibnH/MercOcv0XX0p4ue85OQq/D9cgJ0BRgC9guex
	 Xu8+XL3z+ymMhScGLX/Y8eMV0vIMmhdD1L2y+hFJ/sBNoa4/JalJ8qSk7nYH0RTco
	 FHkfkNkxchi4JYWqlVZlQGc/tb6JB2OnRn1+HQBrsPbeh43BzcMq0bbvqYoxvAt3/
	 3QBvVJ1LEjHMwdskskJgwvPnv0UYa8usNx3y8qyPl/HhI13YC/djKptli1nJ65JKS
	 ZtshCkR2h9tQbtnuXAQTu/QFWKOerV3Lk72YzEny1c7aNmomVqVcA5S5PnshDBr+A
	 SdeQu42ihvPNw7Q6nQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1w6a4s2liO-00OKXP; Sun, 01
 Mar 2026 16:29:38 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 4/5] dbus-common: Add Gaming appearance class (0x2a)
Date: Sun,  1 Mar 2026 16:29:29 +0100
Message-ID: <20260301152930.221472-5-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301152930.221472-1-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SkPAv3nf7qG0NhWw0hXB4vIJCROeojGHKKvwJrISdcVulqlpiC
 dKic3dRnBOAL4t/2GZWKAYWQVC4tOnAfOGx9bCXRGqDnD24OchqU7JKZwn/mM4SXdODjxll
 EBdzDcMjVQTSeylEGiZrIB91o6WrBMpxZurwc7HqKnO/YW+pjnAIbl84dZVud9D85PLPCt6
 pJ+od32ffUuytWSFPpGkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rThb6oiAAOI=;J5BiMDl9NWTWDrxSl+5Gwcciqa6
 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
 b5dUJwGIpfgT+gIz0=

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.
=2D--
 src/dbus-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..04d8a21c4 100644
=2D-- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -144,6 +144,8 @@ const char *gap_appearance_to_icon(uint16_t appearance=
)
 			return "scanner";
 		}
 		break;
+	case 0x2a: /* Gaming (BT 5.0+): generic, handheld console, controller */
+		return "input-gaming";
 	}
=20
 	return NULL;
=2D-=20
2.47.3

