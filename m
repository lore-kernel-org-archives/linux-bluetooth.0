Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ba5648fa0909220656x93d9701le6b45a58cd0d3105@mail.gmail.com>
References: <ba5648fa0909212143g36f47acck2e4b610429c477ec@mail.gmail.com>
	 <20090922143053.287fc8a5@vlado>
	 <2d5a2c100909220608j1600e8f2k4063d6b2ff7b3296@mail.gmail.com>
	 <653A85C7F32C4741880F71219266EA02030BD03BB6@EXGMBX01.sasken.com>
	 <ba5648fa0909220656x93d9701le6b45a58cd0d3105@mail.gmail.com>
Date: Wed, 23 Sep 2009 07:39:18 -0300
Message-ID: <2d5a2c100909230339y537e8db2jad03e1a1971906d7@mail.gmail.com>
Subject: Re: BlueZ Supported Profiles
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: bluezprofile kernel <bluezprofile@gmail.com>
Cc: Sreenivasulu Yellamaraju <sreenivasulu.yellamaraju@sasken.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 22, 2009 at 10:56 AM, bluezprofile kernel
<bluezprofile@gmail.com> wrote:
> Hi,
>
>
> Thanks for the propt replies.
>
> As for as I know BlueZ will support
>
> A2DP, AVRCP, HS, HF, FTP, OPP, DUN, HID profiles.
>
> and protocols GAP, SDP, AVDTP, AVCTP, RFCOMM, BNEP, L2CAP.

You just missed PAN profile :D

> sdptool gives set of services. All the services implemented in BlueZ?
> What is the version of each service/profile implemented in BlueZ?

I don't remember the exactly version of each profile, but that gives
you an explanation why:

http://www.bluetooth.org/tpg/QLI_viewQDL.cfm?qid=15706

You can check other qualification, they may list what version the
qualification is about.

> Specially I would like to know details for the following profiles
>
> GOEP - Generic Object Exchange Profile
> HCRP - Hardcopy Cable Replacement Profile
> HDP - Health Device Profile
> MAP - Message Access Profile

Those are not implemented yet.

> PBAP - Phone Book Access Profile
> SYNC - Synchronization Profile
> SyncML - Multi Sync

PBAP is implemented as a plugin of obexd, SyncML is not really
supported directly by BlueZ but there are another projects such as
opensync that aim to support it.

> VDP - Video Distribution Profile

Another one not implemented, but it should be easy to support it as it
uses avdtp, although Im not sure if streaming a video over bluetooth
is really practical right now besides that I never saw a device which
implements VDP.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
