Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E755537F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589901; cv=none; b=Jxc5Zl9hudnkATUuCOnTOcSAmsa7ucSukcTgSU+/TwtveRmB+E1nnlcF+AA9gfTV7fHcunpnBYAVVrJI3XtOPXNG6R2OsXeKkemPRKQGnBhPtl1DEzBDRaYOiyu8idojwSxNazwjcTJ02iHh3IZfasQlbrvMDJrQeAuG24Kg2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589901; c=relaxed/simple;
	bh=WIETOBVd/t9OIh3lFAIlGoTg18s6Gfm/6LJe+lVeM78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlXRf9byFBxUriNydg96NLrOZHGAF+YZD8KtWg7zkO6TpEDX4Q8LWwuS+H41Me1BG9hoBTIriJUjbJriQu0I36DKrm5MXfTy66+UQSXO8d8QBkgo9Ente8wcTJb0h/rT5ikvNPVQw8fBzoCVhw3ZZ03/ESBxaxiF6r0U666Ax70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=BOZWqcBQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="BOZWqcBQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f2b05f87bcso23700496d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745589898; x=1746194698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9u0EsiiWYB9w+4KowwbuwpKDKj+7XfBuZlNF2jmejs=;
        b=BOZWqcBQKXXKU8hXr2iMvDah8d61SPIW7R0kxVx1FXjsxgg192y4Mlt0+ikhizpr3V
         H1477vZ8PTvlERwotguxvWPNiKBbK4FwyY6PNx5lh5niQzkOvtzMduKU6BKlYvTkVmmH
         ATwKBw3B1PlKZoo2gC/aqr1JBdavtxdz+vYyrxQTYq1znVOWlENf9MiTl7xY4nAhcpCR
         meIXwbmprxBNxoqoEr1rMrWX1feJ0nCxacwIh7+UzfGSOA7nZX07SA+s3G0YQlil6PsA
         HXrFGqSUuEv9GvqnYnaI/xwe4UiqjPylyV9oGG3leR8vNbSzKyvHbuyC1CxrSjDQ8HaI
         u10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589898; x=1746194698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9u0EsiiWYB9w+4KowwbuwpKDKj+7XfBuZlNF2jmejs=;
        b=lKf+eAk96vJws3SYWr+77CnIeVqsgRelhAZX9elu3gJeUi5LoxBrKDynrFC1C/TtV3
         tHbLsnEmLen3CdrBX91UwnOluG2I7RS8VdYgCBOX7F45rI41C4ZrFQJwVFA/QVbLslWd
         m2gsc3oTjDdSh0Sj7QWiMdEFFfJe629iv4q/fU/KurGCbRpOp34LmSpvC457gx6zrJVl
         4v0/WJAuHzeYqcxZtQenkol72b501glXj2AME0NNdFsPZ11OkW6h8INsBgr4Ir1Hqqfp
         3wsfsazpA+FWfHC2RQITpTwq4rGYMaewe2x0Fsk7VDKNj4MD/4T/9HPkcNsd4o0Nsb5O
         GsvQ==
X-Gm-Message-State: AOJu0YyRfKIFrhOSOzguqbigZlFVl3EN6SlCnyQ6uCLDUMVgBaQ6EVpL
	iCsuSQPpR7hGnDSurTtuWkMyFUmI3UsN9ghYPgiWNoBrdKq2I4i4uYzxDCvNLliL186rZsUt8/o
	p
X-Gm-Gg: ASbGnct1wFWdS7vnCRsRi4tnHq2tlHyVbUPQJkKpPkA2hXfWlTCMWA1c7mOMrODGq7X
	uFvN0fHsEnawlIU6K152iFaro3uJYh69w60IoCgjELtslPnAiBP/pRIH6696y8xXIUR7c4cKQbz
	qOIp27ozluEzuzU7nGv99NrXYSDhlLQ0JjilDFdlkqaihcv5xrFZK9RyE65KnOtXlzle8QP2QJl
	8lV8tMSeTin6tbcqsWv7J56x9lUM0rlxy8yQEi5jm4aJVDyTUOSymhUqU+ZHA/nY+1TsMWD4WWK
	08FKsk5z4g9GcO5tXZwmUvjBb6xKo4BTyapePg==
X-Google-Smtp-Source: AGHT+IEjO+JtWEwwy9PAm4ZW3hmLczWmZirNMCIz096plIvKJvLCx56kIJRZ/Y02CoJbvBk6YgDBsw==
X-Received: by 2002:a05:6214:226d:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6f4cb9edb2fmr45634816d6.25.1745589897863;
        Fri, 25 Apr 2025 07:04:57 -0700 (PDT)
Received: from andromeda.lan ([74.15.9.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aaea5fsm22253396d6.94.2025.04.25.07.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:04:57 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	sanchayan@asymptotic.io
Subject: [PATCH BlueZ] shared/asha: Only update device set after start succeeds
Date: Fri, 25 Apr 2025 10:04:47 -0400
Message-ID: <20250425140447.615075-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that one side's connected status is only exposed to the
other after the connection is actually complete.
---
 src/shared/asha.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index e623e7156..33bec40da 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -421,8 +421,6 @@ static void read_rops(bool success,
 			asha->right_side, asha->binaural, asha->csis_supported,
 			asha->render_delay, asha->codec_ids);
 
-	update_asha_set(asha, true);
-
 	check_probe_done(asha);
 }
 
@@ -447,6 +445,7 @@ static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 		if (status == 0) {
 			asha->state = ASHA_STARTED;
 			DBG("ASHA start complete");
+			update_asha_set(asha, true);
 			asha_set_send_status(asha, true);
 		} else {
 			bt_asha_state_reset(asha);
-- 
2.49.0

