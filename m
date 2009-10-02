Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Oct 2009 11:26:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] misc fixups
Message-ID: <20091002092617.GB13444@jh-x301>
References: <200909251636.06774.sgrubb@redhat.com> <2d5a2c100909261529j700b78a6p12fdfc27f81f1015@mail.gmail.com> <200909281008.24999.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200909281008.24999.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 28, 2009, Steve Grubb wrote:
> On Saturday 26 September 2009 06:29:14 pm you wrote:
> > > The first is that in audio/pcm_bluetooth.c, a data structure is being
> > > overrun. Because the underlying buffer is 512 bytes, no overflow really
> > > occurs. What appears to happen is too much data gets copied.
> > >
> > > diff -urp bluez-4.54.orig/audio/pcm_bluetooth.c
> > > bluez-4.54/audio/pcm_bluetooth.c ---
> > > bluez-4.54.orig/audio/pcm_bluetooth.c       2009-09-25 11:33:47.000000000
> > > -0400 +++ bluez-4.54/audio/pcm_bluetooth.c    2009-09-25
> > > 14:35:35.000000000 -0400 @@ -729,7 +729,7 @@ static int
> > > bluetooth_a2dp_hw_params(snd_
> > >        req->h.length = sizeof(*req);
> > >
> > >        memcpy(&req->codec, &a2dp->sbc_capabilities,
> > > -                       sizeof(a2dp->sbc_capabilities));
> > > +                       sizeof(req->codec));
> > 
> > Be careful that this structs are different, we really want to copy sbc
> > codec capabilities which is used to configure latter.
> 
> OK, I see the uint8_t data[0] in codec_capabilities_t which usually means data
> to follow. Missed that. OK, the revised patch would just drop that.

This one is now also pushed upstream.

Johan
