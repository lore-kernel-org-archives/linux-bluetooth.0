Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238550;
	b=G6rVFP51OytNU0y3+U2HMthntr4T+cEZ5y3iNQXTJC8D6H8/dOaxbza1r6M6MoxcNTSA
	 T+aASgBFexB3EurlhZKeHO2AqRxTMK//+WjQ2IctuZRNsyZbRvnCO8pi+OO1bBBAWIq8L
	 AA9C4yuKfr2+e9F2iXhkTqMqojrmCnNDqR54gKXa2+CQV0HIx+CPhOHqaKU4qGcm7NBNK
	 Y4AHBy/T1I85Hvw763j/mlIWXGq2icDYkEloPW6zBueP9evpUtBc7k6Z7wm1R9b3eQZ6n
	 jM2HGISVm6dfdIzvxLe9wRot9SL6hJr2t7ZQ0i3RK+JCe7n4KFKNg/tGoNtHOZJ8euQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zy8EMM1BFHAclhzxr/2gtUNrv7vvQFeHFQT5Y4VUcUk=;
	b=ouIUG3HK/+RfQelOA8/UWVKzldtHuk2xQgmBNsv4zI2f9qYwSL5oyua7u4607ULTjPsW
	 32qgL7U9MhfjdliGWTCxjlo4qSilCwrizjQyzJHTARRJslYjvlxoidZkQka0J/PGM2wiI
	 Woo1tXu+OPzSkT2rRpOAGHxTKfFN6m3U744EvRKSRyVnWjWYxoheOeM4+ebKmlSxABgFt
	 MTG39pmqkpjVbK3edKlbTM/iSsle3CYAXaPNAfhA0PC6hjd8WaCCIbWkfj6c95lgBZTaz
	 QfcRS1AKfhyaBbZ+fy6f6pAUBuvtBnePECFBQ9jYF6/fzlbOzd2OX5k2eG/V7NF3iVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPvOhJml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889D606A32A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8889D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPvOhJml
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67bef25eb92so1347047d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:35:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238549; cv=none;
        d=google.com; s=arc-20260327;
        b=JTC+ZLae2Lvb4qWrFB6chXCOMG+VrF1WBf05ZmZMVcRo6keG14Dumzw2XfHorXZlqO
         uDGZ/H0rmJE/3R3QoxFEiQM7vQTbGh9a0AIwk35jS5m1ClsSceIgY6K2xxVY16UBvLBN
         393yU+zR0xk+CPGgII6azmLnze3j6tpG+AS2GjCkhpAsqJlggTP8q16mnWnZ2amGMq+o
         4Go6X/uVl/C7DEvtFyWW8gZBS0Pm0dn7EUCfCFhbEoIuDo+zxbO1dEXum4fWZh2NZibf
         TVCkc+EkqoHH1BdRjpYEZQRCQLTKngkpVeCaqDXDLYXrWkGNR69yGXC+1M6JRlyP9Npn
         S0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zy8EMM1BFHAclhzxr/2gtUNrv7vvQFeHFQT5Y4VUcUk=;
        fh=8cXfq/DecXXKO3/LC2J/5Ly1rJ2kOsLk06KYH6WKlNA=;
        b=YQ4kA+z59eVWQdAFA+A2wlC/VgpNfptnpGb/o0U7mhavGitMMoU0rdHfBRFF5COCuI
         b+cNcvkaWPh3gbM3V9hkB3QgS4C+JLASml7fTvAJcMw/SiNood5enEZ+mfpKAAruS6gl
         MFYSSbROEbzLwx3Ak4WsyN776Gf9GtaDbEtqEIvqr/hBU4it7AEUvLEj+M6DppwQjCnz
         eSPmV06ldbw0cPiR+RJh0Q6SAzPZH0GqRwtgGgIk1w3OT/MDMXJa9Ub9EKf4noXlufNn
         nRq2DmqBBtHjSdJDq/2VovheSYbsu86RMQoFIfdNKcn2/T7iud2PWO0Tow7Z5uKj+TVE
         xpGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238549; x=1794843349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zy8EMM1BFHAclhzxr/2gtUNrv7vvQFeHFQT5Y4VUcUk=;
        b=wPvOhJmlawyeWLM/BpMi2/XGhvtnj0nSJQpchKZsVC5jW9PDPyzZqE2TMyrfJtu2/f
         4gm/SBO9gF0q/bLYzMcjQzlMhvsUflAtJOmoWBz7t/K2JVvaKheSHMujV4hJOpbhcjIs
         yOY81XWxbqsyDvz/twVCOakySXo6dTzwKXc/G+UmvgSB/UCh4JXExzifxR2FkHzEMCvC
         i230IBq/jf5HZBvb03xg6vPHUYSc8CnL/TxS1eDoJ8+9qgPs+wzv6s2VdK4EU+AkOLZj
         1iYgUlihFRZtcizx+DnUxSTSRPdDU+M4ykCA9MglNhYz5U9FZRGEj6ZB7qTazsagJffL
         obhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238549; x=1794843349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zy8EMM1BFHAclhzxr/2gtUNrv7vvQFeHFQT5Y4VUcUk=;
        b=tIOFUpMWEP3dLXPgDzyPWF9DWl4mQjli1VAyX6TO9laptYLi45ZojdphQAMex9GPMS
         qo6ROG+aPc6aVrLgZ8lntPDfzyG/yeWM3ivUAxCmbCtsHuhdby91uxQnMjGOUcUvhOUL
         OF7HUTNELruoQrzZs0O6p/NPUhn6VIw+Zv2P2O3h1pCRmbR0kFyoZ6hKOSL7s5Jz4Cg4
         O3v799+Z94cfDLAS8m709xq2oFmzewbZTK22rvfI58Ij5r3EZ2BohlGZJGbB4YExrFo8
         RTXpFGpY483eC8WY4uTnug6cjUyQy5rJWrixF89Blw5gM6kceHc4qozBl0BT/WFz+HNV
         EbCg==
X-Forwarded-Encrypted: i=1; AL+hErHtq6mb1KwfqSjOY6Cia3bkJy/5fEAAJCqHvm6J8NI6PraORcyKrF+0ZXPa1P/dJRN5it/Qbg9bTQ+UiDwaAkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JClXWV2PPjChgn3pPlfAoxCm5nxnzCDIkcWdk8iS8adR09ZAc
	HeuxL+qO5Cwp8HMA+Fbbt/N/tN8dspzT3UpDzaBC+mrpa35TmQp1IaFaaQRl7smr4ajMFNJe4JF
	RcmmKmWabtSgrqP2BsXm63VPaYFzBDkfdbdQA
X-Gm-Gg: AYBFou2gahhi4BQtpTfsdU3yOAeOfySe+MwGbpkg2nstk7Oh8Y93ez0JpzpN8Xrjd3X
	AEtslmZN/2y1Ybr1MyrLRCwhrwTfsfL8nsp0ZsuyCk2CCgN5EhzIBMUv9p4oMQy2mmrONYmhfZx
	T635zIiyNaS4Hsgf6KqEd724buc2zaY8quGimrVnM8k9RxfufCW4FTJ/59Lz7kN3smnpdoPHzxX
	BdFwtc5odhqFQWKJVGg+L31qUtWkx4WkIz3Zov9+bDJSBWXEn7+4neS0rZ/sLcb97q4zZm6SQjJ
	U+siF1N4iK56FXCpirSInZt4JS9hlSjmUQIMtroWRzvdGKJWnAZ5LCLDoMBrBfoiXqNhUIXR+nQ
	tzbYgT3e3hsfAiMnMWgSxUzA2svBh9j8smtV4witw1i/7sQhxy/Gj++e6EIrvmeFPwNXFbO1flM
	9xJbH593NUR6sptKBXx2Y9Q7sHsULEh7iZ34UnWrczAEUezZNlh3RxNzM1
X-Received: by 2002:a05:690e:214f:b0:679:c7d1:fff9 with SMTP id
 956f58d0204a3-67c3dab73ecmr1892246d50.38.1794238549440; Mon, 09 Nov 2026
 07:35:49 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108042008.226295-1-hex@freenixos.com> <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com>
In-Reply-To: <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Nov 2026 10:35:38 -0500
X-Gm-Features: AclHuK9eNSp57e_PRSWgRYYAfxmD3rF4iHPMGs5VJcyC7z9NY_ANVxJUm3pWbPE
Message-ID: <CABBYNZLJpDXTPmE_=rJ=J3oUMWRzybHhut4y1kPTEU8y2AKKiQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump
 segment data
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Hex Lindqvist <hex@freenixos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Nov 9, 2026 at 8:21=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com>=
 wrote:
>
> On 11/8/2026 12:20 PM, Hex Lindqvist wrote:
> > struct qhci_vse_memdump declares segdata as a zero-length array in a
> > union. Zero-length arrays are deprecated [1], so use DECLARE_FLEX_ARRAY=
()
> > instead.
> >
> > No functional change: segdata is only used with offsetof(). With debug
> > info stripped, btusb.o is byte-for-byte identical before and after,
> > built with GCC 16 and Clang 21 on x86_64 and GCC 16 on arm64, with
> > UBSAN_BOUNDS and FORTIFY_SOURCE enabled.
> >
> > An AI assistant helped find and check this change and drafted this
> > message.
> >
> > Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-o=
ne-element-arrays [1]
> > Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> > ---
> >  drivers/bluetooth/btusb_qcom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_q=
com.c
> > index cc4cfcde2afa..97be9078e045 100644
> > --- a/drivers/bluetooth/btusb_qcom.c
> > +++ b/drivers/bluetooth/btusb_qcom.c
> > @@ -533,7 +533,7 @@ struct qhci_vse_memdump {
> >       __le16 seqno;
> >       u8     subsys;
> >       union {
> > -             u8 segdata[0];
> > +             DECLARE_FLEX_ARRAY(u8, segdata);
> >               struct {
> >                       __le32 dump_size;
> >                       u8 first_segdata[];
>
> NAK. Please keep this as-is. since:
>
> 1) segdata[0] is a familiar GNU C idiom and, since it is only used as an =
offsetof() anchor, is more straightforward than the
>   DECLARE_FLEX_ARRAY() expansion.
>
> 2) I guess this kind of isolated cleanup may not be welcome.As noted in D=
ocumentation/process/maintainer-netdev.rst, simple cleanups outside
>    the context of other work are discouraged

While this maybe true if the above code does produce new warnings then
it needs to be fixed anyway, from the commit message it doesn't
mention any build warning but that perhaps is because it is enclosed
into a union which mask it or something, anyway trainling variable
length should be accompany with __counted_by; so the compiler can do
bounds checking.

--=20
Luiz Augusto von Dentz
