Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD3130AC9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102052; cv=none; b=VjaUUfjYNGrWKo82ysOBGpnXlEHHf7mWDuhirn3gVeCjFIgHfjEF49/ZitkOHY3Zc8+Hp7XYcBdsqBfmkjtMbxtaEUAZpCRH5PqO3TC9GsgpTaro4avxlLRc7XVCixkgfE9AnPfunIbYlLd2E8Owp8Iyk674qCzEkJarvR0vlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102052; c=relaxed/simple;
	bh=HDmaMe11IDoKEb6TLxFcSdYHu1ll312hWuanOVtOSc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDNQPtOSoBrMX2jy0RgtfQImY3VKyLTgugomiseX9CTuaaufmIw9gob/6jl4yLCGZvNPy4xriRw71KLT7mk3LAON9DDXc8or2r3Pb5rtyjjXtuhP3aScjoyI5ZKKkNYrkdLNqpfBDjAI5ZocoscYzt8NTkik+EKta8AWzEcYhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnlvQjHQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnlvQjHQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42db1baff53so297371cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102049; x=1708706849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXkFceeXEfNVDWEJpo0yVBOYLfaZe08nALnvmUBTlbw=;
        b=gnlvQjHQHd52rYPa8WOvarhYaXcfV9MDrie2s4zhxmJq3MfTP6vQkm2lHZxck61fPm
         WCY3FesurvzSK950BrjywB4PYiUf1pJsmOFa670U3yKkkIPhd8QNObtVQicPBwfNtn5B
         aoWQXSE8VI8WAz8YQqr+2JaZZytsfZiph1n8LUsfEyhF+wFh9CaViToKcz393xOsl9Qs
         KP1CYqpEurVxT3/izTfaq6zAUI1vjWuHrauX920WyxkYsHfD3jbjpI2JDomBzq5hkx0r
         fF/cxM43a/LId8OJmwap9aP83GZAFyLOslz8CklVf5zJb1ixF10gmjJ4sLHZIvBBa+Ch
         mIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102049; x=1708706849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXkFceeXEfNVDWEJpo0yVBOYLfaZe08nALnvmUBTlbw=;
        b=Z2OfmsY3/dang5FEmChmjnDtBu3RUaZUc7eEFzwzpWOmNWm1yRwWtfk13MXrAE0Noy
         8s3/n963o+RAzhixJrxRaUFm7tA3i39UYK1CSXtvACybQ4zVTq0hT1TUBapPFTOJPjTV
         MS6BvZeMHS0QkmyVMJe/5s+mbg5fsEf683USwVtTZSQYgCHp6rBikll/QP7Ska+OlR4c
         hlT/N3dUjVCrvfhNi7eIFpeQKu2/QbocC2A/MLFNjva3Ixbh9495osHsxFD71mZULS4U
         IV0ZATQiyRtyOiPvphlx5vLAoyYNdv5hCySgGPUGGY183A2b49TzobIZX9OJfD8yDFJu
         TdtA==
X-Forwarded-Encrypted: i=1; AJvYcCWBCYlysBjjNZ7i96zm1ue+a4lWFqTbGuG3S4IqVz5UQCCxlOn9YQSQoX5AUVXPZdXwL7fnIbziSMQHAa/LWw8yPXioZmzZLNvswQRVDCrr
X-Gm-Message-State: AOJu0YzlXnMBTIQVAh4pPKI4sR6aj46bjVsvTJtRTww5ZTFT63lGfRAq
	YNCBhcJxk8Pv6z5P9gychuSJZ/hiRe5bKngIXntqOGIFnl+Y7PLCHOBELWvh3BZK7LUytWEAsDH
	M9wFe1u6jG+erqvrBRaLkmzlHfSJjtzkvOmio
X-Google-Smtp-Source: AGHT+IEVpZ5HM9rbk02BkNTIep9N7nAfUAfy8yxcNkKX84dnrdPT03xkqCecOi/KKpBtxCG8YX67VLl1EuYrKkcA64Q=
X-Received: by 2002:a05:622a:770b:b0:42d:c91d:9317 with SMTP id
 ki11-20020a05622a770b00b0042dc91d9317mr291479qtb.14.1708102049017; Fri, 16
 Feb 2024 08:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
 <CABBYNZ+MJRSAWHjgNTNwcWCdq5y0zBU5f8XJvr1tv3LCqvdKJw@mail.gmail.com>
 <CADg1FFfgNHF9q+dSn=K9qjVMKx1zaBpG=NoeM_3Gr942Zj7_bA@mail.gmail.com> <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com>
In-Reply-To: <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Sat, 17 Feb 2024 00:47:17 +0800
Message-ID: <CADg1FFe09dXWr51OFKutAf=ax0TFXa5HN=6J+AX9QHbb1QiO+Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if
 hci_request is pending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, Ying Hsu <yinghsu@google.com>, 
	Joe Antonetti <joeantonetti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Good point. I found the hdev->req_skb is actually not read at all in the
current code base, so perhaps we could remove the legacy code entirely,
and reuse it for solving the problem we're facing now. This approach
seems cleaner to me. WDYT?

OTOH the below snippet in hci_event_packet (also another similar one in
hci_le_meta_evt) needs redesign as well. It distinguishes LE/Classic
event per hdev->sent_cmd, so the hci_req_cmd_complete for LE command
would never be called after a classic command is sent, vice versa.

/* Only match event if command OGF is not for LE */
if (hdev->sent_cmd &&
    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) !=3D 0x08 &&
    hci_skb_event(hdev->sent_cmd) =3D=3D event) {
        hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
                             status, &req_complete, &req_complete_skb);
        req_evt =3D event;
}


On Fri, Feb 16, 2024 at 11:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Thu, Feb 15, 2024 at 11:21=E2=80=AFPM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > +Some Googlers who would be interested in
> >
> > Hi Luiz,
> >
> > How about moving the hci_req-related data out from sent_cmd? This allow=
s sending HCI commands while hci_req data would not be overwritten.
>
> I have something like the following in the works:
>
> https://gist.github.com/Vudentz/251275bb688fac32585f90ac0076c407
>
> It is not stable yet, but I think we can get away with it since it
> just means we can keep the pending request stored in the req_skb, that
> said we might need to overhaul this design since it is not very clean
> in my opinion.
>
> > On Fri, Feb 16, 2024 at 5:37=E2=80=AFAM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> >>
> >> Hi Hsin-chen,
> >>
> >> On Tue, Feb 13, 2024 at 12:24=E2=80=AFPM Hsin-chen Chuang <chharry@chr=
omium.org> wrote:
> >> >
> >> > hci_cmd_work overwrites the hdev->sent_cmd which contains the requir=
ed
> >> > info for a hci_request to work. In the real world, it's observed tha=
t
> >> > a request from hci_le_ext_create_conn_sync could be interrupted by
> >> > the authentication (hci_conn_auth) caused by rfcomm_sock_connect. Wh=
en
> >> > it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
> >> > LE connection is triggered by MGMT, it freezes the whole MGMT interf=
ace.
> >> >
> >> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> >> > ---
> >> >
> >> >  net/bluetooth/hci_core.c | 7 +++++--
> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> > index 34c8dca2069f..e3706889976d 100644
> >> > --- a/net/bluetooth/hci_core.c
> >> > +++ b/net/bluetooth/hci_core.c
> >> > @@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *=
work)
> >> >         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> >> >                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd=
_q));
> >> >
> >> > -       /* Send queued commands */
> >> > -       if (atomic_read(&hdev->cmd_cnt)) {
> >> > +       /* Send queued commands. Don't send the command when there i=
s a pending
> >> > +        * hci_request because the request callbacks would be overwr=
itten.
> >> > +        */
> >> > +       if (atomic_read(&hdev->cmd_cnt) &&
> >> > +           !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
> >> >                 skb =3D skb_dequeue(&hdev->cmd_q);
> >> >                 if (!skb)
> >> >                         return;
> >> > --
> >> > 2.43.0.687.g38aa6559b0-goog
> >>
> >>
> >> This seems to be causing some mgmt-tester failures:
> >>
> >> Pair Device - Sec Mode 3 Success 1                   Timed out   22.75=
3 seconds
> >> Pair Device - Sec Mode 3 Reject 1                    Timed out   22.53=
3 seconds
> >> Pair Device - Sec Mode 3 Reject 2                    Timed out   22.52=
6 seconds
> >>
> >> I think this is because we need to respond to an event with a command =
like:
> >>
> >> < HCI Command: Create Conn.. (0x01|0x0005) plen 13  #241 [hci0] 16:25:=
38.699066
> >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> >>         Packet type: 0x0018
> >>           DM1 may be used
> >>           DH1 may be used
> >>         Page scan repetition mode: R2 (0x02)
> >>         Page scan mode: Mandatory (0x00)
> >>         Clock offset: 0x0000
> >>         Role switch: Allow peripheral (0x01)
> >> > HCI Event: Command Status (0x0f) plen 4           #242 [hci0] 16:25:=
38.701881
> >>       Create Connection (0x01|0x0005) ncmd 1
> >>         Status: Success (0x00)
> >> > HCI Event: Link Key Request (0x17) plen 6         #243 [hci0] 16:25:=
38.702375
> >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> >>
> >> But because Create Connection is pending we cannot respond to Link Key
> >> Request, so it is actually a design problem if we cannot send commands
> >> because something is pending so perhaps we need to redesign how we
> >> store cmd_sent so we can have multiple outstanding commands rather
> >> than just one.
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz
