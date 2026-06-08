Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E830DD1D
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926256; cv=pass; b=iqERzWB8LvaYefOy8+9m4Ds4w1SSlnmVxYpVM7IaSNda2YL3MQSj0R/xVCHxIKYj/7l6LitoxNhtX216F26yIyHsE7gVEGQCKtgk04wsH2Yjh16VyYnflI4Zdya3H8HUZ+y2CzawfVk2JruHX3ilDQh/Ct9GfKWBzsNcsCKq468=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926256; c=relaxed/simple;
	bh=ezd/PoLvI0Z1RoKgF/d1R5fy+N3FNSX0KL1ZMfAbnqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSKfOFnboBz41xQb9pri0+POpwUKyqTJ8AdE/diHMb0cWiOejL1yWUDWNcyJZly1xCkV74vKHPxVbQz2Z7nWfAiuEDEAq2AHg01/r8sboqrJ7bT27CvbUbomqxsalu8wKxau5ELGQUuZqytBLdtdcO0+l7V4LcCyG6FL0fZ/h3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dae/y64b; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dae/y64b"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e8833c99fcso49052417b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926254; cv=none;
        d=google.com; s=arc-20240605;
        b=CsAeaZn3sSBZFZCI0A745ZqrrE0le4ABhEdaF1DpMrbQ3y4jnzmoSdjcty+3Albqlu
         cGy+7y/xmAdn27S/wMzGjpNXwmn1n1isIjSnMzGmUVBuqWs5mQO/V1v9IbVuQ9RS4iRx
         qGK2ixwI7BSmtIUQUaNgh07SkY2v/pOLXxqGK55Ex14g1hriF37G8I9hc1M2vBC2iAfp
         /RslQU0xF28N0NuchlNYQwMYRTMxgA18vs6hbwH/5deJSy8mYm0cDbXitGqPNF02v8o4
         JntXoG6yPveXnrW0PIhmqRP9WYZeUtk2jy+/0wghEsxAbxcHD67Hcb8GNu+JRbapF9Eb
         jTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMDHZIEIudUtq/ww46UkAChtFT5NXaZLDi5z3sNKrvQ=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=EDHVxlTqvHTBPdUv8EESB/CLdd2yogMRHsryyp7SWCPHtFiTv5+nHKQZFP00MX6XVN
         v9X51bm9XS9ZMW75/MjGMckoZNemPWUwqJR21e/rEtyrdInlEHdwz00xl5xXBfMYSnnA
         kcQM+0QvFvyp4Dkcq3Zm3C914NkCbGynC7dyBqSUvLWWzqfwNeWBffTrH+waMo8IXRwN
         aIFQB5GDHaelDYMeog+ekV1hu/jQq2Zr4rX6nizCb+32335JU4jULRx8qNgnl34jyo7w
         Fhek4wBMOv3jiLOQnXZFVhKo7ZzSBoCkKEoN04jeQLBJSDrtBbbu42XIXOOFk4dBIh5T
         dpoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926254; x=1781531054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMDHZIEIudUtq/ww46UkAChtFT5NXaZLDi5z3sNKrvQ=;
        b=dae/y64bdjgo8vcR14gGIWVvXXPRGnBhoVkA/7vtxzG/NfNXsq65/XPzUb0cNeBWMz
         eu2x7pCqIcqjlvHIlQe+RJCqCmYzARS9BpPfm5BnmYPTeCKnAw6Rn/lTjKIa/78/2urB
         PpqHRn6Yj52CMkefKOWBvnzClVLWfQXcCK+OrnxsCndZYQ6hTc3+QCaxgY9EPvVxkFsY
         T61ddbr7YM/J4iXjpmeZbfi0xxfwaCR1N3PB+7P2Ha7dO1gJM3S0JFsWG6mGQlrIiOeN
         5kKou4cdvpbkxNqwV8kiqJtmTgj0Ltz8EEIdYWFUc61xQBdCFWlwfSoy2Ptn9VMXZiye
         na5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926254; x=1781531054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMDHZIEIudUtq/ww46UkAChtFT5NXaZLDi5z3sNKrvQ=;
        b=B2vP+LTuG7R3nGpbU3LCzFAeqNFjG7yvNUfS6HhrjX415K4HRqQMaRo6q/8wX8h3hQ
         Pm7cwfogrAE7tDcv5/Xqgb5ODmaC8oWllYnk2ASHu/sT5f4fAbl/vgTbP8D6xggKQ5zY
         RSugZ7POlxWFaktke72X7MRoDRjRkfbBO55EVNxRYdN92P7sUsaHxKuffz9bTBrmfX+e
         YNedfbIHqKLZWR84vRDW904pfXg9lZSqre4s5ZJnwEiYErLOTbIuA7AerHf0NDr+0KBy
         vsOzNuPFvUjdyVhUP7FJpk+wUv3cxFVQePDQ4kTutTHXtxOC1/yeS2vPegE1lAHiDzxA
         2ixA==
X-Gm-Message-State: AOJu0Yz3yUxAxsj7GUSxN7x6xtAykiyd0afbXDC+EFQw8Mcfw6hiVXE3
	lvJdfaC/AD+RbZmpz3KrETvyl8sIZYo0OL2cIypBwvltVltoR+/ng5edOJw4SmnrVboBJWpTwA8
	9sm9Lef9y25ik+X3H6eCeqFGZRocPyWXViMuhR1MYdA==
X-Gm-Gg: Acq92OFx6yftbk5azROOBSQC1dnCftsFp6aLvLFQwUwXQBRNbfsH/tyYl0ETDO+8E8y
	I2B3b2H4YX/5sF+o/V2X8W++2sa7fu5nmmljVoFXJFMcXhjL+PIwbOC65Z7TFhG80STTQygjxAV
	tbm+hNsJkTt3Gezmvk6y9fDPAkmFLtIUcDLo1OHVFyYfpgeWzC3PFPMKq068Ublf9qG5xA4950C
	33tj5WBugVlWlSH2TWqDYvKrOWPxcjtS/+ADDDHH115nAdky0yySMceplX4NzEWsxzdwRe79AQH
	IoEsURwJ2CS/c49Tib4Oms4XQVeY6a2N3SytNNQPPsXC89cbG0cSdRg0WEZjcdaCZ3jPGsrvmxk
	EjR/E
X-Received: by 2002:a05:690e:43d3:b0:660:6971:db68 with SMTP id
 956f58d0204a3-66107019871mr8665525d50.35.1780926253570; Mon, 08 Jun 2026
 06:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608112028.3686726-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608112028.3686726-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 09:44:01 -0400
X-Gm-Features: AVVi8CeTWJxtwS4EclpUVR-xuhEKyUPdfeGjbuYMrEXqr8jLmCVBI944ggZspz8
Message-ID: <CABBYNZ+yoX-HWoNg4=wcqbZWp1fyK=_cEzhwd8m3P_jQWO41mg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] bap: Fix CCC value for ASE control point
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 7:31=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> WriteWithoutResponse was missing
> ---
>  src/shared/bap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8fc2fb14d..968b85730 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -3776,6 +3776,7 @@ static struct bt_ascs *ascs_new(struct gatt_db *db)
>                                         &uuid,
>                                         BT_ATT_PERM_WRITE,
>                                         BT_GATT_CHRC_PROP_WRITE |
> +                                       BT_GATT_CHRC_PROP_WRITE_WITHOUT_R=
ESP |
>                                         BT_GATT_CHRC_PROP_NOTIFY,
>                                         NULL, ascs_ase_cp_write,
>                                         ascs);
> --
> 2.43.0
>

CCCD explicitly requires ATT Write Request as per amber.bluetooth.com:

Core GATT does not allow Write Without Response for the standard
=E2=80=9CWrite Characteristic Descriptor=E2=80=9D sub-procedure. For a CCCD=
 write, the
defined descriptor-write procedure uses ATT_WRITE_REQ / ATT_WRITE_RSP,
not ATT_WRITE_CMD.

The exact source is Core Specification 6.3, Vol 3, Part G, Section
4.12.3. That section says Write Characteristic Descriptor uses
ATT_WRITE_REQ, and the server returns ATT_WRITE_RSP if successful. The
procedure mapping in Core Specification 6.3, Vol 3, Part G, Section
4.12 lists only these descriptor sub-procedures: Read Characteristic
Descriptor, Read Long Characteristic Descriptor, Write Characteristic
Descriptor, and Write Long Characteristic Descriptor. It does not
include a descriptor variant of Write Without Response.

Supporting mapping is also explicit in Core Specification 6.3, Vol 3,
Part G, Section 4.13:

Write Without Response maps to Characteristic Value Write
Write Characteristic Descriptor is a separate procedure

So for your original ASCS question, the answer remains:

ASE CCCD configuration is not specified as Write Without Response
The Core GATT descriptor write procedure is a write with response
A CCCD write should use ATT_WRITE_REQ, not ATT_WRITE_CMD

One subtle but important distinction: Write Without Response exists
for Characteristic Value writes under Core Specification 6.3, Vol 3,
Part G, Section 4.9.1. That does not make it a valid GATT
sub-procedure for descriptor writes such as CCCD.

--=20
Luiz Augusto von Dentz
