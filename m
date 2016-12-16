Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACqzuK_EY6No+DSekZMqzRqNvNo9_=zpDOBvve26LwRz5JOuRA@mail.gmail.com>
References: <CACqzuK_EY6No+DSekZMqzRqNvNo9_=zpDOBvve26LwRz5JOuRA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Dec 2016 14:56:06 +0200
Message-ID: <CABBYNZKZCqxLqsbcmfcLJWjs0USR4GGXtq+W0w15xCsMK2-8=w@mail.gmail.com>
Subject: Re: How can Gatt server know the changed MTU after MTU exchange?
To: Edward Jo <tkv2357@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edward,

On Fri, Dec 16, 2016 at 12:12 PM, Edward Jo <tkv2357@gmail.com> wrote:
> Hi,
>
>  I tried to find the DBus API to get the negotiated MTU in doc of Bluez 5.43,
> but I couldn't.
>
>  I would like that Gatt server send the response data chunk in MTU size when
> client device sends 'Blob Read request' to GATT server.
>
>  Is there a way Gatt server to get the negotiated MTU? Perhaps, I'm missing
> something or misunderstanding.

The underline code already takes care of the negotiated MTU and it
truncates the response to fit into the response. In the other hand
what you might be after is the offset where the response shall start,
which is something that we apparently did not have support yet but it
should be easy to add.

-- 
Luiz Augusto von Dentz
