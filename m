Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684502248A5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807177; cv=pass; b=dy1/z7dFeXSzCWlfZmSKCX4Ci2zl/D1sJ0GDEgQIRGCCtgFgyK0Xn4XgxjV6PtUaufiOOEUBtt/agyV++0h30mtVGqcYvxheuvsjVYvArnxkd5deQdkUs2pqusR9FmQhhiwQZ4Rw8RJDlDtJJkX7837hIBvWm0REjq79uBpzO3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807177; c=relaxed/simple;
	bh=FbuTuZPPpsDIHjYeICxFmz4NrjrpvXrnGYP7fxf+5rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsxwXp+F0c5UoJbms0vPiFkUQ3hS1JX+qrwPbDx0CTRvOWtp/DZh/wBfWjnD1L8wC73MWK2LaKzz7NBfhsLL5M5Iofbd0TuJc/oCQjAW1AxMsPbPo5fuACe7U1sdXmmRFCwd5UvpImygXqjQb935g6HU+5p2zYjimq+UAiryDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDIHavnJ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDIHavnJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad79df972so8755090d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 06:26:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772807174; cv=none;
        d=google.com; s=arc-20240605;
        b=K13zzQvyEeJBGnP4uikCcAzenJKYEF+FFgjXUJna1Wt7glqn+MfhDXiV9RO0X/cAXj
         4C2EXC9r7mI/vOnNMFt8gdFd3nnxXBnWVgkEcBDV0R7DPu4HwFzAQqRLCJ4Xd2q6FJ4t
         kogHsegcqUfYtKntMnS/NZ05MvGHDR2whFFmnc6A6LTlStri3U3CHy6GZjKXiWDBCtBz
         2ewTNdkj4+wABag+2yL6sOYoLcBURps/XTTtkKdQN310l7l9q0oCXulSwhuMw6BZOXui
         YquASBcr5HiXSNVdaqBJDTCxmmi/k+tIDbM1N853rsaULyKwwCKxcoQhtRj698KQUh1G
         2ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOTRhbe5JtJ1UvX7ZBiR3vr0JIb5AmLXv9lzENdEv1I=;
        fh=KXcOb5vphlZLN1D9IwLcOrc/UM2jVmDyJWWf/pmWc4g=;
        b=TN/vwqSlREa2ueq0fQ+OQWtbRLJVG8hbqtay+8oWPHTNW4smsqLgmWh0fQl4XIu44b
         6//H8FKUqOC98KRyFXsUBXlcJbFcEswqZpKi44HlGtHXhgq3kVFcJ7xfBNcIXuR+g7o1
         zEmIpn6tE/xGHtD2oxU3hf9WqGOSB+/e1iiIzQApBS73OEZZizlsoZsRZua411vPNhUP
         z6QiDjyQA5hYbZfco+P/0Y6TqhUptq+c63IfFQVhZFfp0HGdxl+fxcibhiLuk61a2DSv
         Rgq6ORhCRA061QyL4g1AcrXkZMGe0uX2349J0z4guzc9y+cTf2b6QYfCQHBJqc9dPDsD
         rXmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807174; x=1773411974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOTRhbe5JtJ1UvX7ZBiR3vr0JIb5AmLXv9lzENdEv1I=;
        b=jDIHavnJ5JmWLCtP/OIB3VlYcUqcotQIlX+CuXc1eVSGvOPciLXLJvlZfrl0QYChB/
         mfC4EzJHmJAd4rhJFz0G1N5BETImb7rdxziFZ02K7kYAmlJbZD1fscDrovrtHqxx3Yo7
         P+g2tgt00lmf8ebeZWTl2SHBQWHwXV8B8tX+vCd7SUPfOUGqhILPZSsvjYa2vUoE9hRS
         Nnynz5AGV47JOO7sxKICPoaqjDayQY7wFcDtgwbY9oyqmSUe5QI3zkg0NSdHFiNAdksn
         k/CcTzNuJE5ms4yuuiqIhZkx4rrNipQB/ZawgXWedMs2S+gFgfwAb91RsH0kVcXeQCNC
         DhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807174; x=1773411974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOTRhbe5JtJ1UvX7ZBiR3vr0JIb5AmLXv9lzENdEv1I=;
        b=scZKUUm8+7YrbX8/wgdatzm7VkHWERkwy5Iyqz0HFgXw85ghbvZeI93g9NgkBdV3aF
         Rt2aEjfVy+pYpP008gGcjvo4qPCoF4UIk+YfIxKLeMyuXCC9m6Cizuqc9rKgr0iawy9G
         MAGfkBGzwT0d1cUpZE5ekvbmL9mPQCVzbJWEMnsJ/i6EMSgCld6hKWMY++ITJXuXNVmd
         OBJdGOfD19iyVFInRdXPfjErNHAg2hhc1hFsMeCuVnjN93EvfdMr2L1+c0Yp99XIXjfI
         NC1pycfaRvUbjg+kdfGtcIIdQMd8LplCumnNjtyJpv+dkS+p/dkfpK1B09v3LxjmiFyJ
         Rjgg==
X-Gm-Message-State: AOJu0Yyzg6Q1NiJFcj+gcD8z5P5fpEEzr/NVSsnt34h3AhZk/lKK3z/s
	wCRyK7Kg9TyamrBcSz7tERVZ3a8O9opvBp+937T8E5XQ9f6HYEXRoD/75rH7VpJdr+sndRYoPWt
	KU0obSPAmK7E1bRe0z+OD7Kh7O67tGis=
X-Gm-Gg: ATEYQzy1kW7LwEqVpaPXV1HQ9ey23fU+UxKatSE0uNvmJGwta1sA8X87ybeTm5n4r8D
	qPZsBiQZCDgSALpqeh7AHF8qk5qyKdpR0rgZhLwGREgzz96TBAJn4yEE1oA8LBzvfSv0A8xAx/j
	L/afpMWmBtX3RFWqCqfLjT17BloVPVBqIC0DUNE0avzvazSP13LsnBA9HcuZ7GqC2fuYzs9+Xbq
	hxsRzwSr7EYmOsrbAe4zpOExUWEyqIHJxDtw/DO8d6gM9O7TMYavCzAx/A5W81ciRNSLzOhkUSX
	yiwV4Z6PLnO+Sg/NyMz8qAgrILHTsNqdZ+5Fkz0Wzc09XHGsbnbodwFsxYoZH0rC0rs60Vdrr9H
	W38Tw
X-Received: by 2002:a53:b191:0:b0:64c:985f:9d4e with SMTP id
 956f58d0204a3-64d14280f5emr1597232d50.41.1772807173982; Fri, 06 Mar 2026
 06:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com> <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
In-Reply-To: <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2026 09:26:02 -0500
X-Gm-Features: AaiRm52XcJidngAp2RgA_0OeWU-nj_u_1Cy4w3VWHF3aipbvTYh9EmOWXbcEr7w
Message-ID: <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Fri, Mar 6, 2026 at 2:15=E2=80=AFAM Dajid Morel <dajidp.morel@gmail.com>=
 wrote:
>
> On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > What kernel version are you seeing this behavior? We no longer use
> > HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6673
> >
> > It was changed some 4 years back, so it quite an old change even for
> > stable kernel:
> > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d56535619=
9d60e1cb94e5a77a
>
> Hi Luiz,
>
> To answer your question, our industrial environment runs on Ubuntu Core 2=
2,
> which uses the LTS kernel 5.15.0-1096-raspi (aarch64).
>
> Thank you for the detailed logs and for pointing out commit
> a56a1138cbd85e4d565356199d60e1cb94e5a77a.
>
> I understand that HCI_OP_LE_CREATE_CONN itself has been decoupled from
> HCI_CMD_TIMEOUT. However, I have conducted a deep code analysis on the
> current bluetooth-next tree combined with an isolated empirical test on
> our hardware, which strongly suggests that HCI_CMD_TIMEOUT is still the
> root cause of the abort in our industrial use case.
>
> Here are the facts and the methodology used to verify it.
>
> 1. Code analysis on bluetooth-next: HCI_CMD_TIMEOUT is still widely used
>
> While the specific create connection command may use a different timeout,
> the entire connection setup sequence relies on multiple synchronous HCI
> commands. A simple grep on the current bluetooth-next tree shows extensiv=
e
> usage of this 2-second limit:
>
> $ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | wc -l
> 150
>
> $ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | cut -d: -f1 | uniq -c | sor=
t -nr
>     124 net/bluetooth/hci_sync.c
>       7 net/bluetooth/msft.c
>       6 net/bluetooth/hci_core.c
>       3 net/bluetooth/hci_conn.c
>
> With 124 occurrences in hci_sync.c alone, many preparatory commands
> (e.g. HCI_OP_LE_ADD_TO_ACCEPT_LIST, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
> which are visible in the memcheck logs you provided) rely on
> __hci_cmd_sync_sk(), which falls back to the hardcoded
> HCI_CMD_TIMEOUT (2000 ms).
>
> 2. Empirical test methodology
>
> To verify that this global timeout is the limiting factor for our
> 5-second advertising interval sensors, we performed an isolated test
> in our environment.
>
> Environment:
> Ubuntu Core 22 / Kernel LTS 5.15.0-1096-raspi (aarch64)
>
> Sensor:
> TE Connectivity M5600 (5 s advertising interval, ~12.5 s handshake time)
>
> Action:
> All previous patches were reverted, including the withdrawn v4 patch on
> conn_timeout. We modified only the global definition in
> include/net/bluetooth/hci.h:
>
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@
> -#define HCI_CMD_TIMEOUT msecs_to_jiffies(2000)
> +#define HCI_CMD_TIMEOUT msecs_to_jiffies(15000)
>
> Build process:
> To avoid any userspace interference, we rebuilt the kernel natively as an
> immutable Snap and generated a custom Ubuntu Core OS image using
> snapcraft pack and ubuntu-image.
>
> 3. Test results
>
> We modified only the global definition in include/net/bluetooth/hci.h and
> observed the exact behavioral threshold.
>
> Phase 1 (2000 ms =E2=80=93 unmodified):
> The connection attempt is aborted almost immediately and silently at the
> HCI level. Userspace applications remain unaware and continue waiting,
> which explains the ~45 s stall observed in our previous Python test.
>
> Phase 2 (10000 ms):
> The kernel allows the connection sequence to progress further, but the
> sensor requires ~12.5 s to complete the handshake. The kernel timeout
> therefore triggers right before completion. For the first time our
> userspace daemon logged explicit "[BLE] Disconnected" events, showing
> that the kernel actively aborted the handshake at the 10 s mark.
>
> Phase 3 (15000 ms):
> Once the kernel timeout exceeded the sensor response time, the connection
> succeeded reliably. The full handshake consistently took ~12.5 seconds.
>
> Conclusion
>
> These observations suggest that even though HCI_OP_LE_CREATE_CONN itself
> no longer relies on HCI_CMD_TIMEOUT, the overall connection sequence is
> still constrained by synchronous preparatory commands in hci_sync.c that
> use this timeout.
>
> Because our sensors advertise only every 5 seconds, the state machine
> appears to hit this limit before the full sequence can complete.
>
> Since increasing HCI_CMD_TIMEOUT globally to ~15 seconds in the upstream
> kernel may be too aggressive for other environments, what would be the
> recommended approach from the BlueZ maintainers to support LE devices
> with advertising intervals greater than 2 seconds?
>
> Would it be acceptable to make this synchronization timeout configurable,
> for example through sysfs or the mgmt API?

Im talking to an AI model/agent? However, it does look like the above
was generated by an AI model that is only checking the timeout used in
the commands without knowing the command sequence performed when
attempting a connection. Specifically for commands that report status
the timeout is short because the controller only needs to confirm it
received and understood the command. In fact, most commands behave
this way since they really need to generate a command complete or
status as soon as possible; otherwise, the host wouldn't be able to
continue sending the next command. Therefore, the rambling about the
usage of HCI_CMD_TIMEOUT is nonsense.

Regarding the actual problem, try using something newer, 5.15 might
not actually contain the necessary changes to wait an arbitrary amount
of time for the connection to complete.

> Best regards,
>
> Dajid Morel
> Volvo Group
>
> Le mar. 3 mars 2026 =C3=A0 22:12, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> a =C3=A9crit :
> >
> > Hi Dajid,
> >
> > On Tue, Mar 3, 2026 at 3:31=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.=
com> wrote:
> > >
> > > On Tue, Mar 3, 2026 at 8:26 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > That is waiting 40 seconds as expected, so I'm not sure what is
> > > > causing it to time out in 2 seconds but that is definitely the
> > > > expected behavior.
> > >
> > > Hi Luiz,
> > >
> > > Thank you for providing those logs. Seeing the 40.5-second delta in
> > > your environment is very insightful and confirms that the standard
> > > stack should wait much longer than what I am observing.
> > >
> > > I have finally identified the root cause of the 2-second abort in my
> > > setup. My environment uses industrial TE Connectivity M5600 sensors,
> > > which are designed for ultra-low power consumption with a long
> > > advertising interval of 5 seconds.
> > >
> > > After auditing the kernel source, I found that HCI_CMD_TIMEOUT is
> > > hardcoded to 2.0 seconds (#define HCI_CMD_TIMEOUT
> > > msecs_to_jiffies(2000)).
> > >
> > > When the kernel issues HCI_OP_LE_CREATE_CONN, the local controller
> > > (Broadcom on RPi4 or Rockchip on Rock 4 C+) must wait for the next
> > > advertisement from the sensor to proceed with the connection. Since
> > > the M5600 only wakes up every 5s, the 2-second HCI_CMD_TIMEOUT
> > > systematically triggers before the controller can receive the
> > > advertisement and acknowledge the command completion. This leads to a=
n
> > > immediate abort, even if the sensor is physically next to a high-gain
> > > antenna (9.4dBi).
> > >
> > > This explains why my v4 patch (forcing conn_timeout to 20s) worked as
> > > a side-effect: it kept the connection structure alive just long enoug=
h
> > > to bypass the immediate impact of the HCI command timeout, but it was
> > > architecturally the wrong target.
> > >
> > > I officially withdraw this patch series.
> > >
> > > However, this 2-second hardcoded limit for HCI_CMD_TIMEOUT seems
> > > fundamentally incompatible with many industrial low-duty-cycle
> > > sensors. Many developers on various forums resort to kernel hacks to
> > > bypass this.
> > >
> > > Would you consider a patch that either:
> > > 1. Increases HCI_CMD_TIMEOUT globally to 5 or 10 seconds?
> > > 2. Or makes the LE connection command timeout specifically
> > > configurable via the Management API or main.conf?
> > >
> > > I would like to work on a cleaner solution that accommodates these
> > > low-power industrial sleep cycles without breaking existing tools.
> >
> > What kernel version are you seeing this behavior? We no longer use
> > HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
> >
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6673
> >
> > It was changed some 4 years back, so it quite an old change even for
> > stable kernel:
> >
> > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d56535619=
9d60e1cb94e5a77a



--=20
Luiz Augusto von Dentz
