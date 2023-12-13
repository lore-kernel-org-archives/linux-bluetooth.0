Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8G0B47A"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBBC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 09:27:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2cc3602ae44so14093551fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488470; x=1703093270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jekjRedosn0K6wXEhT0sK4bryG2cjli8f9x/8clxpHE=;
        b=m8G0B47AplkpDVUAqCrlJH9b7LKOeU3gHVLWvYIES+RnVayAVEt7fMWb16XRnc5IXV
         BG85WEQ4GGOelaWf7kx3ziAfmlc3s7+t4dZDeNKKDZ0STENiOxUGnhOW06qLccd7zkL6
         NOiKEyVUzwfmj52pAqKfnz390IkK3RLF0j61UEXPVuUjTImJqzOB1MHihAeikhZ4C5l9
         PPBL4j31cfFeMk0qKp7c+ZLPMk+XNf7qSS0+dzUcicaJJLPJsSYUvp+9cAvcbqYrZtQh
         rgafPTZJpHUHBAeY9ASFgomc+XMkx8/8RW61m/+/tdpRIzilvV6jADu6RkI40vMLZncv
         YbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488470; x=1703093270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jekjRedosn0K6wXEhT0sK4bryG2cjli8f9x/8clxpHE=;
        b=dbs3r6yR2Iup4siiwvl7sZfFm+DBq5pgjRcSbTLUpOSogjQuwuDlvZ/fBhxr7RVj44
         2nuga/MVFDbY5SJmaGM7BGEi7VBLmIU5F9Me6v7mnZCohGiyw/FzTJX10A5hc1Wa2ll4
         +tuqi2PDRXQPqG3I2VXCUrVOA4IISFy64MZ+zzzrlhRL1A+YYV0NF7K5E/LbZpDH2rR2
         /rGF89CYFKTE1LMc727JRy50vBSsf0AGTyldW7A6J22Xnx7MmvxYchow8iia9e8q98YK
         +VeSSZZWOCac0LdYRTnCzDxO4pL4WUkMx+VbJ/2PIkLTF2cunG5DkegSRoi3j9wfZkqv
         hHug==
X-Gm-Message-State: AOJu0Yz1qwnwWkfxfVZGSqTwagl6TnE2pqpmbqI4AfqhrhabumxXuS5H
	kwHm5w5n2OW8wb7zNOVuMYPxHmbXHguWcrmIFVG1ji9N
X-Google-Smtp-Source: AGHT+IEGAQSoxz/XOR7MqN25k6wmL5tCzT37HaccNkcQWxP7vVGzmUARRq3uScydzGTeQPnk/h7s3l4S2EsT6dKl8Xg=
X-Received: by 2002:a2e:a103:0:b0:2cc:1c8a:466a with SMTP id
 s3-20020a2ea103000000b002cc1c8a466amr5022609ljl.13.1702488470103; Wed, 13 Dec
 2023 09:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213085011.1152912-1-frederic.danis@collabora.com>
In-Reply-To: <20231213085011.1152912-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Dec 2023 12:27:37 -0500
Message-ID: <CABBYNZK8u1iuHA8FRXO9HL-kbYrL8jngo=UJG71+HHXJuSNSFw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Fix HoG discovering characteristics order
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Dec 13, 2023 at 3:50=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> PTS test HOGP/RH/HGRF/BV-01-I fails as inconclusive after waiting for
> second report map read request with message 'Please send ReadRequest to
> read Report Map characteristic with handle =3D 0x00E7'.
> Handle which has already been read, as it can be seen in btmon traces.
>
> This commit change the recursion order to read instance characteristics
> before recurring to next instances.
>
> Closes: https://github.com/bluez/bluez/issues/657
> ---
>  profiles/input/hog-lib.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 7ff1ede3d..db62a3c9f 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1780,12 +1780,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>
>         queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
>
> -       for (l =3D hog->instances; l; l =3D l->next) {
> -               struct bt_hog *instance =3D l->data;
> -
> -               bt_hog_attach(instance, gatt);
> -       }
> -
>         if (!hog->uhid_created) {
>                 DBG("HoG discovering characteristics");
>                 if (hog->attr)
> @@ -1798,6 +1792,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>                                         char_discovered_cb, hog);
>         }
>
> +       for (l =3D hog->instances; l; l =3D l->next) {
> +               struct bt_hog *instance =3D l->data;
> +
> +               bt_hog_attach(instance, gatt);
> +       }
> +
>         if (!hog->uhid_created)
>                 return true;

While I don't oppose this change, but this seems to be a limitation on
the PTS side which expects a certain order of the operation which
doesn't seem to be a requirement coming from the spec, so perhaps we
should file an issue to PTS.

> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
