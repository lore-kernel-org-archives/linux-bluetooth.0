Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 11:14:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: Re: [PATCH] textfile: fix missing call to munmap in wite_key
Message-ID: <20120516081415.GA29073@x220>
References: <1336657428-14129-1-git-send-email-vishal.agarwal@stericsson.com>
 <CA+_sZW8tYxCyfKrc8_r0E+toOj=HQxfDWaQTY=ezmxd6Jtg+AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+_sZW8tYxCyfKrc8_r0E+toOj=HQxfDWaQTY=ezmxd6Jtg+AA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, May 16, 2012, vishal agarwal wrote:
> On 5/10/12, Vishal Agarwal <vishal.agarwal@stericsson.com> wrote:
> > In some cases it was possible that munmap is not called corresponding
> > to mmap, which might result in future read or writes to fail.
> > ---
> >  src/textfile.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/src/textfile.c b/src/textfile.c
> > index 2712cd8..9d88fbc 100644
> > --- a/src/textfile.c
> > +++ b/src/textfile.c
> > @@ -220,8 +220,8 @@ static int write_key(const char *pathname, const char
> > *key, const char *value, i
> >  	len = strlen(key);
> >  	off = find_key(map, size, key, len, icase);
> >  	if (!off) {
> > +		munmap(map, size);
> >  		if (value) {
> > -			munmap(map, size);
> >  			lseek(fd, size, SEEK_SET);
> >  			err = write_key_value(fd, key, value);
> >  		}
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Did you get a chance to look at it. Just to brief about the problem -
> If we try to pair unpair device many times then in certain conditions
> munmap is not called and after some times the mmap starts failing.
> which will result in nsuccessful pairing or unpairing.
> This patch fixes this issue.

Sorry, I did actually take a look at it and concluded it was correct,
but I forgot to apply it. The patch has been pushed upstream now.
Thanks.

Johan
