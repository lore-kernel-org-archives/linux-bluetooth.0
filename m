Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 11:42:01 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v0 03/16] client: Add progress property to transfer
Message-ID: <20120524144201.GA10754@samus>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1337785218-8661-4-git-send-email-mikel.astiz.oss@gmail.com>
 <20120523174016.GA32263@samus>
 <CABBYNZLms7f_+85rPROq+pfgXMR3vMnc6pZv_9_2LY5HpzckZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZLms7f_+85rPROq+pfgXMR3vMnc6pZv_9_2LY5HpzckZQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11:25 Thu 24 May, Luiz Augusto von Dentz wrote:
> Hi Vinicius, Mikel,
> 
> On Wed, May 23, 2012 at 8:40 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > Hi Mikel,
> >
> > On 17:00 Wed 23 May, Mikel Astiz wrote:
> >> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >>
> >> The number of transferred bytes is exposed in D-Bus using a specific
> >> property for this purpose.
> >>
> >> Internally, the value of this property does not necessarily match the
> >> internal progress counter. In order to avoid D-Bus overhead, the
> >> property will be updated at least every N bytes, where N is fixed and
> >> hardcoded (TRANSFER_PROGRESS_PERIOD).
> >> ---
> >>  client/transfer.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>  1 files changed, 45 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/client/transfer.c b/client/transfer.c
> >> index 8292265..2c6e1ed 100644
> >> --- a/client/transfer.c
> >> +++ b/client/transfer.c
> >> @@ -44,6 +44,7 @@
> >>
> >>  #define TRANSFER_INTERFACE  "org.openobex.Transfer"
> >>  #define TRANSFER_BASEPATH   "/org/openobex"
> >> +#define TRANSFER_PROGRESS_PERIOD (16 * 1024)
> >
> > Just a detail, but this value is half the value of the default Bluetooth
> > MTU, right?
> >
> > For a future improvement, I think it would be nice to consider a value
> > related to the MTU.
> 
> Actually I would rather do it time based, send progress once per
> second, since with high speed this may spam the bus anyway.

Yeah, that would be even better :-)

> 
> 
> -- 
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
