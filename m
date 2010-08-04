Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201008041554.27451.santoscadenas@gmail.com>
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
	<AANLkTima=oJ4mPMkfPCNPjsqhxX0drGBDURXBMaLrJ1C@mail.gmail.com>
	<201008041554.27451.santoscadenas@gmail.com>
Date: Wed, 4 Aug 2010 19:45:50 +0300
Message-ID: <AANLkTinO4=BjcNP5uyi_nX0axaBth7aUAhgOoFdPKrY2@mail.gmail.com>
Subject: Re: Changes in HDP API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 4, 2010 at 4:54 PM, José Antonio Santos Cadenas
<santoscadenas@gmail.com> wrote:
>> This has 2 main advantages:
>>
>> 1.  Anyone can request to connect not only applications which holds
>> local endpoints
>
> How can you guess the remote end point to connect to if you don't have a local
> end point?

There is no endpoints involved in this case, bluetooth applet/agent
has knowledge only of the device so bluetoothd will need to figure out
all the matching endpoint and make sure local endpoint get notified
about the available channels, so responding your question there is
nothing to guess it all about matching the endpoints if there is no
match it just fails after the discover as simple as that.

At least that is the idea around connect/disconnect in gnome-bluetooth
and N900 bluetooth application does have a similar design.

-- 
Luiz Augusto von Dentz
Computer Engineer
