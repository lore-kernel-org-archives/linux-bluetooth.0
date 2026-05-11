Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956421E098
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473321; cv=none; b=KpOul3/Rh1YYfk2xF0O9RcDkRq0X0ykni3gNArsDP2iaOtjyH+/OM9jBP0ayNwOfb5vfAJtQaPqfxMW97jo9tVxz2CSpVi0daSeDhsQqcw7onkx3/fjLxOe/Wp6ET1fJjGVzP1Lw1mdB4hWGds+YE1eVwU9ckK68I7XlVVENexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473321; c=relaxed/simple;
	bh=vvadtyXXIbl/oB4Xd9zs956u18cJH3PEfBIeDhUEX90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tS0Kid7OIynve54z/BrUhwTFWtWL3ehEKG3PeO1xvOjDv82RZg0qMAh3yUcSkyV+tZoYRCJycl7X2blDW6m6DdKc2KsjeETNLN3prJ4i0vvHKqqpF7P/9Fgwi8cAl6/y5yVgkGLqFsrUwfMRt4lTV5/ywXyZ7vsJoTS5OzDI8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqvMOHra; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqvMOHra"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2725798eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 May 2026 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473319; x=1779078119; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vvadtyXXIbl/oB4Xd9zs956u18cJH3PEfBIeDhUEX90=;
        b=kqvMOHraqzElryhGX1tR7WRvBblROVa2hNUeZJQrPSTVjhOe020pmeV66GJaKMVd9t
         z70pBwoZf0T21gN6S2MOkMXqjRvILjpcvj3W1EgJxwfDUCIgxNU9fxXkaVkJWpAfdKPu
         1xv0gliBRprAKfTbPLfNcfDfFcz18qC9opYANLT306LnzRej41PWAl+zj3QxFTW6bmy5
         ulpNqVwZHnAsN/xyYq3qgdrlpCpOQVZEioMhVnWB/K/hePxy7judrT/42UvsRfkmmMV6
         0LJ7ZH4trep+mXjNr07/vhrAuh1u3jC+Vxsbp7PKLXppBN4j/KiGp0iaiIEVhxgnzaoH
         AIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473319; x=1779078119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvadtyXXIbl/oB4Xd9zs956u18cJH3PEfBIeDhUEX90=;
        b=pY3/Ji789WfjR61CCWggZSbmx8IaiuR9AMril9CnFEHmvNfOnVuAQ3Y8EsMTiUBgms
         14eHEC0g4segeLpYBAfyUBaiHJYkrzZJBbJhiUeNwP0NxysCKwEz16XE+n8JiJiAruXq
         sAmSGUppcoE+aQ1HvmzJJ6IIJWvUYa8901sIl1ONXW34PUKmDNpGnHgGbugETqvkHczx
         n0/NW4QXrc+Fwwsu3gGEh/E+bG4FhHQ4KS4WBf/mcSNm+U7ofrUnphN727h6ioxDICs4
         ZnzcvyjBh6B1nnGR9wQj5+KVaxnsvq2ppyKpMNouEg+sR6aI6dKum8nkT/C05dmkKNyc
         R1cw==
X-Gm-Message-State: AOJu0YyhhK5zsSZ25rkC3qZaYxr7LtsqMcUZRC+TCIPAZt2m4G1OmMkP
	hV5su8wUmSGqXOdjWZEXSIrZjk99GKsSpLLUdRoha56d6R9u8Foa6rfH2OopMQ==
X-Gm-Gg: Acq92OG2X3uQT0bA7djCXqOcf+Y1oo92F1ddFQYJBtj3RaTB92O89LQgyJ2LK6MELOy
	AFp6qIqqyV1PskT30IVByL6A7Nn8BHmXgGeZ7xsywmX5MQiTP9fUfM5A8+no4rWD35dwf/2wr++
	O1pmWInMnvNEmLIOA7XyDGMmGGDuTe92Xu02KfyHzToJCX5OMliploZUDfljz3V2gD5ZKnhjt7M
	b4RZTCMVWLkDmSEa5OK2IRGlVbYi6lsOJ4kN+8CV+vXRDNc/89EDe9385Qug61yHNs/3BItXPhH
	x14ygMM7Yq6m0U48K4WG3ErXCcsjpOl+5opO0XONXyQ7yY1xSvg/0YIwsEcoxiZRs7VwnNtMg9W
	C5ch+lbSm6dK5dKIUjmOtvYimaz/tMOfRB8KnfYkx1XZ3oDKngMg9VDypeQ1h4wAi5b8N6R0dYD
	OvkhhfHe4r5485/H1mQp2MUER//d22Zrg=
X-Received: by 2002:a05:7300:1825:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2f6e4978037mr6587196eec.18.1778473318971;
        Sun, 10 May 2026 21:21:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm11877000eec.28.2026.05.10.21.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:21:58 -0700 (PDT)
Message-ID: <6a015966.050a0220.1796c8.94cc@mx.google.com>
Date: Sun, 10 May 2026 21:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0343583964326680557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260511031837.221778-2-oss@fourdim.xyz>
References: <20260511031837.221778-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0343583964326680557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_sock.c:1497
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0343583964326680557==--
