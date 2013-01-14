Return-Path: <cyrus@holtmann.org>
Message-ID: <50F3D948.9010605@oss.bmw-carit.de>
Date: Mon, 14 Jan 2013 11:09:12 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/8] obexd: Handle empty path name in SetPath
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1357919757-10334-2-git-send-email-christian.fetzer@oss.bmw-carit.de> <CABBYNZKLNngQw6rSUUPJBapZ+rt7C4PsVajegFKwv6j+-8zvrg@mail.gmail.com>
In-Reply-To: <CABBYNZKLNngQw6rSUUPJBapZ+rt7C4PsVajegFKwv6j+-8zvrg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/13/2013 04:55 PM, Luiz Augusto von Dentz wrote:
> But what empty means in this case, I would like to stick with cd 
> behavior, so empty should set back to root. Otherwise the patchset 
> seems fine. -- Luiz Augusto von Dentz 
But this is exactly what the patch is doing.
g_obex_setpath called with an empty path won't set the parent flag,
and thus it requests going back to the root folder.

< ACL data: handle 21 flags 0x00 dlen 21
     L2CAP(d): cid 0x0041 len 17 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 32 pf 0 ilen 13 fcs 0xd8
         OBEX: SetPath cmd(f): len 13 flags 2 constants 0
         Connection ID (0xcb) = 98
         Name (0x01) = Unicode length 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 21 packets 1
 > ACL data: handle 21 flags 0x02 dlen 11
     L2CAP(d): cid 0x0041 len 7 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 32 pf 0 ilen 3 fcs 0x2
         OBEX: SetPath rsp(f): status 200 len 3

Or did I misunderstand you?

Regards,
Christian
