Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816F37AA94
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812665; cv=pass; b=hf5IG+ECJvaS0xmAYRA71sgScIbqoWl0GXiZMeZkxEfuvWZ8zafjLCE096JCKwMVip9JmXyI3oj63SeIR7MzAx7lZBy1QULL/UR03ABjY4x62l0bTtosAqIRFnrsI7Bvb68TXgwoKaYddybQH9EE45hgdOfikzWinSeTofSINkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812665; c=relaxed/simple;
	bh=nU2U7n31nMJJby8OFwLxH0LvrZTH/dNz6Oz3h8RDJ5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZfUG0U40AcCyaF88SvjY+zL5H5J+sFphm4YEgHz7dpOjxYEM+M1LnfXxdBXKeIczA94W12BGdzC4jraOpQIqEV3VjAIw7qHiqqliQvv9WacqkMbz2IEl3fmda5l7zf9+iBEKs2K/Vo75JyZofedY02uSn4lb0cYnyYoe96es8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzW3kPqm; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzW3kPqm"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad019bbd4so8594890d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 07:57:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812663; cv=none;
        d=google.com; s=arc-20240605;
        b=TGTl7ySsVHAiKYkE0tWSkB8f4SUqG0Pw4D58dhp59kIJ6rLbu4+fAqE9aWSiYst7rr
         tKRvjqR/Iam0uH6lExcnykywvanoYC9ZULhBWR6t7kSYqYrsSfUPrOwmseGX+QF18RKQ
         S4zZR438FbHtchhNqoh8gAqoyDFGhFpqK2Ui+/t9w4qDzGvNbWv2iv/auXhpOhPK010J
         Coa844wpgowbCOkk5VefMySp+gw/dM3VH2gPrVYwl4ciAwBxlFlN2RMKOkOsZ2EHPgu6
         okxbKyEZP5d/wUGxMVEh3cxYUlxA7oIW8ZJJ9pOdCrZrlo4eV1Z7wmUX7Ju8UCqTgaTG
         qwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WYWLzHaEWB/Sn5WTHbuiJIhJPetVWtPjIze/jf3E0ls=;
        fh=KXcOb5vphlZLN1D9IwLcOrc/UM2jVmDyJWWf/pmWc4g=;
        b=OzYm1oiuWFiPBhS+GQRCdcB4BiLwML7xIsEU7ZkDs3r+WeOCTQQqSRbgqd7P2hzGax
         1rmeEDTi4UzKJ+Ixz7QYQ+WwJyF8EatyMHuQ+l22OCHcJLXLoQtn5LAA2YbkI0iZ56ZF
         vasuFyQdBKo9zE8xOSzbG8QND5A66fLD2cWneLqcdf+AbdY+w3azmJlGx28R9s3l9APz
         Se+bahZsNAcNh9n+7sDFqCu1xAmCAp9n23GfdYlJijAbcFqqRwamEqNytSBJdjlJ5mNv
         rK053WdiUjkO03Ujwb7iOtP+fxSS611YIfU0XdYch+M7lGmbbJifkwNACs/No4DGOMz5
         auGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812663; x=1773417463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYWLzHaEWB/Sn5WTHbuiJIhJPetVWtPjIze/jf3E0ls=;
        b=LzW3kPqmTF1fpSVoUwzfsobwVh9MoJtfj91shBXXRnkjqroWQejaFVZ1156f/b+tj3
         va8Wf1XCDA86TR61D0J+YgwxiUIIfVtce+KbGSofNRC+SL9DohHgdJUkBkSY6EjNf/ZA
         HW9VxV306+mwD/d7x5j1RsUFKe/SRczkH9mIDM99Kt+xUrW5ptNdclYa7usWUhWP2/PR
         Y2UUTyP6vGji9hFBBtsUb4MiY+FOUGo6CRSqgFxmFLdXXKwMUzpEevNq1bV4sNBFicsr
         UV6sMAE6Cg1+LIIsOALdDbKJ/+YekgbzrH+ReNjGNAoQKldQ4WYN7pAD78TUreSSVpS4
         UQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812663; x=1773417463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYWLzHaEWB/Sn5WTHbuiJIhJPetVWtPjIze/jf3E0ls=;
        b=CfBxibJmuWVB8+J91Snd6jUmZX921Wmo+HbC/SYBkJSq71G778Ai2OBHJWXgelW6XO
         VcNFNd3x9dGyIgS8jp4uM3gQZGMvELSPFw3c8CZO1zwAoV0RYb/0yWDbMjZSlgEwIFPB
         o//PcGoczN+W5oD6FVOcByQZM3p2T0cH5zFgISbS+jU63UDkpFfajOYSEm5AkClh2oM7
         2ymcWxT15OAjirLhtkO15p1ba5PtYTf1ER3sJuYF/NpFZaxiFSkjvlvrnwYK9E9Nw4+k
         lMj0zXzrKAhjfytg2ceLOCke7aLS+Tfb3SC1q/poxwqLe6LcKmaPnUt2MwCUW53ebjT/
         2URw==
X-Gm-Message-State: AOJu0YyY0cIXIBCGuj0kUYvsilMsLiGkCTqcOsHR94ZW1LQdoUohAiA+
	CeCmYKuv4HJJ9XV9kZ+FqU4+aIffC9hbtmrqfGe+JuulAqwzcBo1+mtMH6ECAVRZnljno+PYvf4
	sEBtxJB7MyWhzKwNpeIOIeb7wINodDCw=
X-Gm-Gg: ATEYQzyds0tDCrOFtziSAuq6SZyJ8RsPRVtErBn5z0SitD9vCriOgpd/ZJwPYDT+5Zv
	j5w0ZtDHha04xrLuGDQ7uV2ToC67UczyDsJV6wbCXuYCIoldo4bCP/eyHqdJShDbKbf/jr147Zl
	aG4HGj7BJhDYxkKUrouDYKO0ErB+pOP7irmJhVCcGjQMMk0aTGfiAKrr5FnQ9fhcSBIaplqKEcH
	h/dOkWx6NbEdxxE/lDIJ9OLu+27UojvHgWUP8dmTwd72VtQAoYq0GUln6aeMuLmYsbpmViGkHoN
	nFY2G0lvJf5qZwUdHTSNa+Pk/jj01UkW78WHxAIbWwIyeEEwRRL1I6mdJjYWlpvSAOA=
X-Received: by 2002:a53:c055:0:10b0:649:f09d:a6e3 with SMTP id
 956f58d0204a3-64d140cd327mr1964368d50.19.1772812663262; Fri, 06 Mar 2026
 07:57:43 -0800 (PST)
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
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com> <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
In-Reply-To: <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2026 10:57:32 -0500
X-Gm-Features: AaiRm52ALjmT3IP3D_H2qjh7uNhJphMPiYufLnzS6Z8w3XVlkstB6EMaf_2vDFo
Message-ID: <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Fri, Mar 6, 2026 at 10:48=E2=80=AFAM Dajid Morel <dajidp.morel@gmail.com=
> wrote:
>
> > Im talking to an AI model/agent? However, it does look like the above
> > was generated by an AI model that is only checking the timeout used in
> > the commands without knowing the command sequence performed when
> > attempting a connection. Specifically for commands that report status
> > the timeout is short because the controller only needs to confirm it
> > received and understood the command. In fact, most commands behave
> > this way since they really need to generate a command complete or
> > status as soon as possible; otherwise, the host wouldn't be able to
> > continue sending the next command. Therefore, the rambling about the
> > usage of HCI_CMD_TIMEOUT is nonsense.
>
> > Regarding the actual problem, try using something newer, 5.15 might
> > not actually contain the necessary changes to wait an arbitrary amount
> > of time for the connection to complete.
>
>
> Hi Luiz,
>
>
> English is not my primary language, that=E2=80=99s why i=E2=80=99m using =
AI to help rephrase my thoughts into proper English. However, I want to be =
very clear: the grep results, the logic analysis, and the hardware tests ar=
e 100% manual and were conducted by me on real industrial equipment.
>
> Regarding your point on 5.15 being old: you are correct. But as I mention=
ed, we are tied to Ubuntu Core 22 for this Volvo deployment.
>
> The "rambling" about the 2-second timeout comes from a very concrete obse=
rvation. Today, I tested my Phase 3 (15s timeout) on the Raspberry Pi 4 wit=
h the TE M5600 sensor.
>
> The result is a success:
>
> For the first time, the sensor successfully associated:
>
> [BLE] Capteur associ=C3=A9 : E8:C0:B1:D4:A3:3C
>
> The handshake systematically succeeds now, whereas it was a 100% failure =
rate with the stock 2-second HCI_CMD_TIMEOUT.
>
> I understand your concern about breaking the HCI bus logic with a global =
15s timeout. However, if 5.15 is "lacking the necessary changes", could you=
 point me to the specific upstream commits that implement the "arbitrary wa=
it" for LE connections?

You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565=
356199d60e1cb94e5a77a
that was posted 3 days ago in this thread? That in theory should have
been backported.

> I would much rather backport the "correct" architectural fix to our 5.15 =
tree than keep this global hammer, but I need a path forward that supports =
these 5s-advertising interval sensors on our current LTS platform.

> Dajid Morel,
>
> Volvo Group
>
>
>
> On Fri, Mar 6, 2026 at 15:26 Luiz Augusto von Dentz <luiz.dentz@gmail.com=
> wrote:
>>
>> Hi Dajid,
>>
>> On Fri, Mar 6, 2026 at 2:15=E2=80=AFAM Dajid Morel <dajidp.morel@gmail.c=
om> wrote:
>> >
>> > On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> > > What kernel version are you seeing this behavior? We no longer use
>> > > HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
>> > > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hc=
i_sync.c#L6673
>> > >
>> > > It was changed some 4 years back, so it quite an old change even for
>> > > stable kernel:
>> > > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d56535=
6199d60e1cb94e5a77a
>> >
>> > Hi Luiz,
>> >
>> > To answer your question, our industrial environment runs on Ubuntu Cor=
e 22,
>> > which uses the LTS kernel 5.15.0-1096-raspi (aarch64).
>> >
>> > Thank you for the detailed logs and for pointing out commit
>> > a56a1138cbd85e4d565356199d60e1cb94e5a77a.
>> >
>> > I understand that HCI_OP_LE_CREATE_CONN itself has been decoupled from
>> > HCI_CMD_TIMEOUT. However, I have conducted a deep code analysis on the
>> > current bluetooth-next tree combined with an isolated empirical test o=
n
>> > our hardware, which strongly suggests that HCI_CMD_TIMEOUT is still th=
e
>> > root cause of the abort in our industrial use case.
>> >
>> > Here are the facts and the methodology used to verify it.
>> >
>> > 1. Code analysis on bluetooth-next: HCI_CMD_TIMEOUT is still widely us=
ed
>> >
>> > While the specific create connection command may use a different timeo=
ut,
>> > the entire connection setup sequence relies on multiple synchronous HC=
I
>> > commands. A simple grep on the current bluetooth-next tree shows exten=
sive
>> > usage of this 2-second limit:
>> >
>> > $ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | wc -l
>> > 150
>> >
>> > $ grep -rn "HCI_CMD_TIMEOUT" net/bluetooth/ | cut -d: -f1 | uniq -c | =
sort -nr
>> >     124 net/bluetooth/hci_sync.c
>> >       7 net/bluetooth/msft.c
>> >       6 net/bluetooth/hci_core.c
>> >       3 net/bluetooth/hci_conn.c
>> >
>> > With 124 occurrences in hci_sync.c alone, many preparatory commands
>> > (e.g. HCI_OP_LE_ADD_TO_ACCEPT_LIST, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
>> > which are visible in the memcheck logs you provided) rely on
>> > __hci_cmd_sync_sk(), which falls back to the hardcoded
>> > HCI_CMD_TIMEOUT (2000 ms).
>> >
>> > 2. Empirical test methodology
>> >
>> > To verify that this global timeout is the limiting factor for our
>> > 5-second advertising interval sensors, we performed an isolated test
>> > in our environment.
>> >
>> > Environment:
>> > Ubuntu Core 22 / Kernel LTS 5.15.0-1096-raspi (aarch64)
>> >
>> > Sensor:
>> > TE Connectivity M5600 (5 s advertising interval, ~12.5 s handshake tim=
e)
>> >
>> > Action:
>> > All previous patches were reverted, including the withdrawn v4 patch o=
n
>> > conn_timeout. We modified only the global definition in
>> > include/net/bluetooth/hci.h:
>> >
>> > --- a/include/net/bluetooth/hci.h
>> > +++ b/include/net/bluetooth/hci.h
>> > @@
>> > -#define HCI_CMD_TIMEOUT msecs_to_jiffies(2000)
>> > +#define HCI_CMD_TIMEOUT msecs_to_jiffies(15000)
>> >
>> > Build process:
>> > To avoid any userspace interference, we rebuilt the kernel natively as=
 an
>> > immutable Snap and generated a custom Ubuntu Core OS image using
>> > snapcraft pack and ubuntu-image.
>> >
>> > 3. Test results
>> >
>> > We modified only the global definition in include/net/bluetooth/hci.h =
and
>> > observed the exact behavioral threshold.
>> >
>> > Phase 1 (2000 ms =E2=80=93 unmodified):
>> > The connection attempt is aborted almost immediately and silently at t=
he
>> > HCI level. Userspace applications remain unaware and continue waiting,
>> > which explains the ~45 s stall observed in our previous Python test.
>> >
>> > Phase 2 (10000 ms):
>> > The kernel allows the connection sequence to progress further, but the
>> > sensor requires ~12.5 s to complete the handshake. The kernel timeout
>> > therefore triggers right before completion. For the first time our
>> > userspace daemon logged explicit "[BLE] Disconnected" events, showing
>> > that the kernel actively aborted the handshake at the 10 s mark.
>> >
>> > Phase 3 (15000 ms):
>> > Once the kernel timeout exceeded the sensor response time, the connect=
ion
>> > succeeded reliably. The full handshake consistently took ~12.5 seconds=
.
>> >
>> > Conclusion
>> >
>> > These observations suggest that even though HCI_OP_LE_CREATE_CONN itse=
lf
>> > no longer relies on HCI_CMD_TIMEOUT, the overall connection sequence i=
s
>> > still constrained by synchronous preparatory commands in hci_sync.c th=
at
>> > use this timeout.
>> >
>> > Because our sensors advertise only every 5 seconds, the state machine
>> > appears to hit this limit before the full sequence can complete.
>> >
>> > Since increasing HCI_CMD_TIMEOUT globally to ~15 seconds in the upstre=
am
>> > kernel may be too aggressive for other environments, what would be the
>> > recommended approach from the BlueZ maintainers to support LE devices
>> > with advertising intervals greater than 2 seconds?
>> >
>> > Would it be acceptable to make this synchronization timeout configurab=
le,
>> > for example through sysfs or the mgmt API?
>>
>> Im talking to an AI model/agent? However, it does look like the above
>> was generated by an AI model that is only checking the timeout used in
>> the commands without knowing the command sequence performed when
>> attempting a connection. Specifically for commands that report status
>> the timeout is short because the controller only needs to confirm it
>> received and understood the command. In fact, most commands behave
>> this way since they really need to generate a command complete or
>> status as soon as possible; otherwise, the host wouldn't be able to
>> continue sending the next command. Therefore, the rambling about the
>> usage of HCI_CMD_TIMEOUT is nonsense.
>>
>> Regarding the actual problem, try using something newer, 5.15 might
>> not actually contain the necessary changes to wait an arbitrary amount
>> of time for the connection to complete.
>>
>> > Best regards,
>> >
>> > Dajid Morel
>> > Volvo Group
>> >
>> > Le mar. 3 mars 2026 =C3=A0 22:12, Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> a =C3=A9crit :
>> > >
>> > > Hi Dajid,
>> > >
>> > > On Tue, Mar 3, 2026 at 3:31=E2=80=AFPM Dajid Morel <dajidp.morel@gma=
il.com> wrote:
>> > > >
>> > > > On Tue, Mar 3, 2026 at 8:26 PM Luiz Augusto von Dentz
>> > > > <luiz.dentz@gmail.com> wrote:
>> > > > >
>> > > > > That is waiting 40 seconds as expected, so I'm not sure what is
>> > > > > causing it to time out in 2 seconds but that is definitely the
>> > > > > expected behavior.
>> > > >
>> > > > Hi Luiz,
>> > > >
>> > > > Thank you for providing those logs. Seeing the 40.5-second delta i=
n
>> > > > your environment is very insightful and confirms that the standard
>> > > > stack should wait much longer than what I am observing.
>> > > >
>> > > > I have finally identified the root cause of the 2-second abort in =
my
>> > > > setup. My environment uses industrial TE Connectivity M5600 sensor=
s,
>> > > > which are designed for ultra-low power consumption with a long
>> > > > advertising interval of 5 seconds.
>> > > >
>> > > > After auditing the kernel source, I found that HCI_CMD_TIMEOUT is
>> > > > hardcoded to 2.0 seconds (#define HCI_CMD_TIMEOUT
>> > > > msecs_to_jiffies(2000)).
>> > > >
>> > > > When the kernel issues HCI_OP_LE_CREATE_CONN, the local controller
>> > > > (Broadcom on RPi4 or Rockchip on Rock 4 C+) must wait for the next
>> > > > advertisement from the sensor to proceed with the connection. Sinc=
e
>> > > > the M5600 only wakes up every 5s, the 2-second HCI_CMD_TIMEOUT
>> > > > systematically triggers before the controller can receive the
>> > > > advertisement and acknowledge the command completion. This leads t=
o an
>> > > > immediate abort, even if the sensor is physically next to a high-g=
ain
>> > > > antenna (9.4dBi).
>> > > >
>> > > > This explains why my v4 patch (forcing conn_timeout to 20s) worked=
 as
>> > > > a side-effect: it kept the connection structure alive just long en=
ough
>> > > > to bypass the immediate impact of the HCI command timeout, but it =
was
>> > > > architecturally the wrong target.
>> > > >
>> > > > I officially withdraw this patch series.
>> > > >
>> > > > However, this 2-second hardcoded limit for HCI_CMD_TIMEOUT seems
>> > > > fundamentally incompatible with many industrial low-duty-cycle
>> > > > sensors. Many developers on various forums resort to kernel hacks =
to
>> > > > bypass this.
>> > > >
>> > > > Would you consider a patch that either:
>> > > > 1. Increases HCI_CMD_TIMEOUT globally to 5 or 10 seconds?
>> > > > 2. Or makes the LE connection command timeout specifically
>> > > > configurable via the Management API or main.conf?
>> > > >
>> > > > I would like to work on a cleaner solution that accommodates these
>> > > > low-power industrial sleep cycles without breaking existing tools.
>> > >
>> > > What kernel version are you seeing this behavior? We no longer use
>> > > HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:
>> > >
>> > > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hc=
i_sync.c#L6673
>> > >
>> > > It was changed some 4 years back, so it quite an old change even for
>> > > stable kernel:
>> > >
>> > > https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d56535=
6199d60e1cb94e5a77a
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
