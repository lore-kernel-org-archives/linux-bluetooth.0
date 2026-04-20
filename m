Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519A3859F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717482; cv=pass; b=RsWi6Us2Cdt/Z4gNnbASZUGD2Iyr3sRQy0X/8F1KUNtdtcDOKn6UXPMyHzkYW5SFqYpLwVdcXrXfHYfr87/vvlrKw0khxVCh0phU0e4N7NzG0XrleV5JIYY6J5AhO23iV6BtGraYfzQm4xO2Z0/eZJ4UGB1Wkkx+I0Z7D+MslXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717482; c=relaxed/simple;
	bh=ADQUzdT1kaUTCl9XZzAUwQqYr9cALPSJzCeEmR/kFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTC15br3rpphBQAXq74G1yioLNxU83byEhm/8LG8jqcMWhKehDPdlVpsk/81ZzuNuAuCs+KM0s3C6HnvuE7XRspGG+eMnqCMHW9MXy9oTSqnunOMnlrTk2a3v2gZohcSFqPlRtKMJrK+c0lpUFQxI/zG+khVKHZXDHpUIN8bwV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCkQy4xR; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCkQy4xR"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65427236e94so1220444d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 13:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776717479; cv=none;
        d=google.com; s=arc-20240605;
        b=iNfxY2NDELfE6bfITIy4aMuEQ3/nOppbkONJT6B9a7cOhaY/vX3wsJwPy4zFiVwG8W
         V8rK57QCBOUrXNdXjr4Htm6WAAIyMJbFw4kWjPJHjH6jKZxPotWn/XYLKRmF9Dg7UPeW
         e7IogIHqc3H00h8+i+o798huImfSaEUYJF4WJVh7ui3Rwa1fTFBk3c83GRxjU6oNcbtz
         37yfnaHXiD0v0PtbinriO902/uV037ZYJccku0eNtkO1kEqDj/E4AGr3kkEWidDwfN+I
         dOxoJWy2XOdbp23x0UM8ZX9pwkKqDjeWGiXWO6o/k2t7OeTHt+fjaL2CR5l4WCergh+Z
         oCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        fh=Urf6QduH+XfosIfqGSfb+/MbtumtMC5kl8tN0Zymiqs=;
        b=Wiwp5VSARYhsK2fru6zDPymfbuHIXK8GpbnM9H1VBIbH5zzmmLCIQwuDA3lAv2QZ7w
         Y5/LFDpCCoDYC+DpQzxs2DetbPVBoT3TdYoaartDuApzN4NXBXP3J0beqpMMQ6eKgKD/
         +qf/i2Betl2LnQSWP9JE9IC2Z5YJ/qRscxMxmTRVQmLJMGCVrNFPT78nUL+GO0tesfO+
         tk8FefOGGU0GHebkt92cStDX8izoaklv+rrrv71E/7Pj+MBv2BSBnaYRozO8OdOh5+yN
         RMgo9raY9o8ansjW8xuFdr1aR5DpafUMi2GPF6PuDlsIQJAAuyN8RSlVU2JOsQW0Z5PX
         sTMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717479; x=1777322279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        b=DCkQy4xR/8IyajeA7H4Q9UtNGrDz2azOo0vpd7awTeLWqj2Ll9Mpzr4FL4qASqw8U+
         l1mWdY4QcwA5v7ImPPKTSDTcl5YOvumrKaWmJGGEygTGntS3tXaXH5aOqslsKX7DrJDG
         RhCMjvIMOCWAk6UP11Qf1yGE8ab/FVCTPPwiJZg/9iAWCQHf0vUN6sBXI5f5fH/QGL9R
         J0y43z+y0iPOuIElX+TagONHGnWgB3xC0G351RIQq/5k+2FnmnOvvW5+SG+9OynhrrrN
         nOB9KhqI9VZ4+yDPmEiAMiCRR3Z2bi8aPKWwfUHMoyPGqATp7dAJhS3TnJKfj9lBDBSe
         AKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717479; x=1777322279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        b=kZdDFqVvOqRVbFuxPxdUeXjkq4aOttzq0QQdg+NeDZ18yP/LE0LhxtNxuN7vmS1LYX
         eaDRzy5lGy/oC2gyUMH5inVdncYMYoa3nNj8L3EEu2/+zieJPTv/Nv8IKKwRRBMObxd0
         Ljo2i52nTQ1ASaN09ZLzHnzhbTHrmvrQ3/Fa0Wx7dgVGEjPZ1cFLX6xXvD58NhhNSrS0
         9qvjAaxsP0ci3VQaKL2UaSV0SLTthUWhnwJCkVIm0++E8H2fgwbRzsUWHc+KCTSBweNs
         7eOwrMQcYK3rkkDIOJi3H26OPOZ07sFYYYyAMgQbH38i165lkiwHswvZ68V5quqbb5dV
         gKDw==
X-Gm-Message-State: AOJu0YzV43qbU5OQr8ER8K1pft31cI3wnmgYlHNaZQVwZCAq/x6ItDUg
	xflRwNcAemHc1jvK3yCRdvn900jvXkN9o6uL8pN9G8DTrR59a6ZvT/LXi8g8ajdXnXm1akpQDsH
	KdA2Wje0YivmY4IXGBiDTBPnDzduouNk=
X-Gm-Gg: AeBDiev8u01IGNJXMOnK0/fwSvP6fwxi52MV1SMCgGWlaTIn4AoxOKGrjczEnkZ4CLW
	3iCjJHKurHO49Hmap4yFkrCtg9JMDyVs8k0fovSjQEGhJyUS8RTom808x8yBHfYRhQ2sZz1s1G3
	ZE+WRTHjeamHUCqcu36aoinaYtFNlFiiJ+kAHQSYoTr+ifDboU/A5EWtjGWVMZ/pTTlFUc0+/1r
	D5GYJrZHWjCM9ipAbsQcZBSN/U1dG0MltKjnnFSALW1Gx7w63w0CICE6XP7nv+EkhkYa5gG27KI
	H/1gbyFj8sMrPj1ksWRIhhKZ+G0PhvDnSXPSZArFQHvOgxlN8+1pwZkQEOKdvYW2q2syzlh8DFy
	P+zC8
X-Received: by 2002:a05:690e:418f:b0:651:c468:99a2 with SMTP id
 956f58d0204a3-65310a2bbafmr11722686d50.45.1776717479496; Mon, 20 Apr 2026
 13:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417104639.2608008-1-tristmd@gmail.com>
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:37:48 -0400
X-Gm-Features: AQROBzDy-6p2J796JPwwp_frm0FIgY1zcTHIOwEvqSjHrTNCfyTRMYOUjgz5Euo
Message-ID: <CABBYNZL-TZ_8XPpsH488Q8WtisfbX4jiBb_G0B3U-quiaYOAQw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length
 in completion ring
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, sven@svenpeter.dev, 
	marcan@marcan.st, asahi@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tristan,

On Fri, Apr 17, 2026 at 6:46=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware-controlled entry->len is used as the memcpy size for inline
> payload data without bounds checking when the PAYLOAD_MAPPED flag is not
> set. This causes out-of-bounds reads from the completion ring DMA memory
> for the HCI_D2H and SCO_D2H transfer rings.
>
> Add a length validation against the completion ring payload_size.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635..5d2f594c2 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377=
_data *bcm4377,
>         msg_id =3D le16_to_cpu(entry->msg_id);
>         transfer_ring =3D le16_to_cpu(entry->ring_id);
>
> +       if (data_len > ring->payload_size) {
> +               dev_warn(&bcm4377->pdev->dev,
> +                        "event data len %zu exceeds payload size %zu for=
 ring %d\n",
> +                        data_len, ring->payload_size, ring->ring_id);
> +               return;
> +       }
> +
>         if ((ring->transfer_rings & BIT(transfer_ring)) =3D=3D 0) {
>                 dev_warn(
>                         &bcm4377->pdev->dev,
> --
> 2.47.3

https://sashiko.dev/#/patchset/20260417104639.2608008-1-tristmd%40gmail.com

Comments seem valid.

--=20
Luiz Augusto von Dentz
