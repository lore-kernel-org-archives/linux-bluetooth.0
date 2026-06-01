Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3752E92B3
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320773; cv=pass; b=ZFCtuJMfNyu/id4SybvOeAXqHosQEwkGb5jPfPBKw5Wh0M1Y6XzJ7jT87CxhSDHGQVTeqSDQTrFopwexlV9MNMFcELQclXxUzEmLQ4XJfKexT+UhQZsXhGWv4Uo2hxl1NOVED2T0ceqy5+BgSIShEdKndKNLe/ar8aKNHlz3GNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320773; c=relaxed/simple;
	bh=xsOCJbl13p+ONLCk8qqplSw1SbMxOoJ3/bmieHshuJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uud/wyyUFigG9Z8JpCyGocOqcqaA6npuCvumY5J793Bc8j4qhDaSDAoOO2jo1Hk0FTs646bLiGhOJOiVY/YTcA5iOkLZ7B0aE40CxpFtouNb4cvVOD5cCyw0DYkgnQ3b0dluxXjHDtIL3wiQXrtQdPMlkdBkjxL9P3bMq9mJ3qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctnErD/l; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctnErD/l"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66049669d78so2965340d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 06:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320770; cv=none;
        d=google.com; s=arc-20240605;
        b=cMR9YIbjXLBQnZ8jVQePEITsHxdo0SZ/2AwjAwNCpR+viA9EPaR2K1t+9oYr6wKWdI
         zYgXomA5v+txS2qzUT7H2FxAdP9Etmq6oqxLlDGqGAmjnLV8xCDVbw7zTjWoWJi2VRoh
         TOSKPv6AJHBEML9wtFIpL6fIhMX4FwsDXQPrERhpmXAi0aQVQ5e/tfFOVjB/WDpRR56M
         yBHPP6Dk36k44A3dtmAQUMjuA4c0V2zzpR4O22Ddjf3bIk/9CgzJuL77ZNR6VIK5eLks
         RRBTIM+ofIPByxCskCu6673kuVHVktpVeNxHs9mqSyL9d4SBFnNjes7wD5TRhaQzs93+
         TIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F26imSLz26eOPqDYkL8X7zYLcI14XVvvvj6wIwF/gxU=;
        fh=4t1K2OH0SCvHZnrToT3CutO6nkfDtIiYC+AEao0WPGg=;
        b=A1NaNrfAVnHrY5dpK/lA37ugsDdcLnjGSm2EILOt3W4Wqah0e7FSQwjty5Ga+IDkR5
         B6xRoL2WpJjJpR816EHXALuodMqX56IE0txgciwMlc5MaKPpDFodchDBbOXkFUB1ptjl
         KiPTnfodrWVhycDmpzkQaocAdhV7It95Ba3swFQKYWM34Z2Uu/mvjGuRJDKfeSJaQM6i
         6bqRJ4MlDmC2VrXKIWV5SSaY5R27/xyWvIdpsOu8W82y8lN1S1DyX7ytiVsfd06B5KD1
         6KQKCBVhwnG9zr7HBzi8t2JE2mj6krjLhOc2MZV/YLqyPcO1cmose57Z+JDLa2fSTTKg
         QxLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320770; x=1780925570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F26imSLz26eOPqDYkL8X7zYLcI14XVvvvj6wIwF/gxU=;
        b=ctnErD/lRFW0UtF+1wSOGcFMvNn/52TupsWVEWrHu/ALBwQkZj0leX2S7nMF20NKBo
         ErqFy98Badqs2nydSnP1YHMJzScrvGRdNRahpPZTUfq0tfZozU9HAM2GpB5sUtfTok+D
         bxtULIB1tIBTaeb1bTPPBelbTsVrbIQ9js0DB+oWL8vAzMPHCc5g0KoMMrvI/9GHwh4t
         RTVocOgq8ctoQrLK3lL44iSbq9KsOx7C8JbQFgIX4F+AnM7O06Cg5rN9S8syjphZM/Ic
         f5wTHtoOHO6NgK05f122dMQlKrIj1qc2mJuJ1yzBvzSF0pWIuYK/+Uy+Okq2inDaL9GT
         xQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320770; x=1780925570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F26imSLz26eOPqDYkL8X7zYLcI14XVvvvj6wIwF/gxU=;
        b=amjGoMTTWmTxxg2Jge27GKI+AYS3Uci+KoxCkQYuiwwMgsMvThucRIJCPDUDjwbDQq
         pgBwvZ0UKCl4dol//jRprvpPiT+kunkHYZ19l2HzZ9NwU+Mg31AKKvp73tj6NalRgqkx
         7ilzlD95HAR6Eq+1j3YQb15jQ2bjikX4+AOTSoOLXGfAC6wPWRxnheXxXEeeeGN85lhP
         BajHxtbZq0JNRsUpS47skdSS1JhQOpvXw5T+ynbkO+3D6zFmlb+c5SK3giRioj64hVGI
         IUFSj+G0yhe2GrqOkzHPQ7MOubhEO6qVS7f+OCZ8LlB4JwE3fTbVYtyHmgk40zfHSnhc
         dSqw==
X-Forwarded-Encrypted: i=1; AFNElJ+89fsa+CgK35Jl2rqgqkOCUf6SSY91u02jLJc7bNN5U87dFy/f1hONkQTNfI0XnntDV4Sb23BBaxXI51R/oww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3CoxojbnnUmMXIlEdKgWzaesvBdvwzwATgjR5hM1Td+Cc0xP
	tO2keZtjfPI6e8rYLKBODMVjjxBDngG+tXoqcez/Qnckwo89TmhkFvv81CYjzeDiHb5l5mqtWfI
	sWUEZc1CUg3pWPIJ51OY8+SVDmjM0ack=
X-Gm-Gg: Acq92OGmuVApD7t3+84gnpP9GR11+Z2NGfDL6cxAjIxdz9TRrLaumRe86UR8/m/Hhk0
	UA1y8FHmQhrXp0lqKD9Nn/MCewH2o1B9VS8r5shjo3lwD/eZH6tjnivJzzPNK3LLkHIdPlYm0uj
	rgxK9bwg+JlziKRlZAZJL/gzlsYWeXzE6fnQSYwWXeUZP77KLexU/M4d4sxWX/6yDgM6x3Uj0Q+
	8LLxuZHBNCbpYK6S9NaoqYwGlc2WL7offJXB3mpAjxU3I+6Dhd+pUXnyzOwxjeWOyqaM/DfseT0
	lWKu9hBt6Kli0GZO3j2NMmagm/bmDs8w+4xFLuqz5q/yPfesgjR5ky/bupGp4Gud54bmc1ypQUC
	9xkD85R1vzWuash4=
X-Received: by 2002:a53:d9d0:0:b0:660:56ee:ebe3 with SMTP id
 956f58d0204a3-6605f049f06mr6209001d50.14.1780320769559; Mon, 01 Jun 2026
 06:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601012620.11764-1-liujiajia@kylinos.cn>
In-Reply-To: <20260601012620.11764-1-liujiajia@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jun 2026 09:32:38 -0400
X-Gm-Features: AVHnY4Iz0SaZ6ZGZCc1tT_uDieV_Kano0HJVkNao8Hid2YjqMdYUImKS7VLNu7s
Message-ID: <CABBYNZJ2Bm1Zw40hVEKQYuXjOLvLv8V+CrTugm4_1sbFdUw=Kg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix simultaneous discovery stuck in FINDING
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Brian Gix <brian.gix@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiajia,

On Sun, May 31, 2026 at 9:26=E2=80=AFPM Jiajia Liu <liujiajia@kylinos.cn> w=
rote:
>
> When hci_inquiry_complete_evt is called between le_scan_disable and
> le_set_scan_enable_complete and no remote name needs to be resolved,
> the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> state. No one sets DISCOVERY_STOPPED in this process.
>
>   < HCI Command: LE Set Extended Scan Enable  #1764 [hci0] 608.610392
>           Extended scan: Disabled (0x00)
>           Filter duplicates: Disabled (0x00)
>           Duration: 0 msec (0x0000)
>           Period: 0.00 sec (0x0000)
>   > HCI Event: Inquiry Complete (0x01)        #1765 [hci0] 608.610548
>           Status: Success (0x00)
>   > HCI Event: Command Complete (0x0e)        #1766 [hci0] 608.611589
>         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>           Status: Success (0x00)

This isn't enough, though, where are the MGMT commands?

> Add scan_disable_complete to check state and stop discovery if stuck.
> Tested with bluetooth AX201 (8087:0026) in Dell Vostro 13 laptop.
>
>   [4517.963204] hci0: state 0 -> 1
>   [4518.096858] hci0: state 1 -> 2
>   [4528.353765] hci0: state 2 -> 0
>   [4528.353776] hci0: state finding to stopped
>   [4533.966844] hci0: state 0 -> 1
>   [4534.097702] hci0: state 1 -> 2
>   [4544.478600] hci0: state 2 -> 0
>
> Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_s=
ync")
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>  net/bluetooth/hci_sync.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index aff8562a8690..4cb1c82cc3f0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -361,6 +361,28 @@ static int interleaved_inquiry_sync(struct hci_dev *=
hdev, void *data)
>         return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN, 0);
>  }
>
> +static void scan_disable_complete(struct hci_dev *hdev, void *data, int =
err)
> +{
> +       if (err)
> +               return;
> +
> +       hci_dev_lock(hdev);
> +
> +       if (hdev->discovery.type !=3D DISCOV_TYPE_INTERLEAVED)
> +               goto unlock;
> +
> +       if (hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY)) {
> +               if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
> +                   hdev->discovery.state =3D=3D DISCOVERY_FINDING) {
> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +                       bt_dev_dbg(hdev, "state finding to stopped");

hci_discovery_set_state already prints the state so printing it again
is probably unnecessary. Also, this probably needs to be handled via
hci_event.c since it is not necessarily le_scan_disable that would
cause scan to be disabled, hci_scan_disable_sync can cause it as well.

> +               }
> +       }
> +
> +unlock:
> +       hci_dev_unlock(hdev);
> +}
> +
>  static void le_scan_disable(struct work_struct *work)
>  {
>         struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> @@ -373,7 +395,8 @@ static void le_scan_disable(struct work_struct *work)
>         if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
>                 goto _return;
>
> -       status =3D hci_cmd_sync_queue(hdev, scan_disable_sync, NULL, NULL=
);
> +       status =3D hci_cmd_sync_queue(hdev, scan_disable_sync, NULL,
> +                                   scan_disable_complete);
>         if (status) {
>                 bt_dev_err(hdev, "failed to disable LE scan: %d", status)=
;
>                 goto _return;
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
