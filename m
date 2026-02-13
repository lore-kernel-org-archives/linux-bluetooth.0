Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FD35D5EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000794; cv=pass; b=fafsvW8Odu8L77Tih4D64guzNRV+eZ5DjxTvZCDQ/4qrsJqpIUR26Ge21a09LzJeZ0Vl/yzPwCzAsTyjT8lWxZ2HgWPcfSIvVbxYXXx7nkgWjhdZ7LB1kW428Z23JYMjeouhOg/zYD5lmHBQ3fYFHRNWhNqurVYy4pwNRs1jeiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000794; c=relaxed/simple;
	bh=NxF8vxFdmzkv2G1u/nJmQKv9M4dm7SQFq62ouC4jZR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbbIP0Q2k4am5DImfVPgmAXYJKKR6lVSNOIo6bEn2CABerKBizVzSrDpY40y+dfsAxrhgspdkbaBjAQKijp4YMCWjhh5KEFI5zIpPdtut88/CW0bC5+UGK+9JzR7LKRwZlER19k2TPbFm/QtMKXTDMhx/oSXKf2EyHRp7BKucmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3ysRwr2; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3ysRwr2"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6481bd173c0so943219d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 08:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771000791; cv=none;
        d=google.com; s=arc-20240605;
        b=WmGdZoGNbhO8cjSBrZjkzZm6D/9U/Q0bvQyAkHVDde25Xw2BDBdYmZ4etb1KRkxBpY
         OROIuV2xy3MsuGCPJzW3/aLFxQVExl1AT7/AmRdVZoPZpwvQBSjONTNK8j0FTU5yGTYd
         gyc1L9nurAii3nsdY3Q5qKDMYiSSWoTXH8/ghbWfC/M9xjxpg1n/Hndy3eysgX6di/5S
         nk/09NvsFmd+0eXkt7zK5cZotf7ELqdHkY9lCc/Zq087DaFLum1dUApQGPI8WvryiHK/
         Q1o3fLJ+/6BuATy8cvOzU28h46QSoxe1W21b1Bm2drWi3NeKZf/8+rxbNazMMyluQty5
         vgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iKun//2h4NkbjNQhpNDR8KClkumMIupv9yHLN04OHhU=;
        fh=ovKD07EXtJ6SFo6Zu/RY9DlGXj+WYK1s+4jzak9kWXU=;
        b=LzI810zj4i6e7XQXm1UOvgxwdR33InOBjm7FMSM/2RPZnX00xpscOYiZxIfkVydoEk
         lKl/Lpe5K9y4D1WMr+qE/nsBcbgCl7GVuCQibEM5WbQGmoBCoSWCcPswwFQp4LB2aww2
         R/H9XcgzcxVW2PnD3xEBDC0Cokl/R3LkN5XPCHk4PELLzMsjUeb7BYU06hAUZa70r+YQ
         jipMy7+dNkcu3YZErDeYzPrNgkbAAQ19qUJJeXBexJz7URf6dayNj1l+8r6pGVXtG2Ge
         fLFyuRWjNdQ4JfT6DZEVZnPfKDObjPAusPlPppsMQCbDqW5wWCfoe4SwLu+czqTcJrMw
         9kHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000791; x=1771605591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKun//2h4NkbjNQhpNDR8KClkumMIupv9yHLN04OHhU=;
        b=L3ysRwr2SK7pqEjYqxgGj1uplrnzrSXGAuF8YtywTxjgPYJK3iqmxZNLZT3Shg3twA
         +zpClOFeIjr/LxHkcMFbvBwL5bVrF9lXwxY/5pXfDYHeJ5FOI+AgT3zWOpaLcBNwfA/u
         9OQo+PIS1a7V1RCdtYIyu6ArJoEI5x+wApufnt6iYg6NIxeotmWHyYtkYQzGzGvFWw2p
         IYYuCEdcBTcmFBptXXhm21NqiVhy92VnKuVQyOJZ8i9+13n//0ImfyqyDc3w2IBKnLin
         WC210hq12j7w2nV10cAg8tMuzDrWk7nYp5yefr0lJo+xHa92LBMWhudDEOtB0rQCeQrf
         9psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000791; x=1771605591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKun//2h4NkbjNQhpNDR8KClkumMIupv9yHLN04OHhU=;
        b=v2hdPAaWf16kkSnANPaFBXmILgUyooY50YOKTCsr40jNh9LaDcegFr2C4eSTWoXJ17
         s9gkdQmvaLz8yuYiV7s8yvMofS6ADqlsbFbmTCVSfDeevCgVEgGXIaNo0KshW+ICUjMu
         w9caEaTaCHvfRrEC4xLdTcfPFuj9pntkDa+QR7sAOZ98od2lDHC9F1AJwUM10bx3uyLS
         zlNRqpqaRabu606wh03/q3VQOUKBcYfjXXD+yzx+WcolxAVCtbg4S5U9RfiN0D+Iz6+/
         xezNF7sItnCzNHCs8HYSQCGOkoWC3q/eRX6CFLqRFSiPP23NavWy4FwuTEWieoCD4g5R
         d+jg==
X-Forwarded-Encrypted: i=1; AJvYcCX3W8W6jam77qhfQpKBLwC1Kj/1I+TNhvTVx8wOtUFaPvRU2+g2uEWzBNGJzYFvtJ/1D0krSmbED+8oI38PaZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6KiuXB2V1X73HygPjG6tSzx0ZiftXcj5u/+676x1CWMPCK5N
	hSme8up5meK9TYOaqyFGWdfZwxB0Mbxf83lLJW6/dX2dNj7aLBWXaAXBBmEMGIywZnd4xszNnI0
	9C4Vxsoyogj8zb3tDCA9gdpAN3q1hFqY=
X-Gm-Gg: AZuq6aI6BJFb1oFZoc0CGhMNVOWGiOjT5W76U0ni/qj7wHq0Rr2GEjWojyRmxUn7CZa
	h4ITEgTJB9f0n2CPu/eTHbUowTakIyuZZESzD+2X+mIIzWvORibARp6DgtZ6BFFJ7pVnAm+yO3j
	lqb7mrAb5kZOBPbbYVY6y7r3VHnsbCARAwe5c/1uoHmzNSKbXyH7xCz90ye0VfcN4TKJeUmdE+e
	09DiziECLtQ1eDxsIjX3Jdw8nYqv8if628qCT6d1BBlgFHpJ5A/3hwOVxREwQ1l5siuq3YDSUoW
	UOlxspDcHQSwLHbJMLrinDP7pyB0bcxdXGbWZhY0qBaEtCF4wEn8PHuz7BuwqqhRyuw9Yg==
X-Received: by 2002:a05:690e:1699:b0:644:444f:3bc2 with SMTP id
 956f58d0204a3-64c197b7b68mr2179093d50.22.1771000790987; Fri, 13 Feb 2026
 08:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5782243.rdbgypaU67@n9w6sw14>
In-Reply-To: <5782243.rdbgypaU67@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Feb 2026 11:39:40 -0500
X-Gm-Features: AZwV_QhKkixPbycp7ryEpIk1Kr7LKZRYQNNPNKNpD-fDBU0wrtomzWGz-pO5Fdo
Message-ID: <CABBYNZLxw5iMU-OFGndS3fE5ooXA5Yxyw5OvUui=RHh0iR15vA@mail.gmail.com>
Subject: Re: SIG-Qualification: Problems with setting TSPC_L2CAP_4_3
To: Christian Eggers <ceggers@arri.de>
Cc: luiz.von.dentz@intel.com, frederic.danis@collabora.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Feb 13, 2026 at 9:27=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Fr=C3=A9d=C3=A9ric, hi Luiz,
>
> if I check TSPC_L2CAP_4_3 (as recommended in [1]), this enables PTS test
> L2CAP/LE/CFC/BV-15-C ("Security - Insufficient Encryption Key Size - Resp=
onder"),
> which is currently not documented in l2cap-pts.rst.
>
> This test checks whether the size of the encryption key is greater or equ=
al to
> a specified length, there are already several similar tests for GATT (but=
 not
> for L2CAP yet).  The test case expects, that the L2CAP connection request=
 is
> answered with L2CAP_CR_LE_BAD_KEY_SIZE, which is currently not used anywh=
ere
> in the kernel.
>
> For GATT, it seems that the length of the encryption key is solely checke=
d
> in user space (bluetoothd), while for L2CAP, such check would be required
> within the kernel.
>
> Would it be possible, to add such a check for L2CAP in the kernel? Is the
> length of the encryption key available there?

I guess we should probably use l2cap_check_enc_key_size and then use
BT_SECURITY_FIPS (mode 4) security if the key size used by PTS is >
HCI_MIN_ENC_KEY_SIZE(7), if it is lower, any security setting will
suffice.

Let's create a github issue first. I assume we will need to do
something similar for ECRED connection request as well since it might
have a similar problem. Anyway you can try with the following to see
if that works with the channel you are testing with:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9452c6179acb..f73506c35dc5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4916,6 +4916,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *c=
onn,
                goto response_unlock;
        }

+       /* Check if Key Size is sufficient for the security level */
+       if (!l2cap_check_enc_key_size(conn->hcon, pchan)) {
+               result =3D L2CAP_CR_LE_BAD_KEY_SIZE;
+               chan =3D NULL;
+               goto response_unlock;
+       }
+
        /* Check for valid dynamic CID range */
        if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
                result =3D L2CAP_CR_LE_INVALID_SCID;


> regards,
> Christian
>
> P.S I'll be unavailable until end of next week.
>
> [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/qualifica=
tion/l2cap-pics.rst#n320
>
>
>
>


--=20
Luiz Augusto von Dentz
