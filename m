Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005615;
	b=K3eI578xz+AI9J7e2kInPcN0tDyJbiDtYht5tU6KaFz5uob2EagmeCbGdhTWeSzCDbFT
	 VIfHTwWOZfzlCSUNz7aCvnY8I8SsQi0VY7a6AhCFHdpbDEzBL+t1jANNNLWBJLkvhCIbw
	 rgbfIi/2rv5SgxTAiw6VLtVVVmOFirDkQmxwrOYuQIXPQixA7q7p7Q31Cee5LdP6/SwVC
	 ddVVMao3K0ny+YAyJplwiXagKmR+lwfDuGwMlz0LWYalTl117jlDapnoeUJlDeZ50tgpa
	 JIeJ0V+/z1l4nV3KxjoypJRQlCk0CXU4lmKjWvVFEgd4Aa3UtPjXYQYqgV9IDDteQxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZvRnzfXrqfMelISvadDN0pr/UXleGc6mJ8EDjmoYVVo=;
	b=vsyOJkDXTSW435EGhpVwuGHtotrWG3nVHIvIebtmtA3IIsVnPeIOn5ViF3Di177zRBOt
	 MMU0krRTPsMkXsDegJqJvRwxJaOfilvdstZ0XoSsiqjCTfc69M+lw6XszhwrmEsXL/UFs
	 sTPeywCII2teg4xazesoS/Af5hqI/UkNFZk2b2x2SuthbvdJV/eIVJXEw2Y5n2Tmtpcjn
	 qfzZaHfcew5xwyv4/KzGT3YUlRtolmT/8ISFd94bpytEDYmGHpdIK6BdK56kpBkHe7Yti
	 Ww9yxPDzljKQQMSGX10NDqC73o6Hk5i+JrgGPFU6oCGGvszTHegFNubdxHpqqppbStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=HsbQt2nq;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526B606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 22:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3526B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=HsbQt2nq
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f6295304dso1195231eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794005614; x=1794610414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvRnzfXrqfMelISvadDN0pr/UXleGc6mJ8EDjmoYVVo=;
        b=HsbQt2nqafQPZ6DMkCkcbmNQ+dCXBt5W6rK3eqWmQ1WbpLKJHhYe4NV73XMNWw0NuX
         vBBKcIXa1ZXzJEHl6y/2E8cv1ZK7kwkmPPSc3uYOChmO2uKJN0bmqJZ2IcmGQwjWkw6K
         3G5BpwfgpNROwQDMzrLH64Kz+WEykV7Oj0L8l8KAUNRj1GH9bzQ3gq/gchRtmPFsWesK
         CilkfYrTnDsrg9JQ5izkKr20bQNd+tzbEhdJ2a4pW8GUFvgzW8yIoIwJ0yUb5nQc8NyF
         mo7e6nN2BVX3L6rrc8CzkT0yqpVzj8R8fB+T84ySENvnqLqfZpw43wzdbZ2kPvebQi2M
         +FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005614; x=1794610414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvRnzfXrqfMelISvadDN0pr/UXleGc6mJ8EDjmoYVVo=;
        b=P8yyhdJaIWwxlbsVXaHhkNfr5Q8QTNYlonEiOsQ0ndS8QOb1Qw4msyfTzKkh1ZcB2H
         SeEsU0ZVQXMnYwRcyfheyll0caVcY+U/PmS6K+LWgHJwA2QaBxv9xssSZVwuCBTtDmNR
         pCK2hTITj+WKsGso+fVW9JKCsAJMRNyy4V9AA60g9AJX/wmf1+xlg5HcOz2Hx/1uvT0j
         xM7KLTbMCmnQ9huScAcQwQu+MyzrLJZmAlb3b989bHAu3WMiH9wRWCgrMhG1sMT6bl7F
         rMUy8QqRvsjnQb1i6bnqXicscXXItxDxTNDg5kNQf+tnFUbTrwgCWrX0obyTk/KTelcX
         hi/w==
X-Gm-Message-State: APuU4Z/ns+K8zr8FOofKX0+9Dsicm/rasj5cjFD60fhCo+M4FBowdPwb
	kTdT6ujm/u66WGne339/HqSSkPxUdtGIfKqw/mLC9vEgNxS+Xs9meWUd7LUpYGvUUpSLjpRYZ0s
	kyQ1vFQ0=
X-Gm-Gg: AYBFou0sKbBg2rt7sPs1LkESYmdGTJ68FpVhiDwFTVYMfINaLXz0V49omSLFBYJz+I1
	+4JCZFtfAUBclRZvrjeZJ1Xo3909nvHI93vsgm6H556dEQSbU3pgqin8Hy49r1IOlYztj5WyUH7
	6Agva3HSi0U5mM0q+tuU/eGdngMqk8eWJE0/0DtOl93fHEum2s9XTXPVfTAqy1s31ePyvNXkzud
	J4mMG27GtdRT0/fs0lTDsi0CyDjIgOj5+Hys7xYhpiil/lyvSulWoWfEjzNX8BYuKtiI4dZvO45
	FOi9SWZMMoB9sv6mpSXuY69Y3NB/fYps+6dAbG9Qntd91Lp19L0OjnFhyYC6gKxcQjLj7hNEf1y
	D1d3Hpeglk6Q6bZOl377yOVaXrIPt47tYIXx8t+aH93VT2MkDUb/PYXouUeFgfS0y+mCI83PWRk
	lBA1oIO16II1i8p3Tyb4lJ97u2e5gdXChir0btMbaUbrnLjUjEvXKeh2OeVc/U9oOPKd+BH6x1C
	uIAZVBm2SRNPA/jH6OzBpweimpnvQv1goCz41XD75620/qvg7fZciVskKe4LbtNbh2tJmcJf1LA
	sIWO+yNv0DLmzIy3YBOvQDq8ymhvx6qCMnpXdfyz079Dk9rHqCQCWcTBx5VJ9ZW51mM+4mLBvXH
	MYUD3PhaJLso/zIWW5qbGk6He/2Ou86zgvQIsib944gLnwTP42qUsO9xX/sA+9eV8BODm0Sk=
X-Received: by 2002:a05:7300:d114:b0:369:f18f:3492 with SMTP id 5a478bee46e88-36f76d0ef40mr5124067eec.35.1794005613965;
        Fri, 06 Nov 2026 14:53:33 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa999654sm8604789eec.27.2026.11.06.14.53.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 14:53:33 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: Exposing the bluetoothd version over D-Bus
Date: Fri,  6 Nov 2026 14:53:29 -0800
Message-ID: <20261106225329.6405-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Hi Luiz,

Quick question before I write any code: would you take a patch that
exposes the version of the running bluetoothd over D-Bus?

In SimpleBLE we use introspection to check which interfaces and
properties are available, and that works well for new APIs. Where it
falls short is behaviour changes behind the same API. For example,
since 5.88 Discovering no longer gets stuck after a failed
StopDiscovery, but a client can't tell whether the daemon it's talking
to has that fix. Knowing the version would let us apply workarounds
only where they're needed, and it would help with bug reports too.
BlueR asked for the same thing in
https://github.com/bluez/bluez/issues/619.

Running bluetoothd --version isn't reliable from a client, since the
binary on disk might not be the one running, or might not be reachable
from a container. The version in Adapter1.Modalias also changes or goes
away when DeviceID is set in main.conf.

I know it would only help from the release it lands in, but I think
it's still worth having going forward.

If you're open to it, where would you like it? Adapter1.Version is
already the controller version, and an adapter property wouldn't be
there when no adapter is present, so I was thinking of a read-only
property on a small new interface at /org/bluez. Happy to put it
wherever you prefer, with docs and a functional test.

Thanks,
Kevin
