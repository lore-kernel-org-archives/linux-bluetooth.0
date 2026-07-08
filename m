Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213382EDD7D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523716; cv=pass; b=DPI49tSKBCDGZos9HyGUlEjU4La4G3h/Hy/h4/PuxkhpTZXvZTuqyqOeUEwk4tuzpQBud/lKNCkFB1+TkHKPxFu0zoJ4nPCr7jo+nVEQV+iWdj/ChgJUlDUKB+Y1CdoVUjuPP6aH+RT8PXxEmZ9tWfiVbt38iuSr4H3SwWHvntE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523716; c=relaxed/simple;
	bh=BivWDSxDU/tO0SkasCcRl26dlfTOHMkfuNrvfjMHzPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up3PEzkZzEEzUR2Nbn44ASsEVy8r7Uu4ACACtl79fKrKtemOXaiQW+KdluK7QutHznDCtE2U/8IaV43gdK2XLqCYUhYgIkjzCK91gC2ePIfWzoPHzW7TgKYLSFQxJAE0FsclRUUsEbj4ukrmG7yWASNGQNsSFb8KKGeNIRxoAcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryYjEgHB; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryYjEgHB"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a09bc459so1129188d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 08:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783523713; cv=none;
        d=google.com; s=arc-20260327;
        b=rDiT5CxzacV6ReEXetFHvYThluf1GfHGsDrMKOG/FqQRVRQNMTZXTelmFLCeFZe4Qk
         EM7PxB5XTUt2ne8q/JhUTBAG9mLjstfFWry8SANZueDofqqD0Nda2++0af0+QaE83hhl
         0WAdlt1foMfLHf7DAKb+VPl/G/L6xqWtKcATX++TroikpFqxep3Y2fkZeH6n3ogD+Rm0
         8cGHgR9IkKVeVFeY4YqmXIH5Pm9MS8nR2Fz0SxxRUZORgUuH0IS75L57pfBqG1jz4lEi
         fKHJOzXqSiEIAiXdU7w8JVbxjLVSrfX+yu/mQSDjDkgCttbMcUFrkQN1YjPF1dp7dovg
         b68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BivWDSxDU/tO0SkasCcRl26dlfTOHMkfuNrvfjMHzPE=;
        fh=XG6eqXGa80mxcosiCO9sP96O6SohR/POAtNZ4eLMC2Y=;
        b=Q7j+sUMop8rs7Idp3QahhAoAl4A/ZjOOPUUHsjMbuqcMSi0ASki1C5bDG/mfD3zkGc
         k+ztzHs+XBU74fXrLErFbHVIy0B+bNaf/uqkxl7BrylQcYO9u3wyX0i2S86KGPxdy/Ii
         bnRBNx3M1xXvDIVdWGL64XDEOZjgQ8f2EcrvMLZrcxAZZp86oI5NQCOwPoHZMgzmP4+R
         5iYaSgh1Xys34FVOkKt/eCkir0JMU60+rHhnpA1Jj41APM4u7dQmM3YPH27MhLM5hc9s
         bu6tOBNP5AOI7/wXx3lbzKfJmXycXRoZv2bOVV4H63tmPFKto6iJWHB8wd1vZ637jY3r
         XGXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783523713; x=1784128513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BivWDSxDU/tO0SkasCcRl26dlfTOHMkfuNrvfjMHzPE=;
        b=ryYjEgHB1mL4UqWXkWqV1Pi9hkCGC/uItd+A+RmJDFyDLuWublqaxIQupl/Gv7x2m1
         j3yH5oe9aDV0J/CcSuVqsvinStFkuljNMYm1ieGVnCRm0EY83/QN7QueqF6R4/Q9pzpV
         3P+oc03HyU6SjJyPfyUxKdCpo4x6jgl3MLgyt8BrWm/sZ9NJriC0gUbAS8XIxePDslb1
         1JbT749f+YB7MVrLZJYPfdUdPEj8yDXUQeXjn3IVThxX29X4NzHiNL7rGJ5NwkQuJlsL
         bkfEkOOHC2A2yYNQJPmoDIbKzunRx6WCCiSICzYnALrCPn4k9ML7Dt+AZOgiVNAMydUa
         KXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523713; x=1784128513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BivWDSxDU/tO0SkasCcRl26dlfTOHMkfuNrvfjMHzPE=;
        b=QBrSs1APMrH+R1IwqRwonnwZzmYjY5oq4cpADnaFqRgjAkZeFjW5VuzQ4tubBtyGf+
         7IvXYCZbK8Nu4MCEbw6JYAbWP5rSKKAbvIUOnSfMeQ2ZDih1ajid/qJpCiwHJApRKFm3
         bdgZaGd6zY6a6Psdnka2N+nsEOafglsxeAVc2txAKKArcMOL+hoThKMb2k9YJlPHHMqn
         Ba0skYC9iIDtwSyWxFUm3DzrjCGCiuQ1RxzElAMk0PmpzAVeU0fb+gs4L9E4Bos2jasl
         YW5MORJZjveSYXcvFjPZLGBm10O/czFMirBXam8cIQ2cPWUfwoOzZjfyLa6c5E3KDQ3L
         RIUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaibMcr9xboId+b+RSt+N9QaVGmokv4Bbjp9+xmvcMwa13lsfgjLIrLpaLLxdVEBo3VFB905aTleHOWpiBp44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAHFhqx9T+x4vANt0RUSnBxpJrqouNSUJlZoA6NvQzjiBSaLD
	Y0zXb8Swj2xCum5vYqbzAJzZxrV905tyEf8YHG1sjHfnCSPY5gE7fsqSN1JqUE4cMSrx4lMPlqo
	ay91z850yaom4kLwX/7o4DviqDvcSLe4=
X-Gm-Gg: AfdE7cnNYdbVwh4ZIKJDXNI0vlVW5Vs8mVmjFMO0jPqdsev9VzfdaVEswcIg0SBzmbW
	sO+2W0qzvc98GUOh/vL3G5i2X1bV+jkLhOoD3sz7PD964si7dCAbruJzUU371V6uUFwfKwF6prM
	uJ/EaFOT2Sb1rBu0nF+TGZwxBxnnTk2VTrVBC3B8oP3JllxDek4w/G/rDel0oHiQw6AE+mNEgom
	KH5So8fsYJg6tQk0toqJRmWZVk6flsywJQxJdBxKE4XbqG7hJliqk6NNh79ny/9EtrHNwtrj2ZU
	WxCdvehzQqw+AShpO1bwki3lRsXyCS92Jb8WkK0IXxBpEeLdcvzWHbG4
X-Received: by 2002:a05:690e:4852:20b0:664:bd7f:1345 with SMTP id
 956f58d0204a3-6679f005639mr1752205d50.13.1783523712905; Wed, 08 Jul 2026
 08:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704231030.996390-1-xmei5@asu.edu> <akomrM-h521h6M0i@hovoldconsulting.com>
 <CAPpSM+Sph2Drdv_HxKTkfkHP-qDPqrRHYQ9eaOhJ5YGE-5cKYQ@mail.gmail.com> <ak5czs34RMdBhPkP@hovoldconsulting.com>
In-Reply-To: <ak5czs34RMdBhPkP@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jul 2026 11:15:00 -0400
X-Gm-Features: AVVi8CfYROOt-cSHN2PWEaGgx9WIED1MmbNOzj0LWH8N2V0uAhNurT7DiXGwKKk
Message-ID: <CABBYNZ+gp57kxcXZTLWgd5n19cmDc1Z8TimW0bv7CQLT7khzug@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow in
 TLV parser
To: Johan Hovold <johan@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Jul 8, 2026 at 10:21=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Jul 07, 2026 at 10:55:23AM -0700, Xiang Mei wrote:
> > On Sun, Jul 5, 2026 at 2:41=E2=80=AFAM Johan Hovold <johan@kernel.org> =
wrote:
> > > On Sat, Jul 04, 2026 at 04:10:30PM -0700, Xiang Mei wrote:
>
> > > > The loop body
> > > > then reads a 12-byte struct tlv_type_nvm past the end of the short
> > > > vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write =
past it).
> > >
> > > No, only four bytes are read before the loop exits without any furthe=
r
> > > consequences due to the following check:
>
> > Thanks Johan, and you're right. Only the 2-byte tag_id (and at most
> > the 4 bytes of tag_id/tag_len) is read out of bounds. This commit
> > message overstated the impact, and I should have caught that.
> >
> > Unfortunately, the bot merged this patch when I was preparing the v2
> > this morning. If you think the inaccurate commit message is worth
> > fixing on record, I can send a follow-up to the maintainers to correct
> > the message
>
> It was Luiz who applied the patch -- perhaps he did not notice my
> conditional Reviewed-by tag.
>
> I assume the Bluetooth tree is not rebased so I don't think there's
> anything that can be done here and there is no need to send a v2 (unless
> Luiz says otherwise).

If only the commit message that needs updating then I guess we don't
need to worry about if stating something slightly inaccurate.

> > > With the commit message fixed you can add my:
> > >
> > > Reviewed-by: Johan Hovold <johan@kernel.org>
>
> Johan



--=20
Luiz Augusto von Dentz
