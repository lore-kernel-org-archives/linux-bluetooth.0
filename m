Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D060EEBA
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781356; cv=pass; b=rz3ZdFOHMzvxec548nCNBqn7KgBli1eK9SfPhedVXo9aPk54xuj3hLGnVL58xLR767P69lHfaAezzPkFD3MlZN4FR2UKBvER8ZgJhwPGELwGLdCDwmuRn1c85vzP5skOUwLQEye8AkMgKM9IQAQWM8W1Mpnj5fwm4M4ZMHdhRRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781356; c=relaxed/simple;
	bh=HI33FsVVs/nHLQXrM3mNEATzfkXUsFWUY1VTnrzaVPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD6mxiCed4Q32EAc/zAUWcckLOInAZIVLoySmv/2huhT2KSq8E1hKjUyVxLS9bMc9usJLuxTDIPfJ4U1Lwjmm+rX1hcscsjK8uZ/FOs3WhFmMSDbFeJADOGZPFPIvSppxh5IXd3ka0sDrZIqXuXMOvdWko8Aj2AxetnaAnhjMFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLMOdP81; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLMOdP81"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6799774d0fcso5831671eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 23:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772781353; cv=none;
        d=google.com; s=arc-20240605;
        b=DNPHZg8Ueiz76pmdVn1azb8xsauTtRR9426K2EviH3SUQ8LA6vGg+T7LNw5yEs0Jt2
         mbo4XZnU3tGFybd16RZABl4X8+OPC9Tlcs5TP6dWkCtQXB73euLpuNcSjMptlI2CNOJ5
         nTLL0+fsc1SX9w+RJOEqI8gQxO5Rp6wqsD+CcDkrxMWaBUtiEyZn9a0eMT7QXbS2Ja0U
         gBk2sgYZo/iL3G8dtXYnG/L2DU3MRYFxsgaSGVNueRAh+Zc47R6Mx0Km+VB+J292A/PZ
         hzTf7EjKpDueVhj6d+odAF5onoPJved8IZLh3U96Hy2hxD/6XnsQMa5ogFkQ9oNRQvIV
         nRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kX2H+i9GCijKEuYuYqhXoDqDG/C51o52b8gENjRkRSI=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=Mbpur1goET5TqHQXAT6neAaS/YgqOp1ALJdQNcl2mJSl0T1CAy79C/ZB2djJvluQ19
         UYb4jorL3M4kG6zHnYVOCa18nirbh5mQy7OJ772NTwO+cI3t0hyKa5EXOAscRg0vnHgG
         fL6iyOXC3aT1IgXBwzBf5umpLY7BukDUhi7N8FBkxSMF387PPAfSpskcZtBXhD3uCdl6
         R5bANEBY08468gK59IPGLaD2DicC95itzK6BHVL059AGD9U8BuM+DpaWCTRtlN8JOsYR
         tO69Fa/1vSaWfFz1CaROWW/1V/qXZcBcFhei4UJQoe13df65xSw51B5jB/ilFOmalW9J
         4Miw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781353; x=1773386153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX2H+i9GCijKEuYuYqhXoDqDG/C51o52b8gENjRkRSI=;
        b=NLMOdP81Pf+/R4GNZH7GIQhru7KTez0JTyVwOvD2G7i+XV6CJ5U5Pb+iR5T/pmzZ+m
         kKtaZr7VoZF1Yk30zyGmz2ANI1mCD8DQOA/VJEss3ePYUvvc1Yrami6WAY6CmqbaSQQs
         DRo8jZJMT0eTLcwQT6WgBKL6srfqbV8uUZNRKyzL7/0JIUqoK6f2cu5bVE0s4f3uhHxX
         h9ZvlWcGbzZdzUrhbYsq76JsRFTs0vHXwbRPC5V/aYxkZYUEMcLnowCJHvAh3CXSCeVP
         OpY35bf39r1vCtpdkdLaLnQkPcLZ7q4y98ZFczpi+hfAKtcTpqmoj5rHxtRgpRoECF/D
         2Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781353; x=1773386153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kX2H+i9GCijKEuYuYqhXoDqDG/C51o52b8gENjRkRSI=;
        b=P0A1pc+NnLHNTCOJ0qI9mwBL/nrg6m/Qj4V/zOSBEtSWOu1GIVubeN2WNPJbtehykD
         LkJJhZuB63SIzCuugMF2Kxwd6u2sn0yI3HLBh0YU/DfhIICE2wmtGGzjepZaN3rVUtWP
         nLpde5p9erhlVlZPGUaFii8gzzaTTRu0kCbXi+pzF8GLhRctlBda7bLsuYJe8mHU7QGY
         zYHdl1tEe54iTYbnOk4KijblT6oBnVXjPazxUKuvRLM5Cm1QwwFuu7QA+ywRE2ELuE4p
         WYvErnh+adqI+0Yrw3VAY5a/VDT6o49CqHXEveeMkTRLmbhtnHPrpYNZiwkUNnlztUSX
         eiuQ==
X-Gm-Message-State: AOJu0YwyJDeTKDL11sH+SRzjMJ3rTOLb6J9zPytsSEKH2ZS+qirMI8R+
	TU/VHlZy5jE3iRQot9Buxulm3P64bhSZgk1te5ffustQfUXGr27+OHZZUQyD0Cnpnt1+VFrznZk
	zWoPJA9qH0/RnDf6Yo0kZQclSjVENoHXx0OEuc/4q8zl4
X-Gm-Gg: ATEYQzwy+2mhnjVbqKTzKFTQAqweQfMcBT/4/Cm1A/QD1XHkebsc6lVaE70Y3+9Z62Y
	sCl+z6VHfkBrENKkju++dpZ/OCW0tIdnkF/Hc+P0QQi1eCxAKa52EGuddiGdzzoytek3RlFV9jv
	wjEsBXM8tU+NH8+cVx14BEKPuXj5RuXVfgdEvLWLsljMfA4uJRsZS+uPm/OOqPMRr1lh+5UjiV6
	ZrkAgVmRG1Iaj/mDATqJUd1h8iJ5ihEJzDTYiPbGM/mALwjTvIp7Oi3lhV3wpvEsVO7o2512E17
	JNC3rxB6Zv/bKYUXunRNM4M9y7YbK+J7jj7+L+4=
X-Received: by 2002:a05:6820:4dc8:b0:679:dcdf:1a0f with SMTP id
 006d021491bc7-67b9bd774e4mr785350eaf.72.1772781353373; Thu, 05 Mar 2026
 23:15:53 -0800 (PST)
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
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com> <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
In-Reply-To: <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Fri, 6 Mar 2026 08:15:41 +0100
X-Gm-Features: AaiRm50isSozxUzZ4uH66B_S6XaotegIYN7OB30pyZuA4aysrD1OW6EwqBLJSEE
Message-ID: <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> What kernel version are you seeing this behavior? We no longer use
> HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
> https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_syn=
c.c#L6673
>
> It was changed some 4 years back, so it quite an old change even for
> stable kernel:
> https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d=
60e1cb94e5a77a

Hi Luiz,

To answer your question, our industrial environment runs on Ubuntu Core 22,
which uses the LTS kernel 5.15.0-1096-raspi (aarch64).

Thank you for the detailed logs and for pointing out commit
a56a1138cbd85e4d565356199d60e1cb94e5a77a.

I understand that HCI_OP_LE_CREATE_CONN itself has been decoupled from
HCI_CMD_TIMEOUT. However, I have conducted a deep code analysis on the
current bluetooth-next tree combined with an isolated empirical test on
our hardware, which strongly suggests that HCI_CMD_TIMEOUT is still the
root cause of the abort in our industrial use case.

Here are the facts and the methodology used to verify it.

1. Code analysis on bluetooth-next: HCI_CMD_TIMEOUT is still widely used

While the specific create connection command may use a different timeout,
the entire connection setup sequence relies on multiple synchronous HCI
commands. A simple grep on the current bluetooth-next tree shows extensive
usage of this 2-second limit:

$ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | wc -l
150

$ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | cut -d: -f1 | uniq -c | sort =
-nr
    124 net/bluetooth/hci_sync.c
      7 net/bluetooth/msft.c
      6 net/bluetooth/hci_core.c
      3 net/bluetooth/hci_conn.c

With 124 occurrences in hci_sync.c alone, many preparatory commands
(e.g. HCI_OP_LE_ADD_TO_ACCEPT_LIST, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
which are visible in the memcheck logs you provided) rely on
__hci_cmd_sync_sk(), which falls back to the hardcoded
HCI_CMD_TIMEOUT (2000 ms).

2. Empirical test methodology

To verify that this global timeout is the limiting factor for our
5-second advertising interval sensors, we performed an isolated test
in our environment.

Environment:
Ubuntu Core 22 / Kernel LTS 5.15.0-1096-raspi (aarch64)

Sensor:
TE Connectivity M5600 (5 s advertising interval, ~12.5 s handshake time)

Action:
All previous patches were reverted, including the withdrawn v4 patch on
conn_timeout. We modified only the global definition in
include/net/bluetooth/hci.h:

--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@
-#define HCI_CMD_TIMEOUT msecs_to_jiffies(2000)
+#define HCI_CMD_TIMEOUT msecs_to_jiffies(15000)

Build process:
To avoid any userspace interference, we rebuilt the kernel natively as an
immutable Snap and generated a custom Ubuntu Core OS image using
snapcraft pack and ubuntu-image.

3. Test results

We modified only the global definition in include/net/bluetooth/hci.h and
observed the exact behavioral threshold.

Phase 1 (2000 ms =E2=80=93 unmodified):
The connection attempt is aborted almost immediately and silently at the
HCI level. Userspace applications remain unaware and continue waiting,
which explains the ~45 s stall observed in our previous Python test.

Phase 2 (10000 ms):
The kernel allows the connection sequence to progress further, but the
sensor requires ~12.5 s to complete the handshake. The kernel timeout
therefore triggers right before completion. For the first time our
userspace daemon logged explicit "[BLE] Disconnected" events, showing
that the kernel actively aborted the handshake at the 10 s mark.

Phase 3 (15000 ms):
Once the kernel timeout exceeded the sensor response time, the connection
succeeded reliably. The full handshake consistently took ~12.5 seconds.

Conclusion

These observations suggest that even though HCI_OP_LE_CREATE_CONN itself
no longer relies on HCI_CMD_TIMEOUT, the overall connection sequence is
still constrained by synchronous preparatory commands in hci_sync.c that
use this timeout.

Because our sensors advertise only every 5 seconds, the state machine
appears to hit this limit before the full sequence can complete.

Since increasing HCI_CMD_TIMEOUT globally to ~15 seconds in the upstream
kernel may be too aggressive for other environments, what would be the
recommended approach from the BlueZ maintainers to support LE devices
with advertising intervals greater than 2 seconds?

Would it be acceptable to make this synchronization timeout configurable,
for example through sysfs or the mgmt API?

Best regards,

Dajid Morel
Volvo Group

Le mar. 3 mars 2026 =C3=A0 22:12, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Dajid,
>
> On Tue, Mar 3, 2026 at 3:31=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.co=
m> wrote:
> >
> > On Tue, Mar 3, 2026 at 8:26 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > That is waiting 40 seconds as expected, so I'm not sure what is
> > > causing it to time out in 2 seconds but that is definitely the
> > > expected behavior.
> >
> > Hi Luiz,
> >
> > Thank you for providing those logs. Seeing the 40.5-second delta in
> > your environment is very insightful and confirms that the standard
> > stack should wait much longer than what I am observing.
> >
> > I have finally identified the root cause of the 2-second abort in my
> > setup. My environment uses industrial TE Connectivity M5600 sensors,
> > which are designed for ultra-low power consumption with a long
> > advertising interval of 5 seconds.
> >
> > After auditing the kernel source, I found that HCI_CMD_TIMEOUT is
> > hardcoded to 2.0 seconds (#define HCI_CMD_TIMEOUT
> > msecs_to_jiffies(2000)).
> >
> > When the kernel issues HCI_OP_LE_CREATE_CONN, the local controller
> > (Broadcom on RPi4 or Rockchip on Rock 4 C+) must wait for the next
> > advertisement from the sensor to proceed with the connection. Since
> > the M5600 only wakes up every 5s, the 2-second HCI_CMD_TIMEOUT
> > systematically triggers before the controller can receive the
> > advertisement and acknowledge the command completion. This leads to an
> > immediate abort, even if the sensor is physically next to a high-gain
> > antenna (9.4dBi).
> >
> > This explains why my v4 patch (forcing conn_timeout to 20s) worked as
> > a side-effect: it kept the connection structure alive just long enough
> > to bypass the immediate impact of the HCI command timeout, but it was
> > architecturally the wrong target.
> >
> > I officially withdraw this patch series.
> >
> > However, this 2-second hardcoded limit for HCI_CMD_TIMEOUT seems
> > fundamentally incompatible with many industrial low-duty-cycle
> > sensors. Many developers on various forums resort to kernel hacks to
> > bypass this.
> >
> > Would you consider a patch that either:
> > 1. Increases HCI_CMD_TIMEOUT globally to 5 or 10 seconds?
> > 2. Or makes the LE connection command timeout specifically
> > configurable via the Management API or main.conf?
> >
> > I would like to work on a cleaner solution that accommodates these
> > low-power industrial sleep cycles without breaking existing tools.
>
> What kernel version are you seeing this behavior? We no longer use
> HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
>
> https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_syn=
c.c#L6673
>
> It was changed some 4 years back, so it quite an old change even for
> stable kernel:
>
> https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d=
60e1cb94e5a77a
