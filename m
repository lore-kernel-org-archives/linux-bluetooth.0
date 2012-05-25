Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337848490.15105.83.camel@aeonflux>
References: <20120524081405.GA30941@joana> <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
 <1337848490.15105.83.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 25 May 2012 16:40:59 -0300
Message-ID: <CAMOw1v4OP6vjVSAL+WjvWmqSaHxs5U1KRBx8zf97gUEkxFWTxw@mail.gmail.com>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 24, 2012 at 5:34 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> > The last profiles addition to BlueZ increased a lot the number of fold=
ers we
>> > have in the root dir of the project and it looks like more profiles (a=
nd more
>> > folders) are expected to come.
>> >
>> > I talked a bit with Johan about changing the hierarchy of the BlueZ tr=
ee and
>> > the following proposal where 2 new folders are created, 'profiles' and=
 'libs'
>> > and things are moved to them.
>> >
>> > compat =A0 =A0 =A0 =A0 =A0-> /dev/null (will be removed on 5.0)
>> > alert =A0 =A0 =A0 =A0 =A0 -> profiles
>> > audio =A0 =A0 =A0 =A0 =A0 -> profiles
>> > cups =A0 =A0 =A0 =A0 =A0 =A0-> profiles
>> > deviceinfo =A0 =A0 =A0-> profiles
>> > health =A0 =A0 =A0 =A0 =A0-> profiles
>> > input =A0 =A0 =A0 =A0 =A0 -> profiles
>> > lib =A0 =A0 =A0 =A0 =A0 =A0 -> profiles
>> > network =A0 =A0 =A0 =A0 -> profiles
>> > proximity =A0 =A0 =A0 -> profiles
>> > sap =A0 =A0 =A0 =A0 =A0 =A0 -> profiles
>> > serial =A0 =A0 =A0 =A0 =A0-> profiles
>> > thermometer =A0 =A0 -> profiles
>> > time =A0 =A0 =A0 =A0 =A0 =A0-> profiles
>> > btio =A0 =A0 =A0 =A0 =A0 =A0-> libs
>> > gdbus =A0 =A0 =A0 =A0 =A0 -> libs
>> > sbc =A0 =A0 =A0 =A0 =A0 =A0 -> libs
>> > emulator =A0 =A0 =A0 =A0-> tools
>> > mgmt =A0 =A0 =A0 =A0 =A0 =A0-> tools
>> > monitor =A0 =A0 =A0 =A0 -> tools
>> > attrib
>> > doc
>> > plugins
>> > scripts
>> > src
>> > test
>> > tools
>> > unit
>>
>> Sounds good, the only problem are gdbus and btio, if we merge obexd
>> into BlueZ btio will no longer be shared but for gdbus we would have
>> to align with other projects as well.
>
> btio, gdbus, gobex and similar stay top-level. We are not going to
> change that.

If you are concerned about sharing gdbus patches, git am could do the
work for you: "git am --directory=3Dlibs/"

But I'm not convinced about the "libs" directory... maybe move only profile=
s?


Lucas De Marchi
