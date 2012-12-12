Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121212120236.GA11264@x220.ger.corp.intel.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
	<20121212120236.GA11264@x220.ger.corp.intel.com>
Date: Wed, 12 Dec 2012 17:38:15 +0100
Message-ID: <CANT-zCWrF=xz-ud=tKbds9Fag5uH+ryLL3ZiQG=APqcZgEq0ug@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/11] obexd: Port bluetooth plugin to use external
 profile support
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Luiz,

On Wed, Dec 12, 2012 at 1:02 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Dec 12, 2012, Luiz Augusto von Dentz wrote:
>> This changes obexd to use ProfileManager.RegisterProfile
>> ---
>>  obexd/plugins/bluetooth.c | 696 ++++++++++++++--------------------------------
>>  1 file changed, 212 insertions(+), 484 deletions(-)
>
> All patches in this set have been applied. I also removed the service
> plugin in the same go as now all known users of it are gone.

I'm a bit confused with these recent changes. I haven't been following
this closely so I guess I'm missing the Big Plan but let me start with
the basics: both bluetoothd and obexd repositories were merged but I
believe both daemons are still going to be separate daemons, is this
correct?

If yes, it makes sense that obexd makes use of the "external profile"
infrastructure.

But in that case, why would we add any obex-specific code into
bluetoothd? My understanding was that, if a profile is implemented as
an external profile, the bluetoothd core would not be aware of it.

Cheers,
Mikel
