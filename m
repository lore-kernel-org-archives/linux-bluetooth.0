Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4CA1C01A.3040403@comarch.com>
References: <4CA1C01A.3040403@comarch.com>
Date: Tue, 28 Sep 2010 14:25:24 +0300
Message-ID: <AANLkTinV-E_GOw1ppN5WJ+KzOvgnY-tiAABLWvZ91ANg@mail.gmail.com>
Subject: Re: How to send stream via obexd without ending request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Pawlik <lukasz.pawlik@comarch.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Sep 28, 2010 at 1:14 PM, Lukasz Pawlik
<lukasz.pawlik@comarch.com> wrote:
> Hi,
>
> I want to stream data immediately after they appear and wait for next part.
> So far I didn't manage to find a way how to do this properly. Returning
> error EAGAIN from my read function leads to canceling request and this is
> something I don't want to do. The other way I was able to find is returning
> value > 0 from read function until last part of data appear. Obexd will
> stream data when buffer exceed allocated memory chunk and return to read
> more data. This is no solution because it forces obexd to send empty
> streams. Does anyone knows how to solve this problem ?

You should probably handle -EAGAIN to handle_async_io in src/obex.c,
so that it doesn't cancel the request for this specific error, also it
should return TRUE so that the callback doesn't get automatically
unregistered.

-- 
Luiz Augusto von Dentz
Computer Engineer
