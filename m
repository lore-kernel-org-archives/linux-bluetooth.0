Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6933509A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017942; cv=pass; b=Q79yf6yfse4LzkQYp4hADfH2TmF7d2gw5ztL0XFRYv5BUyxYuOw3rTHTYCHRpaTIXQ0hvBeKDQEoQjuuleQt3Ej6USo0L/PzOpWb/td3yLyZhWotqNTeiLwFAgpKlQ17aHddnY98wegDOTNNQ1pz4uC9bAa8UZhdm2Ji60ScsJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017942; c=relaxed/simple;
	bh=4Cr6vYygpcn2zRIV4DglVk5tkBf5kzUKsmOG4WxOPtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPH3hoOwZi0CQyxA3hip6FJFQ20sO8Vi+4+exxCZEReaWg/NB0hZ5hm0tpYuf3gKg1Mb6dhAO8qmXJ9zCsUzsOmzjqHDE+qW5YKkTB04S2uq/h6T+13HbmeoObhubb/xqJHiBsGvQuEtjAE/YcmcMnrqaeySbTX1AmI2KTu0jBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGOR7tgY; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGOR7tgY"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794265fb73bso814467b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 09:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769017939; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb+/gQ3al43vTuhIuhnj7nfvU2y7d2Ly7zYgTqhqDaoJY0kmeLNxtzE7FJhHfhohmB
         kBSO62ZlHrwmG3oC6rILVujr0lu2uiT+yVLPiGS17bQ1WsyycQM4D05JsMV7Y2NCeRDC
         Pyi07usIVinUYIHeiq2rT6hnAVHW0RJlfq4FekNEYufw6CiTqTvJowU0jTkChjJ5sHtY
         2Unf1ZCjcsg+rYJ1HEHiCbsK5FJY7Itjry7XmGvuY8xIfiI2bcPgdMHys5cHN179aDd8
         PzacVI2aRYfe+08Ovepvvbn3EZV9/1P0pt944pfAziPaxJwozW+JSq3m8ddelbCdteM2
         gskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JyNXz9oNsS7iG+YF6CjhlrPUZCjAKoDX0fhoXxjJquk=;
        fh=dXHXDsFJ33+is9YHzsPgwtgijmjp0ZCH8RvVLxZ/t8U=;
        b=CYuV3hf11xrJ7vAWKXoA07IfjxiAgLq2xbg8hcakPFLNLznsHN1MOsuD72Xu1OmplE
         FF5LWZ5AWRX4OElqSbtIcPWzR4Xj4jUgmWL+XwdcwJTZ1A69f6wX/B7MeVhEa8Yu1kWJ
         QANKdQ7nN+9PgJWb2jIqg5wrd6lQ6DSxL79tvwmQ3wJX1mzEvaiX8jkIn6iN3e2qIS+N
         tFEK0+gCrA59UbokM8tG+II9Hz6BIMblVqbwzyMFz06dsJskE3knWiohwI16ArUHMRHc
         qWQezzLScKmJrAxcU8gNE9ZY1/Msb5sgqYjHrsQ6UWkFxqCyKY+3r39pyP63+tsSrfiW
         bwfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769017939; x=1769622739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyNXz9oNsS7iG+YF6CjhlrPUZCjAKoDX0fhoXxjJquk=;
        b=RGOR7tgY8Px7zPhgfXBjCV//8kf2VgP5ce6XRFLtYWFcNmXNTWt54LgoZzMKBEoJPL
         KYgQaP41w8hvnQbR25byhr5U/Hzu4NpBZktxACCXsxmBIUK1yjqmADTKdsjCDgDCS1AZ
         T9G8vlCbdaKyzQRagRFd0lLLy5Y63xyw5jMCGSMZGq0+YRBTtpKoatO7MgQUSu3CX+In
         /lUoHIslg48YZL42Xn9GLjsNvHhTAQOI3B5FfR8io4HsjT0tk7MOGspPMQDmR6fOctfQ
         zZgvkJARk/5giKR1gkOydAIeeJMqqTolJvUPxK3NeDhVkIF2SgZJ/aogEY04YEU/qRwY
         x8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017939; x=1769622739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyNXz9oNsS7iG+YF6CjhlrPUZCjAKoDX0fhoXxjJquk=;
        b=GYLRBG3JBFIHjOeokzLNAV6yWNqQFOifzZV6GTbxAM4tmbOcFP14ISTZEmQrsPZs22
         VFtRpKlvDmYPwQ7NFAeIgVQz/59KEf2i0KFfSlX97F0KKPYzsTnNTO5PbS9aKoMIpizP
         PpZTN+7tbVmEAgAavgJBIBX2fvv+fX1gQJouJeG8bsiKF2x0RadfO5V+pp+/UfuCFPgL
         b2R22rmi5TPAoVe0rurpP4cjUlCHY9en+i71VK9yQxViG1e5LmJ2hvEE9rn45APw4AIS
         A1j9hbJCMlY0F+M/76jcPyV4bgGAlHHhueRXmV//Xn5mMRZZ6zEZY5OwTZ+RZmKZDNaO
         TFKg==
X-Gm-Message-State: AOJu0Ywi7caQkEkqKap2Ob6XQrAojeF1G8q65PCZdXvrMzmaz8G94NeD
	3lrM26/+lZwrJ7Gp3AnFNuW2aKeH6uywv45rnVCxG0oSfqwDk349bPTzUUG+OcgZRGd9yPLwXmq
	bRbK9dcXw4PS3cuqhtQfGe0ws9pgw6QlAPU55
X-Gm-Gg: AZuq6aLiqF27gzNE05FtDavQi0qL2EdPPplFeHwBW1dNHZ7QAI2Odalqb5xbg7jQsA+
	Zoe5iMUZT2a92pnufDRulr8rGbqVDr0gt/EX0nmTFSuTqt5RU0WbgG2/kFgtOgTXnciSgagrQMS
	EhncVuoufyHuoPkodv2LRpvCyiQ3XPfpSn8h1ZshatmO5FYOkQK6P8UqTwugqoNYXh1uKGNmuxS
	pHj9oOG6s71KEZPEYIY4N3n2bkl+CQTnteM8HZiLdXkXBzFrr+YsVQ+OFd9IqgvNp+XgpZLr6VK
	0dzNFN8XGMyRu3s++Whmg6K+lglLr9cg7qfKRYeAi/Mh07KEy8Kz/Gs=
X-Received: by 2002:a05:690c:9c0b:b0:793:b353:9dd7 with SMTP id
 00721157ae682-793c683524bmr165037707b3.53.1769017939269; Wed, 21 Jan 2026
 09:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
 <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
 <7a1da200-d909-4795-9f64-e7c86d53e0c0@amlogic.com> <CABBYNZJgA-i7OFTSgJ=EJLRLR-B7CGSZL0+VfBuVXMoDpxVNGA@mail.gmail.com>
 <9f107c06-123a-468c-886e-4135a08595e2@amlogic.com>
In-Reply-To: <9f107c06-123a-468c-886e-4135a08595e2@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Jan 2026 12:52:08 -0500
X-Gm-Features: AZwV_Qh3ztFO_y8EokRgTswtQi1swdGwO0TWMXXqxa5Tsp7npRKhcqhyuAsG39o
Message-ID: <CABBYNZLUSGS8Q6kK71vV6FNBL535RQjfO5UNYokR32Ft7p6VaA@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: Yang Li <yang.li@amlogic.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Jan 21, 2026 at 2:27=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote=
:
>
> Hi Luiz,
>
>
> > [ EXTERNAL EMAIL ]
> >
> > Hi Yang,
> >
> > On Thu, Jan 15, 2026 at 4:42=E2=80=AFAM Yang Li <yang.li@amlogic.com> w=
rote:
> >> Hi Luiz,
> >>
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi Yang,
> >>>
> >>> On Mon, Jan 12, 2026 at 1:42=E2=80=AFAM Yang Li via B4 Relay
> >>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >>>> From: Yang Li <yang.li@amlogic.com>
> >>>>
> >>>> The ISO sync timeout was previously set to 20 seconds,
> >>>> which is too long for PA sync. This could leave the userspace
> >>>> flow pending for an extended period of time.
> >>> I think we used 20 seconds based on the connection timeout, that said
> >>> I do wonder if 2 seconds is going to be enough given that the
> >>> advertisement window can be wider than that, specially when SID needs
> >>> to be resolved.
> >>
> >> Yes, the Core Specification defines a PA sync timeout when no PA repor=
ts
> >> are received for six consecutive PA intervals. In our testing across a
> >> wide range of devices, a PA sync timeout of around 3.6 seconds works w=
ell.
> >>
> >> This assumes a PA interval of 500 ms, which is already a relatively
> >> large value. Taking into account six intervals plus the time needed to
> >> receive extended advertising during scanning, this timeout should cove=
r
> >> most practical use cases.
> >>
> >> I understand this is ultimately an empirical choice, and I am happy to
> >> adjust it based on feedback. From your experience, do you have a
> >> recommended timeout value?
> > Actually the code define some recommended values for us to scan:
> >
> > TGAP(Sync_Scan_=C2=ADInterval)
> >
> > 320 ms
> >
> > Interval between the start of adjacent synchronization scan windows
> >
> > Recommended value
> >
> > TGAP(Sync_Scan_=C2=ADWindow)
> >
> > 91.25 ms
> >
> > Duration of Synchronization scan window
> >
> > Recommended value
> >
> > TGAP(Sync_Train_=C2=ADDuration)
> >
> > 30.72 s
> >
> > Duration of synchronizability mode
> >
> > Required value
> >
> > That said the duration seem to be only mention in the context of the
> > source, anyway perhaps we can use 6x320ms=3D1920ms(~2sec), this will
> > make us resolve the broadcasters a lot faster but then we need to
> > check in case we timeout we should try to rescan a few times.
>
>
> I understand.
>
> In our system, the application layer has a timer to monitor whether the
> PA sync process times out. If it does, it will re-execute the scanning
> and PA sync actions.

You mean in bap plugin? Or something other than bap plugin short PA
sync that enumerates broadcasters? Anyway, if your system is using
something else that is besides the point, the thing is that PA short
sync shall be able to recover if the PA Sync times out.

> >>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>>> ---
> >>>>    lib/bluetooth/bluetooth.h | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
> >>>> index f9f22c3f7..572009e75 100644
> >>>> --- a/lib/bluetooth/bluetooth.h
> >>>> +++ b/lib/bluetooth/bluetooth.h
> >>>> @@ -152,7 +152,7 @@ struct bt_voice {
> >>>>    #define BT_ISO_QOS_BIG_UNSET   0xff
> >>>>    #define BT_ISO_QOS_BIS_UNSET   0xff
> >>>>
> >>>> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
> >>>> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
> >>>>
> >>>>    /* For an ISO Broadcaster, this value is used to compute
> >>>>     * the desired Periodic Advertising Interval as a function
> >>>>
> >>>> ---
> >>>> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
> >>>> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Yang Li <yang.li@amlogic.com>
> >>>>
> >>>>
> >>>>
> >>> --
> >>> Luiz Augusto von Dentz
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
