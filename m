Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Solve compilation warning usin gcc 4.5.0
Date: Wed, 11 Aug 2010 14:55:41 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1281517766-5612-1-git-send-email-santoscadenas@gmail.com> <20100811124942.GA12156@jh-x301>
In-Reply-To: <20100811124942.GA12156@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008111455.41381.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Wednesday 11 August 2010 14:49:42 Johan Hedberg escribió:
> Hi,
> 
> On Wed, Aug 11, 2010, Jose Antonio Santos Cadenas wrote:
> > ---
> > 
> >  audio/control.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/audio/control.c b/audio/control.c
> > index c8aba53..daa01ef 100644
> > --- a/audio/control.c
> > +++ b/audio/control.c
> > @@ -446,7 +446,7 @@ static void avctp_set_state(struct control *control,
> > avctp_state_t new_state)
> > 
> >  		avctp_disconnected(control->dev);
> > 
> > -		if (old_state != AVCTP_STATE_CONNECTED)
> > +		if (old_state != AVDTP_SESSION_STATE_CONNECTED)
> > 
> >  			break;
> >  		
> >  		value = FALSE;
> 
> That's the wrong fix to suppress the warning. The real problem is in the
> beginning of the function:
> 
> 	avdtp_session_state_t old_state = control->state;
> 
> Obviously that should be avctp_state_t and not avdtp. Do you
> want to send another patch to fix it?

Sure.
> 
> Johan
