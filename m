Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB2D46C0
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079405; cv=pass; b=ncJZW3+3qCjEL33Sx5E4DwVpvFv8YFONqT/AzGkh/28ykxIDfTgCygng9cr8iDnv5FbJQHwL+Mfj0SOUaTPylDWLRrZ/uzirchwPvl0XKwCFMTGq5nJrzCQ8rZiIVLGvbzUgl1CM0QDIqKcX6GK31wvV5MQA9YXwvRsftM24shU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079405; c=relaxed/simple;
	bh=RBNp5bYelOX6M2K6Cat2KqmEsLBgUhdLVOrm61DdXys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdyVDmYrizVbRHKYdswJ4G0tymvljYDYHG9Hhl8Y7Fqgd32SFIQLkzfaKw2/7RC2L72ssP1KCgPocgwikCp+D7XpUH66armc9d/qfY7vgP23fMa4it6PbEC/ALUixQ2YfWpaCo3JyvOdluYw8fAdVwuMX7PBis0YiyD/Xj4sOQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIvTGwuT; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIvTGwuT"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so9179352d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 11:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079403; cv=none;
        d=google.com; s=arc-20240605;
        b=WyXA1jK17pDCOjoDAuD1CgPkw4M59REhIEWVj1f+q1uC5hUJEdFB90Hwwk5WreQ0B6
         EePCcQjZKtb806eFbJ6PpXZIvCneSVkrEUEP9xIRtZ+B+28STKlncULHg153Sai92boF
         Ozfb1ngw8XKPH7ePLgeSLLBTvSlRTdYhWWKU1parOvboghnJ9e29Df2cpmNIzHrXtIqk
         4/GYTP+jNDYdASI8bdcQjBEDiblcuEAemIxIWyLUwjPkR1R1qoqy45SukaL51h9JynwC
         UDgdfgS2W9D7rj97tWKmsAjOaMqezAj2S/ks2RY0IADOatClvqaz7d4C/SXfdiWUo6ld
         M30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3qe2hSSyyUD5QJ6eskpYQYCaCQqbFKz4DLIsfb3Qor4=;
        fh=XpeyESMyPG1EcHWk4zVxetP78AWMv8zWnb7T6kDYEyQ=;
        b=Sv6LCcdH9kPXNVwsgavMRH73ZxR3YYkwngbwfTRfN46IZBNnS4daZRmaXi3TOOJz/a
         4JDCW/iK5Bi2y3DhscUdWU18Tnd36H6xMT0VvQxZDyexXymUeXxwITpQU54J9Q7qNcks
         D/nFhIwMyY/OVoG+cYSl172EGEgxUKZ5z+Bl22d+A/wc74yCqsEq1DDTcVKYmypsOuKZ
         CSzvp9hdTbMccFXEQ5UHi0PM6nt7JeAzneBS6ckFyNq5ny3pBAoOXo4Mp2I70tH3BJ1x
         8gLxbfCgo/IRlWJwQQs1vUSauMTJNYyKl2G654OvJ2PWBYDFpCuJ5FG++nppO7TCMlvT
         dUow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773079403; x=1773684203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qe2hSSyyUD5QJ6eskpYQYCaCQqbFKz4DLIsfb3Qor4=;
        b=RIvTGwuTywHHYVwcGXKIIw/K4P5lv0ZdoLgwWE4pVqQoitVKfuGh9iXEkFXW8eseJa
         HPFc0J+UV7o3jItw8GKBhc+xJ7UmvYSGXoCCx6RYRqldRBwmpD990pYmhVwC2lx2HrMi
         cJOFikhKZDCFNuLoZCLHqMtkNOdTAobPmlM+vHi+zpvGoIbKwcPFipfGFfZjRI2gd9BE
         5rbdkoLBkQA7hsJRE3+rqo3Hj8yigsISdA/u8bCmir7buBin4QKIGfB6bDtKpXMmCbIE
         Pbqq+a+lpighq+GQo51v2BEteEAvbuDvBgvvB8k6i3uxthLWNQculjdHTxpqq3yxLMV2
         QJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079403; x=1773684203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qe2hSSyyUD5QJ6eskpYQYCaCQqbFKz4DLIsfb3Qor4=;
        b=V78QCgvbOpUL0NSkzWz9EoPZmoPKYApAi6vk95HtwSvtiY+3VVqEex6vLR/gmv6U8W
         kGrgIoWAga/+haUHwplnVuVj1prvZIXQPwKd6q6DHXn+hrao8L0lYyxoALIu/+PuD5bD
         9KAHOqVcP4Xa8QfJJ9akxx/s5mj/GPmW7UyCDm68/zkhePGPw+nTu69wD8nJvZIElW+m
         0mlmGk6+Zo9ZnV/blJaJez+1g3WyZ/NK94gILBXAGL7tnTO5Aie8kewMYgOmqoxriN2E
         ziiOWaeuDtl/kXMQqraZgBF3gnpL4ns33+tpe4mti8hftB3mcg04vUPveloA3rq8+dfA
         +f5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlkS/OsONFmv/nXNw36U70KotxjSHd39WqfUtdJP7Ax5t3m/QS/IbYbOu6G54rHJUFJyYyIK94N3/coofE9HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZUQ5qLUTP7SbMjjJRPLJzHXPGUjsapIWfkRUqrM+BwJFNbDh
	VedwNGKlGWXr/FJwm6gNT2vLO5FI/kyRx1qXHtCdSgfXu4gZqaL/pjm/vxJWhVdzsGQr1+vIoHg
	yU+IuqETLe/bSK5DSFh/ihdUPy80y/6o=
X-Gm-Gg: ATEYQzz5Qhe0L0f+p6ilyrslBGV85b4jqbUbAg/rbuWan/HKoQovoavAxMelPz0Hb+5
	iOhk3HzygSn593XvdB19GdU2AT73TyKR4J9Iu2+1d7vKEQfmUUIi7psHcuk0D7sk1TJVkDnXssN
	HFFlDVQ3dBiy7YCyyvUpiAxXC8v/aNXECCpe2ZF+thYUNPRiM+JbY2oCcAO2Lpe6Ae5Vc/rn2s3
	uFJ/rzGcdNsDpUFqPkkBz9vzkgtx0OTCxfKRTmn1foFkLsvXRhGO1vLIA56sommaPu38XQZ1Cbb
	M2NhmWDNP908Oo5RT+MruHgZJ8XOeV5odPB7qZFN8JuEa1HzDAQDiCqZGcp+SJ0YjGU=
X-Received: by 2002:a05:690e:4486:b0:649:c7dd:d2ea with SMTP id
 956f58d0204a3-64d141a0203mr8540153d50.39.1773079402780; Mon, 09 Mar 2026
 11:03:22 -0700 (PDT)
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
 <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
 <CABBYNZJ6NNL26BOxV2E6HBA6D3vgOauRQ=75vRcBMA0D-vSEHw@mail.gmail.com>
 <CAM8DPm0rgZEY+aNj8-RJv7JwvMOBQuRu7qt7G+z_OpVL+zk3Gw@mail.gmail.com>
 <ea9528bd-ccde-4da3-b85b-793e370b4da1@molgen.mpg.de> <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
In-Reply-To: <CAM8DPm20ECFZF6v19SrLwA8o92YXY_dsWvOyFDOuym5S7P2kCg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Mar 2026 14:03:11 -0400
X-Gm-Features: AaiRm508ooyGXiPGOEgeeyCywprIjsLVBWblUczLOwusGfwGWya-cRdztjzWRSk
Message-ID: <CABBYNZ+ePfwbc2NS-hG5g98trXOvUqRtp-ZiXD2crrvx-Lygzg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Dajid Morel <dajid.morel@volvo.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Mon, Mar 9, 2026 at 1:37=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.com>=
 wrote:
>
> Hi Paul,
>
> Thank you for your feedback. I have analyzed the current bluetooth-next t=
ree
> (Commit: 19182348259c) as you suggested
>
> As you pointed out, Luiz is the expert on this topic. For my part, I
> am an apprentice student
> majoring in Physics and Microelectronics Systems; I do not have
> extensive expertise in the Linux kernel.
> My analysis relies primarily on observing physical behavior and
> experimentation on our production line.

One thing is discussing, another is arguing. You aren't seeking a solution =
here.

> Le lun. 9 mars 2026 =C3=A0 17:02, Paul Menzel <pmenzel@molgen.mpg.de> a =
=C3=A9crit :
> >
> > Dear Dajid,
> >
> >
> > Sorry for chiming in. Luiz is the most knowledgeable person in this.
> >
> > Am 09.03.26 um 11:02 schrieb Dajid Morel:
> > >> Yeah, you really don't know what you are talking about, there is no
> > >> timeout on HCI_OP_LE_CREATE_CONN itself, the controller shall genera=
te
> > >> a command complete immediately and the connection attempt is only
> > >> interrupted with HCI_OP_LE_CREATE_CONN_CANCEL, so lets say yo want t=
o
> > >> increase HCI_CMD_TIMEOUT that means HCI_OP_LE_CREATE_CONN_CANCEL
> > >> cannot be send because it would be pending on HCI_EV_LE_CONN_COMPLET=
E,
> > >> anyway I fill like Im wasting my time here.
> > >
> > > Hi Luiz,
> > >
> > > I'll be brief and stick to the logs. Here is the output from a stock
> > > 5.15 kernel (2s timeout) on the Raspberry Pi 4:
> > >
> > > [bluetooth]# connect E8:C0:B1:D4:A3:3C
> > > Attempting to connect to E8:C0:B1:D4:A3:3C
> > > Failed to connect: org.bluez.Error.Failed le-connection-abort-by-loca=
l
> > >
> > > The "le-connection-abort-by-local" error is the smoking gun. It prove=
s
> > > the Host is aborting the sequence, not the peer.
> > >
> > > When I apply my patch (15s timeout) on the exact same hardware:
> > >
> > > - The "abort-by-local" error disappears completely.
> > > - The connection succeeds 100% of the time.
> > > - We can read the pressure data.
> > >
> > > I noticed in dmesg that the Broadcom controller is missing its firmwa=
re patch:
> > > [   16.357546] Bluetooth: hci0: BCM: chip id 63
> > > [   16.360628] Bluetooth: hci0: BCM: features 0x07
> > > [   16.378604] Bluetooth: hci0: BCM20702A
> > > [   16.378639] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
> > > [   16.381695] Bluetooth: hci0: BCM: firmware Patch file not found, t=
ried:
> > > [   16.388662] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e8.hcd'
> > > [   16.394969] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e8.hcd'
> > >
> > > This likely makes the controller slower to process sync commands when
> > > high-latency sensors are advertising nearby. However, the system is
> > > 100% stable with the 15s timeout patch, even without that firmware.
> > >
> > > If the timeout is truly decoupled, then "le-connection-abort-by-local=
"
> > > should not be triggered at exactly 2 seconds. The fact that it is
> > > proves that the hardcoded limit in hci_sync.c is the blocker.
> > >
> > > Since this is for a Volvo production line, we need a way to support
> > > these sensors. If you refuse the global constant change, how can we
> > > avoid this "local abort" in the sync sequence for slow controllers?
> >
> > As this is the upstream list, it=E2=80=99d really help if you could tes=
t with
> > 6.19, 7.0-rc3 or =E2=80=93 best option =E2=80=93 with the bluetooth-nex=
t tree, just to
> > be sure.
> >
> > It=E2=80=99s definitely great, that you are looking for an upstream sol=
ution, so
> > please be patient, and I=E2=80=99d really be interested in your test re=
sults.
> > Depending on these, a way forward can be derived.
> >
> >
> > Kind regards,
> >
> > Paul
>
> The source code analysis of bluetooth-next confirms that the LE
> connection preparatory
>  phase (Accept List) is still limited by the hardcoded HCI_CMD_TIMEOUT
> (2s), which is
> identical to my production kernel (Jammy 5.15, Commit: 7824a77711ba):

This is a logical jump, there is no evidence that Aceept List, or any
other command done in preparation has timed out, just collect the
btmon traces so we can check which command is considerer to timeout.

> ubuntu@builder:~/bluetooth-next$ sed -n '2511,2514p'
> net/bluetooth/hci_sync.c err
> =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST,
> sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>
> While I cannot easily boot a 7.0-rc3 kernel on this specific
> industrial hardware today, the
> code at line 2511 in bluetooth-next is strictly identical to my 5.15
> kernel. In our environment
> with high-latency sensors (5s advertising interval), this 2s limit
> systematically triggers a
> "le-connection-abort-by-local" error before the final connection
> command is even reached.

Derr, you can boot a regular laptop, it doesn't need to be the
specific industrial hardware. Since you don't claim the issue is
hardware-related, it actully _doesn't matter_, or maybe it does and we
don't know it yet because you never provided any traces.

> What architectural approach would you recommend to allow for more
> latency during these preparatory
> sync commands without modifying the global kernel constant?

On the recent kernels the timeout is configurable.

> Best regards,
>
> Dajid Morel



--=20
Luiz Augusto von Dentz
