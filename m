Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618129;
	b=RPLrto9hitmto5Q3KrKzoO8BIz35GfmlpOhuy+uGE+LA83kP0aHzh3YSjAO7FeEN7YIR
	 Jg+APO7Au8gFNQXUeyg3hhe7CH5YaCl1ljcObyKbHx40MNpKv1E2br2G5EXkjPO/MfZ2y
	 jAwCqPX6Z3Gcxgppd48BWTbuZxmh7huMb0uagmXXZ3sxrkEKCgdOEFt7gGQxHMzY5RDfp
	 pSlQ7ZlcZOIdp0gqCosB/6pX07eR1du9BBcl+hg1SOYwuOHRTZlY3DEndc3A6+DXtOhaA
	 HuGOsXnoyRUmp9Dy1wFfm1OLsuLz23FYfRS29PEELn3PsiIqI+RPrSxfknpcOAoppvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=u81B7OIkisTmF/+cW7UszP90zXAKvsTC8wEXt0TICVU=;
	b=dLHlLMHYRSJFeMSe3aYJIXQHfIltRtQSzPPj5a8w29PkkjpTf8IlXvdM/ythDkQj5FYX
	 oQoL8xpQxeLjCDwQ6SHQaUOSiRSw3zs2omc1l0b1amZykVFPmi1wSqN7fXiyPhFA2PXHn
	 Enfda73hI1MPaN79DM4YKS/Cs54AGiX7GzVQbJN76PPi5pk7np0i4bOMLkCQvigEWJs0S
	 cipqqzxQfbJQbQSyfKWuoY+LzFCqinjTmkzSyq05y8/ofexmkvtEUhOwXO8YWUt2u2OmX
	 M/AtZitHXOiKV7dHdBDupe/S4sjbpAUWNZU6uBSGMqLUFjnlIAGB3ECGd2qHJHdUDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kIVGl35+;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAC606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kIVGl35+
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3b4944a0eso4409002c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795618128; x=1796222928; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u81B7OIkisTmF/+cW7UszP90zXAKvsTC8wEXt0TICVU=;
        b=kIVGl35+cx1BzP9LLbgfjhgAYlh/5+ukA8uRZQGYxkCXQs7FZ+Qw4VmsP+rqEXBGDc
         Ioj9tKLow77GnpjiTER++SGGq5ePAV54wakiak/YiWWs4LNTiW6CRSeyYedz7g7XTPJS
         ROwCdAIlfPL1M09/6LFY7RphYD05Ri/PDh3I7ElrSwOI8p+XONbzIDTOWoHOFN+izQnR
         BHv8wmgL5uVZee/9V+UwG5Fq8IWVt11xQqfWfd+j5oav1Gy5a0m7E6J4pvAe1xCkrEj1
         +ZDpP6ixYo7B0ikFS+J/9oF+YLs7rwXnfeqfAmvqZklTjGD8MUOkTgk/uawXYs90BG2n
         Kn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618128; x=1796222928;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u81B7OIkisTmF/+cW7UszP90zXAKvsTC8wEXt0TICVU=;
        b=Z64+ZTS4M0L33exnqy2Cy+sDsO4slQn1yF25ZcWvP3MEtQaGzm+6ZL7RUd8vja2Yt3
         W+A2YZ7fBDLVg1tKAKcJEPYSIaDeXRG3ID0A0cbbbcuhV9Vjw33uBVFalmgqPOnStW5F
         Z6BIRGXwxhdYuGDCUuF8CfUrMGjP7O9o188zi+KPyt44dVjAi8b32GF5eGY26+v+xDOi
         SenK5+EyRPPdhKco9TCqxuNydx0Z1FfVYOc5Hhf0Tj4Q5ZK1MzAgXd4orvlxZP9T8gQ4
         hM9U4EKbX2ObaaJctHSlLUQvJ8TmB3uOcjOFod+sbVNLC0lCRAVuZDHqd7qUTRGByMtK
         NG9Q==
X-Gm-Message-State: APuU4Z8moPohgliBlJ0aUwnfg+WFaIiiHpjC1DjZnHWLT3UVnKEy2EBn
	GjxYwJkrxOkmJU+EWK/d2FjCjHhKhoPuHr7zsdPhU93HP1GOR99XV++fzNPlgw==
X-Gm-Gg: AZFdTZfgc6oERKh7GQ2HGLKQ5LgAmjkPLdUk06rUIAEtum1nv3gh6zXTItYQxo0kSjU
	rbCjQsFwuwzE1yST/hFMn9YX/pb1/+dN/Lqy8J5KQSkR1ib9MQtp8qquId/gnbQevF/LJdxvTPE
	+CA43/ErwgVajmtcRyCZxvtWdoIgVHTBYxFu8xzXsZnApYFGhTU8sPNBrZtgEru4GiGqzgA3tbj
	PvruPgOZpelfgrYimRtG/Mi8niD5SmkMcr/bvIg+ZtNiMctUmXcerZcXs9rOyQoClSuKCt7IHOe
	Sbn0NynNSP89eTD7cCWZ2JLLsHpO8w/JBDKBM4FueZoM8YRitUTTfXWy/sl+1ZwEGCDRngetcBM
	KU0FByA1qa24VCXA7NIr/L6+K8TlPDTYdgK6QzD8leuMjY159zkdyyv89Cg1n8gwaTuM6RW0KSp
	QYxcwm33ZSWoobHYgILG6feMmpzMwumhQjICEtmSfa5R5KqGnUWK8wy8wKWFrmo2Se1ok8N/q/R
	rcSs3n4I1hKZUNS/qMoiwJuj9EcclNEzHqxpjJlbLlD62sZQ3r8RlmZC0Rgmqq4Iz+qLIzfzVU+
	ja6oyS0TTA==
X-Received: by 2002:a05:7022:f109:b0:1b3:8814:8383 with SMTP id a92af1059eb24-1b55689fca6mr14006409c88.9.1795618128470;
        Wed, 25 Nov 2026 06:48:48 -0800 (PST)
Received: from [172.17.0.2] ([128.24.161.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm48685814c88.13.2026.11.25.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:48:47 -0800 (PST)
Message-ID: <6b06f54f.77c88264.209d21.483b@mx.google.com>
Date: Wed, 25 Nov 2026 06:48:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3711207059471276677=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261125075709.459719-2-frederic.danis@collabora.com>
References: <20261125075709.459719-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3711207059471276677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221749/

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.75 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      314.18 seconds
MakeCheck                     PASS      14.83 seconds
MakeDistcheck                 PASS      150.31 seconds
CheckValgrind                 PASS      349.93 seconds
CheckSmatch                   PASS      318.57 seconds
bluezmakeextell               PASS      101.59 seconds
TestFunctional                PASS      1231.46 seconds
IncrementalBuild              PASS      312.36 seconds
ScanBuild                     PASS      1175.58 seconds



https://github.com/bluez/bluez/pull/2918

---
Regards,
Linux Bluetooth


--===============3711207059471276677==--
