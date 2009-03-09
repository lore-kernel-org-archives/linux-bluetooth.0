Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Mar 2009 15:04:59 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Broken SDP parsing?
Message-ID: <20090309174644.GA4340@jh-x301>
References: <1236301226.3602.2314.camel@cookie.hadess.net> <1236523586.16880.141.camel@cookie.hadess.net> <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com> <1236608040.16880.1580.camel@cookie.hadess.net> <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com> <1236612318.16880.1656.camel@cookie.hadess.net> <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com> <1236618579.32264.23.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236618579.32264.23.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Mar 09, 2009, Bastien Nocera wrote:
> On Mon, 2009-03-09 at 13:40 -0300, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> > 
> > On Mon, Mar 9, 2009 at 12:25 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > > On Mon, 2009-03-09 at 11:32 -0300, Luiz Augusto von Dentz wrote:
> > > Problem was sdp_data_alloc() falling back to doing an strlen() on the
> > > string, instead of taking its existing length into account. That would
> > > break any strings with NULLs embedded.
> > >
> > > The attached patch fixes this. I'm not certain that making this public
> > > is useful, but feel free to make it so if you feel it's needed.
> > >
> > > Cheers
> > >
> > 
> > Sounds good to me, I will check with Marcel or Johan if they can get
> > this changes upstream.
> 
> Apparently &#00; isn't an allowed character in XML, so the attached
> patch just swaps it out for a space. Much easier.

Thanks for the patches! Could you still fix a couple of coding syle
issues please:

1. Keep the lines max 79 characters
2. Have the new function start like:
{
        sdp_data_t *d;

        d = sdp_data_alloc_with_length(dtd, value, len);
        if (!d)
                return -1;

Also, please prepare the patches with git format-patch so that I don't
have to play with GIT_AUTHOR_NAME, commit messages, etc. but can use
simply git am.

Johan
