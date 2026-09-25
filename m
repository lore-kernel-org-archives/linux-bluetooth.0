Received: from mail-qk2-f30.google.com (mail-qk2-f30.google.com [74.125.230.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EE40B0E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371872; cv=none; b=bNf6icD5to+PmEU3ghjCGgxQlbrKCcF5Gxfi1W2qD3Quu96S/ak1sibO6J7gbnE+r3LydpLrCEs7+dBtu5rEAyF4myXyaLOM++XmWEwr5qNmNHwHpZcEa7aJ/SCxR4HU5VqX6kcEgi1kgGjai/xpwGsc7yVMa+e4b0R1TWrD/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371872; c=relaxed/simple;
	bh=9a1iBbnQuiawLW6UiWMbLTkBxzDRxKk5vPD8i4UeP9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYiKiq3rnbINEjUuG8EvIGZ4KY53+O0YR1hPoGOWKRUeLzFIywGG6aIFjJQtMnQKqUcREikfiAqK98sJ8Hg8lGSsPPwsiDJNm9npnaY6NhQZmtb5b+UnVpWrahvx8NIDJjX6pBnJ5BQyjw5Nr1sja+389IiyJqXXFFmseXfhmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN//xoNe; arc=none smtp.client-ip=74.125.230.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN//xoNe"
Received: by mail-qk2-f30.google.com with SMTP id af79cd13be357-93a222edc62so146674985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790371870; x=1790976670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nhkmFr6e9eytHPykM79264LOe6HbjSmdum6RZxBwROk=;
        b=NN//xoNe7zePeJcuAxRo+xCogHz//Ez/3bxKAGU4FL0VWPAFTF5Wal9X5KQRVVlu0i
         rfZuLq6gOa9Kv3QsEckCeLIpjTgeOYz3lRm0oi/8sNJg/KBUipvL1mUjrYDYafAz1D9F
         01qsmaK64iiDmR3kL+uP65b7TgJTP2SAfigAzo1nkPPEhHATXC2K2iTsRKefP9UFzUTg
         ilb/SJgX+MzJG5AYbAiIvPGbThUDOdIf3GewwcqDdsjdcDSIUMjeTldIlEY6Btyvz3Vh
         GkAvf7IA5QHIkP8NkOAhGCpdAtjEBm6F6uoA+TtNMj1Stx+1jyQ2FIvAkOtXTfg5PCq8
         GvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371870; x=1790976670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nhkmFr6e9eytHPykM79264LOe6HbjSmdum6RZxBwROk=;
        b=KFmhQU0Ss8PxR7hTsfukeqyXeiQ6JxliYg+EmrhODF5yTXfaPCmGeRu8icfawflY5y
         D7jDLdSruxDz8FYMEuGqPb0RcBRcXa6ZvaB+iksoODDwm81wNLguCu05CN9NbB1gcEpL
         HB22eE/jMYjr3UjSQas3mbiA8ARr9FBYGl7pn9Nh+naoojly2+WtInhCzrGdMHxKhhQ6
         xGVYqYZmq/FOqslZdRnAMiHRI/jL+gDGFASKu95fdgevj8dHm7Ht0jz4Thfa9LzchM2M
         YxNaBSXTNJG5TLhJpUNhRh0fHFt0LB7Uj6jSeX4tm3/s+nuluov8t2irLrIgCdlDgVuf
         sylw==
X-Gm-Message-State: AFuF++lLoR35X8Dcom8+bNSMkt1YnhEsG2FJWNTedfvZUENn8ekOyha+
	MiQ31+bciu+XfVOHE0p50w9STHmozW38Q/W7sYtG70n+PQJwsB4R1jHRgvmjJ2sodN8=
X-Gm-Gg: AYBFou1mnSav0x6SY1mHKuqzbEthg1ICHZ5srFRJrBwP2oQqlwiETl3xej78sMPcaLP
	QHOKgMO2f4Z+rLdeGg/eUn3EJfK9pnss5nONecTBp8eJjkKiKXN8l+piecqimsVapTiPa0GDlox
	3FttjsH1qZuH9Uqg9vEJhQkbQcZ99vL4KFOT5IUC90E29r6v1C+8++v5xXpVMA4mZS80uxOEd3x
	7DZgzATTDBzw2fj2giPcQ1QWoLKlMLVgY9H1SEhAFkTF6noEc0ly7xVXAJnuCENCUFBfsq+ww/O
	yZURAGkumn5LEnNmYtPITkbImu6eKyC3CaH+5ZJ08Ghbbi3RXo3hfE6EBSkKKtn6pOyRUo8uagy
	+lOv2wueZBUwlGKPwV26JQL8M0RB9YH/3ItSalLyZSjacPSP6cFf0h/CrMn9L6dt+AHDhx3vCEv
	oWSR3abaXH9k5i7FagMF1a+ifbbCZSWa7q2cvncWUck/TnNtFUtXpYjZXNGrYqULUUfyjWZaIG0
	cGUJC+pK1vv0Hfk+RkwPZgKlRA8Hw5OY9HNkcDI/sN2zTFM+9mNwT23hORsPEY4BqrSh7Li60Lm
	XHXSvXfiDP0Gq2lzhvIO8rqM3Iy7rO8X3tswfgKdRzMR1hTcpronD2Z0OloKqGPYGWBmMenZI0D
	/GkEP/bexn/7H9lDwIoDDy4QtEsFE7Z/gDN2VXJxIGXQ+UqQVtPsb3yZO/c7UOa10RhcJKOyWBq
	JxAO3Zlzv8Dec4iF3ciJatWh3+youbpLWW4A3JWGyRpDLDrTfKD5jTfoGdM5MK7Y8=
X-Received: by 2002:a05:620a:4388:b0:93b:d79b:9a60 with SMTP id af79cd13be357-93c43d36ee8mr732123585a.65.1790371869640;
        Fri, 25 Sep 2026 14:31:09 -0700 (PDT)
Received: from archbox.localdomain (209-6-114-8.s774.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.114.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448f516csm270438585a.23.2026.09.25.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:31:09 -0700 (PDT)
From: Nate Mendes <natemendes13@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nate Mendes <natemendes13@gmail.com>
Subject: [PATCH BlueZ] dbus-common: Use audio-speakers icon for speakers
Date: Fri, 25 Sep 2026 17:30:32 -0400
Message-ID: <20260925213032.4011392-1-natemendes13@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices with the Loudspeaker minor class (0x05) currently fall through
to the generic "audio-card" icon, so a Bluetooth speaker is shown as a
sound card.

While "audio-speakers" is not one of the standard icon names [0], it is
implemented in practice by at least the Adwaita, Breeze, Papirus and
elementary themes. PipeWire already maps this minor class to the
speaker form factor and uses "audio-speakers-bluetooth" for the
resulting sink.

[0] https://specifications.freedesktop.org/icon-naming/latest/

Assisted-by: AI
---
 src/dbus-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..889927f8f 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -73,6 +73,8 @@ const char *class_to_icon(uint32_t class)
 		case 0x01:
 		case 0x02:
 			return "audio-headset";
+		case 0x05:
+			return "audio-speakers";
 		case 0x06:
 			return "audio-headphones";
 		case 0x0b: /* VCR */
-- 
2.55.0

