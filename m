Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Solve compilation warning usin gcc 4.5.0
Date: Wed, 11 Aug 2010 15:17:07 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1281517766-5612-1-git-send-email-santoscadenas@gmail.com> <20100811124942.GA12156@jh-x301>
In-Reply-To: <20100811124942.GA12156@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008111517.07434.santoscadenas@gmail.com>
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
> 
> Johan

I have also experienced more warnings, but I don't know what's the best way to 
solve it because they are related to gstreamer and I'm not familiar with it. I 
attach them in case anyone can solve them or help me showing the best way to 
solve do it.

  CC     audio/audio_libgstbluetooth_la-gstsbcenc.lo
audio/gstsbcenc.c:138:1: warning: no previous declaration for 
'gst_sbc_enc_get_type'
  CC     audio/audio_libgstbluetooth_la-gstsbcdec.lo
audio/gstsbcdec.c:37:1: warning: no previous declaration for 
'gst_sbc_dec_get_type'
  CC     audio/audio_libgstbluetooth_la-gstsbcparse.lo
audio/gstsbcparse.c:37:1: warning: no previous declaration for 
'gst_sbc_parse_get_type'
  CC     audio/audio_libgstbluetooth_la-gstavdtpsink.lo
audio/gstavdtpsink.c:82:1: warning: no previous declaration for 
'gst_avdtp_sink_get_type'
  CC     audio/audio_libgstbluetooth_la-gsta2dpsink.lo
audio/gsta2dpsink.c:50:1: warning: no previous declaration for 
'gst_a2dp_sink_get_type'
  CC     audio/audio_libgstbluetooth_la-gstsbcutil.lo
  CC     audio/audio_libgstbluetooth_la-gstrtpsbcpay.lo
audio/gstrtpsbcpay.c:70:1: warning: no previous declaration for 
'gst_rtp_sbc_pay_get_type'
  CC     audio/audio_libgstbluetooth_la-ipc.lo


Looking to the code, the problem seems to be in this macro:
GST_BOILERPLATE

http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-
GstUtils.html#GST-BOILERPLATE:CAPS

As I said I don't have previous experience with gstreamer and I don't know if 
it is a good idea to declare the "get_type" function previously.


Regards.
