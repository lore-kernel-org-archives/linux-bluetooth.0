Return-Path: <cyrus@holtmann.org>
Message-ID: <1384172013.1898.5.camel@nuvo>
Subject: Re: [PATCH 1/3] gdbus: Don't try to remove removed sources
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Nov 2013 13:13:33 +0100
In-Reply-To: <CABBYNZKWPY2UMOuexvPMHKpiJJ8efgA_xxWOU1yXV_d6LKy9=g@mail.gmail.com>
References: <1384016577.3880.36.camel@nuvo> <1384016658.3880.39.camel@nuvo>
	 <CABBYNZKWPY2UMOuexvPMHKpiJJ8efgA_xxWOU1yXV_d6LKy9=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2013-11-11 at 11:32 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Sat, Nov 9, 2013 at 7:04 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Sat, 2013-11-09 at 18:02 +0100, Bastien Nocera wrote:
> >> When we return FALSE from idle handlers, the source is removed.
> >> This will be causing warnings in glib 2.40.
> >>
> >> See https://bugzilla.gnome.org/show_bug.cgi?id=710724
> >
> > Note that there's plenty of other places where this should be fixed.
> > I'll leave those up to somebody who doesn't get RSI ;)
> 
> Btw, did you really got a problem or was just by looking at the code?
> process_changes always call remove_pending so perhaps the problem was
> just in generic_unregister, so the change to process_changes was not
> really necessary.

I really had the problem, and the patch fixed it. Resetting the id for
idle callbacks and timeouts needs to happen at the end of each callback
function, or you might be trying to remove an invalid source ID.

