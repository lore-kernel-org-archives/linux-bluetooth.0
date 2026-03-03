Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842F372667
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564241; cv=pass; b=EFuK69nk2qFfVW3JKnBew09e6v3SFJbgjzBbeEcAGVMIdtVp4/Ejdd1UKmePKOLFLgrD2cFtguilTDQ/Gh1sRaH0dr2G9eGQNDVTx9fYoFvS/ljU+E84ZupTGHwQR5D011lN6Vw/vHastuxF67TiQ75nkq7PLAVHF+5Gv7mZQbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564241; c=relaxed/simple;
	bh=7aHFrHdwXscwm6Fi6YhxIBl+8UvAExGuTsPma262jlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJLCAA7tpdFCI3s9kga+VpnXkBEIsO1nTAu20lLvgHDT7NiYTsgAFfd04tw4qStjwd/rlQR+/EQBmz3P3JQ7PPDfaiY2R/gFpXCOLd5Z/RdefjJSoqTLgzhlQPCGIo7RSHAao/SrmOr5VU5OKChGlte6CEJqvYoALVu2zm97QcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc2YqTaI; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc2YqTaI"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64caaacb9bcso5733780d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 10:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564239; cv=none;
        d=google.com; s=arc-20240605;
        b=HNNG/CQ1yuWra4YQk6dsixHuU/PgLkq1bMA4InobUjlRJsNsZi5rXz599jE06ff76W
         /p1PdezhRFEDlsZnIYO8X+E9g8U870XKxlH6nufreSDcVMksysyGmhFYlik0aasbTMtn
         UTEPLBx6/PnrbJZ1Wk0jHvauRFK4seX45hyzLlij8DT6s9Wh5zODPRWc4fBvVfEEfFdB
         t3/P7xc5pDrNvODxIA52xUl7g1k0oS6D6nDYZDAfuQ1YpuRs6I6/e5pkuf73c4meBpw7
         MDEtWORpL4kplngsr1InBLbzGQTYtcBoH8YFaQ2xGXltaSpxqGHOu8iynDa6HVYCHoIE
         d3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd06tEIgDKZaDZbvOI/mHK86GUetcVQAuNHianvFexA=;
        fh=h0eQ6x2YQvNL1Vl3qWYaFuXONWZvTAzm4sX7XrpcDBk=;
        b=I7icoYRbBcpJZW0yeUK28waT5925Uj8FdpWpJLhj93h58b+B9E0qnuK5HSluLuBSre
         BDAsxGAkLqsBNnaeTEfjF3YyuR9KkFGk0papuDaNbVAKir1faLHG9bgqagHhCbdYxT6b
         3Nr4YKNFOW/TGYKiIYxD/YEqsWxO9g7IL4oU6oAO2aonKZnB/VAlOtOZv+zloqNurdTF
         SkGuRAul+yNeoEZUPUjA0BH1JKCRrxtk0QEQMJ2HE26K7Uej7kg5r8VE60O1SnMqsEEa
         HDw0ysRqhmGAv4RSSg+ZAwmFXFxFiFov4Y8yODe7x+PIH4WVv93CQhDRUEUOYrPJG6jM
         KKwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772564239; x=1773169039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd06tEIgDKZaDZbvOI/mHK86GUetcVQAuNHianvFexA=;
        b=mc2YqTaIJ4I1sTawB0TxcnVqoCxQD7So9PC/nnFuk5cdzFASmrsaDC5CwPM/wYdSuo
         JhJPMesHishHT+pj2+tmXxutEAF1UKJQRpdV2R+m43+TWGylLs9ZW4hu9SxhTof0Ldht
         veOxxRy6F45IqWxXS+7ug3OE05Y42aPsphA/R6yzJLfHqKfCfttCJgWr117615e6zH9n
         bcgMCRQ6yCFr2w2Gma2RfMm292D3ujKnfSyKKVhx/UGTaLBipe6pBmheKZAe0UwnGyH9
         xvYmtHfjXC1tPs/prCmGz8ZyFZcAQvxR9s86oOGCbStgyOBYO/VqavBw9IO9KYOWLiXz
         bfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564239; x=1773169039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dd06tEIgDKZaDZbvOI/mHK86GUetcVQAuNHianvFexA=;
        b=msdYBqXP5iwVvxRcCaXa6qavqpEdwRvkbr7E4XPp+BP5HYpfqVVESngILRNjRt00ja
         Jv6gLq4R7efeRjyjXvhV28hyNrvETM5aODLk9YjQKOTiLPdhoRmLSC7rrPO3BfdU/7jH
         01haJqJor+qTnXqoD3+zxeQgSm2Xn9iIQs75SEeCol7grHg/w5f27nTkjiHnOOelLhih
         7pFdXy/A5ASVzlqu4pebA3yDA5QP9eMqoPCtqZcqVN1pWQGZnn0silgQjP/BZd8mMOz7
         vTe7QW6jQOhrO8prqSCnwldLF9fIW9tNNEezMqV6S1v8sHS536yy9sZ7ZhPHLqU6vqpJ
         VXyg==
X-Gm-Message-State: AOJu0Yxhf3lduYuhGT2HRgetVXbxZP38jv2ozl33XIrFyYxQu3rWT/uz
	CXjW+6lyXRVwhZgcPZiciIJGCeL3tQVyN1fNy3V5S2zoiopNxz0Ws9sRKu57ewuTe04aAUPO3Yy
	lF4cpgwjTCoSVVv6hXHQJkNe1uz7LVHF7iner
X-Gm-Gg: ATEYQzwN94qLsoX64SmC1xYdmEUQt6AlU+QxaaUXKAcLVwFlinfMap8Y5ZbPudoekJl
	BnuCV2j7TzwYFx0HQhBtHkJxTX/dQcOwpwxmu5FTT2qt2ZlZUtnauRNO/kSLE2NR4yMthxhnTFA
	LyLDamx32tmAgQkSCn6xnwjg2Go6fzqN9vKitpMZmx+dYtV9ORchdtyI4rSxcOLpO+4h+eIvU5S
	wAxcfmAuJ6E3dH8f9JXRPYd/phfFBhN/+rFmTiiXsAiWJTEogGn8zVb6VsUCU8lqgtQ29RgcRX8
	x2DM8dq0pCBTTgcgAfsZfwBzXUlADSWrFt76Ar5Tgr2abVx49AOLtMPI/PQpEdYGaYFiIQ==
X-Received: by 2002:a05:690e:d53:b0:64a:f0cd:d50 with SMTP id
 956f58d0204a3-64cc235af60mr13910683d50.88.1772564238830; Tue, 03 Mar 2026
 10:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302092203.12775-1-pvbozhko@salutedevices.com>
In-Reply-To: <20260302092203.12775-1-pvbozhko@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Mar 2026 13:57:06 -0500
X-Gm-Features: AaiRm52jRBnOXtEDzpAjHXiG0SIdkNAhNPnWXQAmQ-pbgnaDvud2OB1qezD9UVs
Message-ID: <CABBYNZ+MZfgSbfcjH+CuKaK978FByLogXDvJh+m7frFPY-Gdvw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: fix EVENT_VOLUME_CHANGED not supported
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Mon, Mar 2, 2026 at 4:23=E2=80=AFAM Pavel Bozhko <pvbozhko@salutedevices=
.com> wrote:
>
> Some devices with AVRCP 1.3 may support remote volume
> control=E2=80=94for example, certain TV models such as:
> - LG webOS TV UM7450PLA
> - Xiaomi Mi TV 4A 43
> when they act as the audio source, provided that
> Category 2 (Monitor/Amplifier) functionality is supported.

Just because these device do this way doesn't mean they are compliant,
afaik SetAbsoluteVolume and  EVENT_VOLUME_CHANGED were introduced in
1.4 so there is no way for 1.3 to support them.

> ---
>  profiles/audio/avrcp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 724b46c59..d501315b6 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1765,10 +1765,11 @@ err:
>         return AVC_CTYPE_REJECTED;
>  }
>
> -/* SetAbsoluteVolume requires at least version 1.4 and a category-2 */
> +/* SetAbsoluteVolume requires at least version 1.4 and or category-2 */
>  static bool avrcp_volume_supported(struct avrcp_data *data)
>  {
> -       if (!data || data->version < 0x0104)
> +       if (!data || (data->version < 0x0104 &&
> +               !(data->features & AVRCP_FEATURE_CATEGORY_2)))
>                 return false;
>
>         if (btd_opts.avrcp.volume_category &&
> @@ -4293,13 +4294,13 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> -       if (target->version < 0x0104)
> -               return;
> -
>         if (avrcp_volume_supported(target))
>                 session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
> +       if (target->version < 0x0104)
> +               return;
> +
>         session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
>                                 (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED);
> --
> 2.50.1 (Apple Git-155)
>
>


--=20
Luiz Augusto von Dentz
