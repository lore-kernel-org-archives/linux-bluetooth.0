Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738306;
	b=5qWjc7E0zhTLNAVxBBLJb40WVCn97yulWTdxTC427zmTkL+SSzTNo8493X/4iKuhgUu0
	 vSX5kuMYCTvkxZkT7CLaHxqyvNzSzV6q2KZI1ZF5HFJA1lwnQL9Hgnjd7mOlQgKfvOOYE
	 JjytAnqXGXZRaLbNL39NBxT1E90z3EKQ+rXZPCihf5BUlR+ZgEB/sq53Z24VCWtZVJxuj
	 9av/QMtIiHmlQA3EbTNeQBoUOiB1yFqGyo2Fd66fn1qfiEwJ/IZ6iamwTb3V/ipzB0R/1
	 lglojJVibKX/nAs5Vk72dzxvCA4R7/wtuUTJTNnveVkVuczaepG7EaHhnndDWvtowgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jzNBWeIV3IrhMq54Ch7avjeTt7QWcPrRkxOaBRnUt1o=;
	b=RqdG1F/+7l4GgySbsBtUzm7VisnaGwoE+lX0TsEJrKRLCLTzNUXu8CtUsc7H1JTVXwfC
	 nVeAL7TtyPxnRpSOVKKSaRzrupyeomi/8rgtCwwoE8Wmw7kk1HPnmAWMz5w3Qc1rc+qM/
	 /ajSQ4l+xoV9MMCXBaArR6PDGij+o5qzTjaEuRnyZO4PZlZGuVC62i0zCHTfEqEW56QG+
	 CUbu6AxLKG/RApVqr/Mdq7bkequ4ATcagP138wCKRCMhc74jdQwT3DeFtVPaP8Lc7sGeW
	 g0pV4mRwLcnxZ1YnFOGaNUOJIIzu5gqIhu0KGxvlNKjxcck1MR/O5VbfesM+UY4YUvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCB1Ycb7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800F606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1800F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCB1Ycb7
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b308fca7c3so40437b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793738305; cv=none;
        d=google.com; s=arc-20260327;
        b=odaz42VV7KbaS+tFUtazRFNQ4yN7fgRT3eW6TDQfSDpOme2qZwAMZkSf0XtX5Ldy/j
         6+oEBkX60Crm7HoIos7PYEnESGNxE+dIUprbhNT5VTyGhy2Eg1rhbmHrYLwsN1ZvLCrB
         A/WIUBxOrgDEUkmPCcbB2tHgNzn27+K6lg+caCgNXwZwS03FefWTIVHsr0S/yagm+Hkk
         AMYdiUQ14zQ95AHVlHSfaJ0ymIeP9vlQIRnQph6lwKZT1DhJl6OcC64i7VkLmMrWZGsk
         9pTR+tOUXiincvaP70AmoecvI9J4QDV1d0NXov3HyYibpDD5L+JDMjqsBrLdErxwFGEf
         mNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jzNBWeIV3IrhMq54Ch7avjeTt7QWcPrRkxOaBRnUt1o=;
        fh=yMRINOhWSIvW8hRDgEW9Bw3sYRl+Gmh1YYZQy/HWyJI=;
        b=U8toZXkVdzk4RdrbpSBgJAVs2Q1yjQkTQ6DrPvJhQSO+6miXRpPLRhz9EB+9QhxE4S
         4Bifs87KKwy5+5oCkau0e7T2bmK81A/naKCYTAZvgX5aUgVqbyuoeTgdYz6g7JP9FIkP
         S9KDWWh45VJDpWTj8X1rvZMsxNpfpRHpFx+fp3prEIrYQfcotWUjOoOTtMPoPwgWakQq
         TBMsZMYnccjpEKMgHVBhueOwf8xvt4y5TLvcLUfZiO4xHgiFA3/u4V9D1gN8+Kgm1FFB
         Ce19nCyX6nsX+Hkdl/LW/iITCue8V835tbRUWgDPgU2YXDRntVKkgJ7Zqe7o2UvZWxVD
         O1zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738305; x=1794343105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jzNBWeIV3IrhMq54Ch7avjeTt7QWcPrRkxOaBRnUt1o=;
        b=tCB1Ycb77ExWoUQLu6GWqoKkiDf3ueIY6PfUlu0C7J3chvHtBXkcPPfna4yILHqooM
         aJpP2wrG5a16ZgSKfownoTtp2hecuNXg48TwEGDrBfR2T2J9Qv6Bkzkjn0/Cqwsl+ubi
         mOXgzh50aw3f1nZTGKOOousizNF/QKsrua1lp2zvaWN++84zERqlpbPYUeGUAzpE+iVj
         EF3dLm6CK56C3C/VOHs/xwXF9AAbCxLyBIsA5FwbH8Z/0yLJ1QqJZ7gHU+FsglIG+pPm
         kebqTMTeaAQfYo9rBSfxKfrockpCkkXvon0rx/oVhs9sa2CLFAbrXjl9Xzr2ooaCGU94
         pEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738305; x=1794343105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzNBWeIV3IrhMq54Ch7avjeTt7QWcPrRkxOaBRnUt1o=;
        b=mEVqI4kr37i0dEGb/yLZQl+n9OvWghEm/f+/3NZi11aXxjbZP7KcZ/3IZixL6cwo+C
         b7QiK1ZFln98E+Jpcz1XIf7R11s20uP1r3VJe/LaZlHl9g3GHmxjr6YLsNYWfMaDOSpg
         V9qhElcVSFBIZZEPZPYH3QjatEqyfiZcDqRYZFPFKAl0v1/6axWPgCKEJeyRobGvaXvj
         ZxuXPpJVYeb/WhiCNRgr5GUhEMj7LOiijUdRZRC06kj4dsByTJz7lf3ZL0Iak7t0kSVA
         sKy+NSp+6fj2xjjTDBqbPu7skCmAImabLv6xzzTdqSIIAHAOTmajptXvM5DXw/tVF4K4
         RTgQ==
X-Gm-Message-State: APuU4Z/Bzv9uz72cF/qTk32MkBah/qBscF35vfNxTVpC08LvpZZjJBoy
	qI3Z9DJJSM9J+bGDOl+Iamfo1K5KssO290o7EJytAAmwjs8E1aIBVvd5UXzIEKrmrJa1iyNHyXf
	GHTjNsKNDkQJGxGu8urKacKrJ26WpieM=
X-Gm-Gg: AYBFou0XdXcnDpqS+Yaw2CqPYUzhRfW7296v+ZtdCRZABDIPB8FsblA84qbf5KmeTpz
	ytrsiZugn/ts1W/68XhZYJp0X+AqwP0WhpzdodD3twzDqE3mZT2oqrET0ku3bUGkOQAXT7NerX0
	4lREKyvF/HcqiTMi4DxAa6KDxZ/rknDrAu0Rw4044nUkaFLrq0hQfF9JWsjONP+EdXQeuMboIkj
	lpT82HERARqJomL5f5juOeVBIn/5dt5V2VbrWf7t9d3uFOxn3np75Km02CoAfoQuLrQg5jBl8Fg
	g2yg3e0BF54oxyUqtcE+BvK1Rq2qkK+Zt9SHrBtKscxVW+Qt2vzexPJojpHTrvLd4djwyKDQUdC
	UFNFv5Ouh7Hj86jmXiUmYMu7rZyhu6vwUe1xzMfHG4uYP8JVZqApYod6UDuNg8B+wzWzizduPgz
	pFuuz0MMpzf/13rGwNAr0Fl8LJM+y+joNSbpWUtmL7eO+Z8Ck2aJWR11al
X-Received: by 2002:a05:690c:698a:b0:8b2:2e52:1dfe with SMTP id
 00721157ae682-8b2b66d04bbmr93027247b3.22.1793738304969; Tue, 03 Nov 2026
 12:38:24 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Nov 2026 15:38:11 -0500
X-Gm-Features: AclHuK_UsU9MqVCfxtwVm6jyd2TlzjKPFxOz3eqoaF0j0W1NnA8PjemqA9qsi6E
Message-ID: <CABBYNZKjiVFVgNxxjTGYKBD0kZD=bQc6kbavcV=6cHGirBgMGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/15] Channel Sounding and RAP fixes
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Nov 2, 2026 at 3:21=E2=80=AFAM Cheng Jiang <cheng.jiang@oss.qualcom=
m.com> wrote:
>
> This series fixes problems found while running the RAP Requester (RREQ),
> RAS Server (RAS/SR) and GAP CS test cases against PTS. So far the
> Channel Sounding code had mostly been used between two BlueZ devices,
> with the local side creating the configuration as the Initiator. The
> test cases also cover the Reflector role, a configuration created by
> the peer, peers with different antenna counts and every Ranging Data
> mode, and most of the fixes are for those paths.
>
> The patches do not depend on how the CS session is created; they apply
> to the existing session set up from the RAP profile probe. Creating a
> session for a peer without the Ranging Service is a separate question,
> which I sent to the list earlier and is not part of this series.
>
> GATT database and RAS (patches 1-4 and 15)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  1. A device removed while disconnected kept its CCC state in the GATT
>     database, and it was restored when the device paired again. Drop it
>     from device_remove().
>
>  2. The Ranging Counters read from Ranging Data Ready and Ranging Data
>     Overwritten are scoped to the connection (RAS v1.0 3.4 and 3.5),
>     but were never cleared, so a new connection read the counter of the
>     previous one. Clear them in bt_rap_detach().
>
>  3. On-demand Ranging Data was always subscribed with notifications,
>     while the RAS Control Point, which only supports indications,
>     followed the requested transport; with notifications no On-demand
>     transfer could be requested. Follow RAS v1.0 Table 3.1: the
>     requested transport for On-demand Ranging Data, indications for the
>     Control Point, and indications for Ready and Overwritten whenever
>     the server supports them.
>
>  4. Reading RAS Features subscribed to Real-time Ranging Data at
>     connection time, when no procedure is running yet, so the 5 s timer
>     disabled it again. Subscribe when StartMeasurement() is called
>     instead, unless SetRangingDataMode() already did, and use On-demand
>     when the peer lacks Real-time Ranging Data (RAP v1.0 4.4.2).
>
> 15. RAP v1.0 4.4.1.1 counts the 5 s Real-time timeout from the start of
>     the CS procedure, but the timer started when the CCCD was written,
>     possibly seconds earlier. Start it from CS Procedure Enable
>     Complete.
>
> bluetoothctl and shared/hci (patches 5-6)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  5. Fix a use-after-free in the StopMeasurement() reply of
>     bluetoothctl, where the Active=3Dfalse property change had already
>     freed the session.
>
>  6. bt_hci_get_conn_handle() always listed the connections of hci0 and
>     took the first link matching the address, which could be a BR/EDR
>     ACL or an old link being torn down. Use the right controller index
>     and match the link type; this adds LE_LINK to lib/bluetooth/hci.h,
>     replacing the local copy in hcitool.
>
> CS role and setup in profiles/ranging (patches 7-14)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> These depend on each other and are best applied in order.
>
>  7. StartMeasurement() returned early for a Reflector, so it never ran
>     the setup phase and dropped every event the remote Initiator
>     drove. Run the setup phase for the Reflector too, subscribe to
>     Ranging Data as for an Initiator (the RAP roles are independent of
>     the CS roles), and do not send Procedure Enable on stop when no
>     procedure runs.
>
>  8. With Role_Enable permitting both roles, the GAP role decided which
>     one was used. Since the setup phase only runs from
>     StartMeasurement(), take the Initiator role, and tolerate the LL
>     Procedure Collision that two simultaneous configuration requests
>     can cause.
>
>  9. Config Complete overwrote the Role_Enable value with the negotiated
>     role, so a second StartMeasurement() sent an invalid Role_Enable.
>     Keep the two in separate fields, and do not send Procedure Enable
>     from a Reflector.
>
> 10. Config Complete was only parsed in the state reached during a local
>     setup, so a configuration created by the peer was dropped. Parse it
>     in any state, ignore events for other links, and ignore a removal
>     whose parameters are undefined.
>
> 11. The Set Default Settings response rewound a setup the peer had
>     already advanced, and an Initiator then created a second
>     configuration. Only advance from the initial state.
>
> 12. CS Security Enable needs an encrypted link (Core v6.2 Vol 4 Part E
>     7.8.133). When the configuration completed before encryption, the
>     command was never sent. Defer it to the Encryption Change event.
>
> 13. The antenna configuration was always ACI 7 (2:2) unless the
>     application set another, which a single-antenna Controller on
>     either end rejects. Choose one that fits both ends' capabilities
>     and the negotiated role (Core v6.2 Vol 6 Part A, Table 5.3).
>
> 14. A StopMeasurement() during the setup phase did not stop it, and the
>     Initiator went on to create a configuration and enable a procedure.
>     Remember the stop until the next StartMeasurement().
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Each patch builds with --enable-maintainer-mode and unit/test-rap
> passes. The PTS runs (PTS 8.14.0, Qualcomm controller) used a
> BlueZ 5.86 based tree carrying these fixes.

We really need to start testing with test-functional though, since
unit/test-rap only test bt_rap itself, it is very tricky to do a
proper verification if these changes don't break anything since we
don't have any functional testing coverage yet.

> Cheng Jiang (15):
>   gatt-database: Drop stale device state for removed bonds
>   shared/rap: Reset the readable Ranging Counters per connection
>   shared/rap: Subscribe on-demand data with the requested transport
>   shared/rap: Subscribe to Ranging Data when a measurement starts
>   client/cs: Fix use-after-free in stop_measurement_reply
>   shared/hci: Look up the connection handle on the right link
>   profiles/ranging: Let the Reflector run the CS setup phase
>   profiles/ranging: Let StartMeasurement() pick the Initiator for Both
>   profiles/ranging: Take the CS role from Config Complete
>   profiles/ranging: Act on a CS configuration created by the peer
>   profiles/ranging: Keep a peer-driven setup from being rewound
>   profiles/ranging: Defer CS Security Enable until the link is encrypted
>   profiles/ranging: Choose the CS antenna configuration from both ends
>   profiles/ranging: Do not start a procedure after StopMeasurement()
>   shared/rap: Start the Real-time timeout when the procedure starts
>
>  client/cs.c                        |  40 +--
>  doc/org.bluez.ChannelSounding1.rst |  21 +-
>  lib/bluetooth/hci.h                |   1 +
>  profiles/ranging/rap.c             |  16 +-
>  profiles/ranging/rap_hci.c         | 414 +++++++++++++++++++++++------
>  src/device.c                       |   3 +
>  src/gatt-database.c                |  25 ++
>  src/gatt-database.h                |   2 +
>  src/shared/hci.c                   |  12 +-
>  src/shared/hci.h                   |   2 +-
>  src/shared/rap.c                   |  82 +++++-
>  src/shared/rap.h                   |   6 +-
>  tools/hcitool.c                    |   3 -
>  13 files changed, 484 insertions(+), 143 deletions(-)
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
