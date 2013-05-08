Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 May 2013 10:26:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: Short names on Extended Inquiry Result
Message-ID: <20130508072612.GD9401@x220>
References: <CAGd9gwjaECWWRE+Ux4XenbUO9L-QSsjnP6wLHEvH5q3sasWWkg@mail.gmail.com>
 <CAGd9gwj=79xKJ0Mdb1eb+a5MDGtG1a3BcC8utfDad1ZLzhfd5A@mail.gmail.com>
 <CAE6HaM=cTHJkVKLCdUUD3oHgOFnGYGuVPwD=LSj4iL4U17vE6g@mail.gmail.com>
 <CAGd9gwiyUaedR6EOMOhpw64iA=_jkM+v08QsNJUteg_d+2mvmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwiyUaedR6EOMOhpw64iA=_jkM+v08QsNJUteg_d+2mvmg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, May 06, 2013, Alex Deymo wrote:
> I though about several options and finally choose tho consider the
> short name as an unknown name and thus calling the confirm_name() with
> known_name in FALSE, but also report the device with the short name,
> while we ask for the long name.
> 
> This has the advantage of sending the device found signal earlier, but
> may have a problem in the following scenario:
> 1. We have a first call to update_found_devices() with a short name
> and report it to the user.
> 2. We request the full name.
> 3. The device doesn't reply to this request (for any reason)
> 4. We get a second call to update_found_devices() with a short name...
> but since we already know "a name" we don't request the long name.
> 
> To avoid this I think the best should be to include the name_complete
> field in the struct btd_device together with the name. What do you
> think?

I'm not completely sure about this. In theory you could have a (broken
or malicious) device with page scan disabled but inquiry scan enabled
and such a device would be causing us to block all other baseband
activity while we wait for a page timeout to happen each time we request
its name. Since we anyway re-request the name when connecting this might
not be worth it.

Johan
