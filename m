Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105114;
	b=MfDmB/AajAz6t8LCdWIQUu+5igcEqJeATdCgnF+z1h1ElXhEQL6u9uoaL6B+8ZWRgHGu
	 NwnZwcvkHtW4+/PzWQx2pghau8OgxUtD853o4hNU8Fo1OTSmAavt1X4YOEtEfE9zLWegO
	 U4EaGWIzGeWcnNcE1Lc08le12GXMHXVQDyeDeYqi29J2RIapqMSg1saWjWfyPDhZEBZCl
	 nwKI8R+sz97TDhkwOMqqJ+p49sCiNXEGCKmSNKoggEaAH+/H4MB4ikZcu07bja5cmxUxL
	 +bS59fiXyey90IRZmxVeutdhJKxOhUxp3tSwICry+P3lZ0CDTzKwRZBs7TmxoFieNuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0h0qSugiriXLCrjB8RiZ3h/iIyQo/vB18s/SqAimWKc=;
	b=RhdKYlEUWJLicd4iKanIfJ6SMgGFVJkIzrXxTDNyDra1tSp60ltjkrGs+vAdU+6Svklw
	 71gd0G4fzL3qOTg+RbkOcx95PE9sm7ETdF9Z15QoN8k7vy0PQC6ZpdHOS5TSlQIzVBN80
	 kgTKZJAtAj4pLjsiLpZAVsQJiDA42H0kgZSshZsF7L9TTdb3sfFNk7ZHAoD8IRQkP4+aJ
	 UYgCUO/f0qCMcZjG88n0DzYZ4DhLlN9Ii+iw04nvdFa8ELdP44G9Lx+on7d1tUCzO0P8T
	 ylSn1GyRM2nGzo6AV1vmtIRJXqfIXsIVDCQ4p9lJS4OJpqpGK3LLtqS0zTw3f+QXG6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1zpbkH2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E2606A324
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 16:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1zpbkH2
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67990a45e02so2453746d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105113; cv=none;
        d=google.com; s=arc-20260327;
        b=Gn5nx/BP5Qrm9pruuB6VYXj3TqpH4vrcpgWBJm51bpY9I4+Ru2zhSIdUqFwoCLqaaG
         xLyklMtrbph3PD+UBj+AAnLJpbwCm6ywOOhnWjw+z54+iob5rXyQqn8EJvRSA8EfQnyK
         +EjTKmzxjPe7dhDhf5tpTlWnHotKK+Vv4Oo0n3BwR0ugGNlRi1bsIIcNkua8JJn2xRSn
         7bmYrLI4eitSBViQPJUu0CbhmyQSwBYUW6D4YbrhWWKkBQVkeQFtzdhZg6HQOdOOhGwd
         XFdpk4NG4CnMvy4QMnEKJQ9dbc0ilf9XjgV2s91T5SONis/vQouJcS9Y6TiviTBl1m1K
         a7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0h0qSugiriXLCrjB8RiZ3h/iIyQo/vB18s/SqAimWKc=;
        fh=fJTvNhOwO3AM3tYUbNMUqA+BVc/up3gAa8zqoR5nDD4=;
        b=naahQbEXx0KUoTnjhAX9kt9Rtjk4jUFy6qCFDRji73d4le7vhLYIJaBgWl3HrAosas
         wsua3H+nKOz0N15RcI+j+3YILnhRJiZnhgYlwwndnhtOA/QgjwtLxnNkIEVIfXK8Wv9m
         77YXlHUJsm7i4X6iymRA8OIETXlFwisip7wYKqcwWPAgmYw9tcuksWuNFKW4hpkIvyZ/
         J6XcQAXYCKUoN25Wt/dt5QnyMTKSrORNhJZDMdejhPFAsinGqd65gWC3DhxaD93MNdac
         Oq0KD+A4M+auhec35LF/Lrz96zl3A2a64I1lswnTb6Et0Jf7bsK64QkgpUzdXo0m/vak
         rcpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795105113; x=1795709913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0h0qSugiriXLCrjB8RiZ3h/iIyQo/vB18s/SqAimWKc=;
        b=j1zpbkH21kknQa6KsrhUHu41uM1mX8InRRgcKPk/LnUnwpKzU3OzLXf6k8XKb1nFLy
         31kJ0I0utfipI291HCHEQXlh+1NlSPdiInKC/KOAvfS075x6Gaiu9qIUQ17Z+6JTriRm
         jQfy3cZSO3+CjckxjFYC/rBF5P4utwl7d/BAdiA9JculYeibwmUFyPsXQQ/KsdOyPhtX
         2Ja2X7lz0qYXuCY/0tYIiJKceY6zEXZ4IeQ/gAj3JKaMwPMP8IQFxq4YJ7ZEsqjdoVan
         tGa/xmywFLpDlG6aqwKjcdDOgadbKWzbV4qVVex2wLqU4PBeI2szEiLHAUgOM7ZKXxQn
         uIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105113; x=1795709913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0h0qSugiriXLCrjB8RiZ3h/iIyQo/vB18s/SqAimWKc=;
        b=s/Gv4kf5gzvC1obsj+UHlbWQtkYeUpWt5y0yKX0MPsXu5N1zXQ1reSIqSUnFJ0kq4Y
         7vTSXtCrmADhK1oUk44bToBK9cgTgVn3l6xKuu7sZ9JUMI7Xn7TD2oAlS7H8cBGUpg4B
         bmkJx3pQ/P2M3KmSNg1lLsiJ7HSVYgx8Gt9iDmv6JU3BjvEvymV/+i7iXdzaR4ykCM8D
         2a/bYAG6QUqvYw8htrkYtMHXoYA61sDYorQx3MMfywVAccETdn1dCjiwc2Hm/X+OwdLt
         bJ6r7/eQZEODQyjF9z1eMagshM4wJa/naZSQPZDC0Gg4SZKN/otcjJhxIMq/fwu+2TdL
         9DLQ==
X-Gm-Message-State: APuU4Z8h7GLjjPO/hiU10G6oKDP1Z6jm+GlHLX3xlcFqoAG7zErDhBHr
	4tQLouZyIEYSjNVhrKRIqhcvfOJWDBgzMSjoaKn6u8/UxZxlN+N6c3cpkV3ZIP61c4kesUdohXc
	uE5pEkpFMaZMb6cCwKbqI8iQYe7bQCwDYW95uZMGzgg==
X-Gm-Gg: AZFdTZcHznhxpAzaMR8nzb1JONeasnQX4gz/PJRWGijaGhkOGN8oeCThejx2lMQdET4
	/npT2V05DxVQXkNwbipncaEnybwW9nXXigYUKNvihYOmzOKdFKfJlZ3aWRsE8xZAKodRBHYogpZ
	opfczYRwLoY8u+SKWyHUOnHUXCoUIDs4ByYIlztTnWAmZ5ljOaXxbPORU/ljbs7lHSD3axXO73o
	+XcaXcZbByPZbLu2kdJ60wTCJseu3cYcPgI1D+nUQ8J9RM3izWPts0DqF1jwwomUnLT2H6LJ1Sh
	N86v/IAqrB6ETMS6qiYaNEyM3UmpHGz8irkn4h131yAc7cZrDD7pAXolJMu5JDylqJ5xFYQTwdC
	C8y70qztpCIxmWwrz9BzF1RQsrZIb+H1o8S7JwWYYo6YYDGTg8bneM36yu/tov0mKmm7ND9sjLE
	H57RRzSNRBnoQkhDpGXU8ztWl7otogfPfEZ764FX56TmyKUnMFhmNKxAsSGxE=
X-Received: by 2002:a05:690e:1209:b0:67c:1dca:80d with SMTP id
 956f58d0204a3-67dd3f9f48amr2886498d50.69.1795105112888; Thu, 19 Nov 2026
 08:18:32 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Nov 2026 11:18:21 -0500
X-Gm-Features: AclHuK-Q77xt3arYmDj_8ltgr_-yiw4XGV2bx_45SrhKRqHjW9BVHBgwlw9n6YA
Message-ID: <CABBYNZ+1W99QY=nQNA-sUd3-MnfLBqFLWaULFgVbTcFahYG+oQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/9] monitor: Decode Periodic Advertising with Responses
To: Roland Schober <rolandschober1968@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Thu, Nov 19, 2026 at 3:24=E2=80=AFAM Roland Schober
<rolandschober1968@gmail.com> wrote:
>
> This series teaches btmon the HCI commands and events of Periodic
> Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
> only listed by name in the opcode table and the events were printed as
> unknown.
>
> It is meant as the first step towards supporting the PAwR advertiser
> role in the kernel and in BlueZ, which is what an access point of the
> Electronic Shelf Label profile needs: being able to read the traces
> comes before changing anything else.
>
> Patches 1 to 6 fix existing decoders which the new ones use or which
> were found on the way:
>  - the Connection_Handle returned by the Periodic Advertising Sync
>    Transfer commands and by LE Remove ISO Data Path was read as one
>    octet,
>  - LE Periodic Advertising Report trusted Data_Length and
>    LE Extended Create Connection trusted the number of PHY parameter
>    blocks, so truncated packets made them decode octets outside the
>    packet,
>  - the LE Set Periodic Advertising commands printed the advertising
>    handle as a connection handle,
>  - LE Periodic Advertising Report printed an unavailable TX power as
>    127 dBm and named the AoD CTE type with 1 us slots AoA,
>  - LE PAST Received printed the handle twice and decoded the clock
>    accuracy as a BR/EDR one.
>
> Patch 7 splits the LE Periodic Advertising Report decoding into
> helpers without changing its output, so that patch 9 can share it.
>
> Patch 8 decodes the five commands and patch 9 the six events,
> including the [v2] variants of existing events.
>
> Testing: I have no controller with PAwR support at hand yet. The
> commands were sent with hcitool to a controller which rejects them, so
> that btmon decodes what the host sent, and the events and the
> successful command responses were decoded from hand-made btsnoop
> traces. Every command and event of these traces was also fed to the
> decoders cut to every length, in a buffer of exactly that size, with
> AddressSanitizer, which found no read beyond a packet. The output for
> well formed packets of the existing decoders was compared with the
> current tree.
>
> v3:
>  - Add patches 4, 5 and 6, and print the advertising handle, the TX
>    power and the CTE type the same way in the new decoders.
>  - Patch 2: also report octets beyond Data_Length.
>  - Patch 3: report extra PHY parameter blocks, and do not report the
>    remaining PHYs as unknown after a truncated block.
>  - Patch 8: reuse the [v1] decoder for LE Set Periodic Advertising
>    Parameters [v2], print 0x00 subevent timings as none, check
>    Response_Data_Length, and match LE Extended Create Connection [v2]
>    with the events which complete it.
>  - Patch 9: Data_Status 0xff keeps its reserved meaning in the [v1]
>    LE Periodic Advertising Report, LE Enhanced Connection Complete [v2]
>    is matched with the command which started the connection.
>  - Patches 8 and 9: report a subevent data command or a response
>    report with fewer entries than announced.
>
> v2:
>  - Add patches 2 and 3. The two problems Copilot found in v1 were in
>    the [v2] decoders, but they came from the [v1] decoders they reuse,
>    so they are fixed there.
>  - The patch which splits the LE Periodic Advertising Report decoding
>    keeps the new Data_Length check in the shared helper.
>
> Roland Schober (9):
>   monitor: Fix handle decoding of status_handle_rsp
>   monitor: Fix data length of LE PA Report decoding
>   monitor: Fix PHY decoding of LE Ext Create Connection
>   monitor: Fix advertising handle of LE PA commands
>   monitor: Fix TX power and CTE Type of LE PA Report
>   monitor: Fix LE PAST Received decoding
>   monitor: Split LE PA Report decoding into helpers
>   monitor: Add PAwR HCI commands decoding
>   monitor: Add PAwR HCI events decoding
>
>  monitor/analyze.c |   1 +
>  monitor/bt.h      | 174 ++++++++++++++
>  monitor/packet.c  | 585 +++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 708 insertions(+), 52 deletions(-)
>
> --
> 2.47.3
>

Copilot flagged 2 problems:

https://github.com/bluez/bluez/pull/2849#pullrequestreview-5977101363

--=20
Luiz Augusto von Dentz
