Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB451C69D
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727582; cv=none; b=ElSpMIIXYoBL1ivGD5ohxWIvZZd4j8fkFsvx+Nwh9xNSM/Kd80sNmYMPmpCLSZDoB7dRzf4B/rdxhb6PljSptdLYHx09KljcUh0j7t2ajTUp2QQpbZrUM4NhMfNo5l/3ljXCgQ+VzIyRxxmAv9E5lWmsZQT54lk1/9Ly2z1H6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727582; c=relaxed/simple;
	bh=LTtuVu126tJcpZXX5K1tu+w27gjJJ8u4pGbVKNR6/3E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KJoeDuvKHe8VowRyr8RrYNvaFCYBLLlr5CQ9900w4I4GWELePHbeswgaCX8gQnXKvTVvrjkRd5OX/ELEJKDMdn03yBoz96IPTmxcbmTuXgbLfEIyBpBQ9AcV0RmHHgce9SeHEdeE66ieFATeWGn5wGSLCM7oqLE7jRasl8kV3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSpwh17A; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSpwh17A"
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-dff305df675so2966035276.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727580; x=1719332380; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LTtuVu126tJcpZXX5K1tu+w27gjJJ8u4pGbVKNR6/3E=;
        b=TSpwh17ASR9QQFtMdH8UF5q+Toh782P7P/GJgSBNRxw1MOM1Dz75SjHPkbr8zLPlL7
         hRuHRmWxhN1LadfzfYY8dDZJgbFiBSvntdnGDQLob13jkZtC9P3p7fPCBT6rRhZUgI7g
         +z3BKPgL7v+8CCNfx8iUMlA3baEq6fI7oV5nsBF3Inha+L2/LypuDkoTeSak3IgRq8hd
         xfALm1PaHSPrRy+nhsDEcCcnMJkH8WGqpcwNQk7Xb3q7QWPj4+EfPhP4504enoyM/lsj
         nhPM7HjfiyuQHBeS9sWyavdZ77sEmdOQ/h/8XchTP5cWWFbthiVY62vBPOdzZECx/R9b
         pLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727580; x=1719332380;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTtuVu126tJcpZXX5K1tu+w27gjJJ8u4pGbVKNR6/3E=;
        b=EJsiqtRvOFzaqsntmNp1Gf2itvAdFxG/3QnTm29zK6QIFvxa9qzgbL1GMitGcV5/cW
         fckFWm9TNcp0hfoJArJjs4zceGCiLZd3/ZD22f40BHje/DzIZoanxrNLgEEKer1/u7/U
         ibmX1mG6pTApuzC2jVQhdaFKiHOilYbimF42BZUkX0B6D1zOPwOobg3in6OovETNbCtP
         4T5HzwbCV9InP97wp6FEYcOzFR1FAeLHT45IckPVx1It+9lgAzylZFJ6UaA/YnW6EhgP
         DCtt/KEMUNfdJ3KJkIK+HdSxxGgJ+mkGU3BPuWuDCybPAUt5qSJNQ1p9nEr5Qeee++jR
         Es+g==
X-Gm-Message-State: AOJu0YyhY1boja9KSCLt5dCes5uQg4UXw45K6r7gm7kuUX9Su1KGLTPh
	OnD3yPHiOP09LJfxdDsTpgkDGIULN8Jic+rbgTv48/FyIpvkr5s0hZxQOc2/OQ0XN3H3EK1zPnG
	BLv1idjS1MT5L00tu7ExG9Tgx9nGBv1E6bGZqaA==
X-Google-Smtp-Source: AGHT+IGhNie95/AwtknhQOc4pj0GLux2P1+cc2jat1XTgfzA0aK5Mde4NQSjIw25x2ER4tVjjQHU+jJxu9v1qW6km2U=
X-Received: by 2002:a25:6990:0:b0:e02:bac8:427 with SMTP id
 3f1490d57ef6-e02be23029dmr402405276.56.1718727580135; Tue, 18 Jun 2024
 09:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Solegaiter <meartzheast877@gmail.com>
Date: Tue, 18 Jun 2024 18:19:28 +0200
Message-ID: <CAFSktxaxM1KFViQUpr6SQV54=MpdPWOZpb41vTRk1UHtLfv9fw@mail.gmail.com>
Subject: Patch
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e151f5061b2c7260"

--000000000000e151f5061b2c7260
Content-Type: multipart/alternative; boundary="000000000000e151f2061b2c725e"

--000000000000e151f2061b2c725e
Content-Type: text/plain; charset="UTF-8"

This patches a bug that made it impossible to compile on gentoo musl.

--000000000000e151f2061b2c725e
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This patches a bug that made it impossible to compile on gentoo musl.<br><br></div>

--000000000000e151f2061b2c725e--
--000000000000e151f5061b2c7260
Content-Type: text/x-patch; charset="US-ASCII"; name="parche.patch"
Content-Disposition: attachment; filename="parche.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxkm0f8r0>
X-Attachment-Id: f_lxkm0f8r0

ZGlmZiAtLWdpdCBhL2NsaWVudC9wbGF5ZXIuYyBiL2NsaWVudC9wbGF5ZXIuYwppbmRleCAyNWZk
ODM3Li40N2I1ZDBhIDEwMDY0NAotLS0gYS9jbGllbnQvcGxheWVyLmMKKysrIGIvY2xpZW50L3Bs
YXllci5jCkBAIC01MTQyLDcgKzUxNDIsNyBAQCBzdGF0aWMgdm9pZCBjbWRfc2VuZF90cmFuc3Bv
cnQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJCXN0cnVjdCBzb2NrYWRkcl9pc28gYWRkcjsK
IAkJCXNvY2tsZW5fdCBvcHRsZW47CiAKLQkJCWVyciA9IGdldHBlZXJuYW1lKHRyYW5zcG9ydC0+
c2ssICZhZGRyLCAmb3B0bGVuKTsKKwkJCWVyciA9IGdldHBlZXJuYW1lKHRyYW5zcG9ydC0+c2ss
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgJm9wdGxlbik7CiAJCQlpZiAoIWVycikgewogCQkJ
CWlmICghKGJhY21wKCZhZGRyLmlzb19iZGFkZHIsIEJEQUREUl9BTlkpKSkKIAkJCQkJZXJyID0g
dHJhbnNwb3J0X3NlbmQodHJhbnNwb3J0LCBmZCwK
--000000000000e151f5061b2c7260--
