Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 25 Jun 2009 05:33:32 +0200
Subject: RE: Mixed Results Playing mp3
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06B65D57@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com>
 <4A42056D.90600@wowway.com>
 <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
 <4A42C1F2.9040808@wowway.com>
In-Reply-To: <4A42C1F2.9040808@wowway.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: John R. [mailto:johnr@wowway.com]
Sent: 25 June, 2009 04:17
To: John Frankish
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Mixed Results Playing mp3

John Frankish wrote:

> Does your mpg123 support alsa?
>
>> yes, it plays mp3 without problems via the machine's sound card

It could be that mpg123 is using OSS and not ALSA directly.  Make sure
ALSA is being used.

> Thanks - I used "-o alsa" to verify alsa was being used, the result is the same.

This could also be totally unrelated.

John
