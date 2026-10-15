Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FA556B8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083322; cv=none; b=b5ctSYzuURMlQizMdVnEENUSrl7LdEFHLdxAnqxaxS0z8o4kEMdwQEDseLvWxmwalmT+uyuUehJcXDf3FrWnDmoQ9Jy+piMvq2dL9iTWzvBCcQY7QqMUEhR0Nw5ctyDHimuzUfO6CGbKk7RHbzLGNzwcZeN8GaHGf0ynx3cIOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083322; c=relaxed/simple;
	bh=wPplHPV1TKrYbrhSxIMNikbauXp/b6tyRO+Ri1Dz8KE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IyVffiJva/t1xctNj51c1meePP4rjh1kitg9Db+3OhDqFaRd6JgOUlOI5HJqxswUUvtUPnav7VGL4IV1ac1pAGfli0ma+V1RjgEU8hYWLQwMRdtJd2RAImLdJ2WHuGzahtqi++1COvWB0IHUoZSFoI0rih8a0fL7zloWkc66uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/HmK8Nq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/HmK8Nq"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e515769d3so468634485a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083301; x=1792688101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MUol33ONZ/UucSrzsOK33KGyUm3N+bmBvmYoqAsuaAs=;
        b=V/HmK8NqXhMhW8eGal8PsoPHZ5ryNkFB//9CnfEDEgxoiZNdkqeg/yhzH61I9q7yd/
         BGXAnxmCDJUPeCd/8Y1WB8OJKXvJkkJHhOKucATMqINuVaBHfQgEPCtKG97stG5BlZue
         DF+1MnUZx3JXZCtgqP60M1fQk8+O95ci+UZ75Wh7Zo3FUcm3je7ygQFvN+48Q1C3sy+8
         R7bhqnxejcrra3XVNtKzm+5foaLfPe/p/nHamuQNg5ty5u8z7cSzfk/JO9eZYfZtCRpk
         qEY5d+hJRAbVKYRNZ8krl1HN2ufDCsz0nhV0KTEGZ59hiFrqqblr1yBy5ksCxdm/FpKC
         mzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083301; x=1792688101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MUol33ONZ/UucSrzsOK33KGyUm3N+bmBvmYoqAsuaAs=;
        b=quMJ0qYBo7DhlPqFuEEQUZ/s+LSYQcen0gWlATP7nUA0law/igvL07TVI1qaKEP4Or
         IBn8eSvu7xo/EdI8yagoXyBhewT1fk5IQ2dDXDiktNeWU7u5QagDOP1hQfzK4waR2ZME
         8orMVpMPWaHCvyGW0Wp5qFMSRD6PYcO9xwqbGBpSEd12tFh9k60DIGBRvj9IVKcU0H3a
         GfhOcWsDwhtVd6Xx+6lFaI+vHxYj/0cwJTfV6toiNN1pERLTQaqVpBif5cje1S5LcNTI
         OZGYr7ho/N4Rpu+nhR3BtTsTnIfa7tz+9NBK2HR1iIkLLYdzes4gbJgixw7oG3qD9g+e
         zeUw==
X-Gm-Message-State: AFq9FYKywjYxkamuMM5ZdqO/ucE1h4N4qTWMpsPWjzj/8uq+dkoGQZ6+
	VkdhCwunztEmzf1FS3DCppWYmOspkw3LlQnowzzy7UVHs5EmqO8SqYOZhsgIQWLi
X-Gm-Gg: AYBFou01N5Qh87ZZkzP2uFAAaFJUL7Gpjfffsc6JVMGqFYI0zR0B9jWsg4J059DLuEu
	fWKQQmpOPol7YMvhmSZUq9g2r2foMxYMbC+GS9nUx/iiweXHewAg73O0nBQmCrgdexBPN1TaEti
	PDz0GJVgLxqTNWg+VVX8oHtoizOaH2JberXTo52r/TyqhJljC7bVBHmDxNv5u2IOlWdyDOdGV70
	cahrjVxCq47O+BEUsZSiNs0H07PNIVZj/Wnz/0u5j/weQKmESFGsQbPKBDJPv+Jlaez+KhVD28K
	Ypo3gc3FOI9plaAtnpnQkr/h9afHIxEBCFd8QTnE9JsQ9JdHof4TdW66h4fBkjKcDpLRaoe++zp
	MPqoO6ciQslCLtS0PfIsHGvIuhOVBTuHRRpjIlx6xE98BS+oPB7Dx9C90VJLyeN/smqjLtjn1E1
	uBwCYel9Fw3SSzO4IzSOWOMhIOrL2Wn08w0DEGTrXfSnKYvX/v7q0FipYXJgvKGaeGmOfTMprnW
	iinn00=
X-Received: by 2002:a05:620a:470b:b0:93e:c12c:43fd with SMTP id af79cd13be357-93ec12c4a90mr3040068385a.74.1792083301510;
        Thu, 15 Oct 2026 09:55:01 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.116.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm809413885a.37.2026.10.15.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:55:01 -0700 (PDT)
Message-ID: <6ad10565.37e4897e.399c73.f761@mx.google.com>
Date: Thu, 15 Oct 2026 09:55:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4884243082749124082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] obexd: Fix FILE* leak in phonebook-dummy
In-Reply-To: <20260930073953.266930-1-jinwang.li@oss.qualcomm.com>
References: <20260930073953.266930-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4884243082749124082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [v1] obexd: Fix FILE* leak in phonebook-dummy
   Pull Request: https://github.com/bluez/bluez/pull/2611
   Created:      2026-09-30 14:09:52+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4884243082749124082==--
