Return-Path: <cyrus@holtmann.org>
Message-ID: <4A42C1F2.9040808@wowway.com>
Date: Wed, 24 Jun 2009 19:16:50 -0500
From: "John R." <johnr@wowway.com>
MIME-Version: 1.0
To: John Frankish <j-frankish@slb.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Mixed Results Playing mp3
References: <6AC5A55546F64545AE996F8200E3AC4E06B17B90@NL0105EXC01V01.eur.slb.com> <4A42056D.90600@wowway.com> <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06B1802D@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John Frankish wrote:

> Does your mpg123 support alsa?
> 
>> yes, it plays mp3 without problems via the machine's sound card

It could be that mpg123 is using OSS and not ALSA directly.  Make sure 
ALSA is being used.

This could also be totally unrelated.

John
