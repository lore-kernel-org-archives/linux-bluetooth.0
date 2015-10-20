Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2015 09:51:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] core/device: Fix build on some platforms
Message-ID: <20151020065100.GA31695@t440s.lan>
References: <1445296472-2276-1-git-send-email-jpawlowski@google.com>
 <20151020053510.GA29126@t440s.P-661HNU-F1>
 <CAD0=r8zA7SToebaN8_T=Mae6+9Ay1KTs2fuF8-+HXxLtytRS2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8zA7SToebaN8_T=Mae6+9Ay1KTs2fuF8-+HXxLtytRS2g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Oct 19, 2015, Jakub Pawlowski wrote:
> On Mon, Oct 19, 2015 at 10:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Jakub,
> >
> > On Mon, Oct 19, 2015, Jakub Pawlowski wrote:
> >> due to type promotions in C this code was failing on some platforms.
> >>
> >> src/device.c:2016:8: error: format specifies type 'unsigned short' but the
> >>       argument has type 'uint8_t' (aka 'unsigned char') [-Werror,-Wformat]
> >>   properties, uuid_str);
> >>   ^~~~~~~~~~
> >> /build/falco/usr/include/bits/stdio2.h:39:7: note: expanded from macro 'sprintf'
> >>                            __VA_ARGS__)
> >>                            ^
> >> ---
> >>  src/device.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/src/device.c b/src/device.c
> >> index 0d3a655..b4e6d53 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -2015,7 +2015,7 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
> >>
> >>       sprintf(handle, "%04hx", handle_num);
> >>       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >> -     sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", value_handle,
> >> +     sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02x:%s", value_handle,
> >>                                                       properties, uuid_str);
> >
> > Wouldn't the right format specifier be %hhx in this case?
> 
> So it was compiling fine on my machine, but when it was compiling for
> all possible platforms for ChromeOS those errors came up.
> The very proper thing would be probably to use "PRIu8" from <inttypes.h>
> but then I found good explanation:
> 
> ""printf() is a variadic function. Its optional arguments( and only
> those ) get promoted according to default argument promotions(
> 6.5.2.2. p6 ).
> 
> Since you are asking for integers, integer promotions are applied in
> this case, and types you mention get promoted to int. ( and not
> unsigned int because C )""
> source: http://stackoverflow.com/questions/26362386/why-is-the-format-specifier-for-uint8-t-and-uint16-t-the-same-u
> 
> so I understand that this uint8_t will get promoted to int, and
> displayed properly.
> I manually tested it for 0, 127, and 255 and looks like it's
> formatting just fine.

It's a bit unclear from your answer: do you still get warnings/errors
with %hhx or not? Looking at the warning you got:

"argument has type 'uint8_t' (aka 'unsigned char')"

and the printf(3):

"hh  A following integer conversion corresponds to a signed char or
unsigned char argument"

It'd still seem like %hhx shouldn't give a warning. Even though %x might
work too being able to be more specific in the type specification
doesn't seem like a bad thing.

Johan
