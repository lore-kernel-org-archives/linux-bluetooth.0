Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED04219ED
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821262; cv=pass; b=IjDhr9y8rEdtD0flU6py2Pm4y203+YvJmsd7RAAMyCubtWaKdo8R7croqycTaEVq83ONJd0lppWpeOOV4bMQL7my8O/7gJ4S3y12J9ei4MU3cyr5h0TbZ5y2gLkWPahYhkpuHeIBT6usS9UD5NE2u6mYINXsJ0ZgkOLcYQfujNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821262; c=relaxed/simple;
	bh=6qQ6vVFOlJHcr0bFQRqm2/M3MJI1h88+qmN63gkucRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCH18R2LJgOMzMtFQQKXuwWCUxmIUqnKRFlvpNUHEqzUvHISX0LRPvbaFTwsmxeSuB7O9KRfQ+Zrvy6XFT7nrNd58psy1Tv0gs2/WTQxVqkwkgJIlPCo4hEKcxA0+V4Fz0D9eiSQRLK59P0/x+tYpnsgyFn9vJ4zJZ6TD/3ty5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAtSNkZW; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAtSNkZW"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463a0e14abfso7180273b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 10:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821260; cv=none;
        d=google.com; s=arc-20240605;
        b=AGzplu9nnVJdJesN6wMfoPKFGbe9lH8A/tFyj2hTSosIaZrMn12fdapJzXGjNZXGli
         wnEY0AM2hznA+4S4qhghM3Mu1SS0cUe71cFyMsuGfnuq8kSgBYcbo6JArcoyx16K77dq
         uTwC4YBLXyOSpG0Eg01MzctWDi45IgJ5pvW9vVEU4EyrmexjQ16uailwg5HjhaXX1wyC
         y/QVjS4kqZRjUL5FwtrvGvf38q83xUu1PHJjrgFOt3a0wq5lmRIi3kyPaDOHg2y2qSsk
         bdNxtcnh1Zpmn4FHeoCJWaLA8AGjLQbgzbjRYfv7Us7fCFuXVgHwnyTUCaX/jut1v7Hc
         s1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vsHiEo527F7ThZd2y9o2igT05ZJCdNZp3YyeDlHdB/4=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=K2PQKm2s/fq3d+CDmQC9/f16xhzUTGrCGuc1urjQn4jOmV/563P3y99pph/pJHGey+
         p/azGFKYR0AlxUfNy+GBMNoPrOctCd9O49l+ILq5XBkKRlSZw2bBAV3gpzodh+z9LPbF
         N2BsgHwSeQobjYJFy3wZwX3F70PSCWPNMduYeHvLd49aG4rv2W3N3/GPflsadqXz9bOL
         SycxRagUB9XKZe5mwDeno5cNm+oSJGLTGT3btyYQ+caldtMQC002SL8xHuM+q7D1NU/7
         pOw17Aw9Qp2tFTPoZFiKrJWTqLw90ZMWbflMyHU/LwpSFImzvBbhJUuKcvGa9QHogGBb
         y/Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772821260; x=1773426060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsHiEo527F7ThZd2y9o2igT05ZJCdNZp3YyeDlHdB/4=;
        b=CAtSNkZWiBrKW/4gLpBjamvzJqbRnUMSxWl/C4Kj+OiKRPV4SA6E8d5InJWaTUNuc7
         hGkq33GIJHbC9gEdt3pIhfT6HUiJDnYvKEP6/WsTmVHCN07vjeWbp6t3L0oRjDG6qhkS
         q1KiBBig4u+qXK2la2EeIeg3XrKa3eiSG8GyK4Jez3hHhD2vmyyXmFv/5e7CmMVMsXSF
         w0Vy/vFzab2tKYGeFdzIR8N+dY0UHRKZ5ExCboJxf7DdcXXUd4AblycgBOur2sNxIfP+
         jHKvO77saWOKAVXz/UvfZ0QFQ8ganJFNLDLnuEScnKiA1B+hN3t5d1KlnJMJwqJX0QZl
         dilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821260; x=1773426060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsHiEo527F7ThZd2y9o2igT05ZJCdNZp3YyeDlHdB/4=;
        b=qG7hps85p6luYBTXLv/UhJjxYSh1QLMHFw5jauIDudMr8P6AjijlFqJrAqK2DjtCoC
         XEYFqgQtPwGBBSyg/UWUj+1XnaWOcSkjYMF/yIo+DNbP+gkLXcJjmztYcyE3h0VUVEPg
         dmLngnAyPZzaZdkIyXmOhjLvrCnF/zeixuLw1dfvDIivN6utSUHYZ46ooe/vWE7xxCW8
         wQxkPb5Gxt7DRxknHbYQgZMOpjo4CzyoJhvkhzBY617lpkYK/mwjSNDR1sNit+P6w0h6
         LaoVViW6bTFCN456FCcvR4Yax5fIfqrY0HoCxj56oG32VwBn2H2t1BwI+84TN5jNQOmf
         Jnjw==
X-Gm-Message-State: AOJu0YwwTyRTrkqnRHXsOxr5BCwJnxy+5alSy+ITZf2hX6krVevzOTEx
	z385azzFukRoE7ZeNKfDlGgJf0nBRyvu9qG2D/ek/xnEhv6/lGygf94QMEqi86zs2NkEwpR4NK3
	LLVicmMy/tSPN0Gufwn6wVgtyNsFXeY0IGKkgqGcViW4S
X-Gm-Gg: ATEYQzz263i8/7n9h14OQS3zDTVUZL2r6Q14N+jf1Q4EehJZv7m6vidT8tZtMXryTtO
	4fQSZda47FpOzVDkngPmyOwoSD+tp0iT+bzIO6Qefjt3/Fll/F22Oe1mQdJeVYJjWvmoF4oAJ4p
	TinETR7rRNMX6oVWSrOJXFSMc/ritjt3lzhl9A2cxhNXQeu/ynr5FJ41nE5ri3im/9l4Trv6T5+
	vnB11IIG+ZCqyX5FZ++ciGJLoQHfZ/R5ktolmzPle5onytPMhcAP3q91tn0X/1SnvqcfkyR7+2j
	cTJC/Di+kUuctygT3J2jNfpkUcrZVO7f57opm2+5Mv2FOhZZTTpB0U8FVXnkEVODPPdm
X-Received: by 2002:a05:6808:10cf:b0:450:d504:9281 with SMTP id
 5614622812f47-466dcba1940mr1540925b6e.59.1772821260096; Fri, 06 Mar 2026
 10:21:00 -0800 (PST)
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
 <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com> <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
In-Reply-To: <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Fri, 6 Mar 2026 19:20:48 +0100
X-Gm-Features: AaiRm50F41Zh-xGt4-V7zbGMAm7jFWrEI-BTUqkGt5zmAJrVexS-tMdVK16RPds
Message-ID: <CAM8DPm2BHBSTZkqOeJTqjOF7jnrX_8JL-YRdu338osq4Hr9iMQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d5=
65356199d60e1cb94e5a77a
> that was posted 3 days ago in this thread?
> That in theory should have been backported.

Yes I mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d5=
65356199d60e1cb94e5a77a,
and the investigation above is conducted on the latest tree.

Le ven. 6 mars 2026 =C3=A0 18:54, Dajid Morel <dajidp.morel@gmail.com> a =
=C3=A9crit :
>
> On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4=
d565356199d60e1cb94e5a77a
> > that was posted 3 days ago in this thread?
> > That in theory should have been backported.
>
> Hi Luiz,
>
> ubuntu@builder:~/bluetooth-next$ grep -nB 2 "HCI_CMD_TIMEOUT"
> net/bluetooth/hci_sync.c | grep "HCI_OP_LE_ADD_TO_ACCEPT_LIST"
> 2511:    err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST=
,
> 2512:                                sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>
> As shown above, the preparatory command HCI_OP_LE_ADD_TO_ACCEPT_LIST is s=
till
> hardcoded to HCI_CMD_TIMEOUT (2s). In the 5.15 LTS kernel (and bluetooth-=
next),
> this command is part of the mandatory sequence before the connection is e=
ven
> attempted.
>
> ubuntu@builder:~/bluetooth-next$ sed -n '2850,2855p' net/bluetooth/hci_sy=
nc.c
> for (i =3D 0; i < n; ++i) {
> err =3D hci_le_add_accept_list_sync(hdev, &params[i],
> &num_entries);
>
> Even if the final HCI_OP_LE_CREATE_CONN is decoupled (line 6673), the sta=
te
> machine fails at line 2511 because our industrial sensors (TE M5600) have=
 a
> 5-second advertising interval. The controller times out before the device=
 is
> even added to the accept list.
