Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:27:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdptool: Clarify 'add' and 'remove' commands in manual
Message-ID: <20131014112700.GD26222@x220.p-661hnu-f1>
References: <1380006548-5011-1-git-send-email-szymon.janc@tieto.com>
 <3234061.FlIIUUDOzO@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3234061.FlIIUUDOzO@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 14, 2013, Szymon Janc wrote:
> > Adapters are no longer notified about external changes in SDP
> > database. This results in 'add' and 'remove' commands being
> > usefull only for SDP testing or qualification.
> > ---
> >  tools/sdptool.1 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/sdptool.1 b/tools/sdptool.1
> > index 88ad818..ea95933 100644
> > --- a/tools/sdptool.1
> > +++ b/tools/sdptool.1
> > @@ -91,9 +91,15 @@ the \fB--handle\fP option.
> >  .IP "" 10
> >  You can specify a channel to add the service on
> >  using the \fB--channel\fP option.
> > +.IP "" 10
> > +NOTE: Local adapters configuration will not be updated and this command should
> > +be used only for SDP testing.
> >  .IP "\fBdel record_handle\fP" 10
> >  Remove a service from the local
> >  SDP database.
> > +.IP "" 10
> > +NOTE: Local adapters configuration will not be updated and this command should
> > +be used only for SDP testing.
> >  .IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10
> >  Retrieve a service from the local
> >  SDP database.
> > 
> 
> ping

Applied now. Sorry for the delay.

Johan
