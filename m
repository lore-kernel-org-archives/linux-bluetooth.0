Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F52C11FE
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306038; cv=pass; b=mMXlAZoIuDUwxuvmrG56DnCpELlawahnMbyViYSQirt07IK/P64pA7YzlWT378Yr2QeaZig0zg0Eoi/PEnjINBmetgg87AaOPPCqr48EednJT5zMKRv+HJDB0TAbfF4kJ991gQ+7X5yeRpQtHgibQZiioXiw2Z09HdmS1q0C3Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306038; c=relaxed/simple;
	bh=u7XYhJb+VA0D3mcaCsVMD9Zazn+oLvqmz8k+X2poJvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEcWGDBxQqa2gszFRvpWn4lfDS4mz13LtGxP/0Q1hgX8vJAIljWe+5qGzQczNuQunX3N+qCuhvUrNBlRwyOgLlGOuV9ofxVYw6j96/zRfcNy+pelo/pG6iLAupuww+pH9vnuP2vfRtMC2E8DncSO+yp4JtZQdEh3Fi9SNrkkeqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBEPgd01; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBEPgd01"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65e39d1dd38so4808795d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779306036; cv=none;
        d=google.com; s=arc-20240605;
        b=MxoCK/I86OJHpFFnP9InBTwwHajAr4ei+kldLFvEGpQ8AXkfVJeayG2GPfd4HmJf2r
         GeNKuPuh8SEO3Z1l77AUj+dkW7GpMdNVhq3P+gtKMhu0ee1CCLwBx7XJAuczfXuPD6AX
         E5guWfE9mewVADOT8/a966v2t5BIbuMaELfKadsYgmLmlEW39nMwCrURK92szeIj3Fpe
         B2qDjTF6no/EMogVeY/OpxRpZXupmgPi//oOX5fv+nICoAeoBnlLuMqkQrv1AH/vxRMv
         k0RZpfAfpHMdMaX01YGjMKuD48TjjzHsp19hMWGsA6IRnoJDWKgQfziDl5mGT+jglj42
         yc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWGsRdr3qURko4P+F4or7l1V0AQnNVM7Qh8BOhBeOQg=;
        fh=xxWjb0GfXkzqM0SlXyEXHwpLk5Z2lCPjM2GQQogQOl8=;
        b=FIQgNrNyxaDxKdEp68hxFDU/SaP/2dZrxooGOUGqj6vzzDDBA7Jah24EpW26+uZILr
         v0wHOK0hR/mqWwH7oaPVCkNyYFUuyJOFO8MzST7NhQSFL4LaQvUA38VgJ/tE8aV+NiYe
         lWXDok4Dimee12o5NlMJhXOfwqv4+r5k05IlQIT+rhWuK2MfWRxyzve4CH8ghqABgJ+J
         mj6cdOOtWyhthKXICdGYUYsEWVF5PhpcKZb/M9nw4yiqd/zcaJ4FuBkxsJqNkN9aG79r
         G5T9L5+GxJ7q8nKmVePvG4268/nGgBHtlIkJzg8h0+bmyZjdQ5I8zMdCR/rdgl2ywWeQ
         WYbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779306036; x=1779910836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWGsRdr3qURko4P+F4or7l1V0AQnNVM7Qh8BOhBeOQg=;
        b=eBEPgd01fEO72RPQmgXVqdDUqoFkEVBjUcfeMwjBPbv0Q7OI8jaRlIf6AsM+ligBE8
         hVu2B54teqqCRYJdSSkFSRK+Sj40HNLuUUTJgm65K5OIjx5W7o4vujM/WHJdw1bPyVRf
         5UcCzyfBsBTmltnh8RX25mxUKXR4Jrai110LalMB2c4pIY9wXfBe4iYfcUe6I9gH+BAB
         5pKkLPuk/TV/UKdHaLmRLRB5jZ9qRRO/1eYL1+d/hm7Jbl0Duy17Nnd1vuYELeefxrPp
         LN6ekG/C6bZNqU7mGV9DZbutw7vFZD9uFv+bDZgd1ZSppkCR/6iAsyO/x6wo73n2M2zV
         l0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306036; x=1779910836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWGsRdr3qURko4P+F4or7l1V0AQnNVM7Qh8BOhBeOQg=;
        b=NGVSWr7uCmI4JiWO8JRBZq7oyPZXKDpnxbizMOb1iISJuMj5t31z9LO8vpv/PkVrkI
         E8sTPLlGJz3A/EG1C2KRW2L1TGMSNRarEqLOjg5OGn+rt6mw52njnYqTj3CUg6iivWNg
         h2r1ZkqWT3Akqb5JT2KkeRQgx2B1W4XCG2EY7pxjzZnjqSv5SumoY6VXBWxxs9ei8R2D
         2v9m4KLfC1SpxBNGp2rKIniQmAIDMVGZfpnOn4CNkaZ6etfL9oA40HvtmIcvyhHPwgSO
         +Qe3/O+3LBBSRRKRnQBiWG8qFRaZXqfsxNdcJmltPtdtIiT6JPey/DwqWnDK6m2HV1+1
         OjtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KZ2mtV5We+JSecT5JJLYmibzMOYlPAR/dfWXfwDoZ2L+U2VlsFLK4n4iUCGiVll6bfHItu/AUJ2KF0y2Nbo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU8Kl6dJk8wtzgwvv+ZThDN3bsBShwRAWMI7uPHclD6hGQWR1
	974OPZ23ju4tORNlgR4e8KU8ssvAYsbvEe9bX0tTcex10DcXIKF3w+RtnunSDFEuDEVfRLpU3u3
	yAl4FtIAWvi7+JJQpTTHLW43hPj9OH+o=
X-Gm-Gg: Acq92OESO0E365s2ypR4n3uNpT4G+zaIFSncgB1Mzf2f4H6BgM9SJ/dteSDKLs2dZiN
	R/pYLWpndhBL4fwnjoIRwTwKHPhyHt/kc/ILBeg4YG5Y1DvHvZzX06D9dVCsG9RsmGQuP73WvIU
	0l3YvQCZkGt/BiMt068HMb1LIltjwuaupo/AXBT4x6xee8QcdQPCkJB3fgsucuUdwai6HnNI7+u
	AAvnT6EGRpE07tuOew7Ir9Pg7HqNd1xsWPR3vv1dzWQmiV3vrupWOjxfNNKzCqgNYFmj36lcoAV
	hl81kFQ0uPVG8wvFS6ZGbGyzqDr8nUf6Cfuy1PobtSjZfh3MPe9dPrPglJQzO9sh3hFHrA==
X-Received: by 2002:a05:690e:1699:b0:651:bc7e:467a with SMTP id
 956f58d0204a3-65e22893fdemr25269832d50.60.1779306036131; Wed, 20 May 2026
 12:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520163859.2859782-1-oss@fourdim.xyz> <CABBYNZ+6bP78+_m_ehhif3xCXxn2ZLQE2q5O3X_03mU8=_T5uA@mail.gmail.com>
 <ab53262f-329d-4c00-9575-8b3a8e96093a@app.fastmail.com>
In-Reply-To: <ab53262f-329d-4c00-9575-8b3a8e96093a@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 15:40:24 -0400
X-Gm-Features: AVHnY4LrhV6I5xjQIb3LICrPNybzZ-aGJgWEG6xICk8MiOPY6B7Ufq3NUGjT26A
Message-ID: <CABBYNZLWU4gzaLytLBD7V4fnFWyjXB4312tB2q00VRDTT6jb7g@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 0/1] Bluetooth: L2CAP: Fix slab-use-after-free
 in l2cap_sock_cleanup_listen()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	=?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, May 20, 2026 at 2:57=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> Hi Luiz,
>
> On Wed, May 20, 2026, at 2:26 PM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Wed, May 20, 2026 at 12:39=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
> >>
> >> Hi Bluetooth maintainers,
> >>
> >> A public patch covering the same UAF in l2cap_sock_cleanup_listen() wa=
s posted to linux-bluetooth on April 28
> >> by Safa Karaku=C5=9F. v4 is here:
> >>
> >> https://lore.kernel.org/linux-bluetooth/AS8P250MB079109F82C16BEDC4F9FE=
584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM/
> >>
> >> I thanks for Safa's report and patch. I already reported the same issu=
e privately to the maintainers in
> >> April 11th. The public patch breaks the embargo and I would like to re=
send my patch here.
> >>
> >> Safa's v4 closes the sk-lifetime hole (sock_hold inside bt_accept_dequ=
eue) but does not take conn->lock around
> >> l2cap_chan_close, so the conn->chan_l list-corruption race in my repor=
t is still open after it.
> >
> > Are your changes on top of Safa's though? That seems a lot cleaner to b=
e honest.
> >
>
> My patch is not on the top of Safa's. The diff looks quite different.
> I reported both the sk-lifetime UAF and the conn->chan_l list-corruption =
race
> privately to the maintainers on April 11th. And patch shortly on April 12=
th.

I'm afraid it doesn't matter if you reported first or not, Safa's fix
is much easier to understand. However, there still seems to be an
issue of calling l2cap_chan_del without holding the conn->lock.

> >> My patch closes both: it drops the parent sk_lock, acquires conn->lock=
 =E2=86=92 chan->lock in the established order
> >> to serialize the chan_l mutation, and re-takes the parent sk_lock befo=
re returning.
> >
> > I rather have each issue handled separately though.
> >
>
> I am happy to handle that separately.
>
> Could I get a Reported-by on Safa's patch since I reported the underlying=
 issue before the public post?
>
> Reported-by: Siwei Zhang <oss@fourdim.xyz>

You can do it yourself, just respond to the thread. Bonus points if
you add a Tested-by if it actually fixes part of the problem reported.

> I'll send the conn->lock patch (drains accept queue to local list, drops =
parent sk_lock, acquires conn->lock -> chan_lock in
> established order) as another patch shortly.

Don't quite like that solution though, we should be dropping locks we
didn't acquire on the same scope, besides it seem that was doing a lot
of malabarism, perhaps we could just schedule l2cap_chan_timeout with
something like this:

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4ed745a9c2cf..413b1c63602a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1529,8 +1529,11 @@ static void l2cap_sock_cleanup_listen(struct
sock *parent)
                       state_to_string(chan->state));

                l2cap_chan_lock(chan);
-               __clear_chan_timer(chan);
-               l2cap_chan_close(chan, ECONNRESET);
+               /* Since we cannot call l2cap_chan_close() without
+                * chan->conn, schedule its timer to trigger the close and
+                * cleanup of this channel.
+                */
+               __set_chan_timer(chan, 0);
                /* l2cap_conn_del() may already have killed this socket
                 * (it sets SOCK_DEAD); skip the duplicate to avoid a
                 * double sock_put()/l2cap_chan_put().

Or perhaps it needs to be conditional to having chan->conn since that
indicates l2cap_chan_del has not run yet, making it safe to use
__set_chan_timer.
