Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA322798FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146739; cv=none; b=TE75+C5m3KPzFPAqEsu84fCn/DmsNVjy+DknSK45dI+VYT4mQjXRXD1RKnhWUxsij7PfHDwe+biVHhzIpwEBvICE6oxr6NxNOiVxeTO2qaOaiSwiMWO2f+vWbTGx4bEHcY6ooAXEmNJPkFEdDt4tKS1yVlqNW2dxENIxBzOXBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146739; c=relaxed/simple;
	bh=spBhXQgWoJfxYu3VMd1oEOfwkNFUEBVlLZatVOsWq5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzPV4JMY7FkmU8ONvoOCqidi7TzIpB37xpD8oZZuzCgfzEe4mpWf23JDjNfYLcJYR5k+6kdCqihxufToSZMCMQMCzgMy9ywDduFScnDoC2i0jnMM9+g6B/8WIlqtVKFtOWE/JwZzKoDafVJw9ZtSFO8YFhdxLKU4462iR1mvl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXIJnwrG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXIJnwrG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a16441so755720566b.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756146735; x=1756751535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/YjoLm5A8y5+93dcfAoep4PHwOcKsIYlL5ykRLstTU=;
        b=BXIJnwrGZmdIaldJAH+5UqhXIfYwVaZsobg8R2YpnGoG9PsZFiKvvcJZD5OuLg/r5E
         tXlStNMDgpSsfkNs/RfhoQHtxTcEVzRW5kMs2WBexA+6uNC1hDQy7knbd+fbwF3rtawZ
         iaeYgoehCkGRbTY99CnhmM9L523I1rpb+898By2kmiISh+uWriPWoPXcj2ZWqElWbU6C
         nTrQ0Oa2v4QmOkWbTDktsSP71aUbqkXH8tgVMoISDkA8WKhwvm4GBNa4BEX5c5HdKltB
         a1qYe/kx0TRd6nCsvTXxssz31mHB4NJ1cArSnHmbcXB4+UWF885ao6xTSSxUkjzTaY4g
         abSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146735; x=1756751535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/YjoLm5A8y5+93dcfAoep4PHwOcKsIYlL5ykRLstTU=;
        b=bksHh+IqI08MB5hhz0hgpCxBEcCxfI24BCvMS/HxXQx/6LNO0YyLIbd2WWT/S5UX2N
         kfQpG0GPTj4Knh7Bea0jao8R9aBvmDymKlIBZBHYIAWWfk5ZUDpao++55yAD6juUJtOD
         WCimI3pqBbFI81Gjri8acEk3RYl9TmbqWxTk14YnGT9nHFbdwzs9/AlNxZV5dRUUYRMb
         nuCOfVbENJVEQqDg1bkkGKrgw2fbCCm9SrBfMDasto7HTRpJ/Tpn5X2qzpa1BkBWfTch
         D1MOuqp/XWBCCTraaa33Z8NgjtyGdBYErf/4owKC0nI0RDJYXh+WZn0v7J2+QmMZ6vhr
         bxbA==
X-Gm-Message-State: AOJu0Ywph9yAmA5Xnj1pELr21HWHN03tt6whCimSTIRR9H0JjK95Kp1h
	Jj5K3GEH1UbxnollWQqYqRr1v3KpOMhoxV6tbHrayx3ErYXlkNRLuD10
X-Gm-Gg: ASbGncseNgjPxGNNwzGZgNqdrlayibdqpw8+x/b+QpYglN50B0GI1czujjeeJ0Mmv9t
	DCayuCaNVcfiFxrQhSRCEQSUKXqXMPiR9rr/XEk+ra9jxi9xf+q1TPtjMj5VldQ6GOtis18u/HR
	V2DpYIU9CAsLtgmGu5jVqxD65bQD4n6jHFnWITnC2da5iTOHPqryQMp5eycDmMxo69Ry5HXyyn6
	dI8TtFJ2VJO9eJ+XllCf09XB/b/+4EDt1dsB/anAHHS3T0Kf4zcfp2UUMseyiEbBmCA8PYmjJU2
	DvHPi/NIwYDBwV46HzEnEDvqGLK7Sho43SY0JBKqz1XO5vZB96LZM1lD1zl9el66LRuGv7Zl+eG
	vPMcwEe/uN1kDkfxpkfPwJ1/U8dKWMcGG/YcwhsDKwTtMQIupHdo6CyeKI0mcEwwqL9ssvMkMJN
	DaJe7ENwP29PpT3x4scw==
X-Google-Smtp-Source: AGHT+IEKk3PBGJnSYSkIWff9sG6ztLqQtfQIgd5aPdSW8WXsoNrPZ/0YBihP5iiKvGeJ7vwQO8WpQA==
X-Received: by 2002:a17:907:268b:b0:af9:c31b:c558 with SMTP id a640c23a62f3a-afe29537f96mr1166328566b.35.1756146735116;
        Mon, 25 Aug 2025 11:32:15 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119ffdfsm5505328a12.9.2025.08.25.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:32:14 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: hadess@hadess.net
Cc: linux-bluetooth@vger.kernel.org,
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2 1/2] lib: Add missing includes in bluetooth/hci.h
Date: Mon, 25 Aug 2025 20:31:58 +0200
Message-ID: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <153fce6357dee9d70a04fb4a6c19a975e5c710b4.camel@hadess.net>
References: <153fce6357dee9d70a04fb4a6c19a975e5c710b4.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compilation fails when using bluetooth/hci.h without other includes.

> /usr/include/bluetooth/hci.h:310:9: error: unknown type name ‘uint8_t’
>   310 |         uint8_t         lap[3];
>       |         ^~~~~~~
> ...
> /usr/include/bluetooth/hci.h:383:9: error: unknown type name ‘bdaddr_t’; did you mean ‘daddr_t’?
>   383 |         bdaddr_t        bdaddr;
>       |         ^~~~~~~~
> ...
---
 lib/bluetooth/hci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 8f59a535a..732477ec4 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -17,8 +17,11 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
 #include <sys/socket.h>
 
+#include <bluetooth/bluetooth.h>
+
 #define HCI_MAX_DEV	16
 
 #define HCI_MAX_AMP_SIZE	(1492 + 4)
-- 
2.47.2

