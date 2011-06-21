Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103CFD45@nasanexd01a.na.qualcomm.com>
References: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
	<BANLkTi=FJ6=OxajrG=qqgSpYkx4=JMvJqQ@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103CFD45@nasanexd01a.na.qualcomm.com>
Date: Tue, 21 Jun 2011 10:43:13 +0300
Message-ID: <BANLkTim7fFz=6fy2wfV9FC41zTfeMfTvRg@mail.gmail.com>
Subject: Re: [PATCH obexd 06/14] Add protocol member to distinguish OBEX Protocol.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

On Tue, Jun 21, 2011 at 10:14 AM, Li, Nami <nami@qca.qualcomm.com> wrote:
> Hi, Luiz
>>IMO It should have been named transport instead of protocol, but I don't think it should be exposed in the service driver, actually the transport driver should be the one responsible for authorization.
>  Well, I think it named transport instead of protocol is really more suitable. Have you reviewed my patch 07/14? Cause I need to know transport type (RFCOMM or L2CAP) when set fd obex transport format (STREAM or SEQPACKET), so I add the member in service drive.

First lets get the OpenOBEX patches in so we have an idea how the API
will look like, then you can resend the patches so we can review and
figure out what is the best way to treat transport types.

-- 
Luiz Augusto von Dentz
