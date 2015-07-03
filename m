Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC BlueZ 00/13] Introducing Soletta peripheral node-type
In-Reply-To: <CABBYNZ+TGZP3783W_PGyTdaM-mQqXs5EUKwto8qoP1FPAnzFgw@mail.gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com> <CABBYNZ+TGZP3783W_PGyTdaM-mQqXs5EUKwto8qoP1FPAnzFgw@mail.gmail.com>
Date: Fri, 03 Jul 2015 14:14:57 -0300
Message-ID: <87si9540z2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> Hi Vinicius,
>
> On Thu, Jul 2, 2015 at 5:33 PM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
>> Hi,
>>
>> We have been working on Soletta[1] for a few months and now that it has
>> been open sourced, it makes sense to show what it can do using
>> BlueZ. This implements a very simple node type that behaves as a Heart
>> Rate Sensor in the peripheral mode.
>>
>> Just a overview about Soletta, it provides a way to write IoT
>> applications targeting a broad range of devices (from the smallest
>> edge to the smarttest hub).
>>
>> You would express your application logic using a Flow Based language
>> to connect various nodes, write your custom node types using the
>> libsolleta C API. And the Soletta developers would worry about porting
>> the libsoletta library to the multitude of targets and providing a
>> useful collection of node types.
>>
>> Using the support we already have in BlueZ for the Bluetooth LE
>> peripheral mode, writing a Soletta node type for the Heartrate Sensor
>> role seems a very good match. And it brings some very interesting use
>> cases with the linux-micro target.
>
> I guess it would be a good idea to have a README in peripheral
> directory explaining the setup/architecture, etc, much like we did for
> Android.

Of course. I absolutely agree.

>
>> The way I thought best about integrating BlueZ with Soletta was to add
>> another mainloop backend using libsoletta so every event would be
>> handled consistently. See patch 02/13.
>>
>> Most of the changes not related to either adding the mainloop support,
>> or adding the node type code are related to some lack of
>> configurability to the peripheral code, perhaps having a way to the
>> callback that will register the service to have a say in some
>> parameters?
>>
>> The most important question is: is BlueZ the right place to have this code?
>
> It seems like it as long as we don't make our shared code public, as a
> shared library, I believe BlueZ will be the right place.
>

Cool.

>> What do you say?
>
> I suppose we need a bit more information regarding what kind of setups
> this is targeting, I suppose this is to be run on systems without
> D-Bus, something like all-in-one design? I don't mind having another
> mainloop but the unit tests are currently limited to glib only so it
> won't catch bugs/regressions with other mainloops perhaps we need to
> address this.

The setup that this series is targeting is the all-in-one one. And as it
was the most intrusive (from the BlueZ perspective) it made sense to
start from it. And it aligns nicely with Soletta having a PID 1
implementation.

(I will take a look and see what I can do about the tests.)

>
> The IoT setups seems to be pretty open right now, from what I heard
> there are setups that would run systemd+bluetoothd(dual-mode/le-only),
> bluetoothd(dual-mode/le-only), all-in-one(le-only) setups, for le-only
> setups Im afraid we will need to make the code even more modular to
> reduce the memory footprint, so perhaps we should nail down what
> setups really make sense to be supported upstream

Just for reference, we tried to see how small the binary would be for
this, we got to an ~180KB static binary when linking the heartrate
module with the soletta PID 1 implementation, but did not measure memory
consumption. Will put together the steps to build this in the
README.

But I still can see interesting use cases for having some (mostly the
client side of GATT profiles) profiles implemented inside the Soletta
project (using the D-Bus APIs). This being the bluetoothd+systemd setup,
I presume.

The bluetoothd(dual-mode/le-only) case I wasn't thinking about it, and I
still can't think of use cases for it, I guess I didn't understand it.

>
> For example setups that require classic will very likely require audio
> or/and obexd which probably pulls everything we have, so I guess it
> makes little sense to put any effort making this part of the code more
> memory efficient.

I agree.

>
>> Any questions about the project, we are hanging out in #soletta @ freenode.net.
>>
>> Cheers,
>>
>> [1] https://github.com/solettaproject/soletta
>>
>> Vinicius Costa Gomes (13):
>>   build: Add configure-time checks for soletta
>>   shared: Add a mainloop implementation using soletta
>>   peripheral/gatt: Fix usage of mainloop_ functions
>>   peripheral/gatt: Add a way to external services to register services
>>   peripheral/gap: Fix missing includes
>>   peripheral/gap: Init the gatt_server
>>   peripheral: Disable support for static random addresses
>>   peripheral/gap: Set the discoverable flag in the advertising
>>   peripheral/gatt: Use LOW security level
>>   soletta/heartrate: Add a node-type for the Heartrate profile
>>   .gitignore: Ignore soletta generated files
>>   build: Add heartrate soletta node type to the build system
>>   soletta: Add a sample flow using the heartrate node
>>
>>  .gitignore                   |   4 +
>>  Makefile.am                  |   7 +-
>>  Makefile.tools               |  20 +++
>>  configure.ac                 |  38 ++++++
>>  peripheral/gap.c             |  12 +-
>>  peripheral/gatt.c            | 124 ++++++++++++-----
>>  peripheral/gatt.h            |   6 +
>>  soletta/heartrate-src.json   |  30 +++++
>>  soletta/heartrate.c          | 298 ++++++++++++++++++++++++++++++++++++++++
>>  soletta/heartrate.fbp        |   1 +
>>  soletta/sol-flow.conf        |   2 +
>
> Id put soletta code under peripheral/soletta as it appears to depend
> on that anyway.

Yes, it depends on it. Sure.


Cheers,
--
Vinicius
