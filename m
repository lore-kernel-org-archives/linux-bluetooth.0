Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA931DDF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152285; cv=none; b=BFBSZy8c5rVkACJNi+lxkK5GYXt3xh6jLMVl18L1J8RW1L52Klxeu+Ay8FAyzrKUzyxCulJ6g4idKIpRfkZFJnFjc3uOHH1cRa18S7ZuFc7j00R6X+M7f9zNkncT/tPwed1AbVM3hezJpAQFYabncq5qYk/Lfl4ZTEgon1ZYHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152285; c=relaxed/simple;
	bh=utEUvRgslPQR0IX9lAgjnQSNl8NTzHlnafOfm5Op/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUXMnVBQRGZZ956qbvV8LIK5ZLFJPubf4Tq2cCyJcFBGIqxQrWcvDYW8dNIVbwj9JVFiDBmdZiJpn9jBbyxqUa4YsUKMMbNUQqjz1ObMi6VZgpBsvMsviDjUTJc3tybLYsIUnNBOmR43ExmWdtGQEIV4wX8QHrCUtGDMw3noFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX1cdhUG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX1cdhUG"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d228a132acso2053221fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 12:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709152282; x=1709757082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrAS243Uv/BtsnctMlI6RKJ4i1o9H5I4rcJEBTPdvJc=;
        b=JX1cdhUGjeC/qLJrrrLfFsPR/NiyOyQNCOydRq2VEeL91iMTkOdaXMBwaut3/VnzjF
         4/B+Fr/vpBeTY0RYJMwqoVwpSxJ8KGx8CBm8bGOpLDqDDsA9b7CbPPDHoxAxNOgEBB3n
         ljiWUXVcV9BpsFeVEMiXDf6eKcPzU17cgqa+uyu2KScjEPON4kfD88XPxcutfqQerH0f
         leliLbaltqPxpOJQj1VSvb+u7FbmDG12+Mgw06kAu+7A+sgPPxxSDijqNSCkWH9dIymz
         Ndxd69JJSIMDyKv+yt/OlmtF6RCReb2Eed6fmWsKP3UMhii1KDrqN3absjGYSj6GPMKZ
         3hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709152282; x=1709757082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrAS243Uv/BtsnctMlI6RKJ4i1o9H5I4rcJEBTPdvJc=;
        b=LC9s6sb4MXQQPwduJ4DPRHhlZk3Piv901QaD+C5hn5IXgkhlWGVtBkBLaXHWiH9SiD
         qfXPCzWswf6wqV7rkcn2Bu3yaDgdFKb3IhVAjCpJXJ1UzfNGQwXZrmsRWlrnjQx6pibH
         iXQPe6QyB+oLzBzHgtigssXXOVnKPpnbebu+50jx7FPQq7GVGDoTFnASCARFiy1JfQXb
         ndNI5/V36uFszt3N50wqP5v5STNFXRithWkf0uOy0O1RmbvrkEKIKi4ltwZLxnfz99If
         PDwtmrHI68i3JTh5diA8wxSBWPqXMJH666zSCDRMsAyHLwock28re1jHJHl1zKrXgVVW
         hSYA==
X-Gm-Message-State: AOJu0Yyf8GZRWd8hLpgAqMEloyALNs4/lq+UdYql8v5B0l/Ff7xPaxfr
	lhq+3kjH1+MdSvx1y1BcUjh91MqOK2qt4bmAckSiNMNoTIbOwgE2+tmB2MNpfvCdVza3odKHgKH
	/7jHsbyYNG9S8dIjj5IiMqgiX88FRQqsNFkw=
X-Google-Smtp-Source: AGHT+IFFXy5b67mQyz0KTth5iz7rWl5nkq7B16idYCHQzrf0PDmk6mNS2WnZY1VaIHkB7pDzIF4QHYWqcf0GEISqdlQ=
X-Received: by 2002:a2e:bc12:0:b0:2d2:607e:8121 with SMTP id
 b18-20020a2ebc12000000b002d2607e8121mr10516928ljf.43.1709152281420; Wed, 28
 Feb 2024 12:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709150574.git.pav@iki.fi>
In-Reply-To: <cover.1709150574.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Feb 2024 15:31:08 -0500
Message-ID: <CABBYNZ+J_SUi_T987ND3hyN228zvX0gD62QNqk5D=GDc+nypTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Bluetooth: add transmission latency tracking for
 ISO & L2CAP
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Feb 28, 2024 at 3:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add ISO/L2CAP socket ioctl() BTGETTXINFO which informs the user how long
> it took the kernel and controller to complete their sendmsg(), and how
> many sendmsg() are in socket and controller queues.
>
> This currently provides information of the latest packet only, in
> principle there could be a ringbuffer containing few latest packets, not
> clear if that would be useful.
>
> These patches allow fixing / working around controller(?) issue where
> two ISO streams in same group get desynchronized.  Having accurate
> knowledge of the packet queue lengths, user application can drop packets
> if it detects the ISO streams are not in sync.
>
> Pipewire side:
> https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test
>
> With this change, https://github.com/bluez/bluez/issues/515 is more or
> less fixed, and the sound server can figure out the total latency to
> audio rendering (tx latency + transport latency + presentation delay).
>
> For ISO, this can be changed to use LE Read ISO TX Sync, when the clock
> and sequence number synchronization issues there are figured out, and a
> quirk is added for controllers with nonfunctional implementation.
>
> For the L2CAP latency, I'll need to think a bit more what is the audio
> use case. Motivation was that AVDTP delay report values appear to be off
> by ~0..40 ms compared to observed audio latency and this amount can vary
> per connection and time, so not explained by unaccounted code
> algorithmic delays etc. Currently it's not clear if there is relation to
> TX side latency, so it may be down to receiver side implementation.
>
> This needs a bit more work to figure out, but the L2CAP patch is anyway
> here.  Due to the possible fragmentation in ISO sendmsg(), it seems we
> anyway need the tx_info_queue thing and can't easily do it by counting
> packets, and L2CAP required part is small addition on top of that.

That is not how it is normally done with sockets, normally this is
done with use of SO_TIMESTAMPING which is then reported using the
socket error queue:

https://www.kernel.org/doc/html/latest/networking/timestamping.html

Sorry to tell you just now, you might have lost a lot of time doing
all of the changes, next time just drop and RFC early on with the
general design so you don't spend too much time before getting any
feedback.

> TBD: iso-tester / l2cap-tester tests
>
> Pauli Virtanen (3):
>   Bluetooth: add transmission latency tracking for ISO and ACL
>   Bluetooth: ISO: add new ioctl() for reading tx latency
>   Bluetooth: L2CAP: add new ioctl() for reading tx latency
>
>  include/net/bluetooth/bluetooth.h |  39 +++++++++++
>  include/net/bluetooth/hci_core.h  |  30 ++++++++
>  net/bluetooth/hci_conn.c          | 110 +++++++++++++++++++++++++++++-
>  net/bluetooth/hci_core.c          |  14 ++++
>  net/bluetooth/hci_event.c         |  66 ++++++++++++++++++
>  net/bluetooth/iso.c               |  58 ++++++++++++++--
>  net/bluetooth/l2cap_core.c        |  12 ++++
>  net/bluetooth/l2cap_sock.c        |  50 +++++++++++++-
>  8 files changed, 372 insertions(+), 7 deletions(-)
>
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
