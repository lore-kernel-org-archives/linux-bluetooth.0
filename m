Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026204;
	b=CRxjBHKy3nuLKHM9G2PRFMKwsPX+RzV9A8Ovn+UbYmTo8KTlMfawTQL/gB9rZ1h4GVRI
	 FW0Jl8AX/zSE5metqn0TPNdkUwDTatozkzWKUUyHq23zPyku5BJZpL/+Q4Bd0WZ/fCjrQ
	 7S1qwrqmNDJd2do1ZslgATgL4p4lZ0FOO9OjUkloERfjT9XV+0In/y2Mo6xqjMvSUI8Op
	 EB7Cnl09q1kSPha6JQSVDjUuXEAC5FvQ9GcNCCnZR0pKRLqg0YXyrGHMkgWbs9Hh3ZaGd
	 BcIbo/ok0rNsh9e82xlcBm93pRG6Ha5kLo33+FHQqOUcIoYVPDpjgZR9H6bg5qW2oDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bzRZM6/hYruTnH7BRg3xAZC6zkH0M/lwAC3C+slF7RE=;
	b=tkVTFliYJy05v5MkJmvIMCwhu4tj97+ncGwDKxaG7tn2tZP+YYcVuHT+TL2unVVCw6kk
	 3Pb2kDynqOwS8Yx+3X/YAU0xdYYb0RZozuYUN3ZwSy3raFqh2kLx5ajSd+/SJ04NxyfUW
	 3ATA3Yz2VTjkw0CQyn7DlOqg0fKwIOVwxKPPWj9Xxo8xgwHkWavKTcGaEPSCzdlT6uDJi
	 YThJXnhPrS5rfoYIEI7P9SMC3vgM9S5wZsCnv0zjEfLANiHiy0HKYGSdmhBwIErhCQwsY
	 3ODd4EIemw8H8IwG3g9GrqaD5xz695QojuVB8yGHtH3B0Bnw0flhd6XyBOuwR7LIYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w+KXL/q7";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA476606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 18:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA476606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+KXL/q7
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb684859cbso922024a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026203; x=1795631003; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzRZM6/hYruTnH7BRg3xAZC6zkH0M/lwAC3C+slF7RE=;
        b=w+KXL/q7pRLd8cUcYIQ6+Mv5CbRkSFRKGr3ap2+DcoKSenmdIIR3KWOpaaxow4p5VP
         Ao1WVQxHBAB8u0UHa1e0ArSMqtz8PACbvPpxJ6OcTRnRsDMStML51TkwLJTvJTonuS7M
         TfY/R2awJs8qoCj3edrfJrajeZJY6Qg9lDIlqpJIK4yriQqfKX+ytcw00oDAKGlkZy0F
         ZNdjNhUB12Gxkt6Wv7LHXX2ABvK4rsbzM9lalHYtqK6aaoHvkKAIKJUwFveSI/iCpxEc
         96jK6cD/eFE3Icr6kA+hjth1rvfRazyuAFC5dcuw/QeUiMneJ5IDO/8JFmCehNBnLtic
         UL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026203; x=1795631003;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bzRZM6/hYruTnH7BRg3xAZC6zkH0M/lwAC3C+slF7RE=;
        b=k9dmvMpQbhhN9oS38AdPSiMo2+obxECCEkmLoINLKuq1chTBaCf3gZm3j/0pNjDulf
         xQLzwpG8gpTuaJyv+oHAMH8z0hDwbSsM8zja1dwQgaSnBantMoTdjVjkigsniXi0Bfl5
         PfwmNWelQhUBXPwqnrqNfqbv3HRyXbUZjk2m8etPG0dMpj0i9Ceo5AkEcdXTJ1YhyTWS
         DJbCSIfwP3L0FzweWsE+P6APhDJ+Jbx7Q30kXdjtqtLxlV+iN+viZB1AYODPtt8v6LVo
         pstDGNGu2834fdItSQ2GPCjP0urlR7nL5bRFHjeU2G/pL/ZuBP0ksozgBxWoWcvkfL8E
         WXMQ==
X-Gm-Message-State: APuU4Z9YWDVxaxpLTLEepo23pE+judpssbF9/3fHOSCHH3QwJ9PrE0rX
	rJfJCsFVnmH9JEnatPbj5XbGc96cbIZAIk998ngz3HbNEBsoTx5r+Qiw3ROiEQ==
X-Gm-Gg: AZFdTZeDpYUsZfyRB5xiDPAYQndOM/pnFmIJBwkPOdjR6WKdaA9eFga8149l3Jh7KKr
	CP8xlxgWxjqX4JJ3ZVIbLCwtkP7AxI3vEpx1nNJIzD9gc5TjEwigkU9HBpInCzwthabmgWsk7I3
	8o9fdK92nhCvMMliL3tjo1heolMCebjSm0h7DSRt6RPA+xa7T//fVPreiFCdnFT1/TJKoUlNXoS
	ZEOlUOr1EbyGz5ueUQxpZl0O9ZIrYop1EgFl0U4A0J/mLA3XnLIdhtX1YjidwK2JbneBFhP/f01
	M3txpPrqIetgL8GQlTYm2lVNT1tvEqkapAGZ36J6GpjosgSLdCdTrD3MjnOyJwzZjphyECohwlo
	VnJ9EAq5aGU78tLSnCDtU6n8NySZf4UkUw5EYR5NwiUrRKCYem13g29U9OlNKSbbsbRGkd6wypf
	b1X2eUvOTlh5GqUUlP1kHGSvKq/lvf95V+Mx0hQrDQf1dF6PNimPspmtpqO9t6yXcUGjQ9tZFSV
	mvDWUWdVP1JFByt+Zu0Fr29JI6m/0LE+BRQqA9L/8vVns0Yj7rwxFPF+HeJx7XbL50rvWE1Hm1r
	jjbut4mj8wvRzc+crL0ZqHFAl+bv1pv/TFESJvlj
X-Received: by 2002:a17:90b:1846:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3b3d07669e6mr3138806a91.33.1795026202952;
        Wed, 18 Nov 2026 10:23:22 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-143.us-west-2.compute.amazonaws.com. [3.42.157.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3f6bb3e1bsm375551a91.10.2026.11.18.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:23:22 -0800 (PST)
Message-ID: <6afded1a.35adf7b3.7413b.280a@mx.google.com>
Date: Wed, 18 Nov 2026 10:23:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7828387149459139969=="
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
To: linux-bluetooth@vger.kernel.org, mohammed.saad.alquraini@gmail.com
Subject: RE: [Security] Bluetooth: SMP accepts a peer's claimed identity over an RPA link and overwrites another bond's IRK
In-Reply-To: <CAD37_9j+G03rRiUXCJD6+7ULxnxrc6=cJRBsNogpPs9tuNvR6Q@mail.gmail.com>
References: <CAD37_9j+G03rRiUXCJD6+7ULxnxrc6=cJRBsNogpPs9tuNvR6Q@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7828387149459139969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 14
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7828387149459139969==--
