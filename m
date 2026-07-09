Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE32D5925
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614221; cv=pass; b=ruIT5vf5QkrhfKkMARr5jKcI4/0B2mRMo93yUWM642IygswU79zqCbVcqTMSadakac4ujA5YKniNDeql1rFoEvx3WJXjGI95oi6qdl5R3fptCWbuHovjrcERSxV2AlNQcpqDsGVg4X+bUh/YI5PZawcSiuXNKX9AwR8ni+sz6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614221; c=relaxed/simple;
	bh=vYmjxs1YH/BT4J1DEjWLBYwLUCcli8aaDvXA5hyUAsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iywXE+2pQ16528LcnJnCDMYxSae/Vr0Y8YUeZuWNRlf1ZIgGXI/ozeyHtZdYHAJwQezfB6gn0wokHYrSrxl1ATTtB+H2OMar8+0HgxVJpY+0Tz3wuifNeEg/k3i+JTHOAgacmIp3g18uEhd/PPxo0xdSU7KBv0RV8UVfhX/wlJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzIBaGM2; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzIBaGM2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664d35b4777so1529381d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 09:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783614218; cv=none;
        d=google.com; s=arc-20260327;
        b=bVWq9GqXKCJMpy5OZbpQMhOzsmIr6QM14hkxVULbgn/LOrWIcBc/irb/UyGJCOUG/D
         GLwW6lAsael99Qf+cBmODfSxhrBn5K/TmHoXY3r6uXAfgyvxUUXxYbYH+QYLD3lphk7/
         +DidHflX0QIbr0JRAOjX5N2Pge7sQ5mB6DYPnqL0borYfMw57oB9PfuFGvMe1Ha0Z6iF
         Sdkb8TBF9TebZXJ++UI9mKgy5ci8SvUqqRXHxGMlSiIN/TARc1qB88A8rQEopQkAsHkn
         KS68h5rPzVYWR6DeMDxePvf5C0IlRARIOkU+pRJTdYpBO1SuK5KDW3XxariCGbmtzau7
         75TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vYmjxs1YH/BT4J1DEjWLBYwLUCcli8aaDvXA5hyUAsE=;
        fh=h2GtZZY16XGfmnFstuyvEuThwaSk1q7VKdNypZJFS3E=;
        b=KL8kDJrt2FLyK9uVblBM6uTiDHY9JeC5g/5dFvZAYWbs2uQfnmMXmE3kninq4sozKN
         XPpYf9MFq3ePrEyJJzk0ZOf1IDZqHdejJ5BpmSDcd59wHRmV5hfhk2vJNkinifnfs+Wc
         GgT0wkkNmavk/Maj33NJGLoV+EHSI2Tu/uJUJuIlfN/vKqAdet3EwtELETvISRpUIvxW
         Hu1iJxhfGXqYaaxd+YkHGPWd0Dy8QM7y3jbjbqtdH53cuIUXiStA1sIfkVjsEFmoKyg9
         nucD98MlITCY+Bg/uJDQC8kVUFakqiiGVuOd3ZNdHy8uOx4+NlzMLCGHWNnv1SmNzJAI
         iIUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783614218; x=1784219018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vYmjxs1YH/BT4J1DEjWLBYwLUCcli8aaDvXA5hyUAsE=;
        b=IzIBaGM2AhOZ9f6nugHM2OHyPVvgKaYtszzX4i2SmlbjP4UKpAgtqSyQJsBAQXgF5M
         yZawxlzQshmrho8aCPf/cZv5ItBo7VaAW1YC2kYpiv/yJlPAuqQ2Jq87NAe0PkF4alJt
         dYbLtd4eWnA81znjGqvLU0tzusm0YaCkDWpNN6mKDMe/Ewl3oKSZj6sT0iTFq6fOefPl
         SE8efGxQCKIajcVrMBGwS3oxC7Jlh/fpG96iLWliiIdOuWAmxZfs+i7LC3atxPfJq0AM
         urzl6qnWgRRy1fhPYzBqX8BcMWOTSfs4cXA3bBzrVm+ZWQ9faUkZe7pgOYbJt71epbIA
         fvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614218; x=1784219018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vYmjxs1YH/BT4J1DEjWLBYwLUCcli8aaDvXA5hyUAsE=;
        b=EyHSlHpd+edO3M+1RkrqGgbmGhMOIjW8+3LwsRZ6Rm/hdoylYvjknZa7Hpw1Ognx1s
         trirr+CIFdLQKgVXNs/qdXUFoqOW4+wIjBKZb5xmitEDjdfdhjA/yhY4lHY1Kbr5JJAH
         6dEYY0ooUupR9ULT+wiUgRmM3Dgxt1ZlyVbCPbAYVqO7o6pzslx/HFIVqkY/BHmk+9U7
         7nhBiFOPR/SmaEdOhh9GkLgUjwfBGxelkxdr547f1dlwEfyEc2m+z7gNLR3+LqDVL4Zh
         JMyy3sd+u0ipM8pR6OQOIwZb2MSZrfzmaCHPPps6GdE7ilT45E861bUV2pR3FDXXP2vU
         FEOA==
X-Forwarded-Encrypted: i=1; AHgh+RphznusXly0rlw9zht5uafo5pDwJ1XUgUHooUS+Pr48cVGwgYI4kz0/jQombWmNr0nZ7QK+hfj4k+A1yK+16X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHwUIcOSnngHHoyJW8+iiq6tYT9Ch1I3yhCCdRXLOG/qCV47q
	g4gJ/w8uc/EhAftMmR+sBtEvozKnsD140lnx1O6QFsFLU2yovVqWi4KUWzoqkff6Ugfz9tusXXL
	4QB3H8iGpyRQyI4JEnPNMWa4KvJUAGgo=
X-Gm-Gg: AfdE7cn/pKC9lJ/cuQRnUNJHS3O5Wt2jkTxRlbARmEdci44KO+PRv7SWgal+6im8wvD
	wx2j/OVAgYr6HQNOcNztbB2ek48PeQCE8bd2IO7c5dS/ksiUwU/JcSpDsHlAi8CENDNxAOhf9tn
	5WZ3ufFCfsOPvOfqBhndoE51j4fUwo6PvcunebNRlBpNevKqQGCbVGOnhhuD/ovScbRvy6d8BBE
	HH3d+j064fmu1eevhFL1ldLdKjang/cDdrGCp91DQ5QUA9M7No/7Mf4hzMirkDs6/z+0tZmpnwP
	eDwBKKAhO77csecpU5OFTTGeCrdwYZIf9or/XpgBBZFkCwx/19J6mR+wsiw=
X-Received: by 2002:a05:690e:4393:b0:667:a025:89ac with SMTP id
 956f58d0204a3-667a0259a5cmr3696252d50.44.1783614218349; Thu, 09 Jul 2026
 09:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
 <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
 <CABBYNZKxGTT5609JUo+04edy3X7hiZmWfXB2cmVGYLTVBz0O3A@mail.gmail.com> <bb434c3b-8523-4412-a3bf-dd888964ea40@zeelandnet.nl>
In-Reply-To: <bb434c3b-8523-4412-a3bf-dd888964ea40@zeelandnet.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Jul 2026 12:23:25 -0400
X-Gm-Features: AVVi8CeRLSCu2T3IygCooLjV7pnz8DjdxjF3uX_bnmMT2EvZVjTVToFmnUDycuU
Message-ID: <CABBYNZLNpsM8UQxM7wpfLKikM+Lto9t+aBne21xgn4t_2Oe1dQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
To: Tom Catshoek <tomcatshoek@zeelandnet.nl>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Thu, Jul 9, 2026 at 12:21=E2=80=AFPM Tom Catshoek <tomcatshoek@zeelandne=
t.nl> wrote:
>
> On 7/9/26 5:00 PM, Luiz Augusto von Dentz wrote:
> >
> > On Thu, Jul 9, 2026 at 10:39=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et> wrote:
> >> I don't understand why we need match_uuid() though, does it fix a
> >> warning? If so, it might be nice to do in a separate commit (fix the
> >> order first, fix the warning second).
> >
> > That is probably needed since the callback signature/return doesn't
> > match the likes of strcmp.
>
> Exactly, queue_find() wants a queue_match_func_t, which returns a bool,
> and strcmp returns 0 on a match so it needed a wrapper.
>
> Also sorry I wasn't fast enough preparing v2 with the added line
> Fixes: 91c340d359b7 ("shared: Remove glib dependency from
> src/shared/ad.c") Bastien suggested, please let me know if I can still
> do something there.
>
> Thanks guys!

There is a Fixes tag already:

Fixes: https://github.com/bluez/bluez/issues/2282

And that already informs the whole problem, including 91c340d359b7
being the culprit, doesn't it?

--=20
Luiz Augusto von Dentz
