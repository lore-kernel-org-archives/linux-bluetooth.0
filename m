Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00193BB661
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549582; cv=none; b=YpQ4KDN+bMGUkVrsymYC+Sc+ZNBSlCVB29wcSq2jo1DzGrYf2Sl5pNz6pVxY8/ub1I14CeMEH6Yqn3PwgbIbRDbE3CeGHYRDLYstJSEBk/cOFB3dRo7npxRxQI1Eb3F/Bd9Y6jXBTmfwWUKQ5N0xT1BKfxwSmqyhrvtBsziiuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549582; c=relaxed/simple;
	bh=tFnZtyo+d88+FRvVhARlqbGstQfd/5feMpXCF4V4m6I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HBxdkksZ7yR1pjjguURk9O+Y1PZKu9ruJGIJfqZRPFcRTIKvr+fCuXI6l7/ENZxjKriKPNqzsabbooEVv8pahRX4QqI5uGIIm0BcNWYutVRG//+Fjmn+ybgNSrqrqrX418+W+t3GjIJP54k3Wxj46oDAsdlV5SVQmLQTYT1tM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inDOZZ4U; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inDOZZ4U"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso562584a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549580; x=1791154380; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tFnZtyo+d88+FRvVhARlqbGstQfd/5feMpXCF4V4m6I=;
        b=inDOZZ4UFz3mj3xBc5liockiUQlNOWxbBen5nF8MEoE9aG5VvP9tztap8dzXrO4vKC
         5t/YQ13wr6tXzAaf1FAFzkQ34+I2PzvF8n/J2+2KIE231xm5KKoK/d0F06g0WIbyqo7l
         zjy0+A403D5IAJEenN88ZtlV4yp64c1J8D6AFsbI45qUZ4wVW3Wwbf+MnZfCy7Fo+U3c
         mgvGtCQmnA8p9ztyKki43ZkD8/K1wdR4/cQtA5sZ8ajePgTY7hVeyZbqwgvk7DyhkiQe
         ua89gbiatDj1mk6XUYG8J7h0pymUkw9DRsTkEmGIfBYzEc50swXuZt7NwIP0J/VkHwCO
         9vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549580; x=1791154380;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tFnZtyo+d88+FRvVhARlqbGstQfd/5feMpXCF4V4m6I=;
        b=FRTRKMMtzw0QdF+8ElAryctXUG//1HZEUOMyKa1GJDgbbb2sEtt1ytKJPuV/ofljgO
         sQb1FhwTLUNP5nvSYiOcDzDiipZA7BwyFRV8fi3m2G3vCMRBXy4dJLCuc9imuP8tpyop
         vaNX5OmOJKe4J+WnGMcSv1tqE4Ub4HRLwUXfaYBmlwXAQCLF46c6Op3aeEKeJWjy/BW/
         3qwUzjeVEqKLv/Z23jkL8Cff8D+8IlvptYjyxOMDKVthkVS/HgwlOHRd+UtEbLCQoWLF
         CKj8B1HztVUpcZSMYDyMY189Veek6ettB6LHqdcdTWK1v8BI4syYPPJDloEpHgfKpTqu
         XQyA==
X-Gm-Message-State: AFuF++l9TG9kSdpkAI9G5DyhxXhTGs/FhYwnuchXTbFcIazkNMGJHbQK
	Op5JIXeCOXIRcB6pI5gufjyM92kxuJFYFeKaosuRQ3nJ0PQI04gNfffwYzKLcA==
X-Gm-Gg: AYBFou3mNjKRdS6tryNw4KSVuBGehez5JVF0jyjkUgwIMDpIQZbsD15eWR27PSXTGLv
	8NY0JMR2VjKU2Lj7H6vP5+ohycfr0dBhY85E8FtokgTjak7U6ejAbxq7ESNh2SFv+ZxPdkjstNk
	Bjx+1PRMWFgfnRAk1IaavE+TW7kJAoOCL32ZfV5uPxdZuDuZWEhZjR5eSzhAj9CYurU55Iow+xQ
	gj+AuMvOZxmYwkFObf9xoOnvhw5VnkBwhhnsHu7i8d9BAPrBoJ0mQp22TGo9Jh4rtyu4jGT2md3
	tLR5nA9AwuFwRrZqmDYcQvz9HWrS1qcvBNgsgmDyfAJZQRk+3TDIcANdyex399vpiH4mbuMQWsN
	oX9QqpZ2wIWIdBMMXLO7yrPuwSCXx4oxvofxJRax/9bLvyBn3bUh9msBRa/7Oyoxc6o4m3SoSKK
	KSz99kRQZQpoS5r3DJpfeUPlJE/PkCHDa500AqwA5ZnbMxwb5JLyWmwLzAscQXWe7FmLuqudoY8
	hSD
X-Received: by 2002:a05:6a00:a27:b0:878:3704:e0f4 with SMTP id d2e1a72fcca58-87ea0ac1688mr6463958b3a.26.1790549579845;
        Sun, 27 Sep 2026 15:52:59 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.117.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8829ff81dd7sm921977b3a.55.2026.09.27.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:52:59 -0700 (PDT)
Message-ID: <6ab99e4b.6514f89f.dc85.bab1@mx.google.com>
Date: Sun, 27 Sep 2026 15:52:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5422617767322264865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v4,4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
In-Reply-To: <20260927152356.2886291-1-ravindra@intel.com>
References: <20260927152356.2886291-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5422617767322264865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:4217
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5422617767322264865==--
