Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBE2F6598
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338458; cv=none; b=T7wdvVkdOew5iMluCGroRqkj9dKrA/RZjjnfhgYgaq9NL4yxyaeAzfio75mKQt0/pBf9IBcRe8MUr+NXlMQ5NNbY10NKULwR/2pZlUnZWib92NdWOe0PiM/nLVF0nDRCx8cUcRBDXWm8cELsQZFjrGLDKJcMOqRqzFeE7M8LB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338458; c=relaxed/simple;
	bh=jmvuvPAWgeISOfaHXiIGDjKuiBSTdaiI+SyUv4o31co=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbL3Z7R2Xkg2pcWUTmcYB4hEibUrtwvWqycxLuaDO2Um3p6qnhKnrGSkCGOM/WZeDPMsdeiCYHygqc4+yT2vvNs0SDzKPuQaX9CYoPVRgkmEvB49SneOmV+94SlNj2SBddtzzYqT6rmuhXhpc+JyljvCxHjfA0vk5V9N/mEtYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeSz2Pkb; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeSz2Pkb"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e352f6c277so692167241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338455; x=1761943255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHSv7AGe2SIGabgzyhOC/Iu9bEmt2m/JH0Tg2yEp75E=;
        b=VeSz2PkbQyerpVelX6bLRXx96ceyVwNfOWtcu7LSticKysYgFQ1BL1Dq82Tf0B2zF4
         vJ5SZNbEqcb9qxS6o2BgKK953zq4FYyyrz/y5mqlz6Fw/mdh0hatZxe1HJl1weMs+X+3
         NOiCwxtI9jsGxmOJja1dbd959wyLvkou76HWCfKMlJuDeVlYYK9FxeaQVhTpg3WKVp+0
         TwIYznO7aX894wmTOSbYEeP7MmKUazq8YZYDXXhMQeUc6Pyddr86GBIjnhL95tInkU/q
         vfylejDEh3pl+6beTkOezyLpfrR14pibHPLbgmZBTst9kNkeJ1bi8/PkdS7dQaq+1oEl
         563A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338455; x=1761943255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHSv7AGe2SIGabgzyhOC/Iu9bEmt2m/JH0Tg2yEp75E=;
        b=OtGMlt/rfRGG9eLHrUoGWJYWInovARLrfcl5ai30fxHiKK0/wimKKTThTpgaEBEkRo
         qtdsj6oKsBpk4VzIsZ8IEOar44x1ugta6fxaB4Ofntlc0u+2wGR2kO7V0ULznM7LMtsg
         jKUJJa+yIamR8LpzWvMAfarR59XdT7Bu7Jvz5mqMcsdxB6od/4UCZMBZGOkltEnFXwBk
         hlCxNboaaUYIHWLnhg2dd8S3taSzNla9Le6/cTDbT1FD5RQKar0KbD97cTJ1RRVoP0pu
         eK+CkjSkbwQei7KEfdOK/cuXn2HXBmzduxiO6bFwtjosQTPuyfC3lCLnDCyK53zxZU+0
         wtYw==
X-Gm-Message-State: AOJu0YxZ+BysVpKHb8h/lHWsRTFKsCb6Jiqw6qFG9JaAE2RKTu6m7n/R
	BZKUL5rn6FFQmFed8LTBq9bkOFh7ndc+gaQTYb6ZN9HO0l3y+0bBZg4I3ZspqA==
X-Gm-Gg: ASbGncvkRjXaMIzTlyJZe84tHI4n3/eUN9wkGptiUG2QE52RgzDyjBjAGEjFfQWlU48
	MyURU8DALzkgjrm0yyDL0RNy/tPAVi5d1QrJRxi/sWM7iWaCirBflFfcvJ0e02S6fyWU6wBuKRE
	VQLLlxRTlGVx9lkR1kcUdHi4eISIwv5QoiJ9jCOtU+35cM+B/dOjqVi+08KCxo8i1mmRDQvRHVA
	Cv1X43xJLFfUbw0HD5ycNmLJz1YMlp+TIMQ0wywTNGID+dYKv2JdNlZKjPTRDy7VFrkTMyC/Squ
	JGX91QbeN1bvsesJPZxAY+HQGMGtQufVAwLM6kGWmT1yM1sbcerNBowRdU9LwKa8U/TFzz/pyrz
	ahxmZPlUObSO248l/eY6atby+mgjKwrqNH48lq/dkYc4WhHXWm361G+HUYFGDsSAVtfllsireJZ
	9FjXhgVLP+oe0Bow==
X-Google-Smtp-Source: AGHT+IENF/fkFhCI5qBSM7jjjIjW4rHCOEgTxbkVI18HeLUvTv4ZU1kymRjP7FejV0uvLgoPt8qvvw==
X-Received: by 2002:a05:6102:510e:b0:5d6:66f:dd81 with SMTP id ada2fe7eead31-5d7dd5ab89bmr8996760137.16.1761338455453;
        Fri, 24 Oct 2025 13:40:55 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/12] shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast
Date: Fri, 24 Oct 2025 16:40:31 -0400
Message-ID: <20251024204039.693918-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_attach_broadcast shall call the attach callback just as any
other instance of bt_bap_attach.
---
 src/shared/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c564297518d6..6573ea39c93b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5684,6 +5684,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
+	queue_foreach(bap_cbs, bap_attached, bap);
+
 	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
 				BT_BAP_BCAST_SOURCE);
 	if (ep)
-- 
2.51.0

