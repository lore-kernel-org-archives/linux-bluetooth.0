Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50F3D948.9010605@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1357919757-10334-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<CABBYNZKLNngQw6rSUUPJBapZ+rt7C4PsVajegFKwv6j+-8zvrg@mail.gmail.com>
	<50F3D948.9010605@oss.bmw-carit.de>
Date: Mon, 14 Jan 2013 19:33:03 +0200
Message-ID: <CABBYNZKJFcY0hCvBDeQw_mxiJUDvOg9VdHrbv_si70iW2chp8Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] obexd: Handle empty path name in SetPath
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Jan 14, 2013 at 12:09 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> Hi Luiz,
>
>
> On 01/13/2013 04:55 PM, Luiz Augusto von Dentz wrote:
>>
>> But what empty means in this case, I would like to stick with cd behavior,
>> so empty should set back to root. Otherwise the patchset seems fine. -- Luiz
>> Augusto von Dentz
>
> But this is exactly what the patch is doing.
> g_obex_setpath called with an empty path won't set the parent flag,
> and thus it requests going back to the root folder.
>
> < ACL data: handle 21 flags 0x00 dlen 21
>     L2CAP(d): cid 0x0041 len 17 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 32 pf 0 ilen 13 fcs 0xd8
>         OBEX: SetPath cmd(f): len 13 flags 2 constants 0
>         Connection ID (0xcb) = 98
>         Name (0x01) = Unicode length 0
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 21 packets 1
>> ACL data: handle 21 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 32 pf 0 ilen 3 fcs 0x2
>         OBEX: SetPath rsp(f): status 200 len 3
>
> Or did I misunderstand you?

I was just confirming this would not cd back to parent, anyway this
set is now upstream, thanks!

Btw, Ive modified a little bit patch 06/08 to use hexadecimal values
to indicate better the size.


--
Luiz Augusto von Dentz
