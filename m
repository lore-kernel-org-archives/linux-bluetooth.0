Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28D31B138
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597578; cv=none; b=c0jN9hXa4uiu5NBtioNWlFlwUb9ncECRGwZHw1QU0bteySvnjJF+rSJ3Uxk9hpeayXsPoPEWsHOmpCYNPMZaMkHbbnj3ceUZHu0pjcMNZluxoGlCXbzn6cuYx3JbzXlLbBizYLy+xOJ42Ks59+qtIdOkG/OLJ7BEXorum8EgAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597578; c=relaxed/simple;
	bh=rbMhXmrZM8dvIOMuVOKQLhZW+Ft30zqIfu0WkkKsBps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uiAB7r4T4Vhq5FOIBeNWaYGxjecrqJN0zwvbj3RnJiMX5alRqT4Tz6AZBhWCaYjTXaUvW593ahnT8YywBxWSreMQ27QI0dMm8C1nZCj0smiVoKqfVAOPhliHdIC5U1P7Yk/VqygS7QIPtZHl0hRLItQdMiMZsAOvU465cgFgPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYAQZmfv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYAQZmfv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0faa6601cso63533571cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755597576; x=1756202376; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbMhXmrZM8dvIOMuVOKQLhZW+Ft30zqIfu0WkkKsBps=;
        b=TYAQZmfvpO8drYVx3IrAoAlNJMDUPWHEWl45Q37A2OINdw9JOBoIRQfQsxj8hvpvZZ
         MgoB/OXNBs9/Usdsj9ranE2/EPdp17J0o1hVFIW0xyQ2k0djvHkBZnrhUGknzedp2v2n
         xiwQmND7kI0+C5nx0ZOOrMS4QMboGtNi6ELwPH6LnU515Mng5FvpRy7i6jlWFlbRSDmm
         xbrIPBYY1ut5qo1awCZr6jmRY17RSqeJDjp7EvqPBoqFR/GK+W1/aUhdje0OUSQY5nC7
         eje4ikUrQNy5M4k/C+009rkDenoF+P6N9lVcwTe/5BYxgOoz1MfASvhmsCwVycBD0ZUj
         dRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597576; x=1756202376;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMhXmrZM8dvIOMuVOKQLhZW+Ft30zqIfu0WkkKsBps=;
        b=GicO5KsPsPcKwGCrM1mMQaSGbiVdo0zfWmLrqkgBEtn17PH1nG4TiAC4Q5jxHlWm3m
         sQJZJ95XE3zduR1fmRDZXFWqgVXJ7kBBAMykIUyCOItkyEKRCBZ3irAzjSxRuWjXe+oy
         T1ZVhf2mDl5UHPLB6DWrJ5Tx2A2bXuK2ocGcVrQvTtSsnWAh/y0HIoer2V6fxwUEvvyj
         H98qwgfCrQQe1/sBQ9PKgnxXF6PKyzq2NA+3Y9EcCAkl722eBx8nJI7Ia8H9tujdnr+8
         inzYn92E5jmUXTnag+wLwzioP6yFAct2iHGYWtU2bAYNitsM28hoBiamHb/dVkePH/mc
         upnA==
X-Gm-Message-State: AOJu0YyHwVmusCesEXIY09ueEG4nSvf3qTOlfKkIFalOV7cSUnkrT3hY
	xQdh04FgVvEK0xjTHzARBh3S5WKGkNMs/pivCMKyHb6JYlBE+XcTaOHHJiwDY393SHi+mTTFt3g
	NDHw16C634XDbC2esOw0i7Sizn5R7dqkM8EXLzARP0Wo7ago1aYsZqR6gokg=
X-Gm-Gg: ASbGncs9JOScJC7kKvZ1X5NspPRtOhHr/0FV0pcFHtQa4JdNtsvxbIMQ/M28Pqmx0aG
	5RlsxIOeMCOia1n4c7n/Z69Z0KcSonzaaecabqPJbeWWMjbmUCt11tKSFi+p51aurVcdkJlLMNf
	gwPmg1OHPtvdCO2jcEzTAGuDZxW/pJXJ4BlLH18YU3vjClVCMQUA3kxTKbUUxdzkvpjzcztVmiX
	hRlFZ76mFXUqfESY5wxwqlo7psr2CLw9GL24wNjTot5cQty7H4/cEc5o9I=
X-Google-Smtp-Source: AGHT+IHQbqh5eCr438oUnDydJzFkaeP3oY5eVZiGbKfxX8G7gXdtCAcliPUFr4vNdDFJWJ2kUAFM3BvTbO5bvULHo8s=
X-Received: by 2002:ad4:5c63:0:b0:709:9979:24f with SMTP id
 6a1803df08f44-70c67899f18mr19536846d6.19.1755597575750; Tue, 19 Aug 2025
 02:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813103459.3690107-2-ochang@google.com> <689c7d7b.050a0220.169a85.c0cc@mx.google.com>
In-Reply-To: <689c7d7b.050a0220.169a85.c0cc@mx.google.com>
From: Oliver Chang <ochang@google.com>
Date: Tue, 19 Aug 2025 19:59:24 +1000
X-Gm-Features: Ac12FXyw01BXmWmY0Kjle4KxImjibFi-tDr4scNHqXzWvuMLHOY7U9ihoAWeueI
Message-ID: <CAFqAZOKaONEocvh2eTqRt6qL7rWvaxk4QGdfTAsN_taouUu7Sw@mail.gmail.com>
Subject: Re: Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
To: linux-bluetooth@vger.kernel.org, oss-fuzz-bugs <oss-fuzz-bugs@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I just wanted to check if there was any feedback on my patch?

Please let me know if I can help clarify any details.

Kind regards,
Oliver
