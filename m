Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00F3BED06
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022924; cv=pass; b=tccy2TYM9BQh0CsFEclMRfszqsaQlec2LOpWhQ8Z6WFp7TjhlfgDrSY4qreURURpmBFD/u9GkdtEYNbWnFXuJWo4VcjtUxP3pwj4jCnldBVMyTotwgJJm0TwzbU34/im2gdwjbQuZAirwaeLJbFDQCIuyQajW6a3sPjJ1A0rs0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022924; c=relaxed/simple;
	bh=VlmNs/mmWySdkvCbtvlw1SpTtQaE+rFQQtAyUtz3ku8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IStCOQ2sUuzUwsbQQGwTPHtMkCVkUj0jjxygY7fk5RGAvb295CySuLHsxzuzqNjca4QapaUb2pbbKbua7bn9gCFpjnnj92XtnZsxj1eqI1mtKGj8I/lstGYk65X/3YH81trSNjsoMoVAIQ0wWo4NoLq77btKaqf3UXerAuWBNK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gnh69Cr1; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gnh69Cr1"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69e1eba21a6so3898112eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022922; cv=none;
        d=google.com; s=arc-20240605;
        b=QaJHowu0h0flihpvjU0WudbCjkB3JSajU+Pb2/EGkmdiR2eNPesgd4STi4o2rkw9l2
         xHEjhLNma0MYkpgrzFqir72g91afG7EMV4EjQs1dyqLKEo5PmEelk25skeDX6JmIuyLs
         oGi9TEYZcinJIvGiMc5VVgp8kMduvmWnAiMyJzCALdynAl3FMaTW51YMhNpNCXgb/ry3
         KEzEy1znSNdodJ35dOo8S80ubUvBnRHOd1OwEPmvervSSjMHTIuxyTVyg+etz8NyVPIa
         p+9hWUO6m1pCLMv+xYPlAzUeluhNSh3KYpNT2Qwqrd5m/5M40k15x+V1fozuLx0PP/EN
         JbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JsHDIWK/DEuMxgFHaPqAWYQl6k2nKERtlHiE+nLuWcM=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=ln6Caxs8iOJgbrqsY7g5g8+/ys7b3GaJz3ZZQ7snRphB5oZeLN1pMhHuhUYUHSVRCm
         0aJo+a7uyUPo/TAXRP7zJwxRKjJ71wpCC/hKrjHqeEn1tA0+zo2QlzEICiJcCn39bTqQ
         HBLbagMXEuLTFRyV151UL8kqF/SqJyh0vFXqMDEFrXlLvr5+salGimFU5oCKYCewVasm
         BCrfj9b/ENkfzw4krogGQdg72eYoAXxbPsD3C+u+pPrRgNPTZqeX/eXb9i3Fxp/x08Kl
         xGaM0EIC/Q1thgcJExikyuZGkE1d7caerDyA3tGZPVwsgp3A8tLqt9Wo+PadZzIs5nwS
         cjMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022922; x=1781627722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsHDIWK/DEuMxgFHaPqAWYQl6k2nKERtlHiE+nLuWcM=;
        b=Gnh69Cr1+J8uNmevXeTgVJ07DSyrV/TnF/O+EFN6U5T+lEqtzm6TEB/DJpWFZZgGMs
         QS+yi71Qo20JVNVVT1At6t8iELMrrY0EEAdNOANZzONuwwVwTGm10VuWXZaKJDm56kb9
         QxkCqdt3NIO7NBERMrJQNBdtM0po/agsq+FSYuzvbzpY672TA5x/WdfJfHaRftrOte/+
         rn7/o3iuGAPePeLi/mezN1ecrhBaxtSsfM4b6oMGuEdyP9bAGQSm/PTdEonB1cYRn816
         rCVVgo7bGNcIM5UsUGsI+z5h6AOQbwetCzGV/qSQxSIiehGRwQJKyLskxlerlC28vMjJ
         /Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022922; x=1781627722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsHDIWK/DEuMxgFHaPqAWYQl6k2nKERtlHiE+nLuWcM=;
        b=SYTvRGPQlBijsAy5iNw8dBKWO130czc/hXkPGtPCb42SBknWne8RcaPv8MBWfvo0bU
         8Hmon0U50JBM/zh0qR/ygbZzOblnbunbmONKYqWkT4NG7LD4LG4yjq0a58wGsfmX0FFT
         UDHAhyX90mcH/x8Yi5c+CKzFlSlZWoERn+IcuJBfpB1KDePBaEKok65ZPh7bFJw8Qe8K
         hQclIQTts6vS9YLLGSAO17+3Ssp239IXlsdK3AwqCiIOlX27b84JihyKzDPKUTxadwJ1
         GeuDzzkd8YTq5bNvzpJehqQAYU2gS6D2Io/48Wr51GBGk0wk24VCIGrhENG6SVWnzTfV
         M8Bg==
X-Gm-Message-State: AOJu0YxV+nTi9TSFMJypFbaAhQJkr1S34QKsTvNo5DpL1WKkeNg6fjrT
	T9shqZyIFB5rxDc7yzwPTJKrzYp/LoOwSPpbhrtuD4C7j//3ZKG7aUqwNTY3b61TthuXPqUDP39
	y2aOKpUIqv5XcOuyr6THm4fKgtxdsHaz7qMOL
X-Gm-Gg: Acq92OEofjxU2wSOY93Fz6ZjApfO8dzmfjSIcnNeTiRXnCjvLqI/v7AW/R2Zxa0Yxif
	Aq5VN/2eyzb/h5JoxFctiArTZ/wKfH6crkv4Ud0HwZgkcJYIUd87BAzEciaeL/+fm1xv2EpyERu
	jce5KuM4PxKlKLVRxX7erTR/9h8RQN814avtf8PkClJvE8GAlfTWlxPl0qha/RruLh+kdZ1Qi7S
	YgMUXQKMoV5hrRJUFnapRpBdlk36DayoXj43M6ZBbrYvfHENvI9KHXEtuFZLpBjpzKLS71wwyP0
	UP80Yi0bzMAr1Ul9olS6Pl+HMNDvnY2tR8N/C/eXqOsmn2GX316dwI0bDo4EE6IQ4VJHmdyA3P/
	EX8iz
X-Received: by 2002:a05:6820:4b84:b0:69b:94ac:da1e with SMTP id
 006d021491bc7-69e68c1af93mr11171587eaf.31.1781022921704; Tue, 09 Jun 2026
 09:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
 <CABBYNZLRz2iqR-eQNjXsJnyeZ8aONnjgaQDO6bRWVqfVy8SbbQ@mail.gmail.com> <11d03be6-8f9c-4b8c-8bd7-0b7d9c9d87b4@streamunlimited.com>
In-Reply-To: <11d03be6-8f9c-4b8c-8bd7-0b7d9c9d87b4@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Jun 2026 12:35:10 -0400
X-Gm-Features: AVVi8CcKn6PEUYWdTYrfnTcazfzbO0GiltffsyJeggBt5L0N-1LLS0zyBlhHlr0
Message-ID: <CABBYNZLomccRxaXOMDxbJ2ksks-2C30h9+oSn1ZRn1cKohThfA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog: Fix starting encryption on some BLE remotes
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Jun 9, 2026 at 12:25=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Hi Luiz.
> I don't think it forces encryption without bonding.
> The diff is:
>           if (!device_is_bonded(device,
> btd_device_get_bdaddr_type(device))) {
>      ........
> +        } else if (auto_sec) {
> +  bt_gatt_client_set_security(btd_device_get_gatt_client(device),
> +                                BT_ATT_SECURITY_MEDIUM);
>           }
>
> so it means device IS bonded and auto_sec is enabled

Hmm, but in that case doesn't the following code trigger first:

https://github.com/bluez/bluez/blob/master/src/device.c#L6469

So either there is a bug or the code you are adding is just a NOP
because the security has already been set to BT_ATT_SECURITY_MEDIUM.

>
> On 6/8/26 16:23, Luiz Augusto von Dentz wrote:
> > Hi Simon,
> >
> > On Mon, Jun 8, 2026 at 5:20=E2=80=AFAM Simon Mikuda
> > <simon.mikuda@streamunlimited.com> wrote:
> >> When BLE remote doesn't reply with Insufficient Authentication Error
> >> encryption is not started.
> >>
> >> Good remote:
> >> < ACL Data TX: Handle 64 flags 0x00 dlen 7
> >>        ATT: Read Request (0x0a) len 2
> >>          Handle: 0x0021 Type: HID Information (0x2a4a)
> >>> ACL Data RX: Handle 64 flags 0x02 dlen 9
> >>        ATT: Error Response (0x01) len 4
> >>          Read Request (0x0a)
> >>          Handle: 0x0000
> >>          Error: Insufficient Authentication (0x05)
> >> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> >>          Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
> >>          Random number: ...
> >>          Encrypted diversifier: ...
> >>          Long term key: ...
> >>
> >> Bad remote:
> >> < ACL Data TX: Handle 64 flags 0x00 dlen 7
> >>        ATT: Read Request (0x0a) len 2
> >>          Handle: 0x001e Type: HID Information (0x2a4a)
> >>> ACL Data RX: Handle 64 flags 0x02 dlen 9
> >>        ATT: Read Response (0x0b) len 4
> >> ---
> >>   profiles/input/hog.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> >> index f50a0f217..845087c9d 100644
> >> --- a/profiles/input/hog.c
> >> +++ b/profiles/input/hog.c
> >> @@ -189,6 +189,9 @@ static int hog_accept(struct btd_service *service)
> >>                  if (!bt_gatt_client_set_security(client,
> >>                                                  BT_ATT_SECURITY_MEDIU=
M))
> >>                          return -ECONNREFUSED;
> >> +       } else if (auto_sec) {
> >> +               bt_gatt_client_set_security(btd_device_get_gatt_client=
(device),
> >> +                               BT_ATT_SECURITY_MEDIUM);
> > So this forces encryption even without bonding; why?
> >
> >>          }
> >>
> >>          /* TODO: Replace GAttrib with bt_gatt_client */
> >> --
> >> 2.43.0
> >>
> >>
> >



--=20
Luiz Augusto von Dentz
