Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Mar 2012 03:34:15 +0200
From: Ido Yariv <ido@wizery.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Storage: Fix a buffer overflow in write_link_key
Message-ID: <20120306013415.GA14021@WorkStation>
References: <1330971151-11075-1-git-send-email-ido@wizery.com>
 <20120305200129.GA17773@x220.ice.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120305200129.GA17773@x220.ice.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Mar 05, 2012 at 12:01:29PM -0800, Johan Hedberg wrote:
> Hi Ido,
> 
> On Mon, Mar 05, 2012, Ido Yariv wrote:
> > The temporary string allocated on the stack is not large enough in worst
> > case. To be on the safe side, increase it to 64 bytes.
> > 
> > Signed-off-by: Ido Yariv <ido@wizery.com>
> > ---
> >  src/storage.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/src/storage.c b/src/storage.c
> > index a65cee4..7e7f081 100644
> > --- a/src/storage.c
> > +++ b/src/storage.c
> > @@ -533,7 +533,7 @@ int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
> >  
> >  int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length)
> >  {
> > -	char filename[PATH_MAX + 1], addr[18], str[38];
> > +	char filename[PATH_MAX + 1], addr[18], str[64];
> >  	int i;
> 
> I don't really see how the worst case you mention could ever happen in
> practice. The key type requires one byte and 16 is the maximum for the
> PIN length. Is there something I'm missing?

Thanks for looking into this.

I might have used an old/modified version when I first encountered this.
When I did, the type was actually above 128 (SMP), which ended up taking
3 bytes. As a result, the buffer was overflown.

I'm not sure this can actually happen with the current code, with LTKs
being stored in a separate file. It's probably still safer to allocate
enough space just in case, but it's not essential.

Thanks,
Ido.
