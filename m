Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 10:37:27 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 04/12] android/handsfree: Add SCO Audio IPC
Message-ID: <20140509073725.GB23010@aemeltch-MOBL1>
References: <1399551937-27109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399551937-27109-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJZAg33U_QpkeD80xBQj-cH3qTY6we6-O+A6D47x76Y6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJZAg33U_QpkeD80xBQj-cH3qTY6we6-O+A6D47x76Y6Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 08, 2014 at 04:22:35PM +0300, Luiz Augusto von Dentz wrote:
> >  static bool connect_sco(void)
> > @@ -904,7 +930,7 @@ static bool connect_sco(void)
> >                                 device.negotiated_codec != CODEC_ID_CVSD)
> >                 voice_settings = BT_VOICE_TRANSPARENT;
> >         else
> > -               voice_settings = BT_VOICE_CVSD_16BIT;
> > +               voice_settings = 0;
> 
> What is the reason for changing this value to 0?

Otherwise we always call setsockopt which fails in old kernels.

in sco_set():
	if (!voice)
		return TRUE;

	bt_voice.setting = voice;
	if (setsockopt(sock, SOL_BLUETOOTH, BT_VOICE, &bt_voice,
						sizeof(bt_voice)) < 0) {
		ERROR_FAILED(err, "setsockopt(BT_VOICE)", errno);
		return FALSE;
	}


Best regards 
Andrei Emeltchenko 

