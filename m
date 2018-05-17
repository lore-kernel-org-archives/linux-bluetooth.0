Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
References: <20180514235614.25231-1-inga.stotland@intel.com>
 <C65C87C6-375D-46B1-8CB1-3C96EF9939E4@holtmann.org> <5b6349ba-e0dd-8b56-5654-c1e0e20be4a8@gmail.com>
In-Reply-To: <5b6349ba-e0dd-8b56-5654-c1e0e20be4a8@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 May 2018 11:01:58 +0300
Message-ID: <CABBYNZ+dmaLOTOJgYMoLS2jzWNZCqHYjVvcJsKYiFTgv1en-wg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-ell: Add support for ELL based IO handling
To: Denis Kenzior <denkenz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Stotland, Inga" <inga.stotland@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On Wed, May 16, 2018 at 5:42 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi,

> >> +
> >> +    do {
> >> +            ret = writev(fd, iov, iovcnt);
> >> +    } while (ret < 0 && errno == EINTR);
> >
> > explain this one to me. Or maybe Luiz should explain it since he
introduced this.
> >

> I'm curious why not use TEMP_FAILURE_RETRY macro?  ell already uses that
> for clarity.

Szymon was actually suggesting that we should have something similar in
ell, e.g. l_io_send, it would be nice if that would handle iovec similarly
to how is done here but perhaps using the TEMP_FAILURE_RETRY as suggested
by Denis.

-- 
Luiz Augusto von Dentz
