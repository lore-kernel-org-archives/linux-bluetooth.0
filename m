Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4a221c10908140352x4e017608t587ad61388cd83cb@mail.gmail.com>
References: <4A82B32E.3020903@gmail.com>
	 <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
	 <4a221c10908120710y1ad31540ib5b16f27d2af4751@mail.gmail.com>
	 <2d5a2c100908131010r7b077b49i4c495d864cae6667@mail.gmail.com>
	 <4a221c10908140352x4e017608t587ad61388cd83cb@mail.gmail.com>
Date: Fri, 14 Aug 2009 09:51:38 -0300
Message-ID: <2d5a2c100908140551s77eb8655s6251c49c735778b6@mail.gmail.com>
Subject: Re: NAP/GN with bluez-4
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Dmitry A. Yanko" <y.dmitry@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 14, 2009 at 7:52 AM, Dmitry A. Yanko<y.dmitry@gmail.com> wrote:
> Look 'local.txt' file here: http://www.cross-road.org.ua/bttests/
> hcidump output also available (with 'simple-service' script started,
> when remote device can see 1 service, and without, when no services
> shown at all). And also dump from windows box (NAP enabled), for
> comparison.
>
> --
> #include <regards.h>
>

It seems the service is registered:

Service Name: BlueZ NAP service
Service Description: BlueZ PAN service
Service RecHandle: 0x10007
Service Class ID List:
  "Network Access Point" (0x1116)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ16: 800 806
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Network Access Point" (0x1116)
    Version: 0x0100

The dump doesn't seems to contain it and I don't see any attempt to
retrieve it, so I'm staring to believe it is the remote device fault,
also this looks suspicious:

2009-08-12 13:33:29.014953 > ACL data: handle 1 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0350278f-3dca-4e62-831d-a41165ff906c
          max 4088
          aid(s) 0x0000 - 0xffff
          cont 00
2009-08-12 13:33:29.015025 < ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0305 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00

This is the only time it attempt to retrieve a record which doesn't
use bluetooth base, also note that there is no attempt to retrieve
0x1116 which would return NAP record so I don't think your device is
really capable to use NAP service or it depend on the record from
0350278f-3dca-4e62-831d-a41165ff906c.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
