Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CA1B272
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqCPlJwx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cba988d6bso1449063a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704298121; x=1704902921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrrG9TEgcVtYhVJwHCIKYyhMwKw9zp2+lWynoAo3BJg=;
        b=dqCPlJwxAqtj7cP4A5V7IC9MlTFC9aPwZ1Zerrw5Thxvv6eaBa6oP47eEQFQGS1OUb
         V5VjOFSO3Yi/2YwDFV5Yh0TwfnxPgikoGFmTcfQ5Wc1L+1GjvtrHBVY22npIg8cITKDT
         bZq+Go7l7dMZnTNmuRC8xwa3rL3GhbhMD5s+IRDKAzzQAp3aopFj5xFeQORPobb+ZIzl
         mK/4KY0PWeEoubDmcyc4n+gw7F+MsmixyR09sGghY9bJC7+jxIZvTurKKYFxrzpfR1Ew
         A9SO1skrM/7P/200+1crlWY/mmpTgzaWQG3PF7gvA3wPvLP3g7cTN9AfuczPp2WuLKrG
         Zs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298121; x=1704902921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrrG9TEgcVtYhVJwHCIKYyhMwKw9zp2+lWynoAo3BJg=;
        b=kytAaQXdKAIqitUG4OrXke8mXrHgr5ol0cb1mQWqE+o8nG/ucPPp0T8/p+Rj5kJ0UD
         kIO4qDRGO0vFpM9Rx6oNZSToXE6GJEEgts+PYsG0f2hE5eASjUilS2wnfhiY8I3ee4GE
         G7FOMY1gvVrKnlT5mHMvPmeZEFB0lsRbV+AaPG0vqSFwF+CY0T952l0BH5ybN0iz5oY7
         HGGKWRnFwgZ36g2yfaqtj7qI5qM/PJFPo4TYSUXRQfsIh5VdlvLn/2EnYx5eBsjv1wDN
         lk/PDxm+MA0rIdKCw+QNSBmTHlR88uF2QEqxX8TsW3QbGfL+9rZq1ceLVxJ7FUBR6w/2
         zJ1w==
X-Gm-Message-State: AOJu0Yw/I6PLQi8L5elWjG4tSq4zUV9hR9fXQVXwZ9wy2EnMqV4QV+WZ
	xfuTcx8RQmrB8UfAqMQVidg/bGSrHRbmtUPlRr6o1fga
X-Google-Smtp-Source: AGHT+IHRfMsM/iQCNdfJoxUAqsgwfyvSVvBrH1hKCyiiEVXtYsOMyv9xztOa8eCROmWRIbQ9taOJOdGamJb+ZIJLNFE=
X-Received: by 2002:a17:90a:da04:b0:28c:3b9c:13ab with SMTP id
 e4-20020a17090ada0400b0028c3b9c13abmr4875071pjv.31.1704298120682; Wed, 03 Jan
 2024 08:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85bf602dac47b63cfc5ec772fddcedbce29c13df.camel@interlinx.bc.ca> <548cbe00abc60f0506dbc47802bddd276c192205.camel@interlinx.bc.ca>
In-Reply-To: <548cbe00abc60f0506dbc47802bddd276c192205.camel@interlinx.bc.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 11:08:23 -0500
Message-ID: <CABBYNZKS0BZGRZ8NMjue91i_P3mtQSL=ctLDcHDiZ+BBcXL2Aw@mail.gmail.com>
Subject: Re: Unable to connect BT mouse after it drops: Failed to connect:
 org.bluez.Error.Failed br-connection-create-socket
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Jan 3, 2024 at 9:17=E2=80=AFAM Brian J. Murrell <brian@interlinx.bc=
.ca> wrote:
>
> Does anyone have any idea how I can supply enough info to resolve this?
>
> Every morning I have to unplug/replug my USB dongle and then open the
> BT settings an reconnect my mouse.  It's getting very old and tiring.
>
> I'd be more than happy to supply whatever kind of debug info is
> necessary to get to a resolution on this.
>
> My previous USB BT dongle did not have this problem at all.  But it
> also didn't have BLE support which I now need.
>
> Is btmon output useful here or some kind of driver or userspace debug
> enabled, etc.
>
> Any ideas?
>
> Cheers,
> b.
>
> On Wed, 2023-12-27 at 16:02 -0500, Brian J. Murrell wrote:
> > I have a:
> >
> > Bus 003 Device 029: ID 0bda:8771 Realtek Semiconductor Corp.
> > [unknown]
> >
> > BT adapter.  When I first plug it in I am able to connect my:
> >
> > Device 34:88:5D:56:A8:C1 Bluetooth Mouse M557
> >
> > But after some yet unknown amount of time, on the order of a day or
> > so,
> > the mouse becomes disconnected and won't reconnect:
> >
> > [bluetooth]# connect 34:88:5D:56:A8:C1
> > Attempting to connect to 34:88:5D:56:A8:C1
> > [bluetooth]# Failed to connect: org.bluez.Error.Failed br-connection-
> > create-socket
> >
> > When the above happens the journal logs:
> >
> > Dec 27 15:47:17 pc.interlinx.bc.ca bluetoothd[3754244]:
> > profiles/input/device.c:ioctl_is_connected() Can't get HIDP
> > connection info
> > Dec 27 15:47:22 pc.interlinx.bc.ca bluetoothd[3754244]:
> > profiles/input/device.c:control_connect_cb() connect to
> > 34:88:5D:56:A8:C1: Host is down (112)

This usually means the device cannot be found, we receive a page
timeout, so Im not really sure why replugging would have fixed it,
could you please collect the HCI trace using btmon when that happens
so we can inspect the error it is returning.

> > If I simply unplug/plug-in the adapter then try to connect using the
> > GNOME Bluetooth control it will reconnect.
> >
> > It will stay connected for a period of time when it will drop and
> > then
> > I have to start this palaver all over again.
> >
> > The question is what is needed to be able to debug why bluez gets
> > into
> > this state with this adapter?
> >
> > Cheers,
> > b.
> >
>


--=20
Luiz Augusto von Dentz
