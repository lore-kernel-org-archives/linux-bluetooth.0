Return-Path: <cyrus@holtmann.org>
Message-ID: <1349426477.27233.44.camel@aeonflux>
Subject: Re: [PATCH 4/4] audio: Add check for non-a2dp codec
From: Marcel Holtmann <marcel@holtmann.org>
To: Chan-yeol Park <chanyeol.park@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	chanyeol.park@samsung.com, linux-bluetooth@vger.kernel.org
Date: Fri, 05 Oct 2012 10:41:17 +0200
In-Reply-To: <506E8AA5.7090709@gmail.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
	 <CABBYNZKHzKv+GQhynnGN04O17kwjDobwL-+CeVB9hJqrVEF05A@mail.gmail.com>
	 <506E8AA5.7090709@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> >   #define SBC_SAMPLING_FREQ_16000                (1 << 3)
> >   #define SBC_SAMPLING_FREQ_32000                (1 << 2)
> > @@ -114,3 +115,8 @@ typedef struct {
> >   #else
> >   #error "Unknown byte order"
> >   #endif
> > +
> > +typedef struct {
> > +       uint8_t vendor_id[4];
> > +       uint8_t codec_id[2];
> > +} __attribute__ ((packed)) non_a2dp_vendor_codec_t;
> > We normally don't typedef this type of structs, besides
> > a2dp_vendor_codec should be enough so this should be named struct
> > a2dp_vendor_codec.
> You're right. originally I didn't use typedef.
> but in order to achieve harmony in a2dp-codecs.h like sbc,mpeg, I've 
> changed it.
> 
> If you make decision about this, I will raise a second patch.

hold on for a second, is this the file that is shared with PulseAudio?

Regards

Marcel


