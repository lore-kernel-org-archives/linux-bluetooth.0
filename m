Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <32F45991-49B0-4B46-84C0-789A3B1D8766@signove.com>
References: <201005051255.09394.jcaden@libresoft.es>
	 <3CCD92AC-1578-4E78-AEE8-80AEE73511EB@signove.com>
	 <201005071203.23882.jcaden@libresoft.es>
	 <2541510E-4912-4AEB-AEFB-83F4339EC3FA@signove.com>
	 <n2haa32413d1005071351qb6db6039u7caab57a5e893884@mail.gmail.com>
	 <32F45991-49B0-4B46-84C0-789A3B1D8766@signove.com>
Date: Sun, 9 May 2010 18:14:39 +0300
Message-ID: <AANLkTimz7yYXB2gV0EyRROItnIP6hILvC8Tz4Hbd0iyx@mail.gmail.com>
Subject: Re: HDP proposed api (ver 0.2)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, May 8, 2010 at 12:08 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
>>
>> Device objects exists for each paired device. If the pairing is
>> removed the object is also removed and a new pairing is needed before
>> connecting to it (as imposed by the whole bluetooth stack logic
>> anyway).
>
> AFAIK the HDP source and sink must be paired before any session can be established, so the relevant device objects will always be there, so the path can be (re)used.

Exactly, I tried to explain this before that device objects is a
better way to expose any relevant API since that would be created
anyway. It also has integration with the sdp record cache and are
reloaded during the initialization and I hardly see us doing anything
to revert this, since pretty much every plugin depend on this to work.

So, with this in mind, IMHO, the whole concept of exposure the
sessions won't fit nicely in BlueZ API, first because it uses the
adapter path to create session passing a device path, which btw
already is associated with adapter anyway, second because any client
seems to be able to create those sessions even if they are unable to
control them because they don't hold an agent, and third I don't think
we should be exposing protocol internals in a D-Bus API, this id's
make as much sense as the bdaddr in the ui (read _none_), it is as
usable as we starting exposing local and remote seid (Stream Endpoint
id, surprisingly similar to endpoint here) to pulseaudio to carry on
with all avdtp protocol details, this will only fragment the logic
around those bits and certainly won't make it work better.

-- 
Luiz Augusto von Dentz
Computer Engineer
