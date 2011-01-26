Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
	<1295984785.2656.98.camel@ubuntuLab1>
	<AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>
	<AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
Date: Wed, 26 Jan 2011 10:54:15 -0400
Message-ID: <AANLkTik-rGVEPwPOO8iV8SM0JUTdEHMFoJvFGnRGTRc5@mail.gmail.com>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Jan 26, 2011 at 9:58 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Wed, Jan 26, 2011 at 9:33 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Looks like more a PTS bug, but makes me wonder if it is not better for
>> BlueZ to have separate procedures instead of this "automatic" usage of
>> read blob request ?
>
> BTW, the test which presented this issue with sending spurious read
> blob request is named "Read Characteristic Descriptors – by client". I
> also can see that the behavior you implemented satisfies both "Read
> Long Characteristic Value - by client" and "Read Long Characteristic
> Descriptor - by client" tests. All theses tests come from the GATT TS
> document.

Another update... Test "Read Long Characteristic Value – Invalid
handle" expects a Read Blob request specifically. The only way I see
to satisfy it is to provide a separate "read long characteristic
value" procedure separate from the "read characteristic value". Any
other ideas?

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
