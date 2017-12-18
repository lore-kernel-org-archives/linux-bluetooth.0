Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1513595365.28597.5.camel@hadess.net>
References: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net> <1513595365.28597.5.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Dec 2017 14:12:00 -0200
Message-ID: <CABBYNZ+VCbK_hb95BZyJpmkcvm8bA7Uy+Q4HOjhawrgeaD7YFw@mail.gmail.com>
Subject: Re: Setting a static pin to allow pairing
To: Bastien Nocera <hadess@hadess.net>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Dec 18, 2017 at 9:09 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2017-12-18 at 11:28 +0100, Roy Sigurd Karlsbakk wrote:
>> Hi all
>>
>> I'm trying to setup a raspberry pi as a bluetooth host allowing
>> pairing from a phone, but with a predefined pincode, and I can't find
>> any docs on how to do this. I find some on how to do this
>> interactively, but then, this isn't meant to be used like that, more
>> like a "blackbox". I've tried to google this quite a bit and reading
>> the docs, but I can't find much. Any idea how to do this?
>
> You can use bluez-tools:
> https://github.com/khvzak/bluez-tools
>
> (it's packaged for Debian as well, make sure you have a new enough
> version to avoid crashes)
>
> This is an example use:
> https://github.com/hadess/CHIP-bluetooth-speaker/blob/master/setup.sh#L73

Thats is rather old, and we did have incorporated a lot of the
features in these tools into bluetoothctl, obexctl, etc.

-- 
Luiz Augusto von Dentz
