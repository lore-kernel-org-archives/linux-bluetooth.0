Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331457799-26506-1-git-send-email-arik@wizery.com>
References: <1331457799-26506-1-git-send-email-arik@wizery.com>
Date: Wed, 14 Mar 2012 09:23:44 -0400
Message-ID: <CAJdJm_Or=Df-bDhVFtteiV8CEop8tEtxAMPBWxmmENeq3nfTWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement TPS profile
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Sun, Mar 11, 2012 at 5:23 AM, Arik Nemtsov <arik@wizery.com> wrote:
> We replace the TPS stub in reporter.c with a fully functional
> implementation. The Tx power level for each LE device is read on
> connection and cached (as it cannot change). When a remote device
> requests it the cached value is returned.
>
> This series depends on the kernel patch:
> "Bluetooth: Implement Read Transmit Power Level command"
>
> It also depends the bluez series "Implement ProximityReporter profiles",
> mostly for the ATT patch adding the remote-device to each ATT read/write
> callback.
>
> Arik Nemtsov (3):
>  mgmt: implement read tx power
>  adapter: implement API to read Tx power
>  proximity: tx power: implement tx power server
>
>  Makefile.am          |    3 +-
>  lib/mgmt.h           |   11 ++
>  plugins/mgmtops.c    |   64 +++++++++++
>  proximity/reporter.c |   48 +--------
>  proximity/txpower.c  |  292 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  proximity/txpower.h  |   24 ++++
>  src/adapter.c        |   75 +++++++++++++
>  src/adapter.h        |   17 +++
>  8 files changed, 488 insertions(+), 46 deletions(-)
>  create mode 100644 proximity/txpower.c
>  create mode 100644 proximity/txpower.h

I believe we need to hold this TPS series until some kernel support
for TX power reading (either automatically on every connection and
sent along the Device Connected event, or through a new mgmt command,
depending on what you agreed on IRC regarding what's the best
approach) is upstream.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
