Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035424;
	b=kGCZ1o39dzAoViG7mQabnusQHGzZeRbIXhyw75Ajg/LiGghAorsEtZ/UTCXmB1keIUJK
	 cWn3AjfVPxwO2kn6C/HCw4rhthvdC423HtYe0ZODYO//lHef8s8EMgpzfG5V0Gi/VRbsh
	 G6c97NZc4dM5Vzu8YiPBDbQDSLKCCLgKWv++KgUqyV3OEIw6OUrxgXXaEyzf9mmK9BuH6
	 HCg/P/V8TZ2yqXqI/fiXcwVWdPVe8hHz8c6E7WAx+RuoOD3hu2yOUbtuVxQBN4sMMcrM6
	 apXuQ18gJoAINWkp5oglBjTFvFDfz8b24NejmetSORWmaRnCYUwBWSJYn2wTmBhCLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jD44Kw0dc/uZl0kPgBZraW0M3ZJSTyhJfpg/xUqpERY=;
	b=mru2PHxhkcZCDW7zCN+JvNTYCJN98REOXb70uZ1GKt9hzQJ4RcjVEL60UkKGiu8lMI1e
	 PfBtMa9g4Y+heORzbYFVoXmgiugcgxBppUPRT9J5rf4d+1wdokxp4SZ4fIBDtDt0K5Yk+
	 YwecDMJnosnkQKXTBB+xOfKqREFtbaRuezl6TiT/t03SRTg3Lov9sPusmLz9R1642AeSB
	 Qn3rI/h3pgJOfyUnBW8qdzfmNurnFfSLrqfT94eNh1AKvtlJjvPwUL3uyg4zrDUBMMp2x
	 t45La2D2nMp0tLtBHQ1CvpHLFktM7DjsOZC4KE1L4z+w83YZ0SUpio+m9gwWpL3+jVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EIzLkdvx;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FF606A31D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 17:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72FF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EIzLkdvx
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ab432273c5so26518277b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793035423; x=1793640223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jD44Kw0dc/uZl0kPgBZraW0M3ZJSTyhJfpg/xUqpERY=;
        b=EIzLkdvxzGbu+/yOwDI+TRj9y+p6mf6dGjLrgEqgx7T2HJDW3+a3VxuO/F2JpB23N2
         8+qYT8Tck6rZ1GoCyjBSj2MYSMOW5a0jSSMJEDqIvfU3Hfo45Oy7OqRwtqfKbUUS8xsL
         ac+t6MHzrYjkaUPX7kHdaJDdcRjY7txGNoZFuj8hrJjdEn0OHYi8FOcBA/O9F1HJANvE
         MJff4gPgrr4TmSScAgzgVYVxwmHOdQ6/QQjo3omWHJE0a4cU+5gMphEqsAiVnXLMeE1g
         ZN/jDg9amsfSHh7BotWpuI2RmsziGmpsjy7cJZetzX3h0r4TqheNKgGHQX4UXj37sP8v
         dMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035423; x=1793640223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jD44Kw0dc/uZl0kPgBZraW0M3ZJSTyhJfpg/xUqpERY=;
        b=mZB1cdOhp3l9CDsUGrZZEbZzwtlc8EiBQR+wjkqhjw1hSrz28iK7F81D6+tI9oBZ/W
         4mZzZOh0EJaxDnDfT78O0nFIqFpj6nmma6trHGkIAXrEkzGmd7k6UXQzDv2Pe2FKkM0v
         +L9QIX3/gSZAp/s1PIucDU6PDYD8k0cgKlkVbgY2QTYl7/AKGwSPntXppQn2Sd4R/yxA
         vCf43ZDd9Wpk6dUZ758/OTyT2tCOLOAdvSqgnCTry9MLlmKpCy5x/AohPcLppM01sdfv
         ACQZHJxwnJ3n0B0U8eRIztns0d9Rdo9eoPFiGH7fV0QLx1dZ6rLGRfpXnsKP3YcwP2Ti
         wcAQ==
X-Gm-Message-State: AFq9FYJ/SpTUZDXlZXEiDE45TaNQlb5bKzeOv522lHKuDhYUyBhKPvs9
	Y2r3CtGzBoOZ3AUwQJaVE+/c+d8cawbtRH7zQzb2/rQqBzJQD+s3sLNCekTiN3SDoNo=
X-Gm-Gg: AYBFou3kN51PwSMjYsGaYL0q93wrJrxbv2LEKyu76nA+9k4+16eDqNfivPxEDlQGQKj
	NDNwfin5GCvYvR/ZOZeqw5oWGWkWOc/GEC8QGBSNxGJpHyYim9BWlzQAp2nusB+BdXsDqR4CnFX
	eJN8b7SOZL1LZQlZmW1IhE0bniF+NTGeWV/yLZPu82hKBVMHrgfgy7cBpM8ZkJKOEYEPigTTSio
	1hWuPqOyu3xeQhQV0zW6FAUpG5/NfB40lGw0SlRA143mkPcZ14qR3TTYDHe4loCHxEvjtM0GUWZ
	WOZ0leRIbAoPNbhyhUd+q3qyp86ic4KPgpiYRC8AJmqN6mnrX7t8eSv+jBsXyQ0zEKjxQ9LzcPB
	rX6UmA3b+tqC8Rc2uKKbLSdhdcQx6vpgo0kYlBvbnzI64EoF6ra8DGHPncD9cW7b+qX5UIumQHV
	ydOe9NZmOKusRGjLDPMlAPG7mHSma3NtZQ6UJ/uy2v6vXdxNu8cpxLDSokPqW9fb78iXvSEc4el
	v4xwFP4t8NfWbWjmlEwYcqx1DuhRP4KYe6GqF6gQk6bOxEB
X-Received: by 2002:a05:690c:c510:b0:8b0:a587:9447 with SMTP id 00721157ae682-8b166c6676bmr60645827b3.38.1793035422833;
        Mon, 26 Oct 2026 10:23:42 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::46d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e9fc27sm35090107b3.34.2026.10.26.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:23:42 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Reprogram the resolving list when a peer's IRK changes
Date: Mon, 26 Oct 2026 13:23:29 -0400
Message-ID: <20261026172331.33873-3-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024004649.56724-1-turbine.bmw@gmail.com>
References: <20261024004649.56724-1-turbine.bmw@gmail.com>
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

Hi,

I'm withdrawing this one too: we no longer hit the problem it fixes,
so I can't test or follow up on it. Please drop it and the BlueZ test
that goes with it.

Thanks,
Brandon
