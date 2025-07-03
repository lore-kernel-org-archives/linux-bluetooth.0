Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E662E7658
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548691; cv=none; b=FdN93PkTJJ57KKFtTp7lxp15DmDUvElJy9yDZccN0URjKWdfdiewXSDvA/8mTouJFzMPUY305L/VH/so9e628UB5MFo4cJJOEfOVrfj+/bl7kCpucYx40Q3pll1HtMp+bQDvJFN1OngrRQrfhgS7WlmNhA8MYKDd1wBCokorCPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548691; c=relaxed/simple;
	bh=JtA3sI0x3avaGHKaDhwLhh+j5BeQy+xzOODfPfgXz8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Yel042t80tQ5mbrzhM5TboeziZrBkSOOkS8snzR733i7r9w3IOufIZRa5fu4sT1YD61v4Favy7fcUxZ8ho6rANZYcWvvWIhwg3ZsoPm9gpstaKgmb7g1lNwYKhzfa1gNjZWpldibjmi7MK2Qy1iUpReXnFdp+vehz0QMPF9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4EJVQsT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4EJVQsT"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b60de463so6392345e87.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548687; x=1752153487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajgmCDyw4Q8aRR+BmJ2261iSp9w5VXwjomtBiT4tzyg=;
        b=F4EJVQsTKJXlxTim0HOOB0TlGmz7fVMGjfDJRKvjHGajajznGsY6wjT4J/PoRzl+Yn
         FzyoOCQM7NRoT1sLhO2K754DW6N2gEnk2QLTmrmtzQGZ9ChCBtUdzix8XJPkJLZP4/5g
         wiT2xjMFCtAfNUWn4qE0XsYu6zwC5JYr8LPYF2xZj63ynV2hsE47Ha+oKYqk2xtLObc2
         NxPxYGlxOiYBqIQvroEE2RD/XrY4cFT8t2jyN2z8DC2jIDqKhbHUpDKS5maPkgiahM6w
         uLzs/cNvb9nECFyG7gxesXUwaJ/KE29g53PxpQgQt96UzGWn4vRmTtvJrx+DKNjJGOnm
         48yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548687; x=1752153487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajgmCDyw4Q8aRR+BmJ2261iSp9w5VXwjomtBiT4tzyg=;
        b=t7Bhd0BRfGbwm2gE1vnL/gLvcqIFA5MhNHao5/UXMFNEV9qQLv82NjtuT75wPg8ihY
         6vhMg4h+lw9CTAkWcfLp8rPRIngp9LWrKWczfor+fAqq1OaY8mDquJR6u9JcrYZNzGwS
         0Y+VsRnnnygXWLdid1o2Ubqz8eZ8qk8Gp8im9baR8lYHw/uik1lPJR+7d3OAKYZBvJsa
         uyXchjmQgaUlm577vJS/OVx7NxGGj3s0ZkQ7W8KkL+maCsCH6X+m1HwCR3XHfkFO48x4
         i0GSPFPoAygmOVZbocS86TUHIsODQHxFq5m5a2DcSvupSa5YcxRypWi+XYKQgRGJk6cH
         zlYQ==
X-Gm-Message-State: AOJu0Yy4HYbvVjEYKQtSV0y0zZ0Y+nTdFKKmvFHn0kOCdXAvgOY+8RAJ
	QVEzFpiURMYjAmnrT/J8hFjPt8f47a2Zm7kgiIDzygdGm0OKAnPFsV0bvOVMjnXscq7jr1LFdUv
	sw8UJIUhuhVT/xUhQNls1julZyl+yvlbuGoUEZsBcTw==
X-Gm-Gg: ASbGncsEFVvV+JnccrjhMvVFPCHJz5PxDUHYj0y7cqnGw1L9mvqzKjPsnn8bD40b503
	cOK4Qe2fT9c17frO0oI+ywG8pcjjvSBKy4F3iNJ4x7IXFtQxwAzAHOkR/DyOAr+w1lnmD/uL9uO
	TjfN16t0Zh2b2LJUgFJHV15FUwaySpRPqZcwbnroaIFrhPQFymrSaf
X-Google-Smtp-Source: AGHT+IFartDO/4T+Ehm3AuNhtxt0ODNcXuipsc6dc2/oSwH3qDkn0hy8m7GjF7bI0ZnzJq7NcReaa/wvSVoyck/QR0M=
X-Received: by 2002:a05:6512:b89:b0:554:f74b:78ae with SMTP id
 2adb3069b0e04-5562eed59femr1193089e87.31.1751548686907; Thu, 03 Jul 2025
 06:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
 <CABBYNZLNdr5kW=AXYohCOp71CCmvir3hjeBungDHYq2gRD0xEg@mail.gmail.com> <05dcbdc1-893d-4ea6-8c8c-40abfbb906f4@amlogic.com>
In-Reply-To: <05dcbdc1-893d-4ea6-8c8c-40abfbb906f4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Jul 2025 09:17:54 -0400
X-Gm-Features: Ac12FXzUnJWp8QvNGNkSynwfAEU39ofj7p3ushwZjCNmImKUPOpTu-Og0ohQP6w
Message-ID: <CABBYNZ+WVE6OKp+Um_g6Ji6CCE1eO+MSuPQz8WLw4QUFCZQ2Aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v3] shared/bap: Add stream state check in stream_disable
To: Yang Li <yang.li@amlogic.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 3, 2025 at 4:40=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi Luzi,
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > On Tue, Jul 1, 2025 at 9:19=E2=80=AFPM Yang Li via B4 Relay
> > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> Add a state check so that stream_disable() is a no-op when the stream
> >> is not in ENABLING or STREAMING state. This prevents unexpected state
> >> transitions or redundant operations during cleanup.
> > What is the issue here, do you have traces, debug logs, etc?
>
> Regarding the Unicast caching configuration you mentioned, there is
> currently an issue in the code flow. The relevant log is shown below:
>
> When music is paused on the pixel 9 phone, the CIS link gets
> disconnected. As the transport state changes from ACTIVE to IDLE, the
> stream state transitions from config to qos.
>
>  > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0]
> 49.572089
> Status: Success (0x00)
> Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
> Identity type: Random (0x01)
> Identity: E8:D5:2B:59:57:A6 (Static)
> Reason: Remote User Terminated Connection (0x13)
> bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream
> 0x1f9fc20 io disconnected
> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
> 0x1f9fc20 dir 0x01: releasing -> config
> bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20
> state 1
> bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
> stream 0x1f9fc20: releasing(6) -> config(1)
> bluetoothd[2313]:
> profiles/audio/transport.c:transport_update_playing()
> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=3DTRANSPORT_STATE_ACTIVE
> Playing=3D0
> bluetoothd[2313]:
> profiles/audio/transport.c:media_transport_remove_owner() Transport
> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
> bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner
> :1.1
> bluetoothd[2313]:
> profiles/audio/transport.c:media_transport_suspend() Transport
> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
> bluetoothd[2313]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
> TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
> bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
> 0x1f9fc20 dir 0x01: config -> qos

Ok, this indeed is not expected, that said we do have the following
checks already in place so we might as well update them:

    if (!stream || stream->ep->state =3D=3D BT_BAP_STREAM_STATE_QOS ||
            stream->ep->state =3D=3D BT_BAP_STREAM_STATE_IDLE)
        return 0;

> ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
> [hci0] 49.585656
> ATT: Handle Value Notification (0x1b) len 46
> Handle: 0x007b Type: Sink ASE (0x2bc4)
> Data[44]:
> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000=
003042800020501
> ASE ID: 1
> State: Codec Configured (0x01)
> Framing: Unframed PDUs supported (0x00)
> PHY: 0x02
> LE 2M PHY preffered (0x02)
> RTN: 5
> Max Transport Latency: 10
> Presentation Delay Min: 20000 us
> ...
> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0]
> 49.585725
> ATT: Handle Value Notification (0x1b) len 19
> Handle: 0x007b Type: Sink ASE (0x2bc4)
> Data[17]: 0102010010270000025000050a00204e00
> ASE ID: 1
> State: QoS Configured (0x02)
> CIG ID: 0x01
> CIS ID: 0x00
> ...
>
> when playback resumes on the phone, it attempts to set the ASE state to
> Codec. However, since the stream has already transitioned from config to
> qos, the phone ends up disconnecting the connection.
>
> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0]
> 60.216004
> ATT: Handle Value Notification (0x1b) len 7
> Handle: 0x0087 Type: ASE Control Point (0x2bc6)
> Data[5]: 0101010000
> Opcode: Codec Configuration (0x01)
> Number of ASE(s): 1
> ASE: #0
> ASE ID: 0x01
> ASE Response Code: Success (0x00)
> ASE Response Reason: None (0x00)
> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0]
> 60.226086
> ATT: Handle Value Notification (0x1b) len 46
> Handle: 0x007b Type: Sink ASE (0x2bc4)
> Data[44]:
> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000=
003042800020501
> ASE ID: 1
> State: Codec Configured (0x01)
> Framing: Unframed PDUs supported (0x00)
> PHY: 0x02
> LE 2M PHY preffered (0x02)
> RTN: 5
> Max Transport Latency: 10
> Presentation Delay Min: 20000 us
> Presentation Delay Max: 40000 us
> Preferred Presentation Delay Min: 20000 us
> Preferred Presentation Delay Max: 40000 us
> Codec: LC3 (0x06)
> Codec Specific Configuration: #0: len 0x02 type 0x01
> Sampling Frequency: 16 Khz (0x03)
> Codec Specific Configuration: #1: len 0x02 type 0x02
> Frame Duration: 10 ms (0x01)
> Codec Specific Configuration: #2: len 0x05 type 0x03
> Location: 0x00000003
> Front Left (0x00000001)
> Front Right (0x00000002)
> Codec Specific Configuration: #3: len 0x03 type 0x04
> Frame Length: 40 (0x0028)
> Codec Specific Configuration: #4: len 0x02 type 0x05
> Frame Blocks per SDU: 1 (0x01)
>
> ...
>
>  > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0]
> 63.651497
> Status: Success (0x00)
> Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
> Identity type: Random (0x01)
> Identity: E8:D5:2B:59:57:A6 (Static)
> Reason: Remote User Terminated Connection (0x13)
>
> Here is Pauli Virtanen=E2=80=99s analysis and solution:
> https://lore.kernel.org/all/3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.came=
l@iki.fi/
>
> AFAICS the bug appears to be:
>
> - bap.c:stream_disable() should do nothing if stream is
> not ENABLING or STREAMING
>
> since it's called from bt_bap_stream_disable() which is called on
> transport suspend which should be noop for BAP server if stream is
> already gone.
>
> Next, I will attach the relevant btmon trace to the commit message.
> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >> Changes in v3:
> >> - Optimizing the code
> >> - Link to v2: https://patch.msgid.link/20250630-bap_for_big_sync_lost-=
v2-0-1491b608cda5@amlogic.com
> >>
> >> bap for big sync lost
> >>
> >> To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>
> >> Changes in v2:
> >> - Add state check in stream_disable.
> >> - Add type check in stream_io_disconnected.
> >> - Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-=
v1-1-0df90a0f55d0@amlogic.com
> >> ---
> >>   src/shared/bap.c | 22 ++++++++++++++--------
> >>   1 file changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/src/shared/bap.c b/src/shared/bap.c
> >> index 40e1c974b..1790b277b 100644
> >> --- a/src/shared/bap.c
> >> +++ b/src/shared/bap.c
> >> @@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct bt_bap_st=
ream *stream, struct iovec *rsp)
> >>
> >>          ascs_ase_rsp_success(rsp, stream->ep->id);
> >>
> >> -       /* Sink can autonomously transit to QOS while source needs to =
go to
> >> -        * Disabling until BT_ASCS_STOP is received.
> >> -        */
> >> -       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> >> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> >> -
> >> -       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> >> -               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING=
);
> >> +       switch (stream->ep->state) {
> >> +               case BT_ASCS_ASE_STATE_ENABLING:
> >> +               case BT_ASCS_ASE_STATE_STREAMING:
> >> +                       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> >> +                               stream_set_state(stream, BT_BAP_STREAM=
_STATE_QOS);
> >> +                       else if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> >> +                               /* Sink can autonomously transit to QO=
S while source needs to go to
> >> +                               * Disabling until BT_ASCS_STOP is rece=
ived.
> >> +                               */
> >> +                               stream_set_state(stream, BT_BAP_STREAM=
_STATE_DISABLING);
> >> +                       break;
> >> +               default:
> >> +                       break;
> >> +       }
> >>
> >>          return 0;
> >>   }
> >>
> >> ---
> >> base-commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
> >> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
> >>
> >> Best regards,
> >> --
> >> Yang Li <yang.li@amlogic.com>
> >>
> >>
> >>
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
