Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 12:57:37 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 00/14] Bluetooth: Change socket lock to l2cap_chan lock
Message-ID: <20120221105735.GC6118@aemeltch-MOBL1>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329748173.2172.0.camel@aeonflux>
 <20120220144453.GE27197@aemeltch-MOBL1>
 <CAA37ikaRSnvSYXgDDh7mviFwSC2Ex=XoDLQ8JfBfNwEgwTxBaQ@mail.gmail.com>
 <1329749594.2172.2.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329749594.2172.2.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Mon, Feb 20, 2012 at 03:53:14PM +0100, Marcel Holtmann wrote:
> > >> so what is the general status of this patch series. Are there still
> > >> concerns or opens? Or should it be go for final review and be merged?
> > >
> > > The code looks now good enough for final review.
> > 
> > Marcel, the code looks good for final review and merge. The only thing
> > concerns me is the change to chan->lock instead of sock lock seems to
> > be split too much. I mean that we have this change done in a series of
> > patches while it might be better to change everything at once. Not
> > sure if worrying about intermediate states here is something you care
> > or not, though, because I'm almost sure they'll be broken doing it in
> > small pieces.
> 
> I am fine either way at this point.

Then I send patches as is, if there is need to merge some patches this can
be easily done.

Best regards 
Andrei Emeltchenko 

