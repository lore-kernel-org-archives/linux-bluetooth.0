Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Solve compilation warning usin gcc 4.5.0
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<santoscadenas@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <201008111517.07434.santoscadenas@gmail.com>
References: <1281517766-5612-1-git-send-email-santoscadenas@gmail.com>
	 <20100811124942.GA12156@jh-x301>
	 <201008111517.07434.santoscadenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 09:40:44 -0400
Message-ID: <1281534044.12579.238.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

> I have also experienced more warnings, but I don't know what's the best way to 
> solve it because they are related to gstreamer and I'm not familiar with it. I 
> attach them in case anyone can solve them or help me showing the best way to 
> solve do it.
> 
>   CC     audio/audio_libgstbluetooth_la-gstsbcenc.lo
> audio/gstsbcenc.c:138:1: warning: no previous declaration for 
> 'gst_sbc_enc_get_type'
>   CC     audio/audio_libgstbluetooth_la-gstsbcdec.lo
> audio/gstsbcdec.c:37:1: warning: no previous declaration for 
> 'gst_sbc_dec_get_type'
>   CC     audio/audio_libgstbluetooth_la-gstsbcparse.lo
> audio/gstsbcparse.c:37:1: warning: no previous declaration for 
> 'gst_sbc_parse_get_type'
>   CC     audio/audio_libgstbluetooth_la-gstavdtpsink.lo
> audio/gstavdtpsink.c:82:1: warning: no previous declaration for 
> 'gst_avdtp_sink_get_type'
>   CC     audio/audio_libgstbluetooth_la-gsta2dpsink.lo
> audio/gsta2dpsink.c:50:1: warning: no previous declaration for 
> 'gst_a2dp_sink_get_type'
>   CC     audio/audio_libgstbluetooth_la-gstsbcutil.lo
>   CC     audio/audio_libgstbluetooth_la-gstrtpsbcpay.lo
> audio/gstrtpsbcpay.c:70:1: warning: no previous declaration for 
> 'gst_rtp_sbc_pay_get_type'
>   CC     audio/audio_libgstbluetooth_la-ipc.lo
> 
> 
> Looking to the code, the problem seems to be in this macro:
> GST_BOILERPLATE
> 
> http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-
> GstUtils.html#GST-BOILERPLATE:CAPS
> 
> As I said I don't have previous experience with gstreamer and I don't know if 
> it is a good idea to declare the "get_type" function previously.

this is GStreamer type generation being utterly stupid. Either way
around it will produce a warning. It added #pragma magic to keep the
warning, but not failing the build. However we might need to turn around
and change that the warning only shows up with old compilers.

Regards

Marcel


