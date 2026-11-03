Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737839;
	b=f3N0OUaHS3yhbA9r4p2oIqPgCSz3jmLU/z+Z3vPihAMtREDGShm/jTa/Fhj59diHDi5r
	 7UX3ZCy1+Exulu4en8TrPO98nIHfDVj0QOsYFC4IAiFIhvoT14lMPZ3KYv7G535SXdN+V
	 RaCEDsl9TRmmd5nY7t8BznPOrl6b2IQEQaxLrMYI+0MBwLfVk5sflONZ1TKoHyQPHmhr0
	 eoM61ymOFHTarCUbB0j/9VyqIL2+afGQ8iZUElRG8LUNKQVCgSWqvvWPttizZGYOOLSjd
	 tLh3uQ5a7VfW/6gqe3WJBTL3PgfQzkq+ckr0wGJ7JKC7jgndj0LHWUz1ZKcb8eNJKQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nuk4wwtjO1nT4BoxuH1voXT4eb65Tx/LAdIGjGIo7Oo=;
	b=z2pO5lb0kKmUuYnFhiNwVkCedKgf/rIzb4Otmm5qZcl7ubo7yRjMVmxDHQMCzKjJlu2z
	 bpBNZCdrPIU+bxxezl0iHM2kxdBwYbg591VdPsilEAkwJtpkpgCRIgeBEES9oTOUNVzZp
	 xuLJRsD4+Z+IOqvI3tPTunB7k7+BO22r4/XpNVJRR109vnB1JfO2j7vamhlJ/dQVZMc/2
	 XjYqLJXRaiIKKYuVdHYe8LJiTVG6KzasUV656bH9o0UhA0zsEK/70ajuhM81zQ1SE0NuK
	 7FPY8SiB0qfx0hIkxWWddhGC688oO71IawyX1+mAPczGV/ZgsRgDVYgd4q8kMZsv1dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh8ySAFK;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CDA606A330
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CDA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh8ySAFK
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9906870a9baso8916241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737838; x=1794342638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nuk4wwtjO1nT4BoxuH1voXT4eb65Tx/LAdIGjGIo7Oo=;
        b=xh8ySAFK3acN8k6uBfhOwcnLP0wqXvJBrC3gVlBhl6lUD76iE78IiDqusIqGnM5kIP
         QbD2EO/Mrye6CIYUN9P+YKhshtKuKpYsENix4kgQ8KPJAAVAhjO4zzX8V6nke/hFc3go
         WYOCNemgEmStVpKASnlI4xvr2+6T+pHTUQ6lO1eFk/Rm1F1c5Tks2hpI/SA0C2CLDebv
         9pq9g9uCJ5sZCrU3QaRYzmXf/d7V7QMmFkK4o5mYrFLGgZqRNQNTyzn+Vv9zd2zOv/Gs
         mo9nn66QUmvpE5R+Rt1nLqAWZ8nMHf3kiqolR3f/cLTBxGoRs8R3OQCBSXGGH/3liyyK
         /MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737838; x=1794342638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Nuk4wwtjO1nT4BoxuH1voXT4eb65Tx/LAdIGjGIo7Oo=;
        b=Kow1sNw/skct4AdAuTLbyWec0KC60IfC7b6yx41DdLgLCYtkmcq0Z3uRk3UCUNYUjY
         Z5pz0tCP96iJ5bVlTujf121Hya/+lNWiMgr8B8QLJcXYyKNwbLYYwpfaV0MugodtHrV5
         +GtshrUipczIWX8LQPBcMWNQgD8/3exoJX+StYD/CRVRLUAqKPzLxrLFw8s/yhMZPwej
         XZikSi9lpgFPc8kHACDWhbfIX/CbMkLH9RVJZ/jb0RCeXrZBXcfE9iGG8d2ggFwXMkQX
         KrVnVAJ9cUsIya5eHcB0h6P1iGSZ8RpOMSww5OPb1IVPkETjELd4hByOLxI0Yiv+Ina3
         npPw==
X-Gm-Message-State: APuU4Z8LT3XPLqIRzF9C9VH/WC0k9M1XpYt9R5NtnBFmlc5hBtYoWbN4
	USxadMN7EEHoTFTorbaoFv/d/yiIECRenh/vBWcuVBhzHdf+okAuW/6HEN9Qow==
X-Gm-Gg: AYBFou3wN6KOZ3rRRbPXpUd9NC+unSF6Mdx22dzqP+9R8swGZ8I2oBG9Z7w+r5cv2Ns
	HsAdY9LgR1QH32YK8Ob993zI/sON3z4CXHcvkrejgIKFFjsq/hemUIBXeQlglly7GQ62y0RC3ux
	+uo/8eO2w2gG7lHW8IvBlFEhAhsLEba5KS44SrkIoVTmy0OZ9QQKHMJvW9aPfnjJ1DQbqFt+EAM
	Ql/SitV+2hnn+WSoji67FYc7O3ZyduvfOO9qxojJc4+sKxeY5ehlUfR/OxjqqlqcaGzLcKn+91U
	/3/o7GdzyRxXmXXLc/Oc1DSt11D4V+A7D9L1fFDqUCAiP77MeM3pvJ9/b88mbzI8Z22i/O8YgYq
	rbM/xqbXSNFIABLLHr0AHLHc/t5vY04fB2IorlnWCJZO4lFqvjVjQLe4vXdfb5hoXwd90Qu50wq
	8f1nYljJSbziGwPrFZ1DWj3Y6799an/pzBWeH6tR5Zz7qKkSvCGGMwlMMjJurTEE8r/J1AhFUXd
	E96o8OzkwfNXJW2DDqsp2qJrrXs0jG++nOPg6tH4ga8ZuP44d0MTljXcBAWAtE2CxtqyfVVKvb+
	k3+ndQZWTcBRlCzru0pSp3agYgbWIAbBwSlmkYsLwYv+vT9PdqE769pRDjv9dyb/rv0R3x1vRtc
	EzoNj6Qo07M9Dlo7GgUSYaoYArzEmkDECUG/8QeWZIImVoRaIkyaScjjwl4z0/4cmy6E8/af+9r
	eLmcHX
X-Received: by 2002:a05:6102:290c:b0:7cc:828b:421b with SMTP id ada2fe7eead31-7d072bc7155mr6729733137.6.1793737838172;
        Tue, 03 Nov 2026 12:30:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] shared/mainloop: Free removed idles without waiting for events
Date: Tue,  3 Nov 2026 15:30:30 -0500
Message-ID: <20261103203034.3904499-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Removing the last armed idle left it in the list without any idle
pending, so mainloop_run() would block in epoll_wait() and the idle and
its destroy callback would not be released until another event.

Fix this by considering removed idles as pending so they are freed on
the next iteration.
---
 src/shared/mainloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 653f22db70e6..27de2b02ae09 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -361,8 +361,11 @@ static bool idle_pending(void)
 {
 	struct idle_data *idle;
 
+	/* Removed idles also count so they are freed without waiting for
+	 * another event.
+	 */
 	for (idle = idle_list; idle; idle = idle->next) {
-		if (idle->armed && !idle->removed)
+		if (idle->armed || idle->removed)
 			return true;
 	}
 
-- 
2.56.0

