Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417862ED843
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592431; cv=pass; b=rzkSBRN50k3Tw7Pjtx2LpwUw6JSf7BDJzaBMc0EfWkPj3QC7ts5ezvC3aUg569X+mtOwO+vPOFex5QurlWF0BAx40u2y7tGWEOhmRlV0OvHYDhZAT4e1N+0S/k2bkMHhUAUa6v5Gc/xeQ1CmBPsnNtVqJkIqdzZ0vmNUL3lHoj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592431; c=relaxed/simple;
	bh=e8wrO5vikecJwWYmKqPCipX+VB+wtmE5VFXv9Q/3tHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb02uTBaEjA+OoAhF6iECGIaN/DzgUExBL6wlGTmPKwO8VjuRWI19HPb5zJGqhZBpcJkgmK2FSCnHLqx15YkP/x/1QmtLZ5eac45+LPTgp+oay/s8TTdnxEbvHLz86pF3xpvejnes9r6yDyKVyqpYWzkRVWK2OMc5us1jCiUXbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XievHkLn; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XievHkLn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-650789b22e3so1732200d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 13:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775592429; cv=none;
        d=google.com; s=arc-20240605;
        b=lcYzjVX88utl1QoffMjWwJyrDlr7QPBtFwtr6okxuplKGDjHe+fqAnD6TrnOHCZF5P
         NtYTAHn1Oho7exUwVyAnyvpfLxQmO7fMLlMnun+Z0yC69PkzucGhQHnvl/lndcHbko1C
         BWnAncXJt84etMdY+0hsExbWZ/+DK/o8icgGevteUx4ZNrMtZExopk1WpPzQ59WPIJUT
         1tDK5thLGZPjuQCeTaJ9tcJfp2auvkdyWfNXyzZkboS+ddWi8CtvtIy8UZb0z/cp92ik
         +rN9lOM/RWX/COs2qdRpGIVRIaaqXJqiD285ZTKgF2D0UjiGtzofv6m6JzJTWcNdSKKn
         Sjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        fh=2fC5nNt1Z/6F8g7RNxvnO7XoUQ4PCMRw2Sat8Nt2YR0=;
        b=JEUdCAOGkqz+YP56rL+ERjSfY27VVev4N4tmWnxtnOYvcMZEZGGE3RteWItsfY+/Hh
         1IzG+AeRIvhSrM4oBInjXx+emjftpzjxevVpjdqiwHSDXgc7PNPn/PrnjwV5z2dmPb5y
         zhZcy/0lzROjK9HM/HEAYHbJgzV23gO3BQER3pfrJjhtoGLAghKJQ69WMROrXobAq7Ze
         sCcks0Udda0voHOKyWRE1P9Th3gXY23ORnAUPX3O/aFGaC8xVP0+lBIquIN3nPXYvW6B
         5D6P22gg/RHOd0F1+oFaXtmy0WdqUuli+pzjii1SgQkob8YvKI7HeRHI6uvLnrFFN35/
         nnbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592429; x=1776197229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=XievHkLnOheSp2jIgR8kESbGKj6CngEzh/Mb8Dey29za/HJrCDQg2qhnais2SlgGsT
         UaCbedRWKPdMdRnyezUm8lA1rrg21G4VJiEti7B8MctxOPpz8yNajlEjI1pHVNli3bxP
         hXbRlHkQ7JCAO0Dk8eWfpypyvXOwwQd1S7Tz3pePpWaqHdNoUW8YLhHKnG0vIM489e0z
         CNB1+xA3NgU6P8lU005PRZVgFz6btE0HEqghbxjWeR+W2OJnI6yZybLOrmpHfMlKjFEl
         2OFtwh+xgt326yFwjeQ88zWM7q1zfYtnMookj0Xvxx75hoR6QoUv/zjuT/tZkn8LqJmo
         7+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592429; x=1776197229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=BWIvP0lr5XIxT2o5ZeUE97/iGfSEn8qF4yGNr1wXwrZIU77OdKSDRqveE40QMwgTyZ
         QOfQg2J+Ojt5cBUPivqUGE/UJXE6uhSf5L43kllTBIog3Bs7eN5FO7sRXVPiNzCRD3S+
         rUokapTSwmAbYlweqKPmRSPs13NMjAd6sKncoKUmSN9Gc3kgiAIaGJT5LHIpSvUzkERo
         HLqzuTDKfg6/dYYRu/m0USGKqil5wKfiwzOOLHytWck7u+wvn8lq9jYoTtptzAxnDZq+
         4RK8TIzDGRCQjK2naq/Wdrm/1Z7DqU7NKw/jdEi9wXIx7yTtAkBSsG5OLuxIk1Pt5+G3
         SBow==
X-Forwarded-Encrypted: i=1; AJvYcCUgw/LUHTwQV1oA1J5SxwWIEyGDDQEg3QUaGLkr91Iy/oZmTlpcZWWR5mzHlDPRzr/PCRKa+MUnIZGOeDCJFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLABALjVFNtq9s/KAN76RudR6n2m/rVtUeyYBAtHphkK3FLf0C
	q6rragjuBv6hfUa0FJ2xaA1X7tQ+YT+SdDx9E8eRAJGrnin3WBI65fYDwcEFaQmO2hyRLwLi/Hm
	AoPvc/YQ6/dMl1SRjThVbY/2aHccsRm8ljD1xciU=
X-Gm-Gg: AeBDievbd3oPO4a2dQSD/XOgxGJdV8F1f8/TMwyxBcpXM6Hfbjxr85TSSrWy+tJwZO3
	wOLHBHTllXvVdMYMz1Wn7FFi9yO97LN9rygiMO2MMoC/t5906zzQSFi2DwPPti/69rr/FHJtDtY
	pauEzR90MRkJhB5RUSd0atmIQugvpV3P95FlZ8guB8RXN0tw8wu9qmkHKDbZ1VL718Lv2LptewW
	dGs6PDOieeJQhqaBDN6Pmc36TmH9gETFDcW45VkhI9XYT6GdTfTfcMeErz7J/XYNboZwEXziMpm
	rmfy9RxByiGXO7q078SuZFq/QNl78Rr1N/PZkQiaRG5crdOtzR25kvuymnKRcqyN2ziT7A==
X-Received: by 2002:a05:690e:1447:b0:64a:e781:891f with SMTP id
 956f58d0204a3-6504878d8b5mr18273755d50.28.1775592429222; Tue, 07 Apr 2026
 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ1FrL8qvvKuktBF@kspp> <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
In-Reply-To: <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 16:06:57 -0400
X-Gm-Features: AQROBzBVPVG9lewQAg4xWgXaY_QVQNvPxJT95QjFDd687G3MpHiw6Ni_WDKPrq4
Message-ID: <CABBYNZKJ9Xqwo0CF8wwax68etv8DywG8BmN=V1CWoWcfiq2mog@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping: who can take this, please?

Just resend as this is no longer available via patchwork.

> Thanks
> -Gustavo
>
> On 2/24/26 00:31, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> > structures, this is structures that contain a flexible-array member
> > (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> >
> > Since struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
> > create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_h=
dr
> > types, and use them to replace the object types causing trouble in
> > struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
> > std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.
> >
> > Also, once -fms-extensions is enabled, we can use transparent struct
> > members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.
> >
> > Notice that the newly created types does not contain the flex-array
> > member `codec`, which is the object causing the -Wfamnae warnings.
> >
> > After these changes, the size of struct hci_rp_read_local_supported_cod=
ecs
> > and struct hci_rp_read_local_supported_codecs_v2, along with their
> > member's offsets remain the same, hence the memory layouts don't
> > change:
> >
> > Before changes:
> > struct hci_rp_read_local_supported_codecs {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs      std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs      vnd_codecs;           /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs_v2   std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > After changes:
> > struct hci_rp_read_local_supported_codecs {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_hdr  std_codecs;           /*     1     1 *=
/
> >       struct hci_vnd_codecs      vnd_codecs;           /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 *=
/
> >       struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > With these changes fix the following warnings:
> >
> > include/net/bluetooth/hci.h:1490:31: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> > include/net/bluetooth/hci.h:1525:34: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   include/net/bluetooth/hci.h | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 89ad9470fa71..572b1c620c5d 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
> >   } __packed;
> >
> >   #define HCI_OP_READ_LOCAL_CODECS    0x100b
> > -struct hci_std_codecs {
> > +struct hci_std_codecs_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs {
> > +     struct hci_std_codecs_hdr;
> >       __u8    codec[];
> >   } __packed;
> >
> > @@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
> >
> >   struct hci_rp_read_local_supported_codecs {
> >       __u8    status;
> > -     struct hci_std_codecs std_codecs;
> > +     struct hci_std_codecs_hdr std_codecs;
> >       struct hci_vnd_codecs vnd_codecs;
> >   } __packed;
> >
> > @@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
> >       __u8    transport;
> >   } __packed;
> >
> > -struct hci_std_codecs_v2 {
> > +struct hci_std_codecs_v2_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs_v2 {
> > +     struct hci_std_codecs_v2_hdr;
> >       struct hci_std_codec_v2 codec[];
> >   } __packed;
> >
> > @@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
> >
> >   struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8    status;
> > -     struct hci_std_codecs_v2 std_codecs;
> > +     struct hci_std_codecs_v2_hdr std_codecs;
> >       struct hci_vnd_codecs_v2 vendor_codecs;
> >   } __packed;
> >
>


--=20
Luiz Augusto von Dentz
