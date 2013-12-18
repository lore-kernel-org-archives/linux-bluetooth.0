Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <13E32B04-DDEA-4BE1-BCAB-40C0395D638F@holtmann.org>
References: <1387365861-23356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<13E32B04-DDEA-4BE1-BCAB-40C0395D638F@holtmann.org>
Date: Wed, 18 Dec 2013 13:57:24 +0200
Message-ID: <CABBYNZK2=57gi1Z_BLo+fn2MBPy0P_686xLjtFn70B-zbkJ3pA@mail.gmail.com>
Subject: Re: [PATCH] avctp: Move avctp.c|h from profiles/audio to protocol/
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Ravi,

On Wed, Dec 18, 2013 at 1:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Ravi,
>
>> This is an initial patch for decoupling avctp.c|h from profiles/audio.
>> Goal is to remove external dependency (glib is enough) and reusable
>> to android/* sources.
>> ---
>> Makefile.plugins                     | 2 +-
>> {profiles/audio => protocol}/avctp.c | 7 +------
>> {profiles/audio => protocol}/avctp.h | 0
>> 3 files changed, 2 insertions(+), 7 deletions(-)
>> rename {profiles/audio => protocol}/avctp.c (99%)
>> rename {profiles/audio => protocol}/avctp.h (100%)
>
> actually, no.
>
> The breaks my nicely tab-tab-completion handling when going through the source code. Pro{file,tocol} have a way to close prefix.

Lets handle these similar to AVDTP by copying it to android, remove
dependencies to core the add to android build and create proper unit
tests for it, eventually it should replace all the existing
implementation of AVCTP but first we need to have the unit tests done.
Later we can decide where it should be, perhaps it can even be inside
lib/ for example (though internally it might still depend on glib.)


-- 
Luiz Augusto von Dentz
