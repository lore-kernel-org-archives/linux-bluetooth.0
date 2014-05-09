Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 11:07:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 04/12] android/handsfree: Add SCO Audio IPC
Message-ID: <20140509080703.GC23010@aemeltch-MOBL1>
References: <1399551937-27109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJZAg33U_QpkeD80xBQj-cH3qTY6we6-O+A6D47x76Y6Q@mail.gmail.com>
 <20140509073725.GB23010@aemeltch-MOBL1>
 <1493986.xzIdKIrlLQ@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493986.xzIdKIrlLQ@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, May 09, 2014 at 10:02:11AM +0200, Szymon Janc wrote:
> Hi,
> 
> On Friday 09 of May 2014 10:37:27 Andrei Emeltchenko wrote:
> > Hi Luiz,
> > 
> > On Thu, May 08, 2014 at 04:22:35PM +0300, Luiz Augusto von Dentz wrote:
> > > >  static bool connect_sco(void)
> > > > @@ -904,7 +930,7 @@ static bool connect_sco(void)
> > > >                                 device.negotiated_codec != CODEC_ID_CVSD)
> > > >                 voice_settings = BT_VOICE_TRANSPARENT;
> > > >         else
> > > > -               voice_settings = BT_VOICE_CVSD_16BIT;
> > > > +               voice_settings = 0;
> > > 
> > > What is the reason for changing this value to 0?
> > 
> > Otherwise we always call setsockopt which fails in old kernels.
> > 
> > in sco_set():
> > 	if (!voice)
> > 		return TRUE;
> > 
> > 	bt_voice.setting = voice;
> > 	if (setsockopt(sock, SOL_BLUETOOTH, BT_VOICE, &bt_voice,
> > 						sizeof(bt_voice)) < 0) {
> > 		ERROR_FAILED(err, "setsockopt(BT_VOICE)", errno);
> > 		return FALSE;
> > 	}
> 
> Mgmt 1.3 is already required by Android bluetoothd (kernel 3.9+) and most
> likely this dependency will be bumped to 1.4 or 1.5. So I wouldn't worry much
> about older kernels.

The reason I add this patch was not because I specially like old kernels
but because this is real use case. What is the default kernel for Android
4.4?

Best regards 
Andrei Emeltchenko 
