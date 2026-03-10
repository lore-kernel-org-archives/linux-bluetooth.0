Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E862BE02C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152376; cv=pass; b=Ge3bLD0zOz+7SK9sfu2KrZZl+u6p5v+b2S9lowrd+fdy9Xho1B4CdNBGOveczqsfFxeqhN33aQTyqGBGzZFuvuMThb39PRBYzJ7QBju7Bk6KPSg54TEQNyvAd/e8DH7+UOoIXqhMHKhdltGxwCCew2Wc/XLHPCnNRKWJ8Hf9ENk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152376; c=relaxed/simple;
	bh=FXuzSEvlfTs0Vh0BJ9So8bcs1J0N37bpJKEJ2HNewKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLbphvR5x60JiKZ4H1UWT4XOgBIvGWcoFgh//HSBdrDnjce3WBQpqTlXf7kV0U+EHtgbwgzsnlLiWEoHq6RE4HWVR6RDZX2iutaLKFKEZRqJdv3rBxSbD4AdUIl6XAUiCS+Tq5CkB1eqp1woDB0sUm8rkn4Yw9xP7W/uR9UPpGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlzM2JoE; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlzM2JoE"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64d5a7926cfso1149067d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 07:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773152374; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp+XSjDfUsb+LmpdZsS7H3gEBNd4MiRN83fNLXvpPSyeCvQIWVopLjF0uwYoqTlgrQ
         1yTIX7zRd40gO2mvcT87lOdREXGELyCxiwMKlAo8mcXXYqIZVkIW7h3vtMOrm2Jwa6kk
         WwGVJjH2eKvX7cClAd/fLoeWnC/nD1pJvc4FFAN7akxiW3/wtFQZwgP6q0Fz3hBDkFI9
         3jSvHEJeFT1N/KVBapSYCXG9J3qwWMDskditMdkkGwvQOY6VUpfzVt7WPVzaPBV0FsDr
         n5GGQY9G3Wq5JziGHR/xfeoTFOHUUg3lcoVMLv9OqDHVlUObmmv5mTfkKpbXHsC8WULL
         uJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FXuzSEvlfTs0Vh0BJ9So8bcs1J0N37bpJKEJ2HNewKk=;
        fh=XdUXspEkNvmJpqFoc43gzI/MDOH7wOs6p7Np4kwSTyA=;
        b=PZD1tKo+wUv3YJVYQWnn0RGguDG0vbW5pCdOqOfrIL7xd5nX4wLgVoe2vLUZQ0AxE1
         EOYU1fHDMI5LrjKWbnf7UVVfRi0s9p/PFsPJB/6dbyLOo8YpMSEN7JAC/LaCsk8DN4G5
         /rxzF84/AFeCM0Xc3Hf+CJB2liXDF7l164QvoxwSMjvrlKhWF1cHvRyw4c5hehdqXRsO
         LhEAWidQ3asRqazTUkUqv4CAEwSCL1fKsaNTmiFkt+mizTKvZxBxmcXZYWJVauaLZT52
         xVStPzD5PVNlcIpOg5Uopa2kTxq+BkVeJbSdQgTYt0xH6QUXErBr21nzCmKq0oaWOz1d
         BTMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773152374; x=1773757174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXuzSEvlfTs0Vh0BJ9So8bcs1J0N37bpJKEJ2HNewKk=;
        b=HlzM2JoEAK8acfCxAJ6Btexk9svfmILDRWH6yhifdtVDUUa3eB+GR6DxbLnZ5OgqZB
         LJzvReFsfAl6FFqDF6Lk+j81gEyR8pdTpzFiBrkrxZlW7yYqf7RhFFOibOQMDRPRsaCt
         xcs839pg56PmrfwAz5yjc5f49HitjR/U3iAeVGi+/19CWCetPjgQATriWRapW96J57b6
         6fhBywxgWT5agdLcRD/IMxZJjzB/vcXt8NYMn65hY1LP1vtEp9c4W1lWm4m6qqGiRaHJ
         QTMihDERI83KKY3vToVDv2B9nqrwJAu4mypWvkcZqKHDhIxeUbAK8uFvQN2h2goxT72Z
         F9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773152374; x=1773757174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXuzSEvlfTs0Vh0BJ9So8bcs1J0N37bpJKEJ2HNewKk=;
        b=OzZaEl3teEmzIfBOJ88l8F/6qH6+AJnFsFefLw/EOTBLrDB+OFVy3ZgiI7ZchpzIrX
         Xio/1639lQU8S7zW0hDb8FDitn0AmRii76eUfWpQm/YijAWte76E00MHJUvpRmHsvC6x
         dwGmSr8/OaESkyufJzkbLbcyff/kCXP2+vIqE7k9PQdIs6yziifMg5MZ1ZP9cANMs9xj
         apttBnAWeRyaqD0wwbMlmBZFuLNw0l9Ydj3OpnW1mfiRWJnoCLAkeu596hNuvT25VDCH
         OPe3Ae+8ZJrV3VMSmY6xd7yZMJC84QPw0VTN4uh/98Dyp7ejQP/JcE0FBRmZEaW44xvg
         d75A==
X-Forwarded-Encrypted: i=1; AJvYcCW0jIQ6lUkXmY04ObmfW+36HZYqKK82avjPqGukrisBp/0Eb6sC/SEo9xoXQRAvVSlpLJOKxuVZuuDUtKh3bzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0806OCo+A6e8g6GtKS08yz7tpzhI7QP8IIfWAqA28ZPk/OL/
	xVsYchcd9XbJpH+rvjcYrklA7bFvgdNQTVzVVOCw18msUneEtxUPthbrSMxQswj6Y2mih2z930i
	3iw+vErQVmfQuxcDR2e1Y+oK950TPBJ3UfA==
X-Gm-Gg: ATEYQzxOqa1zd1KXhOUC6Xos3vdFPbHkHIf+j9ewzL5hVHfEJ19edD0QH2M53QD0o7H
	vac/+oBHiRh2JMQUCRZlTyNFLY+j0Bnim+cvh8kAFUZ+AKlzKhTz3dXT43uOuFoDSqC7nrjsmWD
	pZuyvjgmyON3gsIbVirdBKNFKaECxkUM9iKYop4jdi6kN8ijXPottSd+iNu4Bl/7GMbzekDD7yX
	wgAAdsPyCPs2dF0ZVPOmdyXQCWXtGVYSimjzws4TI5PA/H2knPMRbvFhPfIPBDTXiIF/e+wfwCj
	RX59wGWQ/GuMbjdgSlgQJEy/PrGS5evkq3f/77jTVsCJYEjEfMHjnT0MVGlXo0syjavusQ==
X-Received: by 2002:a05:690e:449a:b0:64c:9a19:238 with SMTP id
 956f58d0204a3-64d140d7827mr10008533d50.19.1773152373902; Tue, 10 Mar 2026
 07:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
 <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de> <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
 <CABBYNZ+ePfwbc2NS-hG5g98trXOvUqRtp-ZiXD2crrvx-Lygzg@mail.gmail.com>
 <CAM8DPm1Ca6CDx3nOeJhEvTiD0510RteKd5Mw=Fg8hkZuA4oRKg@mail.gmail.com>
 <CABBYNZKtAkftUyyo4B5D7ADN80as3rE5dHHQcKoWa7tmUfBzgw@mail.gmail.com> <72946edd-fad1-4201-8c23-f36cfe925cb7@molgen.mpg.de>
In-Reply-To: <72946edd-fad1-4201-8c23-f36cfe925cb7@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 10:19:21 -0400
X-Gm-Features: AaiRm52AqdKTn6RHKnWZzAe4mhbd4vV7Xu6rPTVcSXZPTUPkSxvAnX3Kvi-LfK0
Message-ID: <CABBYNZJ31JR4ejwS68_kad6uxmNt0gBFB9eyM-yA+Ck5iiQQdQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dajid Morel <dajidp.morel@gmail.com>, Dajid Morel <dajid.morel@volvo.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Mar 10, 2026 at 10:04=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Dajid, dear Luiz,
>
>
> Am 10.03.26 um 14:47 schrieb Luiz Augusto von Dentz:
>
> >> Trace Analysis (failure_with_firmware.log attached): Here is the
> >> relevant excerpt showing the host aborting the sequence on the 5.15
> >> kernel:
> >>
> >> < HCI Command: LE Create Connection (0x08|0x000d) plen 25 #65 [hci0]
> >> 13.006556 > HCI Event: Command Status (0x0f) plen 4 #66 [hci0] 13.0094=
73
> >> LE Create Connection (0x08|0x000d) ncmd 1 Status: Success (0x00) [=E2=
=80=A6] <
> >> HCI Command: LE Create Connectio.. (0x08|0x000e) plen 0 #88 [hci0]
> >> 17.048391 > HCI Event: Command Complete (0x0e) plen 4 #89 [hci0]
> >> 17.052037 LE Create Connection Cancel (0x08|0x000e) ncmd 1 Status:
> >> Success (0x00) > HCI Event: LE Meta Event (0x3e) plen 19 #90 [hci0]
> >> 17.054039 LE Connection Complete (0x01) Status: Unknown Connection
> >> Identifier (0x02)
> >
> > Ok, so it is actually cancelling after 4 seconds, not 2 seconds as you
> > repeatedly blabbed about so in the end it doesn't correspond to
> > HCI_CMD_TIMEOUT but probably something else that sets 4 seconds.
> >
> >> The host systematically aborts the connection attempt after exactly 4.=
04
> >> seconds (17.048s - 13.006s).
> >>
> >> You mentioned: =E2=80=9COn the recent kernels the timeout is configura=
ble.=E2=80=9D
> >>
> >> Could you point me to the specific commit/patchset or API that
> >> introduced this configurable timeout?
> >
> > It is the third time already:
> >
> > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d56535619=
9d60e1cb94e5a77a
>
> This entered v5.17-rc7.

This contains a Fixes tag so it was probably considered for
backporting, but I guess it depends if the patch applies cleanly, etc.

> > But you may also need the following:
> >
> > https://github.com/bluez/bluetooth-next/commit/bf98feea5b65ced367a871cf=
35fc044dedbcfb85
>
> This entered v6.10-rc1.
>
> Luiz, would it make sense to backport both commits to the longterm
> stable support (LTS) series?

It doesn't have any Fixes tag or Cc: stable, and if I recall correctly
this was done on purpose since this introduces a change in the
behavior as previously sockets timeout was not use as connection
timeout, but I can see it being valuable for stable trees to align
them both.

>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
