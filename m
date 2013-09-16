Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2389837.qqrqTJ68od@uw000953>
References: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
	<1379071852-10094-4-git-send-email-szymon.janc@tieto.com>
	<B531A8F3-8ABA-4CD1-A013-AB0AFF40302C@holtmann.org>
	<2389837.qqrqTJ68od@uw000953>
Date: Mon, 16 Sep 2013 15:04:04 +0300
Message-ID: <CABBYNZ+hUzpvZsNN6rDSo0jezA80L_qYW0=BjaP_R2q8B87iug@mail.gmail.com>
Subject: Re: [PATCH 4/8] sdp: Decouple Device ID profile implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Sep 16, 2013 at 2:10 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Marcel,
>
>> > Make DeviceID profile similar to other profiles implementations. Use
>> > btd_profile for handling DeviceID profile while adding/removing
>> > adapters. The nice drawback is that SDP code no longer depends on
>> > main_opts.
>> > ---
>> > Makefile.plugins             |   3 +
>> > profiles/deviceid/deviceid.c | 181 +++++++++++++++++++++++++++++++++++++++++++
>> > src/sdpd-server.c            |   4 -
>> > src/sdpd-service.c           |  58 --------------
>> > src/sdpd.h                   |   2 -
>> > 5 files changed, 184 insertions(+), 64 deletions(-)
>> > create mode 100644 profiles/deviceid/deviceid.c
>> >
>> > diff --git a/Makefile.plugins b/Makefile.plugins
>> > index 7c5f71d..df5d2a1 100644
>> > --- a/Makefile.plugins
>> > +++ b/Makefile.plugins
>> > @@ -82,6 +82,9 @@ builtin_sources += profiles/scanparam/scan.c
>> > builtin_modules += deviceinfo
>> > builtin_sources += profiles/deviceinfo/deviceinfo.c
>> >
>> > +builtin_modules += deviceid
>> > +builtin_sources += profiles/deviceid/deviceid.c
>> > +
>>
>> this is changing the semantics a little bit. Device Id record is guaranteed
>> to have 0x10000 handle. I would prefer if we can keep it that way.
>
> Why? There is no such requirement in spec (is it?), and this is just another
> profile so not sure why would you like to treat it in special way. (Also if one
> disable deviceid other profiles might get 0x10000 handle.)
>
> If that is really needed we could still have a plugin, just with high prio so
> that it init is called first and then use insert instead of add record when
> probing adapters.
>
>> Also we need to find a way to make this work with the extended inquiry
>> response that can also included device id information.
>
> Currently deviceid info is in main_opts and is handled from many places.
> We could remove this from main_opts and put all the logic (config reading,
> default values etc) to deviceid plugin and let it set proper values for
> adapters.

I would prefer to stick with core managing the main.conf and then have
an API to which the plugins can access it, iirc that how connman deals
with plugins accessing information in the conf file.


-- 
Luiz Augusto von Dentz
