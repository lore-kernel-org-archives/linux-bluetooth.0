Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080124677F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589472; cv=pass; b=c1v5fzdlmHJ08SYg00+bwMDZ3io2cVdA+1R0klTzz/eYAVFdeqFxpKMVjdPGB3+jKi14V4demOODN/oaZ9VOQIcE2rcDXqQWcdolpzCPlUBDNkzMQ42YpxrazLySzdxflY35J7RV5ZB7+o6/mT1Cuu/pG1NrtwN6AwL1StWQjVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589472; c=relaxed/simple;
	bh=ChBEwXdZsvG8vDfMuMK83AMS5qMJ9ka1t15sfq8hYY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=um2lV6FHWG/OxoIfc506OffN5zElyDRy+giHYk8vBCw8j04mGF5orPEKAPhxtjQat0I+SaXMbwF1G5fX/fEAPeNQXEjYOm58zugHOFTRtgXz2/Na49j0zmMyHEIQwD4nenELP3h9zT8tFHfGmXfNLDnhKIlqU+AT40/H23f2DH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h33V2c2D; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h33V2c2D"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38dd9c6840aso32891521fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 12:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589469; cv=none;
        d=google.com; s=arc-20240605;
        b=Tg8EAHhHp9nfOhZUHQLhdm6xKuZQRr4EXzEP7QHMzQkdHh6Y4LT2k9YJ/r4YCi9/FC
         co4Vdnu+v4qa1WV9xmodIjVCjg71/08fhHxvchXRb+OuCtPcQIFiwsdHWz9ktnfscxLF
         0kl2dnjom4na+h3TW1VaFkCl2qP9OkUwLMH4ZmlgOs8NZVpTAZBnmITIcqUjcVLFTJ79
         z4ppDp2g/8nWk6QtIcPWNvPKm4hz3MYm2kIVTPRNgrvcGZA3rhpUPP1MuokYp/riUrF0
         jJmCGULoN1wrz/tc980hAiYH2s5UtQMiEZqDilnc0oxMPtnLJc8KnyNi2Ukh0nQx5RVu
         V8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ChBEwXdZsvG8vDfMuMK83AMS5qMJ9ka1t15sfq8hYY8=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=GlDzPiSiEH3foPZYzrLNNWN9PFsg7LWAWxt+ciTajiWAZ1DdIbnYPPoBw5rtflZg9i
         IFRt93G/fJR+LP0zcBlY/PQJ8o9t0mC8/tsiLVBb8kzOtymHDPyU0neNZ7GX/O7tRKEg
         AyqKUxon//XwOnM4Y3mP4oiG7Yg2/6V64/WExXDlO9MNV9mH6YNjEcUlCuFrGUiw0LAS
         kHrhJ8XDnkY//rOi2ZsKFC52aK5u+rbjcRlo9oZab2SAVFTcLF8M1pT76dyZIZtVGoyB
         Jct65HVzVQviAfwViBGSGZME9ZA4nSP9vcCiXMs7PhgYUle3ZC64EV1grfXnCpWbdcre
         gMQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589469; x=1776194269; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ChBEwXdZsvG8vDfMuMK83AMS5qMJ9ka1t15sfq8hYY8=;
        b=h33V2c2D5UGkB0gGE4bPzH1BJ54AtXu2tKAZE0YNBXwMaKkFaWj2Gov4wwj5ghbza6
         lXen1yqFqEzRlrM+10xE6RH7ptqj8DuCoMVyQgK423eqj9nTDYHWrZabbVe12hJ5VVeM
         O1dE5rABJVenqgjJ+bAa4go6bwve716Iq/8Y7Ib2KsxPD55tH+Tk1P/bHu42S1Ku19VV
         67Fb7BQ6bl9ReYVpnx8/FYKvAbaAO4wmUc6lAuA1MDb2uS5H185EyyQS6i8F8+DJwLxG
         u4S/im9kS4ZE9ShFOc3wH2/EuNWCPJrKsbPWZsq0Hfer0FBJe64LOZg7g5nhINR4PCqD
         bkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589469; x=1776194269;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChBEwXdZsvG8vDfMuMK83AMS5qMJ9ka1t15sfq8hYY8=;
        b=D2DXDwaJ853vfWnxMtujXEfkG9P97C+m8fM45zn3FD221fU2t0iQuWcuk55Ehdgikb
         H5aH2xxiYaqf2xi/HasJ7hbx3qWiloYr9OZ0TcxoipPzn+Q+Cy4RLUkXm8YNDGGX1JYF
         oXgSTjaWnsg3YHvPrBlHZpNPZ5SFV5UMLPxMqMDWySItMdojDGiHaqqTKEg6lh/3+BdL
         dWNPtykLUF/2q+Fp8ylUboZXZFT5HRvGS2V69CMxb1h/dSek2KoVHYxzcokipnM+uk76
         7dazWrWNpV2ogwkCjBc6aGbx30l7tOoFw9Uqrwp2elcifZ0tp+/LBXFbQ/uyL3+ZD9Ys
         0iRg==
X-Gm-Message-State: AOJu0YyKPMxp7oUfx1cVd6VcZDSJ0G3q608qdwOrjNSM8fVyZP70wBpm
	P71H1sXq68+fHjEEcek54+bOLkJjeS6/4nLWQSR4Z3cvvcgf3F7KdTuWeTDquq2/zQXf7qfdHOL
	YpdXfl5v6kAx8NELzHuRrkWt+T28ulTjHHHJfxgQ=
X-Gm-Gg: AeBDies+A8J24h3cyurz6F/6wV8x0vq0BjHIUM+cnNA0s0+I9XNM208AjkooIkASkdM
	LUYru7bX6PCU3iKMvl4BUJjx9qTU6seC7PqEXf0sa82pN3qMjihbxcQbYsK0ZFnDuY9qufyqY1G
	TG2oz3cPzYZzDzXhniInTZVafnA6McBr7//Sv0f36Ecfb/G32sClv70Zdw9BAE42Mh5vqjxNBhl
	FRcTH7heCwC0OGKeYdQ9yVDMlCuGsOCqwvvAIEZb83FpCpDofTx2XycTSUp9HBiuahqP8j9uudU
	AnBez54XxezWyW5hYbQkfXfIfWpFMMX+fulZTw==
X-Received: by 2002:a05:651c:23c3:10b0:387:799:17f8 with SMTP id
 38308e7fff4ca-38d91bef49bmr38999051fa.16.1775589469205; Tue, 07 Apr 2026
 12:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "A. Craig West" <acraigwest@gmail.com>
Date: Tue, 7 Apr 2026 15:17:36 -0400
X-Gm-Features: AQROBzD6xlIYG1EkCjg6KAuk3usbyG6fkci0WKIFZgZxacjy8FC_lZIT9Yek_8M
Message-ID: <CAFbfRkohK6betYLJENW-kp+4GLNB801qBP1VmkQKVKgWh6=Bbw@mail.gmail.com>
Subject: off-topic meta bounce probes
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've noticed that I get bounce probe messages from this mailing list,
as the system has noticed that some messages are being bounced,
presumably by Gmail's spam filters. Which leads to the real issue,
Gmail FREQUENTLY files linux-bluetooth as spam messages. In most
cases, the messages in question are code patches, which there is no
reason for them to be filtered, but there are also an inordinate
number of spam messages that get sent to the list. I suppose that is
two separate issues, is there anything that can be done about either
of them?
