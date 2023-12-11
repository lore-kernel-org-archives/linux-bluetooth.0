Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6V2EUf3"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBA1723
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:53:00 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so65555461fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317178; x=1702921978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3ufnXGidcOnmQQt6XNrIUZLzoxqF+duuoKjMVgCFx0=;
        b=W6V2EUf3xek/kbKi26Wrx1JCWBuYDQux5Imrx+JOoyBpCPLuSjW+YR3TGi+9TkvGHc
         so4oKD0GuTChQkNgsxs+muLFecohfME12x/AZssUmgvcv38lWT3A0GxtkTrHUIhhbHvA
         jJhA/7AMymp4Sttl/q6vJVPkrKeAzux86XpA9GWVVjVxSxwTynIhIGTDvd4aOTGUD7Bb
         VKpnJOx7GACu4BXvUhfCnlFDA1puyq3Ec00en28eKqXcF4vw6ASD14n415dbY0AhTCr5
         X9b4vMeXpocB6ywMsrbJJhUsMCrqAW7B/HTIJOyh0Kw/4m8BATuIytJ3fZNJv0M7ErjL
         +5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317178; x=1702921978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3ufnXGidcOnmQQt6XNrIUZLzoxqF+duuoKjMVgCFx0=;
        b=ecTPCyK008x7uE0p15RRBZGHmdxhtvTPh9gHm7AyUc2cruk6Vm11KnS9qqgZUveX9H
         latu6EXZIPQA+scuj8TeKd20gvQ/vOLnPq9VWgEougpSf1ubsETg8XrQu4+grGnf9xoG
         OYXr9IkIICoELuq3MW8OYBDjm5uor/tdRtjI4w8lYiJcie68QQhNowGN5hGWvc31fu0X
         4FDm7GOtqpX1BWQBcWfp+hpmLHAHSFPRMc5I8ntoTWBFZDr14DTByNmnalhdynyGULp6
         rz7nudrDTA7uFVNwibsBo2G+Qn/jXav7wX6E5DE8NnH6Sr/RKMO/rCahtp04n+N39o+5
         6rGw==
X-Gm-Message-State: AOJu0YyUziawUlrgUhSDmIJPwXfBFbpzKykwYs2swW8rvI6kwu9bsVXs
	q50vEUuGLhcAKsNk3zch9yNFoNO7p3MvMwxizbNuELZHk+8=
X-Google-Smtp-Source: AGHT+IFprDBfMuEkTOnVdUX9utBDfq+tc1cxte52gLED7mkyRXjsjxYwiI1CCl9o0Qyp9ZfjmKBjZ8TcNrRHMKzTMg4=
X-Received: by 2002:a2e:ab18:0:b0:2cc:1e99:3f50 with SMTP id
 ce24-20020a2eab18000000b002cc1e993f50mr1845995ljb.43.1702317177712; Mon, 11
 Dec 2023 09:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXbWcZPq_2zIbqEO@alexlu> <6576dd12.170a0220.262f6.400c@mx.google.com>
In-Reply-To: <6576dd12.170a0220.262f6.400c@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Dec 2023 12:52:45 -0500
Message-ID: <CABBYNZL0eonsTFL-_DkXw_B=pRHz9QyeHubbRzpBD3dF-oWiRQ@mail.gmail.com>
Subject: Re: [v2] Bluetooth: Add more enc key size check
To: linux-bluetooth@vger.kernel.org
Cc: alex_lu@realsil.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, Dec 11, 2023 at 4:57=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D808=
718
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.48 seconds
> GitLint                       PASS      0.21 seconds
> SubjectPrefix                 PASS      0.07 seconds
> BuildKernel                   PASS      27.52 seconds
> CheckAllWarning               PASS      30.74 seconds
> CheckSparse                   PASS      36.91 seconds
> CheckSmatch                   PASS      99.35 seconds
> BuildKernel32                 PASS      27.19 seconds
> TestRunnerSetup               PASS      430.58 seconds
> TestRunner_l2cap-tester       PASS      24.23 seconds
> TestRunner_iso-tester         PASS      45.04 seconds
> TestRunner_bnep-tester        PASS      7.09 seconds
> TestRunner_mgmt-tester        PASS      160.98 seconds
> TestRunner_rfcomm-tester      PASS      11.03 seconds
> TestRunner_sco-tester         PASS      14.59 seconds
> TestRunner_ioctl-tester       PASS      12.19 seconds
> TestRunner_mesh-tester        PASS      8.72 seconds
> TestRunner_smp-tester         PASS      9.77 seconds
> TestRunner_userchan-tester    PASS      7.32 seconds
> IncrementalBuild              PASS      25.72 seconds
>

How about doing the following:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ad7b9f86f74..f9a8fb9fcce2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -750,9 +750,12 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev
*hdev, void *data,
        } else {
                conn->enc_key_size =3D rp->key_size;
                status =3D 0;
+
+               if (conn->enc_key_size < hdev->min_enc_key_size)
+                       status =3D HCI_ERROR_AUTH_FAILURE;
        }

-       hci_encrypt_cfm(conn, 0);
+       hci_encrypt_cfm(conn, status);

 done:
        hci_dev_unlock(hdev);

That way we don't have to proliferate the checks over to L2CAP, etc,
so we consider that the encryption itself fails if the
conn->enc_key_size < hdev->min_enc_key_size.

>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
