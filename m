Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BF42E8CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983116; cv=pass; b=Skdy76JuFVff0KeGfc9uzY76nJSzncBiqts9d+jEqv+VE1df711VGdiqbTVOZY6HPQ2q4Gh+5fk7PhCyLxQsxguRDKpLtqTeRbvwhlT6HtRkAHyKNCxqGGtGepHVbcNepTJuFBsOqh88XZIvuPIgUZ/CMCYj2FMZ/YjOdVegb+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983116; c=relaxed/simple;
	bh=TxKeIXRF86ivBxRjmnwES3EEmCq5bYW1Q/mhaUnlTv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6T1a1N8n3KLhAKZKYFTspEj4NSk17UMnKvbG6j9uSzHybjXatc1tHSBk7XCigV/WO3raA3BqXkX7iBAGKor/hVpDZIe/hhRzWyJpF64kB8lzHXcj+Upa9hGou6hjTEI1FAfDWckwfEB3FY8df638wOBVaXOamJsbbtezN4Ax1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/BhHyhD; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/BhHyhD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c8bde2dcso45689707b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786983111; cv=none;
        d=google.com; s=arc-20260327;
        b=pt98pphLxC6jpjXlQfaJBb8Xg5RCDx5EeL4zgtaEZlIuieOIqTSrlMSM+u5A9JLJfx
         QCDu40xXadEC3VLztjuMTcRMbHLKc/0uwkALpxNV63fU4hMbExZHu9a0NMtp7VOMkGyK
         ULopp11xBJ9ojKlnQTQVZRifpULGBLGNLGzY1o3UGmqpqk87Ru6TQDWo5PRJL4qavf3u
         HqTuLPjM0Urp9rxdtv27jd+j0r3QrOB5IEF6OsJ2QO8nfo1fnm5id4tQXz0mYKiK48Rp
         eIv2X75BfI1yOCLJbC5hX4Xwrjp6cx0TBtEN4rsGWvc77Chz77eqMQk9IKEyzO5Hh6XO
         HErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        fh=+Qn5MvUE9KQK3P2J9RgLcpUvl5JaNAJPH7s3l36hIbQ=;
        b=L2X25YtrwOWNcR2aCB2fhm0fva1s59cTQkB6Gv35Dt0mPHCkQkZ4YI4dX+SOA6pniL
         Tp85yzF7Jrd1W0ax+pkgRgi3NdBkqpSSZ/PyV/4FtvG9bLEw+lNv6TA5eH8mGnRT966r
         /aOGIP5o2i6KQiHg1Yzbc3b9BI/m/3S11W4duBgy1XKFh/t/z0M5pEB8upvPBQ5jWtRp
         Oa0MF+F5BYcN/T9t/Hucv1AMnjxXXHCBsjFz+uf5N2mdnhCZ5HKv29YafWrZxs6os1+E
         Ic3BGThG/ISkeRufmfGoc1O7QvpmqX+yhBjxSc5fQbo12AJry+6k//tWpZdgrPAamL3E
         xgrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786983111; x=1787587911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        b=G/BhHyhDp1vGQKuDF0mu+K8w+u84AR3Ec7vBYiKP4Vz1lQijgDZ5+dvqPiZ5gI4bZe
         eUig4MXdWeqMhFFAxWJx9Avn017Qlhgn9DTxMWFWNRp92t+2DZD50TXdOHINCcpyyx65
         sJQUVqKWmH/bqjP7aVYjSfHSsu0Dq5ehDRSnbdUIawRYUTmn1y5zoWDRj3NWSi+t2HYn
         2DsxlEUIcGmhADGEsW01BCGAuB1K+jxDwogP1+DCjdS4tRFYOB6zxYqql3F8uWwrpZAq
         7bADdL7zURcB9joOcxpXW7bMcqFn+2jcJSp64CkX3FVqY9Mgy+/p7JZq1lyRBNDI/K/O
         TCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983111; x=1787587911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        b=EIhF2Q8EDeSDbzdvH1pvS3L1pozBQ04qVbRqxaDjDZ4zj5o30XG+Cu8UrIZ5OW2+y8
         tnCtg/6oZw3AanVhwAwBgiATXh4J262MV57t005Vg0ZCj4OwRlK/rV01gMBTo9YmnR+y
         n1VGrn6X1PlcBTKip3RqjmoeT07jzB1CMR8F7McU9sOgz4wk4oss2YuLBoY3aPOsZdXN
         GoPXo2l8EL4HRDHZNTT95ZHAcug5b/J0MhqtHaaC8cxpozkgjk+JpbDhMXLwLABsuMTu
         ucDVfBvfCAxNyXnT4eK/8ZFJMhdVHY9b4WtzKqJuNDQkFYElMVuS3jTzsM5mfnl3nx1R
         XynQ==
X-Gm-Message-State: AOJu0YwPrQ0vMN+1EbgoPQqcWZ4Uysx2bXKl/R0LHAqtniVJEjRjeZjI
	7U4/nJWRirzBZ4xwJQqP402RKGlosSsAihey7O1mfn6hr07DRw2O8+9wbqsdB5L5yU1lCx4gTQy
	NSwh3xfEd8Y3U4yIKOFMIH5M+72MSp6P6JhalK28kyF3z
X-Gm-Gg: AR+sD10w+eKM8YFA/UIVIvC7DcO2uLs62y2oJP1kiAaYc59KJoBAJRhn4cDA5g5UB9v
	PGRIupEx2/X88e1d8fHTDFUQeLqQpkGAx9N030rAhqb0o+gjn7JDjQxUr7pvLsV0WGMPalzsH+T
	Np/s5S8s+6vGsdzz9LUM3ysHQt/Z/IbxzVVRCWgiZ0QTwvcYdsCNt7AyN2garDWt/okPeyx/P3w
	ws+HYRgucA44i9VEisrcUU5iRinKtaYxmtgGEjiADXusBw9acUi5k0mWjskfe9XRnNAdukl2Uo/
	yQwOpflMt5FTPu/wVEyTQXV2K+xwzBe2LZ9xIxePLNz4V52Xz4mJeMb8eb/o1WutVX5fWU2GC0P
	uiKZLet/IFMUUWPNQ0qFD2HbCiZ6GEC1A8IojvB4=
X-Received: by 2002:a05:690c:350c:b0:81f:3969:4abb with SMTP id
 00721157ae682-837120f5e45mr99343807b3.29.1786983111180; Mon, 17 Aug 2026
 09:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817150240.520181-1-valentin.kindschi@fiveco.ch> <20260817150240.520181-3-valentin.kindschi@fiveco.ch>
In-Reply-To: <20260817150240.520181-3-valentin.kindschi@fiveco.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 12:11:39 -0400
X-Gm-Features: AcwNN1UQ7PbI7dH28blaACAAUUeWuGN0Dkp1mCbuI2K_MqDLHz1Nx88r6KNdpmg
Message-ID: <CABBYNZJ55q+jpSRrp7PS31hR6xbDEPNExQCADKGWFKtKKweMjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_event: keep HCI_LE_ADV set if the
 host cancelled
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Aug 17, 2026 at 11:03=E2=80=AFAM Valentin Kindschi
<valentin.kindschi@fiveco.ch> wrote:
>
> le_conn_complete_evt() clears HCI_LE_ADV before looking at the event
> status, on the premise stated in its comment that all controllers stop
> advertising when a connection is created.
>
> That premise fails for Unknown Connection Identifier (0x02), which is
> what an HCI_LE_Connection_Complete carries after the host issued
> LE Create Connection Cancel: no connection was created and the
> controller never stopped advertising. Clearing the flag there makes the
> host believe advertising is off while the controller has it on.
>
> Other non-zero statuses must keep clearing it. Advertising Timeout
> (0x3c) in particular means the controller gave up advertising on its
> own, so the flag has to go; leaving it set would make the
> "already advertising" shortcut in hci_schedule_adv_instance_sync() skip
> the HCI commands and silently stop advertising altogether.
>
> With legacy advertising the disagreement is self-sustaining. On the next
> software rotation tick hci_enable_advertising_sync() runs:
>
>   - hci_disable_advertising_sync() returns early without sending
>     anything, because HCI_LE_ADV is clear;
>   - LE Set Advertising Parameters is then sent while the controller is
>     still advertising, and is correctly rejected with Command Disallowed
>     (0x0c);
>   - the function returns before LE Set Advertising Enable, so nothing
>     re-sets HCI_LE_ADV.
>
> hci_schedule_adv_instance_sync() re-arms adv_instance_expire every
> HCI_DEFAULT_ADV_DURATION (2 s) and its "already advertising" shortcut
> tests HCI_LE_ADV, which can no longer become true, so the command is
> retried every 2 s indefinitely:
>
>   Bluetooth: hci0: Opcode 0x2006 failed: -16
>
> Captured on a BCM43455 (no LE Extended Advertising) after a central
> connection attempt timed out and was cancelled:
>
>   LE Set Advertising Parameters (0x2006)   Success
>   LE Set Advertising Enable     (0x200a)   Success        HCI_LE_ADV set
>   LE Create Connection Cancel   (0x200e)   Success
>   LE Connection Complete                   Unknown Conn Id  <- flag clear=
ed
>   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.033 s]
>   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.016 s]
>   ...
>
> Keep the flag only for the host-cancelled case.
>
> Fixes: fbd96c151cdc ("Bluetooth: Fix clearing HCI_LE_ADV for LE connectio=
ns")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 btmon
> Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
> ---
> Changes in v2:
> - Rebased onto bluetooth-next; no functional change.
>   v1's hci_event.c context lacked the hci_store_wake_reason() call
>   present in mainline, so the hunk did not apply.
>
>  net/bluetooth/hci_event.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5720,10 +5720,12 @@ static void le_conn_complete_evt(struct hci_dev *=
hdev, u8 status,
>         hci_dev_lock(hdev);
>         hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
>
> -       /* All controllers implicitly stop advertising in the event of a
> -        * connection, so ensure that the state bit is cleared.
> +       /* Advertising stops when a connection is created, and when the
> +        * controller gives up advertising on its own. It keeps advertisi=
ng
> +        * when the host cancelled an outgoing connection.
>          */
> -       hci_dev_clear_flag(hdev, HCI_LE_ADV);
> +       if (status !=3D HCI_ERROR_UNKNOWN_CONN_ID)
> +               hci_dev_clear_flag(hdev, HCI_LE_ADV);

Hmm, I wonder if this is not valid for all status !=3D 0 though, for
example if the connection timeout we probably shouldn't clear it
either.

>         /* Check for existing connection:
>          *
> --
> 2.34.1



--=20
Luiz Augusto von Dentz
