Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B027FD45
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339214; cv=pass; b=QRKSGvKApO6fHlbNq09JVg9z4ZrZKNXSbdvUvwLGLBNhFY0NlUOXuhumDrMwlWc2RA8o+CCGTVLDq5BYpDBLXj7iR056fAGlykyFcsxnmbzQw5ngt6zkGRVxiVQb6/EDzZuJDLBRJ2gDQzywiFwI0bVTWaF3j5nv1McbbUMgBT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339214; c=relaxed/simple;
	bh=ZyAgppg8xtGBgqphdASne2ArBkRyS55Nqr5ugkW7s9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyJKgrVPhPFTxAg8hUw4C409TejcoME6160bMpi7TO7YNNrsOhiqLIvQ/yOXNPDexEaHBNDsc5UAjiQsiQyoxrjnEt2fEEfGDOSo1ZttUZFuDnfn29Fx7gpqWX4kVlNab2zaLcyOvdvJ0cPakW+Tyj5TZOlIsPJzfNn4Vr9EiC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhDvhbGi; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhDvhbGi"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649d4690174so3501118d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771339212; cv=none;
        d=google.com; s=arc-20240605;
        b=RZEvImPenzdEkAm12wG7WtMq1FRshMF04WIdSVG5WkuZtpDe0wnaPFxEUL/mtBtcu/
         CNxg6SDpw6COTzenIIw7Q84feCImsUAf1BV4Q6IGg/AFOecZsy3ID623By33CxFhpZyT
         b1pJUlehwa6FHmT5EaqzzyDmNkvG29y0NdRkUMFoimRpgi0XV1coL8xMlqVDEyBE3g1d
         qR/gAdb1Af1GjuG7DmSxwxdYP14VQik6EZO79t7UgkYC3C5d4QIyRoU2xjiXXDWfd5X6
         tZnTjpByWtBcCfOMPL6wv+mLNQPkbWsb43SWDqsVwq4gppagWRHaBMThq2D6XQbvaAJa
         l/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMBm582DjI/1T3i5qq3DdtpiHDjymwpNZGUf1p0PeGA=;
        fh=pqp7XuGOqWjrMXO5KdLlrVeInm9ggbF8oaBLutiYXhs=;
        b=lIei4oHj+5JkW6yANuQCBA+uSQW0QzPtMgt2+2e2VKax/TCYdFq9dxeSwbqm4Eyo4N
         94CiUiQj+2ucknSlNsIVvAJVdSWJbZ2D7dw33792m9giUsbminTcHx74VimxKPd/oREF
         4sKsgRf7zNo/oA1VboQ42CURU5wsAYTMDYH0noM9frzcA6x+JV745ldmJlucAV1X4mWd
         ZtPkUyk5o9BSH1hQW9I1htX/TRgovd5hoNDCQOuVRHVgzedaERkarmvThvJPlTQV43jH
         jnDNyCgJ9mFBI8EHm2JEmViOxu990iFo31fdU+SKgrt3BlPXJxI8p/2R4XJ0hZW9dxg1
         Z7ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771339212; x=1771944012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMBm582DjI/1T3i5qq3DdtpiHDjymwpNZGUf1p0PeGA=;
        b=UhDvhbGigVzNgKmK6MAfURmGGKESpBwKgp+4aT+mgI8mhv+FPOptpx3pRcY2UsN8sW
         gKbxBGXAQUzvXMd84Oat0PXDg5iXKd1ByP5sPdQzGGGJtmTKdE+cYqu1hgKAFMtrxcgO
         PJROkU/KV9DVX66Jpeb0cs8Ssz1v8Wan0keYIBvxuH3mpp8nPDNHEQL7VyLuDGHoIrP5
         3gKX2vwSSj3r6NjY3mvWYv2erTjMlYG5JtmX0v6cL+Z/eKZsUkBGugvBsiM9rsNGYxgo
         SbZIyfecbsepfnUW1e2xsqWw4wwatSQSjl+PvR5AMuhzKk3OvD9l3JyGKl8I16Dv+uhJ
         uw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771339212; x=1771944012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMBm582DjI/1T3i5qq3DdtpiHDjymwpNZGUf1p0PeGA=;
        b=vmGe+f2dFAoIkDTX/kMCwrAx2qc4GXgUrt9B346zEQhjGVo6aNjANCzrHmS/EeCR6Y
         /bQ2bIrp43nqFg1WW6oWQ0wg9M3kGqOksv1JZE1iVHUntbzPvzTByGXjdOWj1ClcuYZH
         ZK/50IS7OqPe7uc37CqPwygiz4RT71hyQHn9Hh0EuC2/HP6oz6AHs6xeAsYp9/OaQ2RV
         2ZjQb1KTncuDCOiYTxwrmgEGsEX99s57Zyv6mLOwU/BcB80L8AzFjnmOeakgEv7Q7VO6
         MQKo2aj2OwkpUx/bGDfyUfJaZC1oE+MWG4AP/Ww08ZteW/tSkO0gQzmdnNyCEPZ2nOFm
         wt6Q==
X-Gm-Message-State: AOJu0YwZjbKzC4dzLE/QsVpBAsPaTf/FHJryZc5nn2CFJz0lYmnIUbGS
	kbu1ENDGi1inEgXOfKamfG1QImJASyQ8GS8MeXbyDXFC9jjiD4luNzaYwWpQR2+9KEpti/w+BKK
	zOZTYuMk14FOwXvtg/+aeYHsIaax3NfXG9vJE
X-Gm-Gg: AZuq6aIvuWcKFC1p9Md7I0yq6vHPcNTX7AQhgxZV4J3erXIY5n9naxhZvgpTlZVp305
	5Mv9NVldHorLR1p/rhLDhNJS2vQsusdqircsqPs6beQXwIFmNS4rTvK/NtnL/835b0EJWeQf3vx
	oRQVJgRSZh/ImNCCy60AINSgz/nL2L6Ok13Xjn9U+0FsksZUEkXXSFa34dVJC0m5UEkiqgcVVE1
	1VWBu8wTAiFCokjuVvuDi6ZUZT6zLig/Waqg5Un/lbqqBboZGWnU/DEpeo4BiAKoSkQFl93jt9S
	3w0uW3AR/6ai+MFDgRFNPllH5xFL8s4lzFYTZcsblY+AKFwRzVfsxpiGi+FX6CDwF1dScQ==
X-Received: by 2002:a53:d015:0:b0:641:f5bc:6945 with SMTP id
 956f58d0204a3-64c21b6fb77mr6973871d50.73.1771339211599; Tue, 17 Feb 2026
 06:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213183333.1830534-1-luiz.dentz@gmail.com>
In-Reply-To: <20260213183333.1830534-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Feb 2026 09:40:00 -0500
X-Gm-Features: AZwV_QgDYnkXJb3mw2mbxcXrjK-T3tj6fNHyCAf18o2V3OwaODxf3syATHwceHU
Message-ID: <CABBYNZ+4pTiHOYHWES3Tc-u4eQzfHT_4Th-rE9fW2DhuYh8AAg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
To: linux-bluetooth@vger.kernel.org
Cc: Christian Eggers <ceggers@arri.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Feb 13, 2026 at 1:33=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a check for encryption key size upon receiving
> L2CAP_LE_CONN_REQ which is required by L2CAP/LE/CFC/BV-15-C which
> expects L2CAP_CR_LE_BAD_KEY_SIZE.
>
> Link: https://lore.kernel.org/linux-bluetooth/5782243.rdbgypaU67@n9w6sw14=
/
> Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request recei=
ving support")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9452c6179acb..f73506c35dc5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4916,6 +4916,13 @@ static int l2cap_le_connect_req(struct l2cap_conn =
*conn,
>                 goto response_unlock;
>         }
>
> +       /* Check if Key Size is sufficient for the security level */
> +       if (!l2cap_check_enc_key_size(conn->hcon, pchan)) {
> +               result =3D L2CAP_CR_LE_BAD_KEY_SIZE;
> +               chan =3D NULL;
> +               goto response_unlock;
> +       }
> +
>         /* Check for valid dynamic CID range */
>         if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
>                 result =3D L2CAP_CR_LE_INVALID_SCID;
> --
> 2.52.0

Can you try with the changes above?

--=20
Luiz Augusto von Dentz
