Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AF38BF6A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050568; cv=pass; b=FCXbjlGbsX46jjgU6FOHD9bdkqeBg1P+GAYg8GwIQEMJnZoPXsXHWh5VGM+BN8GVUM4HADSPI52PZ0LdA6LiEPniQtWS0d+Eehp52u2bvb3Xs2mchaPu25AQwGJTBoOC65KAAn+QeDXWRw8iyGWDJdeTD9MqRoqSguP18Aglusc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050568; c=relaxed/simple;
	bh=GafKhRKNDVwJSj5WoaMkckXbAekNQPewU6iFfgeqpsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scU6JNlH6coQXPVY7YIQ/Yk+bIusCmSMT5NkWpVlRYh8PRpXSe5Im0Q7ERWtvzZyTJQ1fdTxMLG8CG6ME013vjQeky4bEwtXrgz1z6T/oPNPhAC1t6MFKDkvQvVtLBOM7XoLG9k/F0XxZtGHWFZd4zHN0FJds5FBDpr+aw46RQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxRsP6Wv; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxRsP6Wv"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4671119c1c0so255170b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 03:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050565; cv=none;
        d=google.com; s=arc-20240605;
        b=h5G38jWsznQ3OCavhKAgUsX/LxIJiUbSoKIpw/xkoB7idS/kOSEsL788CKg1czNpB+
         uOsHdyBrpA4518pE0u9Kl7HBDqR7nMU7YIi00b2FCfRv56ZY10Rna1ZW/QI2oEAtdN+7
         dDDbv5uAOWLB1Ilfu04UCgRPO0GLk+UiH9v1od1Ry9XWfiLBdGJbcsb4oU7//VDWzZH0
         /uDH0/+msYfEjyxozoQXq2l0lVEpW2EAO5LC1DvwYJZjAG7ly/lMvNFCrS2jLxGOp3fO
         xMWbJYT2/czMkLL0EQbfEpMvCFc397+O8o/Vxy/3Rqq1YTIiF6PtKFPs+b+dd6Fe/x5D
         Wung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a423lANGTr0fnXuJeSUGGDUj0dLdr11Maaz3KclrvIw=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=E4EPl9xLfMISZH47DsKdfy9NThdjD/SSO9b1K4CnOvjALRDc1rNBmhVqPMMtTD2byB
         pmsERmmFx53iuQTamhzD/CQCSD8Oi3h26kollattQ47hS/8ZKuL7HFR+ejCxF8p1uGeW
         IGF4Ub+Mj7EMyUSd4REydnK6lXSc8gMPWjW71i7fJT2fVTEajV9xEcDFq8D0td5+SSd7
         qR/4H93BwlAPob3TbpGkyTOibE/ByyuqMwjlDb1bU+JzH86uk5Pv+umgObu9TFHxPY5k
         GxYKXB3sDYJOyszSxLfK8djdzY/a/Ho0iZpQWTSZdjiL8TtykmLIkfzQVKh4M1vME9ik
         uzXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773050565; x=1773655365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a423lANGTr0fnXuJeSUGGDUj0dLdr11Maaz3KclrvIw=;
        b=OxRsP6Wvid8kc7IS2zyPQRxNTP0tU2Ivp3/9t2DeVhMjS1Y9FNbMGi1MMnKvcz8vEi
         Z3ts/LvfVYDV+E4Qx6QkaaTCYGYCAtuFYiU/JqsI7Hb2mT73PuHoujZAxIybTCGl2jXV
         nNSvJnbwd4VyFz/+3C0kPNru8yDet8PbClOuY5vBrdG7NF/MU+vv/yj6d+1cOXh15ft8
         /RHHkcQQrpuuFMNaRrSkR3wEVZ0l0Hn4beEvmbDThujbMmY+sZMLUgmhT/joTsjZWqJx
         2DKMVoDkUAddks5+5Rj5pQw8JgFWjSxbC8tea67sxXalr1nQ7FroQPVIIZ+CcaK5D/Jy
         7G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050565; x=1773655365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a423lANGTr0fnXuJeSUGGDUj0dLdr11Maaz3KclrvIw=;
        b=RONtRD8kf8+wKVA7hcYOI4u3zBox8Rlk25eymOTgr3iMIVvgspGPR2HyCAa2TvAVnM
         YUwBCZFmoU/q/X/S8znZoEROQcrclYIk65MIsOfKpp3ATIngFNDBeWmb+RbLZvLOHiSb
         b5xoC/M/oFnfieLUxF//nJI5TXWh8h2PAdjeczpmaeIp1ELC41VmKtTckUZBLcI2SX7k
         2NgkbUhYYlLTxYeeOZli1PfKrwgDtnXoTAAKG8WWkKEeranhFBRL6PogHKTT7ygm+zDz
         0DO8qJHud4l2G6w90DDBVWvgo7vTEiMk78q7zK35oK67kQonbBjDk2Ff4ss5neHCLEgB
         d3pg==
X-Gm-Message-State: AOJu0YwP3SiExmNc/OmZQV8aaxp8yq7bv2+SgXQUzU/zRmPF4tQMsaQx
	/5Ue+I0JLLSMQ5HKGnQKXNkklIq8ZZCq4j6micHIVMKXJHq4r4E4rBtxA0nGKeQuhnbkh4sAGLL
	mLEIidSuUiq3If/xaLpZs/MzbaWP1XIA=
X-Gm-Gg: ATEYQzz4iUP5BQXNgG4IvlHSPr7UUvwh7yTh7pEC81aLVTQjx1HIPwhrsWzoSkQFYEF
	H62moyrMUBMaoLmcQGUot4gkwAfVMzGktVcelGTE9INeDqXG1CwWIDPSoK5XzZ7lBFUDo4L/1Ql
	PtKgOIuMSaAdNcRoquwJgP0jFARq9MTT77AGGH5N6QZuWZpvmDAbYMi51tMHRwXEwE1Wqut39sG
	6OQzyyIsH5RcxVjsP70tZMysdS13i/99rFy0xCPEHdznkFhBS+xo3u3rqtzeK51qpSnoe40H0qN
	PwhmeTOYvDCm+Rpvjvw8oblcHc7aljS9k3f851U=
X-Received: by 2002:a05:6808:344c:b0:455:d3f2:4bf9 with SMTP id
 5614622812f47-466dcb0b4d7mr6015904b6e.30.1773050564762; Mon, 09 Mar 2026
 03:02:44 -0700 (PDT)
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
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com>
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com> <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
In-Reply-To: <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Mon, 9 Mar 2026 11:02:33 +0100
X-Gm-Features: AaiRm52yHWubH8j9mQefoVXpnQHZEGIQ_AFRt1Xf5iVSXD9IBbJDBnpSoN7sqAg
Message-ID: <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Yeah, you really don't know what you are talking about, there is no
> timeout on HCI_OP_LE_CREATE_CONN itself, the controller shall generate
> a command complete immediately and the connection attempt is only
> interrupted with HCI_OP_LE_CREATE_CONN_CANCEL, so lets say yo want to
> increase HCI_CMD_TIMEOUT that means HCI_OP_LE_CREATE_CONN_CANCEL
> cannot be send because it would be pending on HCI_EV_LE_CONN_COMPLETE,
> anyway I fill like Im wasting my time here.

Hi Luiz,

I'll be brief and stick to the logs. Here is the output from a stock
5.15 kernel (2s timeout) on the Raspberry Pi 4:

[bluetooth]# connect E8:C0:B1:D4:A3:3C
Attempting to connect to E8:C0:B1:D4:A3:3C
Failed to connect: org.bluez.Error.Failed le-connection-abort-by-local

The "le-connection-abort-by-local" error is the smoking gun. It proves
the Host is aborting the sequence, not the peer.

When I apply my patch (15s timeout) on the exact same hardware:

- The "abort-by-local" error disappears completely.
- The connection succeeds 100% of the time.
- We can read the pressure data.

I noticed in dmesg that the Broadcom controller is missing its firmware pat=
ch:
[   16.357546] Bluetooth: hci0: BCM: chip id 63
[   16.360628] Bluetooth: hci0: BCM: features 0x07
[   16.378604] Bluetooth: hci0: BCM20702A
[   16.378639] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
[   16.381695] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
[   16.388662] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e8.hcd'
[   16.394969] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e8.hcd'

This likely makes the controller slower to process sync commands when
high-latency sensors are advertising nearby. However, the system is
100% stable with the 15s timeout patch, even without that firmware.

If the timeout is truly decoupled, then "le-connection-abort-by-local"
should not be triggered at exactly 2 seconds. The fact that it is
proves that the hardcoded limit in hci_sync.c is the blocker.

Since this is for a Volvo production line, we need a way to support
these sensors. If you refuse the global constant change, how can we
avoid this "local abort" in the sync sequence for slow controllers?

Le ven. 6 mars 2026 =C3=A0 19:27, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Dajid,
>
> On Fri, Mar 6, 2026 at 12:54=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.c=
om> wrote:
> >
> > On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > > You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85=
e4d565356199d60e1cb94e5a77a
> > > that was posted 3 days ago in this thread?
> > > That in theory should have been backported.
> >
> > Hi Luiz,
> >
> > ubuntu@builder:~/bluetooth-next$ grep -nB 2 "HCI_CMD_TIMEOUT"
> > net/bluetooth/hci_sync.c | grep "HCI_OP_LE_ADD_TO_ACCEPT_LIST"
> > 2511:    err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LI=
ST,
> > 2512:                                sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >
> > As shown above, the preparatory command HCI_OP_LE_ADD_TO_ACCEPT_LIST is=
 still
> > hardcoded to HCI_CMD_TIMEOUT (2s). In the 5.15 LTS kernel (and bluetoot=
h-next),
> > this command is part of the mandatory sequence before the connection is=
 even
> > attempted.
>
> That doesn't incur in any traffic, sounds like you didn't read my
> previous response where I explained why a short timeout is normally
> required for HCI, since normally only one command can be outstanding,
> I really don't know why you keep coming back to the same topic when
> Ive already shown up to date distros wait 40 seconds to complete a
> connection.
>
> > ubuntu@builder:~/bluetooth-next$ sed -n '2850,2855p' net/bluetooth/hci_=
sync.c
> > for (i =3D 0; i < n; ++i) {
> > err =3D hci_le_add_accept_list_sync(hdev, &params[i],
> > &num_entries);
> >
> > Even if the final HCI_OP_LE_CREATE_CONN is decoupled (line 6673), the s=
tate
> > machine fails at line 2511 because our industrial sensors (TE M5600) ha=
ve a
> > 5-second advertising interval. The controller times out before the devi=
ce is
> > even added to the accept list.
>
> Yeah, you really don't know what you are talking about, there is no
> timeout on HCI_OP_LE_CREATE_CONN itself, the controller shall generate
> a command complete immediately and the connection attempt is only
> interrupted with HCI_OP_LE_CREATE_CONN_CANCEL, so lets say yo want to
> increase HCI_CMD_TIMEOUT that means HCI_OP_LE_CREATE_CONN_CANCEL
> cannot be send because it would be pending on HCI_EV_LE_CONN_COMPLETE,
> anyway I fill like Im wasting my time here.
>
> --
> Luiz Augusto von Dentz
