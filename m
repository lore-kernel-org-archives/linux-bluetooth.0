Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC1CD2C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031513; cv=pass; b=jNeiqhlhng9frU0zWd7Frn8g+lVrCzLwXR61Shg/RjkK+KzyUhGXrks9Yje69TQAM/C+2zAPbS8J4TZIjh8viKMZN0k9zn0UxzI9t7JrEVqf6kRPuT77PhEIF9CH8CGiGdD0lHKIYrZgUH7SRZllc9R6pM2FP5GjbHb7zz8mjq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031513; c=relaxed/simple;
	bh=1euOt61NGiPUxm/16Mcp/dLiglNgpuspHB6/fWltKJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAma0RbTElaP6eJXoddAs3XLZSxNVD+injYfw70HXYyB2iuScYuGgD4ccGWOht2bJrAiITzmoz863lEvOKeN6XBKH4b3Mf3NjesyyzJRHzC3uo2pToKwXFgufRNe4nb/uGw+0dsIOG0vbavhKsHbVQYmoOccPKKL18RK8xAtXmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOE2wiit; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOE2wiit"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64eb7def21dso82616d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774031512; cv=none;
        d=google.com; s=arc-20240605;
        b=Pc7t+46YXZ5ZzhX3v6bvDjDx3sVndEUxWhPjHfvyACeM99RpjsZMJKAsgAOS+RqKI+
         jQ1dHBGeg8y7cZ4hEltIZ8/dShn7zUXtZ6QtTwm+BBGKgHVw7srKLMvtWETD3dxwXWXb
         PsvTmHwqn83Z9lCJS81dTeM+wlZ+RexXd14dePiaCWo978gPZQHt+euA4QVLB+TrBvJo
         TzEERDtVLLilSv4vG7wLQ+3pHDmuh0MasbFstjL/R5TL6475+cszAOVJqeQAHWbKHhgh
         CaPTsgU2diNBgJ0Y4kLnXFyrXABmYIEpJOzDdELmL0Z3js8teb85cea/KI9zroQ3OMms
         Br2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DbiHBmcB2tt5lxJvP05UC7QDJ82POUBzMorB6Nqabwk=;
        fh=tbdFINF8I6FwxbBQqrwgQuQRCjZReRB15a9IiL3jp9Y=;
        b=bnpmG5KWfGWH3tII8FvqqawzjmNQNCX5nafwWK+rIu30GvC1aiKn3WiAl77bDcXhgi
         z8XPGvv+bhWkyeQ2UkEOkWjwAK6u0V6ynZ7IOiw8BnHv3hjwXWsRh1Jfs9uEiXxmovVM
         mai0jxt3Xf7qRG5Rnm9gRhDm1MVcP4Y0/R0VYuq2qY4+hTTxh/KTZ6RO+3lBgvpj8/vd
         ayDgkiaLxPKE5YeWMV+ZRW4JLYlVs5Pw8XQeQx4cQpjc4SkcvimIlZmsSNzK0DzxQDWX
         Y0UOhG6daQH60WI0k4Fpm7j60jA8oz/os8+vOphlOhFDgB+90Rm1m+tgnflh9ijFWK7G
         YBrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774031512; x=1774636312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbiHBmcB2tt5lxJvP05UC7QDJ82POUBzMorB6Nqabwk=;
        b=GOE2wiitbE5bnV6JxQerNvFJJEOEE7Gqx9pr/Yx+GfU1c/y5HY2F3nFpeSqXtPJ0av
         pKWEkqNeBMm0bnQSoWe+xFH6IMKGlqXM2RhNFWj44rwSI8iBJkr6skXugMYUHhYwyrlO
         EO47c0nc2obHcfI+2P4Sx2xw6qOb6NZ4XClUdvUYCsK8PppTmwD5+xzn0iekS7S+ZJQA
         vq1XW5qtS0n1YGOlvVLgdXZZpd/3WLgUlNFapoWC3U9t8d360yodGBSdwh70H53tIzRi
         Ebzlaj8zRtCjFa0x5+om15suyFR4s2LTLOPZm9Ts34SCd5XrZF8LGbBLRYM/M8rjlM2C
         Hg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031512; x=1774636312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbiHBmcB2tt5lxJvP05UC7QDJ82POUBzMorB6Nqabwk=;
        b=Z6wBjKOQqR4oE7a9dZj0jDI65149ppfFUB58DG/N0cgiDDXFPszQt+Qtp2AzaBrn7x
         7H/jxuc5JnKry2CDbqhCF9Q6RsFrq/N2rULnEAl2jYXTKGwGXPJvYTNFaXmu5YTbZXzY
         HZgqSHBJk9QKFA1oOsXvrVdiobaZJjM82wGpgVnqKh3XLOpH7qksVfKLn/wVoAbjTLq9
         0AK7h8woKrbPP/2L+iUfR1f041zDk9sjrQ46UBzfjmnh0sBDqur4psDpSa1n5z8LKVCw
         +boJ74gPmIQfTY5weKYjIiVyuMx8/gR79ydemidL4y5UEanABzaXaf54XYGaFQtoGn+X
         SVjQ==
X-Gm-Message-State: AOJu0YzuY8D2u8k2oTpO+088lLjEd+EbUkg7CnLURkSG714hUfAPcVGu
	H7R+3RKM3HNNHaLjQFks4Es0xxKIHBfGHFWSUovmnnys4AokhqX4jnLBAF0uZtDEccWlp/yv/2T
	B6f2oHZjcXTrXZ9lBQqhX832Bq2zws0U=
X-Gm-Gg: ATEYQzwXPlBgTQDhQ4QAm3+qCzzHD+lZqXsZFsME9Ab80wWqA/Cw/FS6TEf04umg8Ms
	Sng3RrBW+QSNGXiKKmGIUlBQIzpJm6pILMet6E1xFd8VlYPDIMmfyYCQ7UDpC+iKfvqLCLBZtdn
	SKKGaj0Pltt6BKq303LzoClyGa0arCsmnw63kMsf5tcnBzl4ZRSGOcn/ZCIkbrJPlHLEFUpNzYy
	IH/sQCVyXn/1VuuwU4r9Kny2PUMuc0OG7kDgEF0XctiVFE8XlPuI2q7scXxnuuqxCB58JPWbDxl
	kXM1U8NExPG3+CWf6F5eKWhbOrXYzmx58aioOdNekDZMeAUBSq8bfl1qWsUgLJ5vloRryA==
X-Received: by 2002:a53:e1a3:0:b0:64c:b6d9:a847 with SMTP id
 956f58d0204a3-64eaa69829dmr3459571d50.5.1774031511701; Fri, 20 Mar 2026
 11:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd1ec531-1603-4788-952d-ff256c898e0b@posteo.de> <20260320114347.2340528-1-fberg@posteo.de>
In-Reply-To: <20260320114347.2340528-1-fberg@posteo.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 14:31:40 -0400
X-Gm-Features: AaiRm53YNK4HjOwXYqYFrjTGMlfQyOUQ12yHTplCjQcA7L6Tc-q9-kCW73ma1Sk
Message-ID: <CABBYNZLxZ+=5Zg6269+DbsE=Q9KQefZQXqacyn1iOR3nYnLuig@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: cancel pending HCI commands before USB suspend
To: Frederik Berg <fberg@posteo.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederik,

On Fri, Mar 20, 2026 at 7:44=E2=80=AFAM Frederik Berg <fberg@posteo.de> wro=
te:
>
> During system suspend, the PM notifier and USB subsystem suspend run
> concurrently without synchronization. If the PM notifier's
> hci_power_off_sync() is blocked waiting for an HCI command response
> (e.g., Write Scan Enable, opcode 0x0c1a) when the USB subsystem tears
> down the device, the command fails with -ENODEV.
>
> Unlike a timeout (-ETIMEDOUT), an ENODEV cancellation does not trigger
> hci_cmd_timeout(), which means hdev->reset() is never called and the
> Intel ACPI reset method (_PRR/_RST) that would recover the device is
> bypassed. The device then fails to re-enumerate on resume (detected as
> low-speed instead of full-speed, error -71) and is permanently lost
> until the xHCI host controller is reset or the system is rebooted.
>
> Cancel any pending synchronous HCI commands in btusb_suspend() before
> btusb_stop_traffic() kills the URBs, but only for non-autosuspend
> (system suspend). This matches the pattern used by hci_suspend_dev()
> which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN) before proceeding
> with HCI-level suspend.
>
> Signed-off-by: Frederik Berg <fberg@posteo.de>
> ---
> Proposed fix for the race described in the parent email. This cancels
> any pending synchronous HCI commands in btusb_suspend() before
> btusb_stop_traffic() kills the URBs, preventing the race. Only for
> system suspend, not autosuspend. Same pattern used by hci_suspend_dev()
> which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN).
>
> I haven't been able to build-test this against a running kernel yet,
> so consider this an RFC.
>
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a1c5eb993e4..acec484b495 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4497,6 +4497,9 @@ static int btusb_suspend(struct usb_interface *intf=
, pm_message_t message)
>
>         cancel_work_sync(&data->work);
>
> +       if (!PMSG_IS_AUTO(message))
> +               hci_cmd_sync_cancel_sync(data->hdev, EHOSTDOWN);
> +
>         if (data->suspend)
>                 data->suspend(data->hdev);
>
> --
> 2.53.0

Have to agree with a few points over here:

https://sashiko.dev/#/patchset/20260320114347.2340528-1-fberg%40posteo.de

Specially the first point: if hci_suspend_sync (which should be
pending not hci_power_off_sync ) had run, then there shouldn't be
anything to cancel at btusb_suspend and hdev should be suspended.
Perhaps something is trying to power off bluetooth (e.g. userspace)?
Anyway hci_suspend_dev does already perform
hci_cmd_sync_cancel_sync(data->hdev, EHOSTDOWN); or do you have
HCI_QUIRK_NO_SUSPEND_NOTIFIER set for it, which is why it doesn't run?

The other option would be to call hci_suspend_dev directly from the
driver, but then again the register_pm_notifier guarantee that the
notifier completed before calling the driver suspend, or am I missing
something?

--=20
Luiz Augusto von Dentz
