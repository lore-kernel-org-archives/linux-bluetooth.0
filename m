Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 11:27:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Add device_set_trusted()
Message-ID: <20130215092740.GB11352@x220>
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

Both patches are now applied (after adding some needed info to the
commit messages for the justification of these changes).

Johan
