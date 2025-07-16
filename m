Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4F1C5485;
	Wed, 16 Jul 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675078; cv=none; b=jqsCa6pu7Flo8+QXhiy4+LDUIKK+cBTS+LmKDD3F8PK4nxPM8lsHvTlYej/L80Vt/ZAUSwiO1FKuWqDcixfGu1CmSR+STlurfsY6Y8P96R3M25uWdF56clhAhAjQsgUWSACMXChemm5tlVPMZlb7fD13k9pjz8BE/Ln7zUhNbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675078; c=relaxed/simple;
	bh=UfLyIV1SWQ21NUZVMf84Gg9fppRFl01xNj/Dm+uoMAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKDMeNcdYnR/2yPLy2niqdzc4hYPqcGZJMyXNzodpUTOiy3pF8QL8OF/1OCmt3yM/aCWbYrAsrL/AaKrX98fUACBrsWLFKrJ/wgz2fenaokZAwFJQQxSVLhh7QcgG2EVErMg1qJ5+8gXuRcTbMQ4BEKaB8uhKlNNagmv5NUzD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ5KzJJl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ5KzJJl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b31afa781so51402001fa.3;
        Wed, 16 Jul 2025 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752675075; x=1753279875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y02Jg6hTtZiEiKF/tGVmXW3lKDGNSs4kEiO4+C2KcM=;
        b=iQ5KzJJl/am2YZ00xGhZvlqg4xbKtcLEPxVSgafXw3mFs7XnhBa9ov2d9rbvPCzOkP
         JUHkBsw/xbBXUVWI7V3R+JEelU4w/74iZ/q8GmUmlJke43uB/rwex66Cp5g7Bvk2BBtI
         +ZKDsgcLSjAg8lV3mLogCdlFWtoa13juIE7NpoJQRKxgPIMERfnnMCa1HD4jP0p84Oz7
         N8U5ydrgdvJF8eyECPPEaG+7qkUpujvu6ekw7/Kp478T8BBIHi3M0eJlw68NjT6zCgqx
         IHw4KdTS4+LWf6PJ3CaD5/ZSy08I1m0ltlt2+vtuopOeXxsT+N4E8dopiwI0GB4iSJRY
         Ft1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675075; x=1753279875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y02Jg6hTtZiEiKF/tGVmXW3lKDGNSs4kEiO4+C2KcM=;
        b=KZNAHeQGPWNyRiYwtMOzNVrMxd95FJZhH05yUMCN+tqwbTohg5C5IlPOyTOrTZFIu1
         3D2DF2bqIcU2gMrxI7PrIyL7IuMgTQnhY5LZPIDN7JjJZMj9dz6btsc0SLEngKb6QgTy
         3T7N4HFOdyTh5JI1ZtrNcNtprkQGmLuIiB0hN/2iWoXO3plv0mmDspXgs4ti4fTYgRz1
         SYZ5JyAi0NtbLuteotG5SALMX8fE8TvLHi7AmNB8no1Zig88cBt+u/H6Vd0oyWs1SHpR
         O4Se9LynGHKLheArgKeFRaJeqjwiUa6a2qTJq4pp0C5WQo6IEPSHOgpY57IvKQAT3JdD
         4iDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzBiVuY8OW3VZuQtn0T/jaOZsQQcC35D6/jz5vIWeroa4dT9k/aFdiZv7oFQcNKOl07mqugEDB6MGTpeJ55i4=@vger.kernel.org, AJvYcCXV3pwfFigevU19C5jN1g2WPUVff/R0ADOxy/nJcpAQgYgmEXeVMEPooykj/u5q9CeC6ERblRctirNiqnrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4Qgr1tXo3SX8S9wwQ6ZC39ylcWr1PKAxc4gAMYJs3aF7wapi
	ZZj57jQ1oLqbg+K8t7LWTDh20m52jGcZdn9eZz6ic4hZe698OLLHM7ciFHi8IyT46eahf7J4tAF
	JEw4JEB7ngjyLw0kCj7rOLVN4od6GuzSHIJ+j
X-Gm-Gg: ASbGncuo/po9CvtJ8yHkKCXISOTIacPwZmiEQPetkaIjfUM6HbPXDr52rJKGWBVLeV9
	2o3UJ+jkvZXyO/HLo9zNjcgPUhidYztSgaOLILmC+JHLjjEmxqlpzpuhG4Gk1WuEMFZdkQdEzN/
	PNqkNc92R9tH8j5X+mPCGdHyTqpMoC+N7ytklzYNb+4QYaL1+NDtFdjphPZUUoBWrbnazfvdvc+
	DRJwQ==
X-Google-Smtp-Source: AGHT+IHE3W/G4/Yn1MXV6f2yoIs3zJ2J0rASCVqWjWYMDt4N9zSd7QESNWrnWHzWyGh301okChh5RdlPnsg+LnCcIpk=
X-Received: by 2002:a05:651c:2117:b0:330:8c4a:4749 with SMTP id
 38308e7fff4ca-3308f6519damr8879041fa.37.1752675074277; Wed, 16 Jul 2025
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
In-Reply-To: <20250716003726.124975-2-ipravdin.official@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Jul 2025 10:11:01 -0400
X-Gm-Features: Ac12FXywQQ9SIipRQJj3j2p_NxLzuDUkGMOU2H7PhJo4t0AvqcczT6v47DtRL9w
Message-ID: <CABBYNZLOTLVz4kCGMK7kw1RE-KdWciOYwkn6tN_=GZUk92ySdA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ivan,

On Tue, Jul 15, 2025 at 8:38=E2=80=AFPM Ivan Pravdin
<ipravdin.official@gmail.com> wrote:
>
> Create and use new vmalloc'ed buffer with dev_coredumpv. From
> dev_coredumpv documentation:
>
> `This function takes ownership of the vmalloc'ed data and will free
> it when it is no longer used.`
>
> As hdev->dump is used after dev_coredumpv, create temporary buffer to
> hold hdev->dump data.
>
> Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@goo=
gle.com

It should probably close the syzkaller issue, which I assume is this one:

https://syzkaller.appspot.com/bug?extid=3Dac3c79181f6aecc5120c

> Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> ---
> v1 -> v2: Changed subject prefix to Bluetooth:
>
>  net/bluetooth/coredump.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 819eacb38762..1232c9a94f95 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_d=
ev *hdev,
>  static void hci_devcd_dump(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
> +       char *coredump;
>         u32 size;
>
>         bt_dev_dbg(hdev, "state %d", hdev->dump.state);
> @@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
>         size =3D hdev->dump.tail - hdev->dump.head;
>
>         /* Emit a devcoredump with the available data */
> -       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> +       coredump =3D vmalloc(size);
> +       if (coredump) {
> +               memcpy(coredump, hdev->dump.head, size);
> +               dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
> +       }
>
>
>         /* Send a copy to monitor as a diagnostic packet */
>         skb =3D bt_skb_alloc(size, GFP_ATOMIC);
> --
> 2.45.2
>

What is wrong here the is code that attempt to send a copy to the
monitor uses dump.head _after_ dev_coredumpv has freed it, so just
changing the order shall make it work properly:

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..720cb79adf96 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)

        size =3D hdev->dump.tail - hdev->dump.head;

-       /* Emit a devcoredump with the available data */
-       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
-
        /* Send a copy to monitor as a diagnostic packet */
        skb =3D bt_skb_alloc(size, GFP_ATOMIC);
        if (skb) {
                skb_put_data(skb, hdev->dump.head, size);
                hci_recv_diag(hdev, skb);
        }
+
+       /* Emit a devcoredump with the available data */
+       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
 }

 static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev


--=20
Luiz Augusto von Dentz
