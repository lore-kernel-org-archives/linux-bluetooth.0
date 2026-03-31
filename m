Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5128725B
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979296; cv=pass; b=VucWGBEIsKhBcnkPEXiPdIYXwQ7Cj+uHZFASTeIZ+d3bJ5gsIE8LH4ZWQmzg9hGEQFLmFNz/rTK4JFnEXw5t4dbKiGJzNqAOLD7Tvm6u5T9p6wbtsZGaCwBMuw2vjaYsUyfQ1DooQIMknfrMhrcH4jCFFvmAHSpLLxVHt7CpCfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979296; c=relaxed/simple;
	bh=hVo7WxLU/BDKLTK1TFiSzVMjKpF295rAA2YWNmF+nYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIt7RDtApVcM2CXW8c9tGB/G+EPbw9Tj48iqzm9tlDD/+xmDBZtdRVyjTbbONvL+I7loTUzDW9D/kE94UzcZ6dhkuvJmlVDD6Oi5bBXCT8x2H0H9AuVrDbSxlVCVDFgsq79QGy5OK6m+2nrwa2Tc3VJuJKw1SJJJxlYAAlsnv0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFirajci; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFirajci"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6500eae6d2fso6428249d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 10:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774979294; cv=none;
        d=google.com; s=arc-20240605;
        b=JupTHnhB3gFgzSJufi4yYdv8Cs0vrzHtRn7ufZPA+C/87++JhB5F+ll+dUWcsRdcOQ
         wuZInfqCNpKvhs4q7gu80d21+y2cd/bgEl90IoFqCS1m/w7BDbLURRwCw8w3DdJ3ZTRB
         VhblTxnFOGLBxtZ3l0ZlJnh4pxodwdmxzX+Tp16TBOPA9bXPcesPl3j5Fs9grFsc2qxo
         /7b1eHf9nc4VNCobpJHnr4ggcYIMH3mBACBexJFkgDaCqRvmAH+9Xb2HUWgeUQBu3HHW
         9YJpm6571ucd2aORmMfWNZaFKmO7OiudVzFCnAG2s7S4SJeqJ0/4NNyHxhpvYgLSSmlx
         eWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kAGXvprQAg9TicChIzzCkc/mjj0hapJWDrcPZS9/4AQ=;
        fh=mhkjHKbe7dOm5blDNTf3rXzO3YvOA/tMKOjsfLw17ek=;
        b=Bvf1R3LaqicqFRUM2Z/61rjnDzAg1+hR5Yy8iE6oLHzbcpcVarubbjj9I/5wvJhv/o
         uzXdKXVSYsMUDF1foe57zJmUmE7oOCM5QV7LiA+HbNL5VJFlJAJO6HHPD1AQlTYQoKwu
         kXxlAz1+FUX25MpmwVEFtxazew/8iL3j0KPLUktfC7UVU/GFQZPpUc6vHvT1RWhe/Pjv
         0SCQltkDKcYi7ExD4ox7L3h1qBSouhd0cTgeLngdEhprMO5+cUjbWC8p9KpKU8iCd+D/
         EzsL8bygn2I6F4JU3UdYJiN78IeLPwjZWvOSXwIJS1LlT9/WSBuihFk2N2BvzsY1GBIR
         35oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979294; x=1775584094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAGXvprQAg9TicChIzzCkc/mjj0hapJWDrcPZS9/4AQ=;
        b=KFirajciVyv8g/bnfY8wTg57r9WhYa25c1F6qVV6E4G3Lki2derPA6xzF2vXHRFZIJ
         RkvouUqny3LcvWGex3pJcHDp5hOOhtDIBcg1YH2prPpptd2a5YvH62/EArwCYhwfzoTR
         fGjHPFGALX+i4HYEJtudWiprb4a1k8VD3cGUm/4nsVZlRj9DgxSj9KWoXl8HnOqolh/u
         ZlasKj4NwZr1UrvPyUGn63cIunip4X0AC0IFYhvo1LgjpVHG09Pbla3zbhz9okSoLJ/0
         MXGkj49UAaw4PLm0T1/lqQ0mip1toTVYfQjkiFhOMGQJhQ0qWOxbBm8/T9rpyfp+fV39
         bDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979294; x=1775584094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kAGXvprQAg9TicChIzzCkc/mjj0hapJWDrcPZS9/4AQ=;
        b=aH7CttPnoEeDdUpShNiog08SiJkTOnVfdQ3g0JlHemHbIz1I0DFGbO4wRDU6lGqsRv
         jqkhuT1/XUMoUu0dyzrUzkeKiS1aLI0XlG6uWJCXE98JpDTiidCP3HL0k1vXAwoz8UBu
         K7bnSkKM+40UT/pGSjhTwaqfA0F8QaFKM/QJ9f1e31PjH5EyJ3bGkYFSyuFBXzRbKPhV
         2rWu8OmMe5CvMcl/ZWYO917sf+YqqUZ/qcrC2quIT4dZNKn8VMfo2ejBRaZyc+ie525N
         vvx3vWoqLEYMKebl6DfxhMmENRyzy8ZIfHQ7zd7TOPAW8NEkYyPyxvMacYajg1QblnZO
         n9Nw==
X-Gm-Message-State: AOJu0Yw4mFvqNHHHc0+e8ZRXMh7wS6qIrm2wMdYpmywn1C9WEK6GDKIS
	UzqIDA1orrH40q7y10MCdldSCanJT6Vq6VRkt7Jgmj298Dnix0FLq77WRK1e7OWObwAWUfK42Cx
	N0IPL+FNqtCJvBDYw9116vwCypdozKCY=
X-Gm-Gg: ATEYQzxb861/vCRFaJh0uMVATsGnQ3lAFdkpWcXgXL+Zg5J/01JdYRgMVW/YaRTKL2F
	bZsxXp7wpV1aymUTGb6xU6bxNXlKGZr60U1wfSgPcsiJFfle7lNGiBO8M4WxUEfPBgnaRAVLYCh
	VAFQePOVA52vIPM6T9aXccKiSWhOtUh0KXmBkJBqZ0+ShENEsYM59UxhBsYRmaVzOsoORB1dUHl
	h6Ehb5EXIeJmQtHiLZkLWUxgX71+E7Nb2++Fygx8Tsp1oLfVTFk1SROeDn9AEGL7LD/Y+40jSVY
	9EkDV/DgOKMUWQ6NOzbU5mXydfQ/EYuKJaM6/62WX/UNy5MWKg74nZriD0M5VtUSxaPNMvWQJAt
	oCrp3
X-Received: by 2002:a05:690e:138a:b0:64e:a90b:b3cb with SMTP id
 956f58d0204a3-6502fe8ef76mr142761d50.72.1774979294351; Tue, 31 Mar 2026
 10:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172134.BD0894C2C37D47@mx.molgen.mpg.de> <66b33d99-b7ea-4918-b1cf-3043c5cab2eb@molgen.mpg.de>
In-Reply-To: <66b33d99-b7ea-4918-b1cf-3043c5cab2eb@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 13:48:03 -0400
X-Gm-Features: AQROBzAIOjLzNje2YwXSqJ1vimDyVnEw6416uulY7RNQAiLukuJrqxKAwdlX1l4
Message-ID: <CABBYNZJQoh1c59HbbpVrZ8VW=r-8MYpYyTrdc7CF-HRLc_R9Mg@mail.gmail.com>
Subject: Re: Delivery problems with Google Mail (was: Undelivered Mail
 Returned to Sender)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Mar 31, 2026 at 1:38=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Just a note, the Google seems to have tuned there spam filter again, and
> now I got rejections for Google Mail address listed in the MAINTAINERS fi=
le.
>
> Am 31.03.26 um 19:21 schrieb Mail Delivery System:
> > Diagnostic-Code: smtp; 550-5.7.1 [141.14.17.11      12] Gmail has detec=
ted that
> >      this message is likely 550-5.7.1 unsolicited mail. To reduce the a=
mount of
> >      spam sent to Gmail, this 550-5.7.1 message has been blocked. For m=
ore
> >      information, go to 550 5.7.1
> >      https://support.google.com/mail/?p=3DUnsolicitedMessageError
> >      a640c23a62f3a-b9c1005c08esi37946666b.340 - gsmtp

Was this sent directly to luiz.dentz@gmail.com? Or it could be perhaps
another email subscribed to linux-bluetooth that bounced? I mean the
fact that I could receive this message might mean some addresses are
getting thru.

>
> Kind regards,
>
> Paul
>


--=20
Luiz Augusto von Dentz
