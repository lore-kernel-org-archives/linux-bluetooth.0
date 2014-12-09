Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141209080756.GA4214@t440s.lan>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
	<1418085655-7304-8-git-send-email-armansito@chromium.org>
	<20141209080756.GA4214@t440s.lan>
Date: Tue, 9 Dec 2014 05:12:02 -0800
Message-ID: <CAHrH25TMKQQFe0QejpRJ61Biy4PqXX5g_Gj01zid=AW8upMOrQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 07/15] core: device: Use bt_att_register_disconnect.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On Tue, Dec 9, 2014 at 12:07 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arman,
>
> On Mon, Dec 08, 2014, Arman Uguray wrote:
>> +     dev->att = bt_att_ref(g_attrib_get_att(attrib));
>
> I'd expect a function called "get" to return a new reference, so the
> extra ref() shouldn't be needed.
>

I see it mostly as a raw getter and adding ref semantics to it seems
confusing to me. Unless we call it g_attrib_get_att_ref or something
to that end.

> Btw, I hope this is just a temporary function that you've introduced to
> be able to do the conversions in smaller bits, and that it'll be removed
> as soon as the conversions are done?
>

Pretty much. Basically we have the old code work through the GAttrib
shim while the new code work directly through the bt_att that the
GAttrib is wrapping. Once all conversions are done, device won't need
to include any of the GAttrib code and this function can be removed.

Thanks,
Arman
