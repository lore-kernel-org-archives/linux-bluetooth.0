Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DEF194AC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440249; cv=none; b=Y3eS5Q/n3Vet4YaLvos/AhjQYsV8hvSzJwXsGenNPS8m3mtMbPY3Isn1E+EMbjvYQWsAW2Cr0ihwvzOW23xGQrBUSglEu69frjdja+JAmAH/xx0GNvYJ0MVNZpdoGOVEnfosRwjRr6MhScH6NyqfoS9fOAPNQTlnoYV3ZWbq/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440249; c=relaxed/simple;
	bh=fmPQ/nhAlYeGY6x/dcB9cp8p855Z2RmjmV5IE+Evgh8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZQ74xzlcWWnHmQ3wyUuyM28XTDuUZ3OthS/zeWUcgVpg3kfojkPQWx452YFYYbd3V/VNSquiolyKVSf31lwTY6M2cuPuBLZs4JdVB7ZzmKmSyMk+5OglJOrQIBGVXgWadzbqI4bQXemqz0W7UZS+tCQM5sNxnrfzsaiQwDkGqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAX7QxOK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAX7QxOK"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso55404886d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 15:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440246; x=1741045046; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fmPQ/nhAlYeGY6x/dcB9cp8p855Z2RmjmV5IE+Evgh8=;
        b=eAX7QxOKxqJFFceXy3UtHwnHhHqkNRHbumjsopaOiDdIT1Pb0iQSq13pM2hc5OgCyg
         Y0iL07X3fVyO4FmlUJ4ArTN/SOnExx64habInynhn08dBSMfREe2N0z8nzbxYqZeyjkl
         atgJFFaSDexYlz75IMbnAxSSFJCzH51pcF0Xul0nAkBaREOZNRLTJdkQKgD/ps9f0uKC
         04QZ6CuGO9VWhOYSqQp+OSVn0FHaAc3HtHT4LBIsAndAIX8ffizU6ZeJV9VWrWEfCJYi
         fa6HoEdLa2Oa+Vyr4zsNxwZ4s8mnYJb4q/YuMqpuY93ixC+3DSiy0vyX1i/uqH5CCMTw
         B13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440246; x=1741045046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmPQ/nhAlYeGY6x/dcB9cp8p855Z2RmjmV5IE+Evgh8=;
        b=Ew5KTfarNAx34G6hVOFp7wqhiwGGMRFMKTs8MxbtHcB5AkCyIM863FOHlW1WoM8l5t
         ZLfmIJp+K1LE2pruAR241zlg3AjBgeRNGknL/9ZKX4WcIAFeSfZxiS4G+GNPLoBVtvMU
         ct9DK2SkMMlq6kl9p3u8hwynvJ0+ciwLyCG+y7zhtshDSCzoY720cb3Nhh7mSCw37LaE
         cp4WhZu6f0AWP4pLQGtlAcc5+fi+M6qlg3YpR/8vjBUQ3OqtLCTFvFiuzZExobBV7ZQK
         C2KTVz6kMnKQyUDNLsif3itx7NYt7GpvKaX6w0G6Epge/i4WzCVVMHmseeMstMZoEjbt
         m96w==
X-Gm-Message-State: AOJu0YwM9opdPLeUxZS7iley3mDULBPCNqEJmA38P1/MdrsB1OHcsoQa
	uMKdSg0JyB53cry8PTwaKRd4lvbL2Fjc2ZjWb+zu1WP3uqL4IrPkFHaNwA==
X-Gm-Gg: ASbGncvpQIx1tL1juix3naO8ap4KG2QfA926kx5I0qhAfhO6C3TGvJbAmB03/fvfXuk
	P9Hl/jEJPF4EJDoFqtlVaCVg6ysl0pfUsk5s5yBzuB1Bp447rKgFkCbLedRNtK0r/gUQlldvZB7
	yGU302Ibj2/M6fqPHHPymyZiIU2uXpOfNHD3kFw8/Ol8d+8PHSl8lgo1Xzlk/4q268PKo3cqlH+
	Zokrvl7+7KuMkpb/j0++d3Lnlpi3E+5U8sfWEcN7IiwDQVzWMBQcEhGWgMZXzKNhLqgjhT7FGHr
	a7jKnOuIPyFupgLI4Y67puhY1iJq+rc=
X-Google-Smtp-Source: AGHT+IE3Bw19NwrAxoz2eBP459fXMnrYNtGk3GhepuTmrEMsyX4Fnkjk5qXTZSoYK23CKTHFr9n5TA==
X-Received: by 2002:a05:6214:c8d:b0:6e6:9ef2:6585 with SMTP id 6a1803df08f44-6e87ab09008mr12798136d6.9.1740440246365;
        Mon, 24 Feb 2025 15:37:26 -0800 (PST)
Received: from [172.17.0.2] ([20.57.47.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b087152sm2850626d6.40.2025.02.24.15.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:37:25 -0800 (PST)
Message-ID: <67bd02b5.d40a0220.e2216.1f4f@mx.google.com>
Date: Mon, 24 Feb 2025 15:37:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3748365515388953384=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhreh594@mtroyal.ca
Subject: RE: Bluetooth: btusb: Add support for Realtek Bluetooth device 0x0489:0xe112
In-Reply-To: <CAF3zC4zY=uLsu5LOOb2B-yDTWQdgcHJ-uGiKL5aGmtX4j-bOqg@mail.gmail.com>
References: <CAF3zC4zY=uLsu5LOOb2B-yDTWQdgcHJ-uGiKL5aGmtX4j-bOqg@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3748365515388953384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:519
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3748365515388953384==--
