Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0A4E36E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010233; cv=pass; b=pb+EUbzy+CPx4nEcVb88zsmpXD+Lk1hxz8XkRR6N3jlaPZA7fFXb2UBYNFvJpOgq14l8K9GFeHVR5zK3B/Xvu3m83SqArOMN8/kh7CigGdlauUuGKWF59YX2+IrVuCX1Km5jpFyk9KFZKjHsI7uW5ejOz4nAN545c4zZBy+/Wl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010233; c=relaxed/simple;
	bh=Fr1ZvC7M7B70D/Guh4gyfXeRrqKCYWm0W5RzyZFxBt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtalW2YA7n/VNROMbl3nvRpHbZQNahHP7urXkqlr4RzbTLye0xQ3Y8PN9Br3fLyEvVNfaDBaesIZSUONgH0s9/fdtA8rjGLoLyZsiREEI2odzWeRFDGGjXSSHoPW8lMmQpe+twGm00a6/yPkmZ+m9Zq0PvSwOzVzYOzRXQRNReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf1penEb; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf1penEb"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso21176257b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 10:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790010231; cv=none;
        d=google.com; s=arc-20260327;
        b=dWgk6W68JGja4/+xyuNNn1AXne6Z9174MaziKggVqV5JgRwmOl5hlXrxsNCM1e8chs
         nEuvJe3kXRZD0yYkvBNvjl0/W3Rzu8TAKz8quf5hG55VKsG/jy6V3Eayp1Fh9yMkVIFB
         Pd9GF3Qms9tBIEwC0O76foSh9uuAmGflOQtZZu7sweDJ6O2PLZIldTb5M3cjpJBc8XZ0
         bIbMXXhazcRSuOhgysKXdOqxOrK3XWkqiokoWcuAIIAzwlh2CyG4VaIkR8w+a3mAXaXF
         jz/ArRumXl0+66Cr6FvLgPKdfEbZ28KqPGkNnJpGfDorSTyM3Luuhcxem+C+gl1bsx+W
         pclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fr1ZvC7M7B70D/Guh4gyfXeRrqKCYWm0W5RzyZFxBt4=;
        fh=8nBRio8df1usFa6mqfBii8WAOGOqooipHqYpOdz+Lv8=;
        b=HX8fQkEz91dd8UELBBrlaAoLQPawrVWZrNlP1QECZgeZHjiscv8m5HezVYDzu2aOWf
         wAdCQLU296Q9N5kCOLY0UAEjDNNhosPbpjrnhBd/nTdZnVBHwiE8WoncyHCknkG6I+JK
         uQlxHCL80JnZnQ2mn3A2aZWIH5jT3aQ4uP4S2yWSXZbe3SqmLwCbEXUeaOmzPCHFqsO+
         x6qzQMnv20RH170UwhdJjqY/e6X2t83jqzeLOKHCd9BeM4x76YcuGF1CGkFK1fSM24Ad
         1z4cFm2MX9tkKuoW+9r9C9USxB85EA3XLOYV+4O8de16wehkcrBF4iLbFXuJ+LIZvPNw
         S9cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010231; x=1790615031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fr1ZvC7M7B70D/Guh4gyfXeRrqKCYWm0W5RzyZFxBt4=;
        b=Zf1penEbJMWHysoHnUaIszXQqXws+faFFp3X2pyTa7bmzev9Kjl/lJ0ieGkW6CRDzE
         kE9mI1oKwhLrbpZDWyPtRNNc2amMaLXCTwVujBJ4TF2h2TkFhEKKGGB74wsQ+WFDzOHd
         TujOZ+NH9lRhY+CQ7U8NB8qvsLpn3BY6guobSCRnt1wi3/mUc3JBuR1fxEHLW5oOrZsY
         dyUzm/mfQ1mHWGQuuhf+Bl7WFVQNGsx0I4nkBA+DBBkfAXgrcT11sbe1/+a3z+jYNVQ/
         N8KsAyTwtrh60FUCzLvD1nNZ1JegikpM537yHs0QllJG5Z2S0hBU5Vgg8V6K9c1h/MCT
         dbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010231; x=1790615031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fr1ZvC7M7B70D/Guh4gyfXeRrqKCYWm0W5RzyZFxBt4=;
        b=FyiuIswn61SZLvevz6VOq35QWPeJ9eJkxK0VIxIvrxrPszlnLz+fuw2/9c47Frxi8j
         MuiAoqQ0ZrQS9JjBf1tEglupz+YJ5FrgefJ/9Ehj2TEmq1ctHMhRE2zB7/vwHkZ8OUWC
         jVsb61okSgVFJnvPXx/hdsm4tJAm0YHyGrE0fx/5RMcpkD06e1kZ1PuSSTu+9ka4WsQH
         sSiRwjuYI4aMJKIb9ZyUHDruRkUto6r96wz9quuZQvmNyljddRDJjK3oqy20gHj0O96d
         hLijutOxRdFB3Tc+Zy1OQgwPHgelS48nUMmEHSAbm3VlOEa8Rpxjc4pvOJ5eqcorJXfV
         5e2A==
X-Forwarded-Encrypted: i=1; AKwUvBwIuk/CmDmZl+m+9wXoRBIi5kSYSYIbOGERs9TXcwma9NGQSEM70LKgpl+d7cTx3z6NZfK+m8FesjiWW5SUjx4=@vger.kernel.org
X-Gm-Message-State: AFuF++mhquUk9CXjrwcC2l3rU6cGgkv5fDRjDtXTyhtocp3DLp7K7o0Z
	ndK2wfLjN1/NPvz3RHekB7HKzLWiVWKfatZkEntwSrIJVjY99x4cex94kJJRIt9S96PuVe02Fas
	Ya7O6s/C9X9E6k6SqKn/luhGmIqAFz0M=
X-Gm-Gg: AYBFou0/XkJe9ms6BMw/HJ1EB7i8aRKDkFlRqaFEWyZnWgvbPC9Gs9MkDbq1j2gZuw7
	YaJjxeBWTWJtpt606xEQeh7cdnyd78aVIWoN899SahZ/Yt+rmZ5HZW4D00AmYSlMd55QzbYjt6D
	nfSKa7lJzy7ZoIPZMvHaVftieL4GxBXQxZnpHIufOvxlLdACa56MlCH9D0cAW+mhcDjjhhwevrX
	7YrSf2VglFP1ES6mrrv74O+epPSd7eE/BcktUamXOYulf8z4nqARMu8s3zH/yCALw4+r83Ob0Y4
	/R+mvZKU0o0t4Apt5KoPLPo43rLTTn0odSiofBJypIR3xPv7Zb64+O9l
X-Received: by 2002:a05:690c:7:b0:88f:62ba:5121 with SMTP id
 00721157ae682-89736b3f13emr48785407b3.26.1790010230852; Mon, 21 Sep 2026
 10:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
 <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-2@gmail.com> <arFYa6WFbADfftCv@slm.duckdns.org>
In-Reply-To: <arFYa6WFbADfftCv@slm.duckdns.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 22 Sep 2026 01:03:39 +0800
X-Gm-Features: AcwNN1X3STP20vedJkuMz1Kg73-gRGHtkaX-0egPFfvOs6xthqlsoiSd4lYHEek
Message-ID: <CAFRLqsUaMS7S0AdAujF0W_45+25RN0QLMnKoOG8BOD2rR5Abig@mail.gmail.com>
Subject: Re: [PATCH 2/5] workqueue: add support for module-owned work
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marco Elver <elver@google.com>, 
	Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

Tejun Heo <tj@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8822=E6=97=A5=E5=91=
=A8=E4=BA=8C 00:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Please provide justification on why this needs to be done this way when
> everyone else can flush delayed items before unloading.
>

Thank you for the review, and sorry for the extra noise.

I will revisit whether the 6LoWPAN unload path can use the existing workque=
ue
flush/cancellation primitives while preserving the required module lifetime=
,
rather than adding a new workqueue API.

Thanks again for your patience.

Best regards,
Cen Zhang
