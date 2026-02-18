Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25C346E72
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440335; cv=pass; b=beZ9gMndt+DOe844MX2rStuLMW/gVNj6c6zdO9LY/+99Nri+pdH5oPSAQ2Ld4g8LnwbxUi1Stca1Bfk/T+paCntsreT+2CLCW67TgSugCXXmKnIoQYuCsYBBcc4y8ptKNLY3HUPA1JJmlPuaP1UY5Ds2hQi4IteVRk64AVzcQWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440335; c=relaxed/simple;
	bh=TkWoV4eQ0tnjaInpZeYB3ffKShmKjVyNcCJ+GJGgrV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2qxCD4/m/GQjw1fb3fIqQoncDPOwmyZbGq0VoyRcUPHQ2dQckaJgS4Pm9T7hHDEsZXSSZ5bbGy/8c9SoHWill6isu9IOnulu6m/vLxM6ywmFBdPtmgXKVwSx4dJ0kTYmljShjDOl0wA0GHmAt3yNk+9NYR/CHzjSepp77X5x8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6oCsgzt; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6oCsgzt"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so66832d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771440333; cv=none;
        d=google.com; s=arc-20240605;
        b=cNshdci26zZQnd6zPmqgRcgU4P52PezUp4oKl3jun9Q9Vbt8CRwSTvz3aCTktUd2rC
         8Vzt/FmiFkqkalZfAxKJ3qH99ehFyx51d4AC0K7VDGbQ9yGEvQa5MyMZKgvv/TGjHcLA
         fxbZbGWAig18Lw2OfX1yt67W1slk+/u1uXdHGxQlWQJlMNok93WtZHysu3Xht7FmA8xg
         91HLjor0iJU05M7Pjh4RehfDvP3wtJeL8BSf3RAq09wb3BhVnxgPpvmTtkPvgjMW8+e9
         7KqYAMdGOmieZJQtU59Jc29GMkrlGdigIriPm69zKGNcheIHqlwy+yEVRW2DVtCtsriI
         fKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TkWoV4eQ0tnjaInpZeYB3ffKShmKjVyNcCJ+GJGgrV8=;
        fh=rmteJgQOrgLpzpZaGd/VFvWTOpwsG1FBlQ5jhGNsQFM=;
        b=anD0XwwVDYNRzpZHBu00tr2Fh76T45fOwk83o2Ci9dgpqfWGU+D9OvQQVMTE6NdDX0
         39mQpK2HkNHt3AaQjHcQ/icUWXZckhdcJaZAXpuMZyPbkjFbTIGtc8RXmbqlLRLTkk4o
         ZttAd2yMEmC38WSLwH/z4g28E/qKilv//88blwfskg7EgLSjI1mOVxMy8NIx8XkKmPRp
         iPFP2IffCndJQDWDNxcNbt8k0Cl6TZ6ujgq61zCLGxo6ZJSdA38MdqbjetBjb2bf9zGQ
         RKz5GJq4oVUxv5fXbYReA0atf3+KxnE+UOdvgpcIBAWRcqicWP8ZvrAXkKQoehdGN6hH
         I0qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771440333; x=1772045133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkWoV4eQ0tnjaInpZeYB3ffKShmKjVyNcCJ+GJGgrV8=;
        b=G6oCsgztu+FjTlFJ1+18erinb5+7LQV2nIw/YzI5DKCgY0UX6bABaiB7AHfrWE43nq
         vEQ/ezKMPBhOwyF7l9l1HiTe0fkijxnXP5OJ0BN7UN9i1Z9hM2Yn2Dld6PFxEbRQW5GT
         nstnMsRRB+wBBZ+hFLgpDmgQnS89krw+o5lx728II7uMkPNPIGvaQrJfXyes0cHXPV/s
         SFpmTOJ/7BaxJ798Bru5LcTLWs4ubKKQYu+wdG7Lbk8+uTVL/DCUD/KoWwAVMKIjEhAs
         7qhgnktLjcjCal6oNBrCX5JXpLAViz2YiGV3WNY7rz1wFgwDt87oMmBisnG4GonyG+gf
         +Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440333; x=1772045133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkWoV4eQ0tnjaInpZeYB3ffKShmKjVyNcCJ+GJGgrV8=;
        b=uBVHSIm5IhEKTw9V1z9cOXeLB4Dp1xhEa+SGyouXrkXpavtNUvnxVy3Iap96emYcHf
         mOJCe4QTHvlSREm9a+OXJsk4Cc9kKA2452CvlW0iXLCDLQX8Q7V/0QC7PZvn8BN57ECl
         S5OnyAB4BzTrO5UifdFOQ25ncwgorP9gPutlEYbbunwvXpgYBoLmqRiKOmdEeAzmrQ6K
         WW58XOac/st7opEBebYubAzUS6d4i2XNPJIH9y1gSqa2wH5Lvu51VZtr1WHAgtuDEmHL
         B6pd46+dkMBVu1G0Okwla2bRW7ZeM6lYGFhcfBFC3xORBMUd8uiFsgt/dHQzxMrH+p7A
         8LeA==
X-Gm-Message-State: AOJu0YwLv0jJKJrtZ8tGKUHWXvs/9wvV0En0vfuHlS+xXIqfSlfys+EL
	s6lMOVWfAu4vdmYrpYwqS1pr+rRtUpJfzWPKrkjv9z2d9A1z9Sv8uzJhK/k/BOdj31PGOaiF31N
	7O7kP0hB/ev+IZ+Z90GAt/fI0uBpCp7mxvBUj
X-Gm-Gg: AZuq6aLCWi2BCX3RLS5YOVasv2LEVOAcH8lPvVvkWDEi5IHgM4RFCFv7a9HuoDi176N
	y7Y+EY07QU/QlDkl99P9l/6dQ20NkCLYJRhxCJWlM+gXYW2pnQ5wAIbvqNYH8O/PyaFnYELDyj4
	ttF75vCPhQHLu7wTibpln8UIxRezwQnnF9O6cGb8/Fc7miprpNaxejD1wMPK2bBLWfmmb42vbKs
	KPVI/7HZ4q+yPsCc5NGpnQHaRxdysHQMfyMnseTmjRVyhGxdTj++cMpczTQlQRwfbTvCkwfh0zx
	InLeWvbvN1EYRNjTmbFChkcONKWPTl2X8xjlJptH4eyocTp64pwD0t1JWkRtp+lDmERm3A==
X-Received: by 2002:a53:ac9b:0:b0:649:f272:4e88 with SMTP id
 956f58d0204a3-64c556c9d33mr1997601d50.67.1771440332989; Wed, 18 Feb 2026
 10:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218024605.70890-1-ronan@rjp.ie> <20260218024605.70890-3-ronan@rjp.ie>
 <CABBYNZJqjaDJmkEy0yvyqLXP6kFH-dVjnzcCVknAkpu39zspaA@mail.gmail.com> <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
In-Reply-To: <defdb4fb77123ebe7abea7e8f225720e4e72e6c5@rjp.ie>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Feb 2026 13:45:20 -0500
X-Gm-Features: AZwV_QiGQOdj0w16AIvhVuZ1FqUVKBz5T8F7RqmT_OPTQ7_jpSohcBaIjzfaxV4
Message-ID: <CABBYNZLgugMFofwxAV4qFFP=RCnXG22MbcTgdt88ydbkSEKO9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared/shell: gracefully recover from failed
 input initialization
To: Ronan Pigott <ronan@rjp.ie>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ronan,

On Wed, Feb 18, 2026 at 12:45=E2=80=AFPM Ronan Pigott <ronan@rjp.ie> wrote:
>
> February 18, 2026 at 7:58 AM, "Luiz Augusto von Dentz" <luiz.dentz@gmail.=
com> wrote:
>
> > Yeah, the revert part doesn't really fly since
> > e73bf582dae60356641a32fc27ae03d359ec4c47 does fixes a valid issue,
> > that said we do have another proposal under discussion:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20260217222954.432=
676-1-larsch@belunktum.dk/
>
> Hi Luiz,
>
> I'm aware it fixes a valid issue. My hope with the patch is to fix that s=
ame issue in another way.
>
> The problem adressed IIUC is that once the input is initialized, a subseq=
uent epoll_wait would hang
> since the epoll_ctl call had failed to actually add the new event source.=
 The reverted patch had
> fixed this by trying to avoid initializing stdin in all cases, which inad=
vertently broke
> bluetoothctl. My suggestion is to revert that change, and instead check t=
he return value of
> io_set_read_handler so that we can avoid digging ourselves into a deeper =
hole. Even if bt_shell_printf
> is refactored so that it doesn't require the input fd, which sounds prude=
nt, I think it probably makes
> sense to check the return values here, so I believe the reverted patch wo=
uld no longer be necessary.
>
> I have seen Lars's patch, and that is actually what prompted me to submit=
 this one. Unfortunately,
> it isn't correct since it causes non-interactive bluetoothctl invocations=
 to also print several
> extraneous lines relating to the interactive shell.

Feel free to git a review to Lars's patch; hopefully, that will help
us get this resolved quicker. We might as well create a unit test for
shell to try to emulate different modes and environments. That way, we
prevent introducing regressions like this in the future.

> I will submit the zsh changes separately as suggested.
>
> Cheers,
>
> Ronan



--=20
Luiz Augusto von Dentz
