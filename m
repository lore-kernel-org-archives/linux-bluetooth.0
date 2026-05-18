Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5726338595
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139647; cv=pass; b=O9ywav+cdrXoT9ziQKtjzc2vwC7vQKR+A5wGIuUTzgHq5mGjF9DNvHRSjAMgUb6/ydg8eGiMdDho8KooUkPkcs1dbF1enfJsP7S04SgXS4NmZgHpJ4tkOfSs3keX1F/koRlOTmUSiiQcnhDOMIDZ/Hgcr67Utni8TOmW1ATDU0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139647; c=relaxed/simple;
	bh=VgAICdKj1ChPb/ZvKV14I9LbkjTewMDtTPTnY9LVuiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJ16j34T3ylR30CkVkvL2uVtLwAAvihNwuKwtfcHsKYho51m+39jobStZZ4+LKIHlcSk1ZQH52wkfZchYXtjQPFNLWFwAudNSCkMZmw6PNYu8nZ3MHhE9M/qAPMZx6AiO3qROmXKdBbuJMGBhgPu2V+RXXH7k/g8efv049d/XUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjwSOjL3; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjwSOjL3"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c0bda7f15so2846780d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139645; cv=none;
        d=google.com; s=arc-20240605;
        b=XRYjOiPfWuIDBodcwXt4RGuMTKTZBdTnvrLZekW/9tAsa383tCLMo/mta07OBQ3+zx
         UUTwYTIh3KjUss74qpHMyQFDtX8wSEalEx+HUZR3GoH9KF2kGpc9uBXfZSMMMAVwAKWX
         Psb2R6+1oHIHzgdmVrh2oRzQ+3dGZ4e++uT3wIm2+ma/U3ThekG/oGoplONbLdtp3b9Y
         24X5RRZG8nGXlP4A/UrtcZmbpQeCpXGM1HfWngf1f156c+cM0G5fWtM07hSmfsMB1Dwh
         9Z+l//UDZKeJkaPr7cc/ebSMSCU2ANrRC3FVe5PCt1s84PQjHgwuyCQqwpCa+u026Y0p
         KEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FCWJ9LgHNt41XxZHeQBahVYO97JLwgjvVj/tk5rtZ7c=;
        fh=4wsg0a2fYeThL3oBtAuihHpwiWPI9eCHP257afCnjaI=;
        b=Fvz0wzen7OELZ4dcGUU0y+oVfkVd/OX+cWSU3z0lr894VAdl96OmiNmSMwWRZ8oGI8
         3IPOsUz4eB6wDGWL31xqWZOVSYgwXE3QMIekaPFFiLCfqRy9kfpnRPWLIWcxscN+ZmX+
         8/jt1tIiU981/D9kIqkusTfxtwYpoTUCZOzqKmVGDPrhW6tvC6+1w5/5w2kSJFiqVVi5
         PWzjgk+vryquuyNE2H3CEs0SaoMNS3QNDRXuKO9/6BzuWdzxM5kJMeRZQT1TSa6k7oqz
         Q9Uroy7A1/B60MqqQ8ULbYspsdQNlm+Vx/c8qEHs1Thu6G68llSngeVM3XNGvM1pW1xt
         MNtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139645; x=1779744445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCWJ9LgHNt41XxZHeQBahVYO97JLwgjvVj/tk5rtZ7c=;
        b=AjwSOjL3urV+Sssc8c7yrDDf5x00nvvfsldx/BHTRYK5beO8b5/2ViYTsAMFy9t9l3
         WfoS+oEPuc4EvEonovg/ME3jIUiWg8GUclK0QYwyPxdMyazMpAnAMI2AjwfzZy+Yi4x8
         HalL3aYqxNl7Ow27lbhJlPVTdppLpffr9Fgx+j7vx4/0IgCweIISYw56QR4PksddaSLe
         nPgHUE2MXY2VAivOpgvgFJsitGHprkKlJuja3413OSGHZPnhJ+P+N/0a9HM6HbtxcwtQ
         fohBCoopS+oXBP/cJFUPWKi+eJ9CQFmLpMEEWQ5aznlgUY/A8YdhMkogkD4qULngFzh2
         4KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139645; x=1779744445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCWJ9LgHNt41XxZHeQBahVYO97JLwgjvVj/tk5rtZ7c=;
        b=O20DLhFZuh5QyeQAy316g8fLxbsvM8hlBrYLZG4v7tgTmQ/MVqHNdnM5rZSJtCgbJH
         OT84QeEjwz0z5N3y3hd839/A+6DVGf1djLtgpkSe0oYYKFGPu37m8SCGtPYLBOUIZDXB
         WZtorGHRhjcCrUzEv8D+ogUr8cG76kweWcD+k7v0gz5wQaxaSy1bScU+IK+OkTjZcTg7
         CWwUaY2J/jHwXcZ1ZtAkezGk2OeAm4IzGHH8YYPXzhhWUMWpSIMRoNyA5hrFxDtP9EQU
         autmvwjegmOeQugljokxwOB2YiUcrUYXvR9IPkoZQWLj5EaTlJfGOLPACh0G/FDesyer
         JOZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zf5Xvp6j5dDPXkIjDxN4JoFzeGIvox1Xmu0a/bXX/cd2P8fSVQh6aBzLtVJENQhuR2+gNAQdeo0UhrXzW87E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+kCwMwzv2Eyp0PkwfkRzn5f0bOZ+mAJVjkXEXi6QQl/Ko5c2
	9mMsTBjHAzoNwWTuXJqg4sKpfl9g48MR9g8XL5r6L+bHNyDn47rFMNfPdLXNFH36HnLyA7KwZbG
	jiwHWGQMrUPwX7lTxs0D3wOYxKCmVmWg=
X-Gm-Gg: Acq92OGAilD9DZh9dBIihEn/BJcmJBAe/A/n0HW+1y+jeDGTG4QAWNv92O1BNRPWU7P
	zQwkPScqMFf8ICUmDNQ9pU9Z5OsH0J6Qz1u4meg0kbkcphR1J4nwkK5HPMvwbP1t8aOwAr8BODS
	Taje4FEbtJeCn7NWbBie8Rx/B0EkXeLBQWeI7tyeFI7YfdTE/ZqcdIJWGRNQI0btvzye39T/mDL
	0n8NEvzzyAnUAvKiudpHQOzkJH2skh9/SFZz91kg06bSzpdxGOZqAAfqeDt/a63SeADzIS/D546
	d+zCyXof1aZZRbMVSFEbjl3N2MtERqe7eL1BqZBoCKfpi9AEwXtPV54HwQdnPEFsbj0buP/n8oC
	QLQ==
X-Received: by 2002:a05:690e:428e:10b0:654:6ccc:69e9 with SMTP id
 956f58d0204a3-65e22897714mr13735432d50.51.1779139645547; Mon, 18 May 2026
 14:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
 <20260518010019.121323-1-meatuni001@gmail.com> <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
In-Reply-To: <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 17:27:14 -0400
X-Gm-Features: AVHnY4IaJZSjxO9U0WL95XQ1HlJCmI6H2C4aTJotkN6ZodbfMPScU-79CRHm4dc
Message-ID: <CABBYNZKA5SUNT8maNVzuAvxqaWYt-eU7F+h58oe8e==QsH53GA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sun, May 17, 2026 at 9:03=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Sun, May 17, 2026 at 9:00=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.=
com> wrote:
> > A response counter covering all outbound responses generated per PDU
> > would close both paths. Something like:
> >
> >         int resp_count =3D 0;
> >
> >         /* in the error path: */
> >         if (err) {
> >                 if (++resp_count <=3D L2CAP_SIG_ECHO_BURST) {
> >                         BT_ERR("Wrong link type (%d)", err);
> >                         l2cap_sig_send_rej(conn, cmd->ident);
> >                 }
> >                 continue;
> >         }
> >
> >         /* existing echo path: */
> >         if (cmd->code =3D=3D L2CAP_ECHO_REQ &&
> >             ++resp_count > L2CAP_SIG_ECHO_BURST) {
> >                 skb_pull(skb, len);
> >                 continue;
> >         }
> >
> > Using pr_warn_ratelimited() instead of BT_ERR() in the loop would
> > also reduce log amplification independent of the skb path.
>
> Thanks, good catch on both!  Luiz reminded me about
> pr_warn_ratelimited before and I missed that again.
>
> I'll give others an opportunity to weigh in and then send an updated v2.

Hmm, the spec does not have support limitation though, it just says:

Implementations shall be able to handle the reception of multiple
commands in an L2CAP packet sent over fixed channel CID 0x0001.
[] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Co=
re-62/out/en/host/logical-link-control-and-adaptation-protocol-specificatio=
n.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

Perhaps we should define our Signalling MTU:

Signaling MTU (MTUsig)

The maximum size of command information that the L2CAP layer entity is
capable of accepting. The MTUsig, refers to the signaling channel only
and corresponds to the maximum size of a C-frame, omitting the size of
the Basic L2CAP header. The MTUsig value of a peer is discovered when
a C-frame that is too large is rejected by the peer.

The minimum MTU seems to be 48, so we could probably use that as a
limit for the overall packet. If the response exceeds this limit, we
should reject it as recommended by the spec, but I think we need to
reject the whole packet rather than the cmd CID.

> Thanks,
> Mike



--=20
Luiz Augusto von Dentz
