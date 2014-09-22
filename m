Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMLZPpDTQ7Kxv90j8SCdy1goZT6Na-rZS5NEhu2kWp9mg@mail.gmail.com>
References: <CACUGKYMLZPpDTQ7Kxv90j8SCdy1goZT6Na-rZS5NEhu2kWp9mg@mail.gmail.com>
Date: Mon, 22 Sep 2014 10:47:26 +0300
Message-ID: <CABBYNZLWFNmsht7N_jb7Qz2K4L8Mf5Spbc9HvP79_cctz5hCKA@mail.gmail.com>
Subject: Re: Action: Start playing a media item with at least 512 bytes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John

On Sat, Sep 20, 2014 at 12:12 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello guys,
>
> I got these PTS dialog box (TC_TG_RCR_BV_02_C and TC_TG_RCR_BV_04_C)
> but, I am not sure how to respond from my bluetooth device.
>
>
> Any idea?.

I suppose this one is AVRCP fragmentation test isn't it? You would
need to provide a metadata that is big enough, in Android case this
can be done with android/haltest and in D-Bus solution you can try
test/simple-player.

-- 
Luiz Augusto von Dentz
