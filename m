Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 21 May 2012 15:51:12 +0200
Subject: RE: [PATCH Bluez v2 1/4] AVRCP: Register for VolumeChanged
 Notification
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B234A45A602@EXDCVYMBSTM005.EQ1STM.local>
References: <1336990615-24344-1-git-send-email-vani.patel@stericsson.com>
 <CABBYNZ+_AozCS3GD1Q19gZux-YrF-_Bh1udRW0D+MkNfYC4+SA@mail.gmail.com>
In-Reply-To: <CABBYNZ+_AozCS3GD1Q19gZux-YrF-_Bh1udRW0D+MkNfYC4+SA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >
> >  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
> > +void register_volume_notification ( struct avctp *session);
> > --
> > 1.7.5.4
> 
> I had to change it completely to make it work, Im afraid you never
> really tested this as it did not compile for me, were you using
> bootstrap-configure?
> 

The code is compiling perfectly at my end and I have tested it several times with PTS before pushing it. I follow below steps to compile my code - 

 autoreconf --install
./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --libexecdir=/lib
 make
 make install

I also compiled and tested my code using bootstrap-configure by following below steps.

./bootstrap
./bootstrap-configure
./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --libexecdir=/lib
make
make install

Had I known that you were facing compiling issues with my code earlier, I would have published the procedure how I have been compiling the code.
It would be really nice if you could point any issues with my procedure of compiling & testing the code, so that I can adapt to the correct procedure and follow for any future updates. 

> Anyway, I send a new series that should take care of subscribing to
> VolumeChanged event which should be working with Sony MW600.
> 
> Now the only part missing is to send SetAbsoluteVolume when the volume
> has changed on our side.

> --
> Luiz Augusto von Dentz

Thanks & Regards,
Vani Patel
