Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 17:00:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
Message-ID: <20131017140019.GA361@x220.p-661hnu-f1>
References: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org>
 <20131016203518.GA947@x220.p-661hnu-f1>
 <CAKT1EBcunESoPak7NhMmW6-r2n3QH8CyJgtg=9W3fXx6sjNmcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKT1EBcunESoPak7NhMmW6-r2n3QH8CyJgtg=9W3fXx6sjNmcg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Oct 17, 2013, Claudio Takahasi wrote:
> On Wed, Oct 16, 2013 at 5:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Claudio,
> >
> > On Wed, Oct 16, 2013, Claudio Takahasi wrote:
> >> Bluetooth kernel now restricts LE L2CAP sockets to ATT channels only.
> >> For LE L2CAP socket bind, ATT CID is now mandatory. Reference: kernel patch
> >> bfe4655f05d7ec4a7c0c1c7e4051862f824cd8ec
> >> ---
> >>  tools/l2test.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Applied thanks.
> >
> > Btw, I didn't realize that this check wasn't there before. It seems like
> > it shouldn't cause any "real life" issues as our btio has always done a
> > bind with the correct CID. Can you confirm that this should only be an
> > issue for l2test?
> >
> > Johan
> 
> Yes. btio calls bind with the correct CID.
> 
> I suspect that the is another issue in bt_io_connect() call inside
> device_browse_primary(),
> the source address type is missing (it is mandatory now). I will send
> a patch to fix it.

Good catch, though we'll likely need to fix this for the kernel too so
that we don't end up with a kernel release that breaks old user space
versions.

> At some point we need to infer the adapter address type instead of
> always use public address.

To be honest, selecting whether to use a random address when scanning or
advertising doesn't at least immediately strike me as something that
should be done through the bind call, but instead something that should
be a global setting for the entire adapter. Having the exact LE address
type in connect() makes sense, but not necessarily for bind().

Johan
