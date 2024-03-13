Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCA4776A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360291; cv=none; b=qCeM73MteRmJ6mKv7iXg9Qujy0Xa/rSHtD0G/HIiIbQcNJQP2favB5ATIs8HtdSwkjF7UW34odWfpHwbmCe95uN3rLXKIoloK7F6DLQQkUOWXF8nGTKUGhg2G5PjvwzWTNz0jJTtxwdVCdVSScIHpM91HzHgrDrmoL2MoQ52NoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360291; c=relaxed/simple;
	bh=jmK8oZbN5UMNdLDYGlEt0IorIHhKXrhmN6tHox2cLqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETL0467zB5mOe6t7yeKcxd59Ghkef5d6+rj1xrK3a+Z86g1Fyaq8yN0khErlEKLrzR3md9Rjyg3GAJFWqQce5MT9Qhg69Jf0rDasXsAWaLitn5PziAAIVDmIfvcRDIuhjZFEbcTHyTqXjqLNouS6YUB5PNgZSjUnyBzGi8qf4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7HjW5kY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7HjW5kY"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso2437801fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710360287; x=1710965087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADWakyR83jXSmbepdR/nrWlWfz0eQCHIH11wkHl1lPg=;
        b=F7HjW5kY4jdMwweYt2noCFgCtGuRfTN/bqNwr2ZfqWaRINT3risOQFHd/TOlF7wCNb
         axZg+i9F2QiGfEelW/bYMgS3EZo8ZoXa8ySXEiEWgjt+sgYjotquA4N07lVnJKWMGbVY
         z4gizOXh7ZC3tm3KFb266LiSF18c6qLk0uhM6MpzeF1Rxc1IlqyWz32M8U6c+/5UyxEU
         fvsIiWoqempCtVTR9POf02kS1Lg9ltgaPh27j+WxEOHmFpqMQ85WZDJmDvPF3z9P4elu
         7AEeoAeORZj1IaFrLWdA9pZFjfLSjNI+AFzkB8pOuRMZUgizPXFxofOvutcZ9IyKv5Qp
         ufew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360287; x=1710965087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADWakyR83jXSmbepdR/nrWlWfz0eQCHIH11wkHl1lPg=;
        b=egRxHdS/48AFbOEgD6q04WhlEL4BSQHP7em2mdS1ySe1y28EEFxwXHfrrBSZFCSru2
         n8coiax1FtpHPjgekyRXTQjNYfd5VOfuJJSK0y3+Z1WhLpd+DcnhBPlqXeMBW7Y7bdDB
         yIQtv5hCZIR72b2moHj+KjFnmB4C1uGHKonZ1dOm8M6JlVpveXt8ABa8QiDdZotUwpfx
         gehm1dwuzzP0qkgPW+wCeAco++WyJNi9ImRfFFtURPdkwnR798OU2RHQUf2qSBNY57F1
         vCQU2HzUNLPxvf0gUJNhA8Y7plOV0KwryFcwPg3GKDNQLjfQix+M3TDs4s5HPd2TM7wb
         UfKw==
X-Gm-Message-State: AOJu0YxPy9LOMB3qNaY6fKmvN9X7p8OUMiVADUtrWiH19wQ7i9rUD69q
	QdMFpP4PE1icqrzzAS1OvONSlofAhrLt3hifJL9UGDT45UqGr6gYnJZ5EwU8NlRHRDnTZLrH4GM
	/O3Q4lY9zvhLNmLauBNamGx6szcs=
X-Google-Smtp-Source: AGHT+IEsRwIEk4wSx4XTQxTZthVg74LhrqC/AiW6ZnUz/VzOoxrP5aNVR0I19EML04qVAjoPNcqWfoJZRAGUyjOrzOM=
X-Received: by 2002:a2e:984e:0:b0:2d4:6c19:67d5 with SMTP id
 e14-20020a2e984e000000b002d46c1967d5mr1193001ljj.18.1710360286854; Wed, 13
 Mar 2024 13:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Mar 2024 16:04:33 -0400
Message-ID: <CABBYNZJKioYe12Qy10FwR5HzifbNyFZLsK4jpVGaoahonkOVuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Broadcast source reconfiguration support
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Wed, Mar 13, 2024 at 1:03=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> This patch adds support for broadcast source to reconfigure a BIS.
> endpoint.config command has a new prompt for broadcast source:
> " This is a BIS Reconfiguration? (yes/no)"
> Yes or y if a BIS reconfiguration is required
> No or n if it is a new BIS configuration
> "The BIS index is assigned in the order of the configuration
> starting with 1"
> "BIS Index (value):" a value representing the BIS index if this is a
> BIS reconfiguration.
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> BIS Index for reconfiguration? (value(1-31)/no): 0
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 1
> [/local/endpoint/ep0] Enter Metadata (value/no): n
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): 1
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 2
> [/local/endpoint/ep0] Enter Metadata (value/no): n
> transport.show /org/bluez/hci0/pac_bcast0/fd0 to view the update
> Transport /org/bluez/hci0/pac_bcast0/fd0
>
> Configuration.Location: 0x00000002
> Configuration.Location: Front Right (0x00000002)
>
>
> Silviu Florian Barbulescu (3):
>   player: Add reconfiguration prompt for broadcast source
>   transport: Add support to update the transport configuration
>   bap: Broadcast source reconfiguration support added
>
>  client/player.c            | 33 ++++++++++++++++-
>  profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 27 +++++++++++++-
>  profiles/audio/transport.h |  1 +
>  src/shared/bap.c           | 11 +++++-
>  5 files changed, 144 insertions(+), 4 deletions(-)
>
>
> base-commit: c9dddb642663b8bafe8998fef6132a2bb36d609d
> --
> 2.39.2

Something's not quite right, although it seems it does update the
configuration at D-Bus level:

transport.show /org/bluez/hci0/pac_bcast0/fd0
Transport /org/bluez/hci0/pac_bcast0/fd0
    UUID: 00001852-0000-1000-8000-00805f9b34fb
    Codec: 0x06 (6)
    Configuration.#0: len 0x02 type 0x01
    Configuration.Sampling Frequency: 48 Khz (0x08)
    Configuration.#1: len 0x02 type 0x02
    Configuration.Frame Duration: 10 ms (0x01)
    Configuration.#2: len 0x03 type 0x04
    Configuration.Frame Length: 120 (0x0078)
    Configuration.#3: len 0x05 type 0x03
    Configuration.Location: 0x00000001
    Configuration.Location: Front Left (0x00000001)
    Device: /org/bluez/hci0
    State: active
    Endpoint: /org/bluez/hci0/pac_bcast0
    QoS.BIG: 0x00 (0)
    QoS.BIS: 0x01 (1)
    QoS.SyncFactor: 0x01 (1)
    QoS.Packing: 0x00 (0)
    QoS.Framing: 0x00 (0)
    QoS.BCode:
  01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8  ..h.S.AZ.e......
    QoS.Options: 0x00 (0)
    QoS.Skip: 0x0000 (0)
    QoS.SyncTimeout: 0x07d0 (2000)
    QoS.SyncType: 0x00 (0)
    QoS.MSE: 0x00 (0)
    QoS.Timeout: 0x07d0 (2000)
    QoS.Interval: 0x00002710 (10000)
    QoS.Latency: 0x0014 (20)
    QoS.SDU: 0x0078 (120)
    QoS.PHY: 0x02 (2)
    QoS.Retransmissions: 0x04 (4)
    Location: 0x00000000 (0)

It doesn't do that at HCI level so it still uses the old configuration
for some reason:

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 41
                         #2839 [hci2] 16:00:16.948281
        Handle: 1
        Operation: Complete ext advertising data (0x03)
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000003
            Codec Specific Configuration: Location: Front Left (0x00000001)
            Codec Specific Configuration: Location: Front Right (0x00000002=
)
            Metadata: #0: len 0x03 type 0x02
            Metadata: Context: 0x0004
            Metadata: Context    Media (0x0004)
              BIS #0:
              Index: 1

Perhaps this is a kernel bug though, but it needs to be fixed anyway.


--=20
Luiz Augusto von Dentz
