Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9729422;
	Mon, 16 Dec 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361031; cv=none; b=J60uzPhNeXhHF5eKdejJaHeNhItfFMB8negl9Q6Qih7irDou7zFS+0y7eC+H8isOKTRAt+a3n2PP8c6gtLObmemMbw3gwhCA9oACdmQ1kbOY8nACW7CvhRTjjNE8h3qUj2pFZn1+xcn4l/D/VUhBcvU8SdZGJ+ZzH6k0F62QuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361031; c=relaxed/simple;
	bh=1uMRSW1Kl3md3v/BA+uSCsTj+gxZYNZ9lespBYYvsJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChMgPzGNobjv03fBRnpNH1vlCowoVfgiLsmmbi2SVWNG2U2VLHA0EV/4p6+jElO2wdbjVws3swr6xOryZsxLLkR04QazKUePcBJ72SxGbyQFqoJxOnv52whIfqrTwX4yxAQPF4RRnvq37rrKZZYACDnTe6n6sJ27Xj+KR5HamlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2BRgwM9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2BRgwM9"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30227ccf803so45963681fa.2;
        Mon, 16 Dec 2024 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734361028; x=1734965828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9desq/mgfdlYR68Dyr0KnrAXZa5MEZhEIiPQ91crHI=;
        b=I2BRgwM9wklxmzp5k5cWQc+PB7Bd+T2maiWUift/dTWouJr7dr0rvy2A4XgECCVWas
         xQ7n3hyVJN48YEE8A7hCEn1CmckNrgTWPSwY2ifOKypCwTyuUFsHHfCNO+1/POQ+/7Zp
         GRvbNpsUAfeRrpCjJuCKesjYxxkcHrG5qHcRo2V1l/2+3SEshe+uaiD3hFg1LmKpoaml
         N5f76bOlYgAOifVeopis1s52Rxhd0cWPC9xXIyS68lUjHVKKH0OW3K8NGrbc1uMSIqnP
         u9bD9pxY1P2iYFsCdldj12ILGCrUqsJdjUqzccS9MAtlk1vqLU+IBzWda891fAqBqq/w
         /spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361028; x=1734965828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9desq/mgfdlYR68Dyr0KnrAXZa5MEZhEIiPQ91crHI=;
        b=pN4zS82pJvx/jn+AT0wSHJMGmKYcbJSAM6E4X5TZvzqbFLtjyHmSKoU4/M4wprGVJO
         hFHm48LZExvQ9+zvAsY6eTzme7pkeT/e98J8xd0DUtyio21OfK8jwQRIiWK+c9CTYFF8
         y1WFgZhCqkJt48MVZhYe7as2u9BoON6Hqto5/nGoVh2Uj/22zJV8AFVjItzHeXWzOl4X
         31BYUvUiCQnAe6SO5DXwFYe0leq/TxAXdpUUDCjBQiKe9+e0Q7PaDdFgy9vaPsM1N0Vl
         FctlOItIwXcmVYP2sJDXylQXUgw76pvRAthOOO9M3ENfoKXe3RK9s5xbKDkLx6Gz7PTm
         MWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrwuW6AJkix1pt2I4A/QqW4r30tGbgJ57HUqNXtxMXS5+JqySljuKsyz1vPAZAO9Po74no9gb2yKoyXFZt7fk=@vger.kernel.org, AJvYcCVzj3ZurzIN1G/Y+durcjmq5OCsmQcteRBrtbe8bqpDFVnOfRU3T5IZuKEmst+YIQKfTPTeG3FFsT7sRVAO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qytKxobC00oL/m0wTFtQu+3QKG/LjD+9tt3ZtrJacGl0gFAY
	LqYcZuWhdxqtt/tR9tAqadt2JCwrQfM2TPxfS9RkJnmTtfYKtAizFRGwyJFsPgxr9WlTsOT0vj/
	W78m1rRA7mLseX8X3N+Ty7Y7wE+A=
X-Gm-Gg: ASbGnctC+reu6l6/PVH4aGJmt4Y+c0nYU0ZTq3GztKB+8jOGBFXsNH7eNR2B1+TJJ6K
	lwYabkUltiV0EZLhdIoL87bcMYtLPd7nKKyDV
X-Google-Smtp-Source: AGHT+IENNnDrzKmBmIEd/XvbgSlXgDhGslt49JrNc9qsIpAS7s6PI4yY7fvXVqXOxAvJ4i4cCg6/8MORYsuybTCBWGo=
X-Received: by 2002:a2e:bc18:0:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-3025453146dmr39157341fa.15.1734361027340; Mon, 16 Dec 2024
 06:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
 <CABBYNZLY_PAA0jPiHwGKUmdd3SKqwViLSHAkNHH0=trdqrDRnQ@mail.gmail.com>
 <8107a53f-5967-461b-8c89-773096a316d1@quicinc.com> <CABBYNZJarA24Sy5qXKy77Jtnn+RBYhSg7Hxj9wUxENNvwkiyTg@mail.gmail.com>
 <f96edd22-c7d1-4d83-96d6-8138fbb1ff71@quicinc.com> <9be4f9c2-bf10-4bd2-ad56-40684f4fb5c3@quicinc.com>
In-Reply-To: <9be4f9c2-bf10-4bd2-ad56-40684f4fb5c3@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2024 09:56:54 -0500
Message-ID: <CABBYNZLz1=AGuGPvxv3MWn-G4djV0QW1Fkd1=f-2BWZEKouuLw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when
 power off
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com, quic_shuaz@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 16, 2024 at 8:36=E2=80=AFAM Jiayang Mao <quic_jiaymao@quicinc.c=
om> wrote:
>
> Hi Luiz,
>
> On 2024/12/4 21:47, Jiayang Mao wrote:
> > Hi Luiz,
> >
> > On 2024/12/4 1:28, Luiz Augusto von Dentz wrote:
> >> Hi Jiayang,
> >>
> >> On Tue, Dec 3, 2024 at 12:19=E2=80=AFPM Jiayang Mao <quic_jiaymao@quic=
inc.com>
> >> wrote:
> >>>
> >>> Hi Luiz,
> >>>
> >>> On 2024/12/3 4:41, Luiz Augusto von Dentz wrote:
> >>>> Hi Jiayang,
> >>>>
> >>>> On Mon, Nov 25, 2024 at 12:51=E2=80=AFPM Jiayang Mao
> >>>> <quic_jiaymao@quicinc.com> wrote:
> >>>>>
> >>>>> Clear the remaining command in cmd_sync_work_list when BT is
> >>>>> performing power off. In some cases, this list is not empty after
> >>>>> power off. BT host will try to send more HCI commands.
> >>>>> This can cause unexpected results.
> >>>>
> >>>> What commands are in the queue?
> >>>
> >>> If turning off BT during pairing, "hci_acl_create_conn_sync" has chan=
ces
> >>> to be left in the queue. Then the driver will try to send the HCI
> >>> command of creating connection but failed.
> >>
> >> There shouldn't be happening though:
> >>
> >>      /* Terminated due to Power Off */
> >>      err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF)=
;
> >>      if (err)
> >>          goto out;
> >>
> >>      err =3D hci_dev_close_sync(hdev);
> >>
> >> Perhaps there is something attempting to connect after
> >> hci_disconnect_all_sync has completed, in that case there is a bug
> >> around this sequence or we need to check HCI_POWERING_DOWN to not
> >> attempt to process the connection attempts.
> >>
> > After pairing, an L2CAP channel is to be created by l2cap_sock_create
> > function. It eventually calls hci_connect_acl_sync, which adds
> > hci_acl_create_conn_sync to the cmd_sync_work_list.
> >
> > The issue arises if BT is turned off after this addition but before
> > hci_acl_create_conn_sync is execute.
> >
> > Your suggestion to check HCI_POWERING_DOWN seems more appropriate
> > for addressing this issue. We can try incorporating this check into
> > hci_acl_create_conn_sync.
>
> Thank you for your attention to this matter. Could you please help to
> check my reply? Please let me know if there are any other concerns, or
> if I should submit another change to check HCI_POWERING_DOWN in
> hci_acl_create_conn_sync.

Yes, please add a check for HCI_POWERING_DOWN, also if you could come
with a test for mgmt-tester to test such a scenario it would be great
since I'm not quite sure how you are able to reproduce this, or is
this a test script that does bluetootctl> connect + power off?

> >
> >>>>
> >>>>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> >>>>> ---
> >>>>>    net/bluetooth/hci_sync.c | 6 ++++++
> >>>>>    1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >>>>> index c86f4e42e..bc622d074 100644
> >>>>> --- a/net/bluetooth/hci_sync.c
> >>>>> +++ b/net/bluetooth/hci_sync.c
> >>>>> @@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >>>>>    {
> >>>>>           bool auto_off;
> >>>>>           int err =3D 0;
> >>>>> +       struct hci_cmd_sync_work_entry *entry, *tmp;
> >>>>>
> >>>>>           bt_dev_dbg(hdev, "");
> >>>>>
> >>>>> @@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >>>>>           clear_bit(HCI_RUNNING, &hdev->flags);
> >>>>>           hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
> >>>>>
> >>>>> +       mutex_lock(&hdev->cmd_sync_work_lock);
> >>>>> +       list_for_each_entry_safe(entry, tmp, &hdev-
> >>>>> >cmd_sync_work_list, list)
> >>>>> +               _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED)=
;
> >>>>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> >>>>
> >>>> Seems equivalent to hci_cmd_sync_clear, that said we should have bee=
n
> >>>> running with that lock already, also if there is a sequence like
> >>>> close/open the close may cancel the subsequent open, so I don't thin=
k
> >>>> we should be canceling every subsequent callback like this.
> >>>
> >>> In hci_cmd_sync_clear, the work cmd_sync_work and reenable_adv_work a=
re
> >>> canceled. hci_cmd_sync_clear is not directly called because these two
> >>> works should not be canceled during power off.
> >>> Do you mean the added code should be moved to other functions to avoi=
d
> >>> the risk of lock?
> >>>
> >>> Yes. This change lacks considering sequence of close/open. I will upd=
ate
> >>> the implementation to ensure it does not remove the opening and the
> >>> operations after re-opening.
> >>>>
> >>>>>           /* After this point our queues are empty and no tasks are
> >>>>> scheduled. */
> >>>>>           hdev->close(hdev);
> >>>>>
> >>>>> --
> >>>>> 2.25.1
> >>>>>
> >>>>
> >>>>
> >>>
> >>
> >>
> >
> Thanks,
> Jiayang Mao



--=20
Luiz Augusto von Dentz
