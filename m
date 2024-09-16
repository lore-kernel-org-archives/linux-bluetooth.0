Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01515D5B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518162; cv=none; b=rhyJc6/jRXKE6Y3bTf6QiL8askmQwQpM5Slag3Gow4WhkfHau6He17hx+FQ0RDGvwPYoLGAaUTGCE2jD8lbgU+PHDGXfmFUJzSoDhpBgkUNDjTJn122m45KR/4jcA9aXG8bom6Jjh/jUojndIGbqD6+WfzN9UxzpD3SCYtp7cRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518162; c=relaxed/simple;
	bh=dE9ncddaBxqIHr6u+VYR2VArdd/tXGYl02HqWQcgn+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU9/pi7hE8u3y2E4z9PUcT2HHUA/yn9kL/4jm4Hw4sJDBbrwaDwXZEOYCcgEtSA3/s4jVWpPkhlLEKyVGy0Oigb5RoKD/KvbT48zLsiXvFIreFbi917E0i3tMSaqoSI8u/eEogj58BwCkm9l3N3ZGTxImKFPk0fv0JCY9qAAUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aATb48Vm; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aATb48Vm"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49bdc6e2e3dso1635175137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726518159; x=1727122959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfuY4LDsqVgg3sv4m3MLMlnvHz6GWqxzPzNtKt8TZ0A=;
        b=aATb48Vmel9QLjsRI/NOVdqe7x+2lf0gbYvhDLSFaC7eKiQpDPsuPCqRWtDd0/Stmf
         V/ESDP4SY//Jl0gieGyFyDkw6NvfPTRfd0eVDMWvdgRnp4AH1DqLLUIIK8XwUM/aY+Xg
         /nFuPF7tAtAI+Svk/9iUxaJo3aGud4e/ZWawYRe0hp935jX2QTuklg9gluETK6v7lJRQ
         7uOM7M5g9TLr+NAUJg8ELSH1jUgq+fSYHZSk4mtAcdPcwLinYtUBqrYG08U4hpX4TNBi
         A+9W3D82hRvvfgZiCoLtN/mgyHyo/Fj6yyi2vyForv6cXCFTXjtYMogcbOmt+ftqCRM5
         OuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726518159; x=1727122959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfuY4LDsqVgg3sv4m3MLMlnvHz6GWqxzPzNtKt8TZ0A=;
        b=ZjX9iz0+PT4pZDsCavzCSC9KOyu2Ewz0NwjvL/8yVzOhOCJLl5/U+DNL/XN1pnXPkD
         LRn8A0aI5xhYLXIWGj8qaTuvkCobuFHZ3X7eIrqjFJS4Y43Fo3bWv7DsfoGkwceVG0TP
         Rkxb3NLGAf0k4mW70wkl4C5rY4+XpZKPPQfHTlqKzwHrZPgIFOeCmsi6xpm5jVNbxu1e
         5Pb8flo/7Mwu4pkw1ZRk/cGDMuF/C5ko8S21XyfJMtlw6+kT+4FKb6GKpELhdrzI1CCo
         Uo8cWjeoMPhNlZsHr6pyMp6KjwRcsL7sOyy4ZIPLF+yJmsVqpJYDM84V1yQNie8vPuu8
         CUBg==
X-Gm-Message-State: AOJu0Yz+SJhojxHNtN8PqYg2pthFqhkJSY3TUdXH1t32WAiI6i8kraY6
	ZDleB10VpAfmeJbcEY9BriKkOASl7QIymoEh9Jh3mm66esDJE+6+r06VQQ==
X-Google-Smtp-Source: AGHT+IE15jZBakDxMlYQDfzuWmEL2UbwQI4RDuATdbRRXG6vv+z7XWkSOqAC71Yc73/H6tLed+g69w==
X-Received: by 2002:a05:6102:e0b:b0:48f:461b:c9ac with SMTP id ada2fe7eead31-49d414b32f9mr13204688137.14.1726518159103;
        Mon, 16 Sep 2024 13:22:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8493978cdbbsm687180241.4.2024.09.16.13.22.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:22:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] test-uhid: Add call to bt_uhid_unregister_all
Date: Mon, 16 Sep 2024 16:22:32 -0400
Message-ID: <20240916202232.231417-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916202232.231417-1-luiz.dentz@gmail.com>
References: <20240916202232.231417-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a call to bt_uhid_unregister_all so it tests if notification
callback end up calling that.
---
 unit/test-uhid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 6871c22eeaa1..c5848bef97f9 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -100,6 +100,7 @@ static void destroy_context(struct context *context)
 	if (context->source > 0)
 		g_source_remove(context->source);
 
+	bt_uhid_unregister_all(context->uhid);
 	bt_uhid_unref(context->uhid);
 
 	test_free(context->data);
-- 
2.46.0

