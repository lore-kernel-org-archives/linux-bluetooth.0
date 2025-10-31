Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E93446C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921339; cv=none; b=IRjoz+vbW9Wk1OxLDogeXr90kZNFVzQZk4fsX46rfanvC/bHEKKn5LOscU1ad3UMkqrHRjbKvaZ6TvphJYSJKHmbj/ZOxUdLkkSNcvCsxpvmCmhARUF2+Nnq4Lpl0cfw4RJnFE4P4YPFXm/sDtUvfTpWvuGuWZadkH6NfSZJWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921339; c=relaxed/simple;
	bh=AMSI4zE2Da2CoHXVBxERvsBwEjjKt58XBoEtfuiGLlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp8EWzwkG9sY9qd/+KCvHGm9+TTxSOWUj2ag3hGrbNSsgTVobnz6B1N4BkxVvV5TpdtzBt+GdOcGHofRTmNSTe2Cc12KVQ2vZsQZsRootljLytvdjahIiS50w1/RDJ8vKSPQ4WdbUyUZDy82oCPjec1WVtRI5SPjIeMIIKFsVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqJAZPms; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqJAZPms"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d50e1cccso24960751fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921336; x=1762526136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhKJuz27wu9b2Q/v2pjgIV8qqd+0+y6WrGE4BcakU/8=;
        b=mqJAZPmsRxzGMJwtLEKgI5sUKxRZs9gdb80UtKbdOCNnffo3CSsnVrW+nq5Rh2Vifw
         CZJuFpBXFPTnNk25sxRg9KZhrKHR8qDTBGSgvBk1+0IWwhTEsS1AmhOSHidpxybATzgZ
         yN+j5wlLSC7VNuRc2O9+p7/G9n/u1mHiM+YmildIMBMHr8wnMy5z16I+zOcYpUJIdXr8
         2skuFjg2/4GN9cgg1DaTQbZoK9kupSwJUxADC+LQm648tPfZBwSK79MVqdP87VDIOtqf
         Yob6FDQ+hhcjtjg4H2Glx2ViyoQM5rGftAvhh97iLL4r9cKERI0/b4aWJWLZt1/yyl17
         Ri0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921336; x=1762526136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhKJuz27wu9b2Q/v2pjgIV8qqd+0+y6WrGE4BcakU/8=;
        b=gMbLIqKgp1HOQhyhj8xxdIpLacaEMHmNDDkQoLddJKvpUC1WVty+UgMNqydpLbHdr2
         /R9HrAge6644Ha25+SyihhNAPr75FHeMTkRG0zOQrRfyrkB7eRfHRm/HjxQA7sRZdFUs
         rDzOgXdeMF0EY09/aQacS665TDVWK6mru6do+F0KpD6RPWXJ925TYwnOtTqXfPFZLOLE
         CmKHE6UO9BalB+yI6B0QCfdqRMhcW87uaOnllBdVmvV4B3qeP/tkHAgMu/xfHRXySvfN
         /5GBMFqlyYSgJbyTeklfmd1uSJUCGWjnhnwtNFaQW5UAOwrFhTvJH8tsW47g5pNCoa1W
         S3Tg==
X-Gm-Message-State: AOJu0Yy0JZSNhSZeh6JCfqE1e5TTadHKOhy9jgDYQ4eDOkY3+BqlOKkP
	JMhxOlVwNFSFrN9T8rOtMsPGe4wkkLhb2i+CQDag6nyOW8Pt2Qe3Waq87+pg3sP0mrXqamTHM9l
	vs2AYV6YaBx3/78AeaPVVyoHPl81MxUUyDdN8A7o=
X-Gm-Gg: ASbGncsNvNJt3x+j3W0QVFQj7UVJkmiXxU+YDlvBE+lTNu2EuB0CnOPIa7Xiz+VoM9+
	sBsBoCR4aVeHTu6kBy5aA1ABallq+K1/Bt/9jKLVCSaFOa66reksrwLDuqu9WUKngOZTlZHTsYb
	GRkZ5dKrRLemQfwADOcvz0imx1gln0NzqJR+Bo6O0ydxqfLFJCJENQnkhZAm3zBy2uXfic1o5Sb
	SWB7kCxDWhZX6facdIzy4WRp8Ndx82WoGRx5IAocdzU0vKTwwMswodkjOs=
X-Google-Smtp-Source: AGHT+IE59eDz+HM23HuvxjomEE9A/DkvQf7SFbgGyB96I8VG23RpWREEs1gOfdNBEcb7IlhV8UI/s5eCTPxUgw0+bZE=
X-Received: by 2002:a05:651c:4093:b0:36e:f1ae:d4bc with SMTP id
 38308e7fff4ca-37a18d9b72bmr9194001fa.14.1761921335672; Fri, 31 Oct 2025
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031081525.2275894-1-lilinmao@kylinos.cn>
In-Reply-To: <20251031081525.2275894-1-lilinmao@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 10:35:22 -0400
X-Gm-Features: AWmQ_bmuXGhzGerZwZFRtPGqD7WF3harKpEvUmZcQ9sLxynctPfun-jmZXTsBxA
Message-ID: <CABBYNZJZeP1eFZXrVPMAhEtdNVSWkuAkyopLcrUG6wbQpvgsww@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Prevent autosuspend when
 le_scan_disable work is pending
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 31, 2025 at 4:15=E2=80=AFAM Linmao Li <lilinmao@kylinos.cn> wro=
te:
>
> When USB autosuspend occurs while le_scan_disable work is scheduled,
> HCI commands sent by the work fail with timeout, leaving LE scan in
> an inconsistent state.
>
> Scenario:
>   T=3D0:     LE scan starts, le_scan_disable work queued (+10240ms)
>   T=3D8s:    Autosuspend check: tx_in_flight=3D0, suspend proceeds
>   T=3D10s:   le_scan_disable work executes on suspended device
>            =E2=86=92 HCI command 0x2042 times out
>
> The tx_in_flight check only protects actively transmitted URBs, missing
> the window where work is queued but hasn't submitted its URB yet.
>
> Fix by checking delayed_work_pending(&hdev->le_scan_disable) during
> autosuspend. Return -EBUSY if pending to block suspend until work
> completes. Only set BTUSB_SUSPENDING after all checks pass to avoid
> leaving the flag set if suspend is aborted.

Hmm, we could also just cancel the work then, in face we do have
hci_suspend_sync->hci_stop_discovery_sync->cancel_delayed_work(&hdev->le_sc=
an_disable);
but perhaps it is not being called always because HCI_LE_SCAN is not
enabled, so I wonder if we should do something like:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1cbdd2ce03f2..59618fde7bcb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5464,6 +5464,11 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)

        bt_dev_dbg(hdev, "state %u", hdev->discovery.state);

+       /* Always stop le_scan_disable since that works as discovery timer =
for
+        * the rounds of discovery irrespective of the discovery type.
+        */
+       cancel_delayed_work(&hdev->le_scan_disable);
+
        if (d->state =3D=3D DISCOVERY_FINDING || d->state =3D=3D DISCOVERY_=
STOPPING) {
                if (test_bit(HCI_INQUIRY, &hdev->flags)) {
                        err =3D __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_=
CANCEL,
@@ -5472,14 +5477,9 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
                                return err;
                }

-               if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-                       cancel_delayed_work(&hdev->le_scan_disable);
-
-                       err =3D hci_scan_disable_sync(hdev);
-                       if (err)
-                               return err;
-               }
-
+               err =3D hci_scan_disable_sync(hdev);
+               if (err)
+                       return err;
        } else {
                err =3D hci_scan_disable_sync(hdev);
                if (err)

We may as well rename/reworkd le_scan_disable to discovery.work since
that acts as I commented above it works as discovery timer not just
le_scan_disable.

> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/bluetooth/btusb.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..a344ea1dc466 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4389,6 +4389,7 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>  static int btusb_suspend(struct usb_interface *intf, pm_message_t messag=
e)
>  {
>         struct btusb_data *data =3D usb_get_intfdata(intf);
> +       struct hci_dev *hdev =3D data->hdev;
>
>         BT_DBG("intf %p", intf);
>
> @@ -4402,14 +4403,19 @@ static int btusb_suspend(struct usb_interface *in=
tf, pm_message_t message)
>                 return 0;
>
>         spin_lock_irq(&data->txlock);
> -       if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
> -               set_bit(BTUSB_SUSPENDING, &data->flags);
> -               spin_unlock_irq(&data->txlock);
> -       } else {
> +       if (PMSG_IS_AUTO(message) && data->tx_in_flight) {
>                 spin_unlock_irq(&data->txlock);
>                 data->suspend_count--;
>                 return -EBUSY;
>         }
> +       spin_unlock_irq(&data->txlock);
> +
> +       if (PMSG_IS_AUTO(message) && delayed_work_pending(&hdev->le_scan_=
disable)) {
> +               data->suspend_count--;
> +               return -EBUSY;
> +       }



> +
> +       set_bit(BTUSB_SUSPENDING, &data->flags);
>
>         cancel_work_sync(&data->work);
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
