Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFF43C7DE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265694; cv=none; b=r/Rxd2xCLPVsMWnXf1HmVVcLbKqB9W3CXc4eUfyxfZRhqAb8Ghr0jrbqO4cE5GhS5SOYYC9SCPvq+y0XtCN+yCaBLGVaUNPg3BzKk8ttbREf2Loi9Rflf0yaitLvDgVPHF98/4czATr/4W3GJhkRkF6+5MnalYbuqgel4UfvjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265694; c=relaxed/simple;
	bh=JY0MQQt+dn+ON9Kdg+CaAndm5F+3kbDUm/fB8N3QS54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwFbqx8sUg66pWF70D7Ol0f35dbnrV30P0Z2iBgFej5DHfRu+XWymL4tpY/VIDksj+jDKqlMg81oSAFRzg6Ozs8qLX7RNKioWsD6XyAzXfqsTA65v8EyH3tsoJx4kYCjquqLlp/hjltBMgtis4GRjWW+ZpRcrh7SWn00sMen4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkJkG3Ci; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkJkG3Ci"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so19477525e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265691; x=1790870491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JY0MQQt+dn+ON9Kdg+CaAndm5F+3kbDUm/fB8N3QS54=;
        b=FkJkG3CiJEUBkWRYNhJGGMIH3SobfV7lx3vdcni//sUMrNiwfrQtDDdX5aXRrKln7B
         w0BpcBVW90jGcJFkrOEbofXxZaJ4GTQS0JS0bwK08PsAIf3zoC4q+EKD+CoRtMFZOb7S
         xokLDtH/PACDx64VpXxssW5dOJhv+G76v/wGPrrZUHiqy/bfc8xc/haMq6JX2COct5Eg
         lqiS0b3Ky0S1LDky41e8Yp7s+mjDj+FZF/72H9wepihantTqXQw48daQN5ZwK3lB6q8Q
         ZZBdRN6gXy0dywWZrjylBXjZJWfgolFj/rLjumUCR3T8P2/AOotgvEpiJ8fPLLZO3DXt
         86lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265691; x=1790870491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JY0MQQt+dn+ON9Kdg+CaAndm5F+3kbDUm/fB8N3QS54=;
        b=zcsEiRlpdIzdkiedLCn1kAslci726tFF85NcVrDbLSXaJBoM6nZ1vI6skfuewtPq94
         wC3XDHNqv4VozBeGY9sQb+G0UrEkf1ouhDVe2j9KzGxFircSga43W0RWN6h8CHgJEqvo
         51P1lI9S6t2ol6RtAzKuzXkUsCD5v3/UNWKJnEnXxn0HRRnB3ORbXoGVyTbaDs4/exHS
         JDCQclgI2XxVRGd9HW5DyG8NHaxPlnE8gnVHtad/lykLjBhjcbWpXRyWzTvuYbOuLfH7
         6t8rhhrmRvMPWHVBnLkA8WxIDbgCOtY01v5uqn6YlqMNE0ZxPETNFVp9GQIute4IqECJ
         85wA==
X-Gm-Message-State: AFuF++nanG4O8Rr9wKPkJF7Ugjp4f+BzmcUZeN2zR7ILt2NIwgHleBnh
	YV8cBGMm4idFCRw2d+eWLYjk31ZNO4z41qElPEFPMenu6okqFcZ7mR2EUErrzQ==
X-Gm-Gg: AYBFou3sSv2/wSVFJTCHBycssWI9F9UTwvob5eMzE5K3bei42wOxXBTVCrXyIUf+nwP
	QAWZLHzuzz/fWGMhIGb7b/ROMLLoem8/w6Z5BkynWx+4Rnjjcxp7vQ5NrDLFPL6dyhRCILJ4twN
	KqNHEYGDAIBtIP+ZAi+JHePzeqRxPbCJVVPzEtw0jFz/MMfjnMKxy24zuZ9Fu6Myi1M8lv37RNm
	C6wFSqa0bf3AjIwi9XR5O57UeTB3BjhoKrOT+0eP7fFXNDw6z/9RsUObNaF2TTl/f+mQA6CuM2O
	Oy0ZdjcXQ6KrQz9gfbJibXCo6LVG6GJf9ABRzJPXIkloOboy+w6K70nnDJYnyitTTVfcD7xv3xs
	6ZA8fIT5D+IP+gxPxNimv/GJKrCofbDh9LAy2Uv/28dUhO5B7A3xjsBVaETffR0wO/z59einfLj
	fYeMntWhKkDvvvnZHeLeK78tUmMaIJTCFAiMqUHw73uEOP+KFemiJgSx5AJ+UqH1pRGCBP7tX32
	971X0YexUX50GWu6RXLTcTau3JE5VegCA8vygf39Z/lKWnnmKnEN/tgDU6NRtYlaRBnMUfM+mo9
	lH5G+rAdLSgroFc=
X-Received: by 2002:a05:600c:4592:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-49fed8c6cccmr11898065e9.19.1790265691055;
        Thu, 24 Sep 2026 09:01:31 -0700 (PDT)
Received: from computer (ptr-178-51-241-237.dyn.orange.be. [178.51.241.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5b646sm62171895e9.4.2026.09.24.09.01.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:01:30 -0700 (PDT)
From: Kenzi Voyer <kenzivoyer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3631 for MediaTek MT7925
Date: Thu, 24 Sep 2026 18:01:24 +0200
Message-ID: <20260924160128.2128261-1-kenzivoyer@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924115328.15987-1-kenzivoyer@gmail.com>
References: <20260924115328.15987-1-kenzivoyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please disregard this patch.

As the CI bot notes, it no longer applies because drivers/bluetooth/btusb.c
has since been restructured. More importantly, Samuel Alhovuori already
submitted this same addition and his v2 was applied to bluetooth-next on
2026-09-08, so USB ID 13d3:3631 is already present in the current tree
(drivers/bluetooth/btusb_main.c).

Apologies for the duplicate submission and the noise.

Best regards,
Kenzi Voyer
