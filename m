Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLkVCNiqKpF=EsW+1uS4pK6mnvt26XzKEbFinQfGdLVyQ@mail.gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZLkVCNiqKpF=EsW+1uS4pK6mnvt26XzKEbFinQfGdLVyQ@mail.gmail.com>
Date: Fri, 12 Jul 2013 15:48:27 +0200
Message-ID: <CANT-zCU9HFLUB0=ooxJHGeRXQLvbfTHnjPaQnmJ7adMSN6icqQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 00/10] HSP plugin
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 12, 2013 at 1:28 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Fri, Jul 12, 2013 at 1:54 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> =
wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> GNOME 3.10 freeze date is 2013-08-19 and they want to upgrade to BlueZ 5=
.
>>
>> One of the arguments against the upgrade is the lack of headset support.=
 oFono should be convering this feature but it's development as well as the=
 required work in PulseAudio are advancing too slowly for the mentioned tar=
get date.
>>
>> This patchset proposes a simple HSP plugin implementing the AG role, whi=
ch is the most common use-case in desktop environments. It's a fallback alt=
ernative to a full-featured HSP/HFP implementation (i.e. oFono) in case the=
 later is not available (i.e. not fully implemented or packaged in a specif=
ic distro).
>>
>> I think we could all agree about this not being the best long-term strat=
egy, due to the overlap and conflict with oFono, but it might be useful in =
the short-term to boost the adoption of BlueZ 5.
>>
>> The plugin approach is more intrusive than I first thought because the M=
edia API code was significantly simplified when all HSP/HFP code was remove=
d. Hence, the patchset brings this code back along with the necessary APIs =
to be able to implement this inside a plugin.
>>
>> In order to test this, some PulseAudio patches are required (the last 5 =
patches of "[RFC next v5 00/11] bluetooth: BlueZ 5 development patches"). T=
hese were never merged in PA due to a chicken-egg problem: there was no cod=
e in BlueZ to test against.
>>
>> Mikel Astiz (10):
>>   media: Expose Media API internally
>>   media: Add callback to report new endpoints
>>   transport: Regroup a2dp-specific members in struct
>>   transport: Add API to register drivers
>>   transport: Add API to report suspend/resume complete
>>   transport: Add microphone/speaker gains
>>   audio: Add function to remove inactive devices
>>   hsp: Add initial HSP plugin
>>   hsp: Add Media API integration
>>   hsp: Implement media transport driver
>>
>>  Makefile.plugins           |    3 +
>>  plugins/hsp.c              | 1357 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  profiles/audio/manager.c   |   12 +
>>  profiles/audio/manager.h   |    1 +
>>  profiles/audio/media.c     |  132 ++++-
>>  profiles/audio/media.h     |   30 +
>>  profiles/audio/transport.c |  384 +++++++++----
>>  profiles/audio/transport.h |   29 +
>>  8 files changed, 1818 insertions(+), 130 deletions(-)
>>  create mode 100644 plugins/hsp.c
>>
>> --
>> 1.8.1.4
>
> I guess my suggestion of having this as a separate plugin was a bit
> misleading since we are going to depend on media API anyway that
> should be part of the same plugin, the other option would be to make
> it a core API which I don't think is a good idea. Btw it seems this
> would only work if audio plugin is loaded before hsp because you are
> not really linking media symbols I guess there are being resolved by
> pure luck and if you do link it might generate duplicated symbols when
> loading the plugins, so interdependency between plugins files should
> be avoided.

Besides the issues pointed out by Luiz, which I could fix in a next
proposal, can you give your opinion on this approach?

It makes little sense to try to advance in this direction if it
doesn't fit the project plan.

Johan also suggested that such a feature could be automatically
disabled when an external profile (oFono) registers.

Cheers,
Mikel
