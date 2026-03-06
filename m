Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB13A6417
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821660; cv=pass; b=MtHo9oXbijRa4L+it2qIB3qlNvquGCCELDDrJ5gXTzY4iNUARkP7UkG1WeQJT6KAaabTCY2qObMDepiZOCWAH06L6srEAQL1+EkIDMBD8zfLMfI2NhbOBF1gF2HJ57E4oVFLzhx/relAo0M6bTzP6wNiWM766++wSxtVLF525ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821660; c=relaxed/simple;
	bh=TwhQAmA8JTFQGSTvfb0HMjeiE+1WxDzWJXQHJ/4majc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiIANLYUmBjjzYS9dvtIiCocEEZNolA6dITMbJcmtU9SmolLjvAVpMyuz/trBIZLVwWh/2nrGX9iu7klNjFEzsnBN5r6be0yFgIIwIXc1jS/okG8SrVQyAftc57m2QGLjPUJ9A6BohTKLKooBtl/NSQwfXZoLmK3q/VJ1SweBCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9FYnw/l; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9FYnw/l"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad79df972so9077170d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 10:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821658; cv=none;
        d=google.com; s=arc-20240605;
        b=DYOLTrkArSLiDcdxgaz4CUTbscHL/tLC8UkauIkmKpWZivv0c3QZauaAo1uuVGKGuv
         AwRUlKdEQMQxgYPpfBiIQg1QrkQcaQzac9e9WKHoltWGXgfWGvxeexLr61as5R5gLmky
         hdVfedjPxNs6z4QrmAcMtfMEFIa+T29nD1xX4eSGLUu6FcDe19ItSg1w4WzOx6GGf2CA
         IfDvJb9CL+JtIYY12l1IgrVfrC3pNOXSJczXCkfHgnmSZO87Kl+t6RJMGTUOc+Q+lbv3
         Csw25u7E3D2xbcnHbdEBiSrsQQUHyTaHVNbGz6h4qWgY93r2tr6bCBY/UVmuRZrVO+Kv
         5osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntWjMCOWQCrbW5V21SE1r96GEfEpnSnSwFiPW/bWatQ=;
        fh=KXcOb5vphlZLN1D9IwLcOrc/UM2jVmDyJWWf/pmWc4g=;
        b=jZp4+bwUMsZEXIb9sKmuth0ya5AVsyQpbTAtYQs4Uim9oXRwUIv5dGeuye8CbFX2fW
         o04IwzXfidZBorDVnMvAhfGkImv1yi0qa4xl659NWpgT1F8ro+NPI5H2AttgsdGYQOjr
         1F+gOkXfqZMGkl7xS1AcdWZmsrqmN/XbmeqP723dUY30UyjNmGeYcFMQqw7WyYEr265d
         8tQUNlqYSbPoNJ7bo6bbJ6IP8PmLLmAMkG8t4PDH4BPMOJSQ+clhewhX5ZWn7I2vD9zt
         2wGnC6wdHa19suic9zEMbbmt959b7KvfFxjZdhTC3r5Lm7SWjhZnM3NaN89TSENpAV+f
         qUPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772821658; x=1773426458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntWjMCOWQCrbW5V21SE1r96GEfEpnSnSwFiPW/bWatQ=;
        b=O9FYnw/lqxDBHZYKRPwi6TNr7+LCLEfNL62LE31DDoSh3o/4lyBNop4uwQZOR/n84h
         8VzgNzza6q2k1oKlT5YqzAmsEt6mTAsQDvab/k/Jp7qpYrcO/av6xDy7oFWwZFEsAzrJ
         CohtHZd2hc2HYHDBZskQihInkIqTwaXoY4FbPM2/a5HxFs6rYPN7WTcKU1/kz/7U61oo
         bu7a8iqB2j1tp+A/o+6u45L023P2erjH9Zm9VjWp9WeNIreJjzwrP+tBcNv1pUlq9b7A
         iE9jWZQ7DcprPv5DbVGhW20YjJ1oae01Fv9M3MBi9sQuOg0wpaN4GWklaO7LaXz/ytY0
         EIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821658; x=1773426458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntWjMCOWQCrbW5V21SE1r96GEfEpnSnSwFiPW/bWatQ=;
        b=fkrpz6HNVGkH9ejRXiHsqmrnJJ3C8ETwiVA/qyZ8VUzx/pLWrTyRMWJz/cVNM2sLlf
         KBRVJGc70ETwaLRo0c6vmJ2y//OzRYq0718vb9zZG6oROYzluNT+lMjcHn9GtMkD10Gz
         +5kYKYlLkYR1jcRSVq8jKLWuEgDKoA4yR1CoACsumk+wPLm0ggWmH4WiMnHbikv3S51s
         0Ktg+LP31pjn/vfOPRHud+tUEzv5HKpvz95ybRqFwQBmUT9Z958L5dG5sUw9rYMVZEp1
         pYypSG/wqPvgpbRuQOAYz34k4R9st4IC+p3F9zwCBXEl+yBtgN7PuJV/noOqufvaSnf9
         Py+w==
X-Gm-Message-State: AOJu0YzORKonDDVTIRJ1RDg9qpAutwlKpeKPojaLDrK075Ypvo5R/4ee
	9jeV6335WHgllthEHUWDjLWa8PMY+UsyJ3dfelWD5yqyqdBwibVqaG1GkF3m5JS+PL3rLor9x2e
	ECNDR62hFuaxIzW3UEX76vWo8tORZMQ4=
X-Gm-Gg: ATEYQzwZ3q/vUAgya1WJgcAsT7bvmsiM+ulKywp3J9VAiW5gEEbOUYMhx3uloMO01x+
	Dpy8JULinzo0qO6lj8/TaBKu4R1mfa+mZU/1bo6nn/jT9LxcHg66IEIY/TEf0YmOuThH720ll5G
	fLI2NkvAzPe7RoqCc9x+3TEfdEEi/ncIgcJHkrqHlwm2/ADEoGClOugVFXV4d84KNzXfzOlAWNT
	gFcIximk+LDRv2MTbxQzFgFkORMcr2rAmyEYWPaqq89UuKH0uHTI2tsc6sZcDED98ZUT9KbH1JA
	xRuZown41QhhWgR0/rMN1i3j3hWnOPXFO8HXyUjZHPhnCJLhW1mA2Xteid3KwFpKO8NGtA==
X-Received: by 2002:a53:e187:0:b0:64c:9abc:27d5 with SMTP id
 956f58d0204a3-64d14060ea9mr2354766d50.2.1772821658158; Fri, 06 Mar 2026
 10:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com> <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
In-Reply-To: <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2026 13:27:26 -0500
X-Gm-Features: AaiRm537Qm0EAyctwiQkfM65aLmOzOchuzQCS_kb9LOuzbtVb_aO37oxDdg9T4g
Message-ID: <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Fri, Mar 6, 2026 at 12:54=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.com=
> wrote:
>
> On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4=
d565356199d60e1cb94e5a77a
> > that was posted 3 days ago in this thread?
> > That in theory should have been backported.
>
> Hi Luiz,
>
> ubuntu@builder:~/bluetooth-next$ grep -nB 2 "HCI_CMD_TIMEOUT"
> net/bluetooth/hci_sync.c | grep "HCI_OP_LE_ADD_TO_ACCEPT_LIST"
> 2511:    err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST=
,
> 2512:                                sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>
> As shown above, the preparatory command HCI_OP_LE_ADD_TO_ACCEPT_LIST is s=
till
> hardcoded to HCI_CMD_TIMEOUT (2s). In the 5.15 LTS kernel (and bluetooth-=
next),
> this command is part of the mandatory sequence before the connection is e=
ven
> attempted.

That doesn't incur in any traffic, sounds like you didn't read my
previous response where I explained why a short timeout is normally
required for HCI, since normally only one command can be outstanding,
I really don't know why you keep coming back to the same topic when
Ive already shown up to date distros wait 40 seconds to complete a
connection.

> ubuntu@builder:~/bluetooth-next$ sed -n '2850,2855p' net/bluetooth/hci_sy=
nc.c
> for (i =3D 0; i < n; ++i) {
> err =3D hci_le_add_accept_list_sync(hdev, &params[i],
> &num_entries);
>
> Even if the final HCI_OP_LE_CREATE_CONN is decoupled (line 6673), the sta=
te
> machine fails at line 2511 because our industrial sensors (TE M5600) have=
 a
> 5-second advertising interval. The controller times out before the device=
 is
> even added to the accept list.

Yeah, you really don't know what you are talking about, there is no
timeout on HCI_OP_LE_CREATE_CONN itself, the controller shall generate
a command complete immediately and the connection attempt is only
interrupted with HCI_OP_LE_CREATE_CONN_CANCEL, so lets say yo want to
increase HCI_CMD_TIMEOUT that means HCI_OP_LE_CREATE_CONN_CANCEL
cannot be send because it would be pending on HCI_EV_LE_CONN_COMPLETE,
anyway I fill like Im wasting my time here.

--=20
Luiz Augusto von Dentz
