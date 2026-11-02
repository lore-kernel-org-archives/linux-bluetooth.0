Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647806;
	b=ZPm80hXTFVSZ7raPzzckIgPe5UsWX9+qPhGDE8/EeCPUQ9oaG8RXEtJHyluxpQgXFqe2
	 kAKTxPyurmv09Kxe7/NmE+uD5HXJ/wycGjDPYtQdW0qFCjTTRjTGnCKqBnRqzWNGdV2Oc
	 leb3JqHi5G7dym/YnsI04wozloqgvLBOc0nsHP7emTZM3B6xBMeZq7JGGLz9QBnY/yIh9
	 hnGLwz6wUNt2jVV82t4FnBjvb/vZrVF65qa00jwc2YlQlm5fY+R/44ZHaqC3n+BBq/XxL
	 f5Epf6YVB91V9PPZnm7FLlFcJEOeprQ66ffwA6Zu7NdTkI4dkmfmYT9KCxw1dfDievw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ot9c4P52YoeTPzGNT3DnqwCCVqykL5NwCxensQqAceI=;
	b=jEOkC5/EIdgxQpWp5WQGnre2wkIDH4TEf/phmOwmNRjNC77IpvZhwcaPDQoqobYsVwr6
	 8UEITRcaXrS3UuSrOuiKVL7nFCviIDZuHK0ELLWMkctxP8brJtC2NT1eQWxUW8XHKrj9E
	 JAybvkA6Vkm87XCheOJQ2htNZ8Ka1yq/cuYbbYhLOV8sQYXgBx0yX4tQ+cTrucMhksLQY
	 pbV4x9hLiwt6Pg0+zWXAg6ViAvsTCo5AXcaAjPwJpARMb4k0HZQj8oQQd6AjVsQSJPxdn
	 cXzds2pXGe37zxY+zWB3L3bRwqn4evrw2IXsgT6ejFiwMmOFe/xNMhwopzAZBLlE2Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQmhXSlK;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319A606A329
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5319A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQmhXSlK
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53dbe9b8d6eso3055864b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647805; x=1794252605; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ot9c4P52YoeTPzGNT3DnqwCCVqykL5NwCxensQqAceI=;
        b=pQmhXSlKVeCI5wRu84j56PWzb/9vYZm8oobHLzgwzDy3kiW5mA5z5l3qpi9SPfG+2Y
         AWAIMTpbufCEfWXKC4RprbedB2E/CIbXoIX8TmCUz3LhD4QsE9AIkp2UKvngwtF//VO2
         +1XPmhlY4A/6Gbc/y6dQ8jtGRlGYbq6oEXX7PJd67kFsspOwHvxdE1BuugA/jW5Nnqu9
         CbgkV2fxqjyY4enjr0nWAimQiyxkwfvwdiUEVnpqsaL3npvB2eAOvcu52tI6tmvwMFgE
         ZQJrWxW/nXjYSbHZDoqn3Ny6AieXlQvqgPBiyvYxW+gaXnTQvpj6Trmfu3OJ5KKvO9xF
         /UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647805; x=1794252605;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ot9c4P52YoeTPzGNT3DnqwCCVqykL5NwCxensQqAceI=;
        b=KixHk3WL7ojbjIxuPM1vkxbUg9ncGgEFpks1WSnfv1jSmdZ6RZhRUmvM2nR3M5xphO
         rA+fCeC2MXDizmkIUudMlfaF/Ah7b2sF+cvzgx5oUzTIu+F0I/5EwSPN3pwE/TN2iwTg
         fxI2TfJzY79xPo8JH3vdpJQIq3v1YzYDNi3wyeOt0yZwnnAL6q8A4jOwfQh+3EeJw6AO
         r541WZKeAE0XNADH4HH58qoZu6+Kp4sJnt+0BoaynpiaWB/u0CJhyco3l+OXu9a3AyZf
         nhOxciUDAS5ygETbjFkHQXIgHu3BMdfYDwOZAZaQoWQvP5iD0jnihzfdashOkoc3usP/
         WfIA==
X-Gm-Message-State: AFq9FYIs0eydRWytzEMNT/xoVIjQr0bF7MrNqTTfBcTgoSZCePtAzfNb
	lHF6MAs9VgPDAuKUgQMHHvF58QCpWLLJUjeSew2wgesrjoWZ9SePRyR3B/s98w==
X-Gm-Gg: AYBFou05JU60WHAaVA34FVunWxWbP4trkunO/d8AKlPOf6Pl/3KfCrp9nOjiVqB9BLd
	2vU5ytl5BhkvJnD83hlgA2btYE+gOYzmKr+jdwNT9fFH7F3L9U26v8r4l6adY6WTslnNn9b0/lN
	RIEvpJm404I+7Oom9Ja2i+biPOwKUlecgDP7ukqeQFjdcwa/M1ywhwj3wMHz98s2n1tEyJp5jAa
	wAoOHOtUKw+W61S+9bJ6ciAnWcqP25gaGS/BsxJfTEVB+FE/X7YOnyIONJ9M3v7NfuAbytFpBZM
	BP+0JlYmn+8V9NEcx5VfIGaoB68VQoSZ2AnUTTItGykP+92hRLXB631vLs2cNnCgzJtNQBKpi+b
	xXZ57vCc4Lew8fu4CzYpNR5OzWgmZKbJGd/MExvveFpTFrKUJeiLYmUiABviNvBrcIAyb0EXGVQ
	RyYaYYZqT79EWXSbqwo4aR6tCf6cElqCZXvyUW44sOOlV6s4eTmpxvBYkoQN0ih7o5AdT6db0Kb
	c5n5/f+EM4j1o0UJTRcKd18djFiTduxxk+vVdbfCFlR0rT1sxAM+VyeJ/qNeXQ=
X-Received: by 2002:a05:6808:c12e:b0:4f5:dc0d:e013 with SMTP id 5614622812f47-563ef615b7amr6704072b6e.4.1793647805166;
        Mon, 02 Nov 2026 11:30:05 -0800 (PST)
Received: from [172.17.0.2] ([52.173.50.148])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe0fc77sm8429136b6e.12.2026.11.02.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:30:04 -0800 (PST)
Message-ID: <6ae8e4bc.a3c0497f.3c77ed.daf6@mx.google.com>
Date: Mon, 02 Nov 2026 11:30:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3065729955114416502=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: DBGC flush doorbell and dump rate-limit
In-Reply-To: <20261102134319.2280200-1-aluvala.sai.teja@intel.com>
References: <20261102134319.2280200-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3065729955114416502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198885/

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      29.60 seconds
CheckSparse                   PASS      32.27 seconds
BuildKernel32                 PASS      25.99 seconds
CheckKernelLLVM               PASS      28.37 seconds
TestRunnerSetup               PASS      579.77 seconds
IncrementalBuild              PASS      24.24 seconds



https://github.com/bluez/bluetooth-next/pull/1044

---
Regards,
Linux Bluetooth


--===============3065729955114416502==--
