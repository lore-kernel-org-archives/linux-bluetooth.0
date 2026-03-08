Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70894370D62
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974107; cv=none; b=HrcZXTflzFxSA4uzSqkfD3mloFedu1FC1NMFpO4hghKxO5V+DO+zDhE5A1MvIcGyp9qauIlv4/WWq70xrEQH1DR4EY1nYaZF/4C/9xXQpFPlWlV/fneusthc7BQU9/y2Mq2gHFrMOwm9pMg0xWErP/XKuOcRlvB1jtKepqmpMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974107; c=relaxed/simple;
	bh=1eUJeYG0CVB+h6Yf3pErieNNFEG42C60JJADElcMeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obDiG9LF1Wasp4qeaAA+csAJIGTea0Ru6gXVFL5MdJ4BkRgm22JjCnIyy45D/UGtiLk9qQyEPV2wi+qbnfqJfA08pPQoyclUEdPKM6Q0viRRWx07N0Ad5U0ymu+6QcFuXZ7PwAZQXe0jqS+ygONm/zL0gA8uy6Y9sFg4uR/+Vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=QmIN7eLL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="QmIN7eLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974103; x=1773578903; i=martinbts@gmx.net;
	bh=MDk0CEx99dnMaEwnBFA/ZNjp/u2aD5G4Bi9vq2Zf+u4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QmIN7eLLY8ARwo+ZSwGB1cNm6JZ+5OdxEt/hIvPTDBVq45sFTRGQgFjytmL50rzM
	 LgCOB07F89EIVtwWxN8wnF47Vz1Dy2mZCmCsRTw7c0G3fVU6IFmk3UAwc4bROw2lx
	 BWfqhRzr3b05rNcHcZyjElnZ32PcjBouqLkmc8Em3HkdMoDbWh/yWSo9GF5ff/Tvz
	 rd5i3Std8IQYHfcKCiq1PG+XOq5mXbJ6mPqJIdHBhw/T1O0g5ecUVqW7F/WOF6vYK
	 9UXY9X4EDLw4ahfubYiT3hkmhWW8YfUXSpN0VvbNT5HkJBTYovyJDCIfPxu+KgwhC
	 6OzIhDwVOmOVa95LVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1vKbwo3rKW-00gCyX; Sun, 08
 Mar 2026 13:48:23 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 5/6] dbus-common: Add Gaming appearance class (0x2a)
Date: Sun,  8 Mar 2026 13:47:42 +0100
Message-ID: <20260308124745.19248-6-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n0+suxDZpry162JXdMeYQEMhE4yFbDU7ejowwhJyLsXpQscD5hv
 RbEAgIYF0CQDqRadHexh9dZ/xUEqhzKZWT8bd9khfy9yJCip6o3qWqVkgmdAEMWoyarJnHV
 W4NOBx4Hys5YU6pOnrZFOlH2ssGE8uLWp5U/AHJJsLCPjw11uQNFCBajLyRpZwJc/h/xZwd
 7C5T/2HZ1STjJ2AJYEjYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:freltJ8P3u8=;SA1LHc60Tu+HW9DLCNYDytIHXgE
 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
 g3+XZL32mtNoGuinSmYanMQGaGLNzNij0Yn8QX

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

