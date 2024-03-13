Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34E12E6C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363005; cv=none; b=UnOm3oAVcYMSpkBFc3bfg/bk9Lxwm0f9Ew0gtZO/VN4dHh1AuAOSt9kY+zR7gJg7mbRJeBjTmbJgtQVx9PmDAcVksrhpvFw162e+J7hPwgHxcZvVycA8SQ3QnjazQe2W6CFMnR9Er2KjsaKv4V3DBZfgBxSXU11h1+OnI2Bhn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363005; c=relaxed/simple;
	bh=H5feKzgIugoZF1a8lhyLmY6+7LZh4TdskA0z+Ih0Xp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKOcOItzlE7/yUFrOHLVVQf3q9gTF8jiB0Tuk9mVAhV/mgJ0++gzPyDrHDcK5uuapHAlP3jgGWviElRXxulaBkY5m4//0g9AUik39OJwIxRIxEeWz4+Pgwl0+1T2qwqfXZ8hSD8n3Kn/L71jbTMV2VZzijSytrr9PjK/NTagf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR+3+6PJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR+3+6PJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d309a23d76so11270981fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710363002; x=1710967802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNiUpjWQVZBnNa5mMwvtGoelqIVFaWfbcJBw5tUQ41U=;
        b=GR+3+6PJ+6y+2oR8Ge9OcFEno2YdzgDfxyViobw7CjnlKTfxBfhQxXfXJpESmLbHwy
         yFn4m8S1zdO6FrklXraO90nDMjvp7QaHmOGlpSHKgoPJCHREDOyaImYxQ/X+N5guLToa
         88IpacndebwOF3Dhw+IUjwaJIfPXs0MJczc0/M+DAnXQvLlsvfVLLaoa5Nxbn+y2+XxK
         FIX6+utNY1uIwIhAWa3RdAJZwJ5W+vcnAHOg5xyjiVCSLHNA1Q7sJOsi9pCgZtM6ogag
         gK1LSJ4aDWiwpGSWRYC94zs7bqHukdYf2lBwjyh8jFP5dgv8HoBqG1RaXb0GtfXRtbmf
         h2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363002; x=1710967802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNiUpjWQVZBnNa5mMwvtGoelqIVFaWfbcJBw5tUQ41U=;
        b=bbySmQVIzaHcZON1zO7I7SiFYKMlR4klcw6MTToddL9bmWeb27XfdHcTkuTXH1BJbw
         FMqvl7KpUGB4wrGjrm7EExMJR7qA/edXuuN0G+AoV9ti0F4RYl7auwpivKaxlnNailtt
         YF6FY4eDqMer/17D2E3YRt5bq2MtDd0UXK0hABy44MlxyUq4EJV9LdsaHH66LV+tZfaZ
         8rELtoSKBpAVbHf4q/jmonlZOYgPA16VGsAvacAqYwc9MPxi/E1nsJY0LUomyt57HTfQ
         Z1HC+5FK4cmQfUyhdLQyMEH+a3hjx/eeFhU+RmDVCoPy1mGITTdAU3N6gS88Thj8fltq
         puCQ==
X-Gm-Message-State: AOJu0YxH9c1+hoJEoD3XE8Fe9c4+1CVwIE8D2m18YjnDsTcGuKF/aVSS
	kIn5CVgE1ysE4ksABAgrE3YUa0QQHIMJRD9j2UAz3r/NFYgEMvaAqQ6CAyfUKv0/reHGPdQLT7m
	CDXd0u27XRKEPq75fXsgICPlEUpOEL26Rc34=
X-Google-Smtp-Source: AGHT+IH0oxO6OaV5CDcDlxbfxzxOeoA4N+NonhjF/XhZ2fkI53UltAfKZ+EGZ4KNMGsMSCzE7gVNozYHr6wlNo8dBDQ=
X-Received: by 2002:a2e:b52f:0:b0:2d2:2c74:ff02 with SMTP id
 z15-20020a2eb52f000000b002d22c74ff02mr1307462ljm.9.1710363001489; Wed, 13 Mar
 2024 13:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313170300.40974-1-silviu.barbulescu@nxp.com> <CABBYNZJKioYe12Qy10FwR5HzifbNyFZLsK4jpVGaoahonkOVuQ@mail.gmail.com>
In-Reply-To: <CABBYNZJKioYe12Qy10FwR5HzifbNyFZLsK4jpVGaoahonkOVuQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Mar 2024 16:49:49 -0400
Message-ID: <CABBYNZ+D4aStZ-o0K3pLuiLF-k2z3j5ak9rJSoNeeVh8E1L+Bw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Broadcast source reconfiguration support
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Wed, Mar 13, 2024 at 4:04=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Silviu,
>
> On Wed, Mar 13, 2024 at 1:03=E2=80=AFPM Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com> wrote:
> >
> > This patch adds support for broadcast source to reconfigure a BIS.
> > endpoint.config command has a new prompt for broadcast source:
> > " This is a BIS Reconfiguration? (yes/no)"
> > Yes or y if a BIS reconfiguration is required
> > No or n if it is a new BIS configuration
> > "The BIS index is assigned in the order of the configuration
> > starting with 1"
> > "BIS Index (value):" a value representing the BIS index if this is a
> > BIS reconfiguration.
> > endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> > endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> > BIS Index for reconfiguration? (value(1-31)/no): 0
> > [/local/endpoint/ep0] BIG (auto/value): 0
> > [/local/endpoint/ep0] Enter channel location (value/no): 1
> > [/local/endpoint/ep0] Enter Metadata (value/no): n
> > endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> > [/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): =
1
> > [/local/endpoint/ep0] BIG (auto/value): 0
> > [/local/endpoint/ep0] Enter channel location (value/no): 2
> > [/local/endpoint/ep0] Enter Metadata (value/no): n
> > transport.show /org/bluez/hci0/pac_bcast0/fd0 to view the update
> > Transport /org/bluez/hci0/pac_bcast0/fd0
> >
> > Configuration.Location: 0x00000002
> > Configuration.Location: Front Right (0x00000002)
> >
> >
> > Silviu Florian Barbulescu (3):
> >   player: Add reconfiguration prompt for broadcast source
> >   transport: Add support to update the transport configuration
> >   bap: Broadcast source reconfiguration support added
> >
> >  client/player.c            | 33 ++++++++++++++++-
> >  profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
> >  profiles/audio/transport.c | 27 +++++++++++++-
> >  profiles/audio/transport.h |  1 +
> >  src/shared/bap.c           | 11 +++++-
> >  5 files changed, 144 insertions(+), 4 deletions(-)
> >
> >
> > base-commit: c9dddb642663b8bafe8998fef6132a2bb36d609d
> > --
> > 2.39.2
>
> Something's not quite right, although it seems it does update the
> configuration at D-Bus level:
>
> transport.show /org/bluez/hci0/pac_bcast0/fd0
> Transport /org/bluez/hci0/pac_bcast0/fd0
>     UUID: 00001852-0000-1000-8000-00805f9b34fb
>     Codec: 0x06 (6)
>     Configuration.#0: len 0x02 type 0x01
>     Configuration.Sampling Frequency: 48 Khz (0x08)
>     Configuration.#1: len 0x02 type 0x02
>     Configuration.Frame Duration: 10 ms (0x01)
>     Configuration.#2: len 0x03 type 0x04
>     Configuration.Frame Length: 120 (0x0078)
>     Configuration.#3: len 0x05 type 0x03
>     Configuration.Location: 0x00000001
>     Configuration.Location: Front Left (0x00000001)
>     Device: /org/bluez/hci0
>     State: active
>     Endpoint: /org/bluez/hci0/pac_bcast0
>     QoS.BIG: 0x00 (0)
>     QoS.BIS: 0x01 (1)
>     QoS.SyncFactor: 0x01 (1)
>     QoS.Packing: 0x00 (0)
>     QoS.Framing: 0x00 (0)
>     QoS.BCode:
>   01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8  ..h.S.AZ.e......
>     QoS.Options: 0x00 (0)
>     QoS.Skip: 0x0000 (0)
>     QoS.SyncTimeout: 0x07d0 (2000)
>     QoS.SyncType: 0x00 (0)
>     QoS.MSE: 0x00 (0)
>     QoS.Timeout: 0x07d0 (2000)
>     QoS.Interval: 0x00002710 (10000)
>     QoS.Latency: 0x0014 (20)
>     QoS.SDU: 0x0078 (120)
>     QoS.PHY: 0x02 (2)
>     QoS.Retransmissions: 0x04 (4)
>     Location: 0x00000000 (0)
>
> It doesn't do that at HCI level so it still uses the old configuration
> for some reason:
>
> < HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 41
>                          #2839 [hci2] 16:00:16.948281
>         Handle: 1
>         Operation: Complete ext advertising data (0x03)
>         Data length: 0x26
>         Service Data: Basic Audio Announcement (0x1851)
>           Presetation Delay: 40000
>           Number of Subgroups: 1
>             Subgroup #0:
>             Number of BIS(s): 1
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>             Codec Specific Configuration: Sampling Frequency: 16 Khz (0x0=
3)
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>             Codec Specific Configuration: Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>             Codec Specific Configuration: Frame Length: 40 (0x0028)
>             Codec Specific Configuration: #3: len 0x05 type 0x03
>             Codec Specific Configuration: Location: 0x00000003
>             Codec Specific Configuration: Location: Front Left (0x0000000=
1)
>             Codec Specific Configuration: Location: Front Right (0x000000=
02)
>             Metadata: #0: len 0x03 type 0x02
>             Metadata: Context: 0x0004
>             Metadata: Context    Media (0x0004)
>               BIS #0:
>               Index: 1
>
> Perhaps this is a kernel bug though, but it needs to be fixed anyway.

Looks like the setup->base is not being updated, in fact I don't know
why we stop the base like that instead of just doing:

https://gist.github.com/Vudentz/ab241cd1a373f5d0f7182355f23227c7

Anyway, the fact that the configuration over HCI doesn't update tells
me that perhaps we need some extra steps to validate these changes,
having to test everything you send to the list is not really practical
so I will start requiring evidence that things really work end-to-end,
also it doesn't seem you had made changes to the existing scripts at
client/scripts since you had changed endpoint.config to require
entering the bis index it broke the likes of
client/scripts/broadcast-source.bt.

>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
