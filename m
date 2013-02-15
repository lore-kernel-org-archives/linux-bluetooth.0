Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 10:36:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Add device_set_trusted()
Message-ID: <20130215083611.GA5750@x220>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 03, 2013, Antonio Ospite wrote:
> In patch 1 a device_set_trusted() function is proposed, which I plan to
> use for the playstation-peripheral plugin; I am in the process of
> rebasing the plugin on top of BlueZ 5.2.
> 
> In patch 2 the newly introduced function is used in order to avoid some
> duplication.
> 
> device_set_trusted() looks a lot like device_set_temporary() and
> device_set_legacy(), I hope it makes sense to you too.
> 
> Thanks,
>    Antonio
> 
> Antonio Ospite (2):
>   device: add a device_set_trusted() function
>   device: use device_set_trusted() in set_trust()
> 
>  src/device.c |   30 +++++++++++++++++++-----------
>  src/device.h |    1 +
>  2 files changed, 20 insertions(+), 11 deletions(-)

This patch set makes me a bit uneasy since setting a device as trusted
is a security sensitive operation. My initial reaction is that this
should only be done through explicit user interaction, i.e. through the
D-Bus interface. I'm also worried that plugins will start misusing this
API once it's available.

Feel free to try to convince me otherwise though.

Johan
