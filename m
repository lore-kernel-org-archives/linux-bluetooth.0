Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AC227EB9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597182; cv=pass; b=HSA7YaftZFRxM0iM9sVT5vkQ81OdUf0pH21VZ+kqgWbkcmSUSCh+QsCWd8+9Rybo0VgLcId0W201C3YCQiECTG+o4sVS4PRJsTaAanFxLWtf5nuCfd/pLWCZFaZ67tfxO48vGNIjvDChTuee3lKAEi1Mcz4io7AGzBRXJi+PS8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597182; c=relaxed/simple;
	bh=szL+66fSBJYUDFDBv9jlxQVdoZCCjFM51xVtOywTpGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE7yBedtMXz2zIid0fK1nbHqqLK5el78jIAl4j8wziSIxx1XWKMNuHkrbdAOTZc8jGIX8UvgGQmahW3q3BDp0+Z7Uw8ts3K6pz/8jqulLX+EwFGiN0xpYYA00xUydTlVkqbuNvF3k/1ujdSKAsFzSBN8h+ITdRQKV9UF36zBmmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwNhuRTp; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwNhuRTp"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79827d28feaso970837b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 06:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771597179; cv=none;
        d=google.com; s=arc-20240605;
        b=CNLorl7GylXbdGkcXkEF94/JOqCCTEVECHwsMDZOQwNjWp4bYHt7ppe3tYPXW+Z/lF
         hIt2MKhTpusKj17RYPYD22fjzSh5YxGnQqwhHTSQe0AI3IPbjE0NNH4BL1MU0pj9T8Pg
         ZciiXYWqf3zVI9WoPE57kRheSaKeG0tHF5r4wfXBNvMrvx1Bym0fWvnaHq5VmN1vtYe7
         /1nWoYTTG/bO05iM7716ZoRmdJRU2UzL+9nVjBPYsb9uuBHhTUa2O7SHimTu48lIuEa2
         q4uK8VPPDsTDm1Cxq4YZ3uCxZj1rcADatSt7BqLH9Q7tWld6MhNgTrUbia8uHzrfD+vh
         O2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78HJ/fm75LRn98MvvN1eOGZ79q8OyEJcg7BHoHXm7OU=;
        fh=dXHXDsFJ33+is9YHzsPgwtgijmjp0ZCH8RvVLxZ/t8U=;
        b=Hl15Zyv4l2Ml8WkZWhObXW4UgEkekGBkdF/8MgImjQkmHRics65RBgw+M8twCDPbuH
         kaMywM9MUmqsNOPmTD8zwD7z6ehaNbOYVN6/5qk60UiHcYi774u6YDuR1tNBTxYZzQVi
         RbADGSzPLB6YRQThCVsRMqnaKdnNntv+ADc6ifiek9v1XZ4U5l8uYu3hnsNWsBXrS2qP
         +vHDbXD6IuxPv9x0ud6BFo5kcQ+nfNJoujJ+mL0ztLIAo5aHLirL8jiUpw87iS1MGfpa
         0GIBnaPR+gTu40NzRNRKkUmPEVK6taMJQRdCb5mcs7PUNxyRLnArxHeIL2B+cHKgXiN/
         PDyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771597179; x=1772201979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78HJ/fm75LRn98MvvN1eOGZ79q8OyEJcg7BHoHXm7OU=;
        b=LwNhuRTpGd8oFG//Te5VyPrxzc+OBH32BO35NQUSrlZug0WzzBSkZ9oBv6YuuHJsHT
         hpgPCBu7qyoiV582LhCzyBXuV6wYwyt/uDa1qAJ3O5pASqiBM0L5cuqFI9DRR57d1dhR
         b/gDNzWzRyC9+Go5VJ+Dh5MWI8xODDAZVhDHWTTMiZZgjywNcFDVvjLoCEOYCJqGUMml
         PelIno4RMnyBsbtKGw/CEGvLsecjv2hz1ceaLniNHlpHmaTlYIIalpKOqUgW9tkjFTRO
         BjIDEFrVykYe9HoPVfTKpFSQES1KCmXrYPrAJBzT4nyhWMLyJQbauUkvRwf0nGeGpKoE
         LYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771597179; x=1772201979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78HJ/fm75LRn98MvvN1eOGZ79q8OyEJcg7BHoHXm7OU=;
        b=AJ/wgp0eAZ7aDI/Z691oalD0kIpnGY3ga3l7lv4hkOpUl0PRLb8BoLnDA1DOZxVh5w
         gWzToPXCgkpTTW5Mh33wD/ZNCVT1QlBznX/C26CLKNjHFmhPn/hBmDXyX3y6h9vMjfZJ
         CI2DY7qqpBa51XYNmz6+Kri+Dh3lY/+44fyXulHQ3j9jJ1keW0SgayayzGDDJwmEaYqq
         qRLcmPNnQqrTrRjNRB5hL9WtYuGzJV15S1Jg/ct9sYbqmBbP8B+EgIx8aHmp9UyjTLYr
         DUY9Er/80XJZsoqCNV8/8meV5adZ3IF1PxMgfM8jB8dKAr3KuXhVxd5TFeXRA6L7xYwK
         6ZxQ==
X-Gm-Message-State: AOJu0Yygyz0wnBpQp1uNVNaIC22XG/y4skbOB5+dnQsqs0afvqYVlFc/
	OBEfgogXUR35ebdnGjtTy6gqOILuC2vrGgOc56yPbVfG96iKzoja0bfL9NZiIjaiinh/R4E/rd5
	EihXUXlsJ9ocieSofnqhcJ8pPaQQjMtkAwA==
X-Gm-Gg: AZuq6aJi4WOBKgSDD8out4mcAxkhu9WfYdCRsQEFieiEFLFMz6V7xhe+IP7w11EtKmH
	+ghEp2A1Lrx6e05pa3HWGqDBwv6ezG5tpmlBV6ZLD98PBFFs2+ER1tBjs/uQQv+eGQwBahJIzWp
	2MKOgT0cr+QnebP9Pl/VjoA6/3Tag69q7fyn1H+7tAWzYwZksysHrXypQEBW5d6WkmTH8Pj++r4
	+in2k46JKA21YGfOGfFrK0yN0r+0O9t7v9tLwrKQL/GqYzsswSGYm/9eTqdQxLHWeCd9uiXKTIM
	+TxQULiIAzXwyuOxpVNYHggNe+8SgYvNaQuYfguYxtb9OL1BeHN9mvxsDR36D59QXG9nUQ==
X-Received: by 2002:a05:690e:4106:b0:644:60d9:8648 with SMTP id
 956f58d0204a3-64c556df798mr6686059d50.87.1771597179527; Fri, 20 Feb 2026
 06:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
 <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
 <7a1da200-d909-4795-9f64-e7c86d53e0c0@amlogic.com> <CABBYNZJgA-i7OFTSgJ=EJLRLR-B7CGSZL0+VfBuVXMoDpxVNGA@mail.gmail.com>
 <9f107c06-123a-468c-886e-4135a08595e2@amlogic.com> <CABBYNZLUSGS8Q6kK71vV6FNBL535RQjfO5UNYokR32Ft7p6VaA@mail.gmail.com>
 <b987227c-73ef-49b2-94d5-4f0ad37c41d4@amlogic.com>
In-Reply-To: <b987227c-73ef-49b2-94d5-4f0ad37c41d4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Feb 2026 09:19:28 -0500
X-Gm-Features: AZwV_QjzqWjFtSIjKgkVGjtJ26X70dTSVl84FPDMGlUaGQBzqVRxjU7PUQ3GVFY
Message-ID: <CABBYNZJJF7uo5h=QX_+-6PLivKAqS2SwPQorq6y7U0tRo-VsXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: Yang Li <yang.li@amlogic.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Jan 21, 2026 at 10:28=E2=80=AFPM Yang Li <yang.li@amlogic.com> wrot=
e:
>
> Hi Luiz,
>
>
> > [ EXTERNAL EMAIL ]
> >
> > Hi Yang,
> >
> > On Wed, Jan 21, 2026 at 2:27=E2=80=AFAM Yang Li <yang.li@amlogic.com> w=
rote:
> >> Hi Luiz,
> >>
> >>
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi Yang,
> >>>
> >>> On Thu, Jan 15, 2026 at 4:42=E2=80=AFAM Yang Li <yang.li@amlogic.com>=
 wrote:
> >>>> Hi Luiz,
> >>>>
> >>>>> [ EXTERNAL EMAIL ]
> >>>>>
> >>>>> Hi Yang,
> >>>>>
> >>>>> On Mon, Jan 12, 2026 at 1:42=E2=80=AFAM Yang Li via B4 Relay
> >>>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >>>>>> From: Yang Li <yang.li@amlogic.com>
> >>>>>>
> >>>>>> The ISO sync timeout was previously set to 20 seconds,
> >>>>>> which is too long for PA sync. This could leave the userspace
> >>>>>> flow pending for an extended period of time.
> >>>>> I think we used 20 seconds based on the connection timeout, that sa=
id
> >>>>> I do wonder if 2 seconds is going to be enough given that the
> >>>>> advertisement window can be wider than that, specially when SID nee=
ds
> >>>>> to be resolved.
> >>>> Yes, the Core Specification defines a PA sync timeout when no PA rep=
orts
> >>>> are received for six consecutive PA intervals. In our testing across=
 a
> >>>> wide range of devices, a PA sync timeout of around 3.6 seconds works=
 well.
> >>>>
> >>>> This assumes a PA interval of 500 ms, which is already a relatively
> >>>> large value. Taking into account six intervals plus the time needed =
to
> >>>> receive extended advertising during scanning, this timeout should co=
ver
> >>>> most practical use cases.
> >>>>
> >>>> I understand this is ultimately an empirical choice, and I am happy =
to
> >>>> adjust it based on feedback. From your experience, do you have a
> >>>> recommended timeout value?
> >>> Actually the code define some recommended values for us to scan:
> >>>
> >>> TGAP(Sync_Scan_=C2=ADInterval)
> >>>
> >>> 320 ms
> >>>
> >>> Interval between the start of adjacent synchronization scan windows
> >>>
> >>> Recommended value
> >>>
> >>> TGAP(Sync_Scan_=C2=ADWindow)
> >>>
> >>> 91.25 ms
> >>>
> >>> Duration of Synchronization scan window
> >>>
> >>> Recommended value
> >>>
> >>> TGAP(Sync_Train_=C2=ADDuration)
> >>>
> >>> 30.72 s
> >>>
> >>> Duration of synchronizability mode
> >>>
> >>> Required value
> >>>
> >>> That said the duration seem to be only mention in the context of the
> >>> source, anyway perhaps we can use 6x320ms=3D1920ms(~2sec), this will
> >>> make us resolve the broadcasters a lot faster but then we need to
> >>> check in case we timeout we should try to rescan a few times.
> >>
> >> I understand.
> >>
> >> In our system, the application layer has a timer to monitor whether th=
e
> >> PA sync process times out. If it does, it will re-execute the scanning
> >> and PA sync actions.
> > You mean in bap plugin? Or something other than bap plugin short PA
> > sync that enumerates broadcasters? Anyway, if your system is using
> > something else that is besides the point, the thing is that PA short
> > sync shall be able to recover if the PA Sync times out.
>
>
> Yes, the short PA sync is implemented in the bap plugin.
>
> The application layer will initiate an LE Scan with a timeout of 3
> seconds. Once the PA sync is successful, it will create a transport and
> notify the application layer via the DBus signal. If the PA sync fails,
> it will rescan and trigger the PA sync again in the next LE Scan cycle.

Looks like we never reached a conclusion here, or you are still with
the opinion that 2 seconds timeout is the way to go?

> >>>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>>>>> ---
> >>>>>>     lib/bluetooth/bluetooth.h | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
> >>>>>> index f9f22c3f7..572009e75 100644
> >>>>>> --- a/lib/bluetooth/bluetooth.h
> >>>>>> +++ b/lib/bluetooth/bluetooth.h
> >>>>>> @@ -152,7 +152,7 @@ struct bt_voice {
> >>>>>>     #define BT_ISO_QOS_BIG_UNSET   0xff
> >>>>>>     #define BT_ISO_QOS_BIS_UNSET   0xff
> >>>>>>
> >>>>>> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
> >>>>>> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
> >>>>>>
> >>>>>>     /* For an ISO Broadcaster, this value is used to compute
> >>>>>>      * the desired Periodic Advertising Interval as a function
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
> >>>>>> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
> >>>>>>
> >>>>>> Best regards,
> >>>>>> --
> >>>>>> Yang Li <yang.li@amlogic.com>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>> --
> >>>>> Luiz Augusto von Dentz
> >>>
> >>> --
> >>> Luiz Augusto von Dentz
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
