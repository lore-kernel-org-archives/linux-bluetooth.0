Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955C37B007
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110889; cv=pass; b=UaZz6ovGTNV/J1BvKnvDxbvGtnQa69c/bF6UYAg9B7H04wFmL/WG+6AnFUQdlxeWWN+mSspBXxZ7XBMAiztpIC7XiKPeAJR/o3Hh8OWNKoaD3qMZAiw/PrXwwkW2cQq2LTByRWB9kkVSZ3YPus87JTYbePXFVnPzqkXMh5zjCdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110889; c=relaxed/simple;
	bh=YVMIrUVS6zcmaa+3JMMy551/txh2lQw63V9+1RoWZ28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdHgJKw6qdZZP+YY1tYXYVAItrGsqImY6SqSfDJMc99BE5SDX7RHzpcC/B+vMNTU57UxPItpdz61yY9n9mUNf753Ov1OTZLy2EFu8BXmKjhtmCPK/wfaD+9PZIBX0SHu+9V4mHVLkFkVyQEX7cEREZQscvqsZ2VCjCN8KHxIUoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egeaQXz1; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egeaQXz1"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651c7ddf514so1546862d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 13:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110887; cv=none;
        d=google.com; s=arc-20240605;
        b=Q7VxBLN1MFXTKQ4P/2LnjyhiTuYyif79sm8/9eMMjm/GkuZG4r+ex/XarFNgWNEhJo
         EENdmWc4HzoNDc++WQcH71NjC8LkQaVjZBaRgxmTAWp7gno0LDbZ3jJF2xPFTtUeNt15
         Njzip2i3EgCtYOt20vt+bqSm2mJp4OXp/iolbCub2hsKCB1w1TiT/QHs/oPSUDiL4z2H
         /+zGgvWnArvDfuVM946HGeX0JIPGGv8sQjtDjhXlhID+cNrksMAcIKSsI/inBTR1s2Mm
         k93p2jGYPj4yMWE2198Xz5wH3D57+P/PPob5JiUQmKFw2pjrIQG9JKQM5PnSVfZR9yft
         q82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        fh=ebdEWHd3gzs6nBrWl5fR/6n5Xk0+P00UdqYwRvpJJeM=;
        b=ZS5fzfwtjMB4NO9adM3BfFejF+tQMLZqvbLinsl9V4qk5liHE3QVNxEHytGUnL1LTY
         GNHbINL8IAkxKgipgtuvDwvqmICnK4B9tVCqoL29QtR+qD/ppiIRQMdtYLoDZqfL2Wv7
         kSWQDIlJ7ze0NzdWUGPcBKkL2uZLB8JMCFBvFN+P+I29ozViMsDqrEgzzmpaddGO+n5o
         eAVcBF5M84MIj1LqajCRSC9awjuHaHAsDFt1o0Z1tRhDXx1B218WJA1/AQdu9hQQUmHK
         OHgHp5GzS+J+TtmpBh3r0QfQUMl+c2bXlM88l6kvyEyKYq56+DVMAp0+ObBJgonEG/4u
         9VJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110887; x=1776715687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        b=egeaQXz1sPI2rQH3TeLrsGVI6UEz444+82T7uUqKAkQBwoCt9loSBETe4SAvC2F8dt
         KMkbyOEz8vL6yfelltOxnCvFX/aTP2ku2XE5piUY9qLnCS/nZByTrieUHB0nQMAznozn
         hz+064mkJdew7xJpW6PKsUA/lMBU8k5sd7MS/9O/9rsHZWvgahi7n6k11V2mRtDzTuBA
         kEFCvDati90yL0ex657/qNAlJNPO2u0MEmJkT4/chEN+w4EycfoSq2m98YJXF5EwP6GB
         f/mPY8otywlBRNF8idPIuIZ/p+PizRzfEmtSFPYUeYjreI0Vu8rxlOG/e0Fb1exopEIL
         RFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110887; x=1776715687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        b=M6MduftCwmRvwRKYdIhWsp17g7YXs+r30LSWydslmXxcIksCFRBPG2iw+D8rCg0UFM
         5iPKJXzDrwDnnHLZfzJF9PGgDmH7grS62EUVSenF+9MuiJwyXIEcV31ocxPxOR7Gab54
         zKG7oEzax4uYTcow7lOqzNL08ntk5hsznXSltxaXjBjqebE4bHp4jc2gf3m4BbrucK0H
         nAYTgR/1Y2WS39vxXo2mM6J6N+2j8t2FzBtZ57bO/6bFurCqN++eBBytt6gevimpTIL0
         wgv2mOTQ67gnMD6TD9sQs2aZee/uk3lUjLT+aRaqzZpi/kAWWl0BsgfHuEfGaYB1qmPA
         JVtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OfkbjaR8Iz4oki8fK37vepu37nISJDZWgi0XyY2AEd5H4clYw2O1nYX/7Zyk3EGpPrOPIXzraNzjozOrCKFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJyzNcM5XXriPinnUblApVHFbHC6OUkws84JmbCPCV4iVLtPJ
	AhSg1LFVBk7vi/WIJLeaLkj+lY8L7yiU97mLxIwTFDdN3uq0l5zyO1NWvW61a6AXjkO1F/VsKAY
	BHY2ANnjvuZNEUTzE3U04Qz3acik+5UsTC4xoMg4=
X-Gm-Gg: AeBDievJsAqZaOG3HxLZczj0xwuFzPxDEv9kxxuXvLfKNEaRcwJ2wFq+vxT7ao+Gluu
	hci4kiUTAEFDAA7kXxe/x/iDt3F2Z9b0FW0/7O8BCsdS+boQi9QjAVla/PO6Rs6SSz4cHrbQtO8
	gss0P3m8at2X/IpUkWarVXAFDuYFoTBTyAu/hvQXR6QmqKvCdRTWTSyyqXiT1NWWJs1raM97R9h
	CjB4adozvAYq4a+b3DcfMkXGBUXWAszxCbEYC7swdFlNlyBAz1pnf2Npfiogs5smLmyP6F2rGbM
	RaHIQhnHm90FE7G+KcLcWKFa4G18t81aUg0okW0o1xqft9/yhEH6p8YZLN6v5mMMeyL+1A==
X-Received: by 2002:a05:690e:1919:b0:651:b2ed:5dc with SMTP id
 956f58d0204a3-651b2ed0f0bmr9095260d50.52.1776110886898; Mon, 13 Apr 2026
 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410172206.150975-1-luiz.dentz@gmail.com> <20260412091614.1786af4e@kernel.org>
In-Reply-To: <20260412091614.1786af4e@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 16:07:55 -0400
X-Gm-Features: AQROBzA-VwBQCcwLZ_TGntNXIr8QWO5A1gfM_ntaeN0OoblK55smm1NdczSB36s
Message-ID: <CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub

On Sun, Apr 12, 2026 at 12:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 10 Apr 2026 13:22:06 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
> >
> > core:
> >  - hci_core: Rate limit the logging of invalid ISO handle
> >  - hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
> >  - hci_event: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFE=
R
> >  - hci_event: fix potential UAF in SSP passkey handlers
> >  - HCI: Avoid a couple -Wflex-array-member-not-at-end warnings
> >  - L2CAP: CoC: Disconnect if received packet size exceeds MPS
> >  - L2CAP: Add missing chan lock in l2cap_ecred_reconf_rsp
> >  - L2CAP: Fix printing wrong information if SDU length exceeds MTU
> >  - SCO: check for codecs->num_codecs =3D=3D 1 before assigning to sco_p=
i(sk)->codec
> >
> > drivers:
> >  - btusb: MT7922: Add VID/PID 0489/e174
> >  - btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
> >  - btusb: Add MT7927 IDs ASUS ROG Crosshair X870E Hero, Lenovo Legion P=
ro 7
> >         16ARX9, Gigabyte Z790 AORUS MASTER X, MSI X870E Ace Max, TP-Lin=
k
> >         Archer TBE550E, ASUS X870E / ProArt X870E-Creator.
> >  - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e=
8d/1ede
> >  - btusb: MediaTek MT7922: Add VID 0489 & PID e11d
> >  - btintel: Add support for Scorpious Peak2 support
> >  - btintel: Add support for Scorpious Peak2F support
> >  - btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
> >  - btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
> >  - btmtk: Add reset mechanism if downloading firmware failed
> >  - btmtk: Add MT6639 (MT7927) Bluetooth support
> >  - btmtk: fix ISO interface setup for single alt setting
> >  - btmtk: add MT7902 SDIO support
> >  - Bluetooth: btmtk: add MT7902 MCU support
> >  - btbcm: Add entry for BCM4343A2 UART Bluetooth
> >  - qca: enable pwrseq support for wcn39xx devices
> >  - hci_qca: Fix BT not getting powered-off on rmmod
> >  - hci_qca: disable power control for WCN7850 when bt_en is not defined
> >  - hci_qca: Fix missing wakeup during SSR memdump handling
> >  - hci_ldisc: Clear HCI_UART_PROTO_INIT on error
> >  - mmc: sdio: add MediaTek MT7902 SDIO device ID
> >  - hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
>
> Two fixes tags are messed up here:
>
> Commit: 802446198014 ("Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] =
array")
>         Fixes tag: Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT=
7927) Bluetooth support")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Commit: 28c9cc700e30 ("Bluetooth: L2CAP: Fix printing wrong information i=
f SDU length exceeds MTU")
>         Fixes tag: Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect =
if received packet's SDU exceeds IMTU")
>         Has these problem(s):
>                 - Target SHA1 does not exist

Would you be able to pull the for-net-next-2026-04-13?

--=20
Luiz Augusto von Dentz
