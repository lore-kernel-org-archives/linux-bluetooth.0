Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Mar 2015 11:05:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Abhinav Kumar <abhinav.ku91@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH ] [BT][LE Data Length Extension]
Message-ID: <20150304090503.GA18273@t440s.lan>
References: <1425445750-3723-1-git-send-email-abhinav.ku91@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425445750-3723-1-git-send-email-abhinav.ku91@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Abhinav,

On Wed, Mar 04, 2015, Abhinav Kumar wrote:
> 1> Added kernel code for for all commands and events which are part of the feature.
> 
> Signed-off-by: Abhinav Kumar <abhinav.ku91@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |   13 ++-
>  include/net/bluetooth/mgmt.h     |   40 +++++++++
>  net/bluetooth/hci_conn.c         |   27 ++++++
>  net/bluetooth/hci_event.c        |   35 +++++++-
>  net/bluetooth/mgmt.c             |  169 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 280 insertions(+), 4 deletions(-)

A couple of things:

1) The very first thing that needs to happen is for a user space
mgmt-api.txt patch to be submitted and get applied before we do any
changes. This will require some good justifications for why you need
this exposed to user space, and why it needs to happen pretty much 1:1
to the respective HCI commands.

2) You need to split the kernel changes into multiple smaller patches.
You can e.g. introduce the HCI definitions in one patch and the
implementation in another. Same goes for mgmt definitions and
implementation.

3) Fix your coding style. There are probably multiple things but one
obvious one I saw was with variable naming: we don't use CamelCase
anywhere in the kernel (or BlueZ user space for that matter).

4) Use hci_request if you need to have a function in mgmt.c called after
a HCI command completion, instead of having a hard-coded call from
hci_event.c into mgmt.c.

5) For all of your patches you need to provide more extensive commit
messages. It's good to have a short summary of what the patch does, but
for most patches it's even more important to explain why the patch is
needed and why the approach it takes is the best one.

Johan
