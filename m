Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960809191823h47b491fegb0efd29d15f166df@mail.gmail.com>
Date: Fri, 19 Sep 2008 18:23:24 -0700
From: "Nick Pelly" <npelly@google.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Data on eglib vs glib, implications for embedded use of bluez
Cc: linux-bluetooth@vger.kernel.org, "Iliyan Malchev" <malchev@google.com>,
        "Brian Swetland" <swetland@google.com>
In-Reply-To: <1221871191.6782.79.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <35c90d960809191520n2067753cs71c07d37ea83b28@mail.gmail.com>
	 <1221871191.6782.79.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 19, 2008 at 5:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> With bluez 4.x, support for Embedded GLIB (EGLib) support was dropped,
>> and GLib became a requirement for bluez.
>>
>> This presents some challenges for embedded platforms. I want to
>> present some data from my experience of using both glib and eglib with
>> bluez 4.6, and suggest that eglib become a supported option for bluez.
>>
>> -- Size of GLIB compared to EGLIB --
>>
>> compiled size of glib static library (see file list later) VS eglib:
>>             RAW   STRIPPED
>> libglib.a   2147 k       695 k
>> libeglib.a   137 k        37 k
>>
>> compiled size of bluetoothd w/glib compared to bluetoothd w/eglib
>>                     RAW   STRIPPED
>> bluetoothd w/glib  1489 k       462 k
>> bluetoothd w/eglib  530 k       117 k
>>
>> ** bluetoothd _triples_ in size when using glib **
>
> I assume that you are talking about GLib statically linked into
> bluetoothd.

Yes, I was using static linking.

>
>> I guess it comes down to whether Bluez wants to support an embedded
>> configuration. If Bluez is happy to abandon embedded, then they can
>> forget eglib. But it Bluez is serious about supporting embedded
>> configurations, it should keep eglib as a supported option in my
>> opinion.
>>
>> I understand that one concern about eglib support is a lack of
>> maintenance. I would be happy to help out with eglib support.
>
> I can bring up a project that contains eglib and we maintain it outside
> of bluez-4.x source code. You just have to install it first and if you
> use pkg-config you would have a perfect drop-in replacement. If you
> compile it by yourself you do whatever fits best.
>
>> If supporting eglib is not an option, I am very much interested to
>> hear the specific reasons as to why not. Is it due to eglib bugs? lack
>> of eglib features (which ones)? or is embedded just not significant
>> enough to be a concern?
>
> As long as eglib has the same API as GLib it is not a problem of support
> at all. We do that already. The main reason why we removed it from the
> source code was that it just became a maintenance nightmare.
>
> Do you have a problem to maintain it in a separate source tree and
> release it as separate packages?

The danger, as I suggested earlier, is that Bluez developers will
start using API's that are not already implemented in eglib, and do
not make sense to implement on an embedded platform.

I do not mind maintaining eglib, but I don't want it to become as
bloated as glib. Bluez needs to make a commitment to only use the
parts of the glib API that makes sense on embedded platforms as well
as Desktop platforms. Perhaps in Portland we can go through the API
and work out what parts of the API that would be.

If Bluez as a project could make that commitment, then I would be
happy to maintain eglib in a separate source tree.

Nick
