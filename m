Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121025103922.GA30500@x220>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1350661172-18125-13-git-send-email-mikel.astiz.oss@gmail.com>
	<20121025103922.GA30500@x220>
Date: Thu, 25 Oct 2012 17:49:47 +0200
Message-ID: <CANT-zCUeSdBSgYN4tnZWL6kASOcTUhhARGifGBsvdufywvXR+Q@mail.gmail.com>
Subject: Re: [RFC v0 12/15] input: Add profile .disconnect
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Oct 25, 2012 at 12:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Fri, Oct 19, 2012, Mikel Astiz wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> Add the disconnect hook to the btd_profile.
>> ---
>>  profiles/input/manager.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> I've applied the patches up until this one with the exception of the
> audio ones which I'll let Luiz to look at and sync up with the work he's
> doing for audio right now. The last three will still need some
> discussion as I'm not convinced that it's a good idea to have these
> generic profile objects instead or Adapter.Connect/DisconnectProfile.

The problem with Adapter.Connect/DisconnectProfile is that you are not
able to expose the state of the profile. That was the reason to
propose such APIs, since UIs and applications could be interested in
this information.

Cheers,
Mikel
