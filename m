Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Nov 2011 16:17:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Timo Gienger <timo.gienger@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fixed reading of on_mode in btd_adapter_get_mode
Message-ID: <20111123141704.GA6456@fusion.localdomain>
References: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Timo,

On Wed, Nov 23, 2011, Timo Gienger wrote:
> If InitiallyPowered was set to false, it was not possible to
> use hciconfig tool, as on_mode variable was set to MODE_OFF
> making it impossible to enable BT via hciconfig until a DBUS
> call was done and the variable was set in config file as
> connectable.
> Furthermore removed if-else condition, as the both calls
> done exactly the same. Removed also last else condition
> as MODE_OFF should not be valid for on_mode.
> Fix tested with hciops interface.
> 
> Signed-off-by: Timo Gienger <timo.gienger@nokia.com>
> ---
>  src/adapter.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)

The patch looks ok and I didn't find any issues when testing it either,
so it's now pushed upstream. It'd be good if others test this too since
the mode/on_mode logic with all various configuration combinations is
far from simple.

Before applying I did have to fix your commit message though. Please pay
attention to the following:

- The form of the summary line is "Fix ...", not "Fixing..."
- We don't use signed-off-by in the user-space git
- D-Bus is written D-Bus, not DBUS
- You can have longer lines than 60 characters in the commit message
  body (72 is a good limit). Let your editor automate this for you (it
  looked like you might have manually done the formating).

Johan
