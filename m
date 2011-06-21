Return-Path: <cyrus@holtmann.org>
From: "Li, Nami" <nami@qca.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH obexd 06/14] Add protocol member to distinguish OBEX
 Protocol.
Date: Tue, 21 Jun 2011 07:14:50 +0000
Message-ID: <EC94610F2568494D8D9291885C48D3103CFD45@nasanexd01a.na.qualcomm.com>
References: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
 <BANLkTi=FJ6=OxajrG=qqgSpYkx4=JMvJqQ@mail.gmail.com>
In-Reply-To: <BANLkTi=FJ6=OxajrG=qqgSpYkx4=JMvJqQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz
>IMO It should have been named transport instead of protocol, but I don't think it should be exposed in the service driver, actually the transport driver should be the one responsible for authorization.
 Well, I think it named transport instead of protocol is really more suitable. Have you reviewed my patch 07/14? Cause I need to know transport type (RFCOMM or L2CAP) when set fd obex transport format (STREAM or SEQPACKET), so I add the member in service drive.

Thanks.
Nami

