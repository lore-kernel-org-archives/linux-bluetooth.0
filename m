Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 11:43:26 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git
 for_upstream
Message-ID: <20101022134325.GA30929@jh-x301>
References: <AANLkTikei6=MbLUQBYNmzbkEQ-12ufzVAf0CA2f3uLu2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikei6=MbLUQBYNmzbkEQ-12ufzVAf0CA2f3uLu2@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Thu, Oct 21, 2010, Jose Antonio Santos Cadenas wrote:
> The following changes since commit a4b1673b878a358d2492f24b46e92ea36d8f8bbf:
> 
>   Fix hidd to use ServiceName attribute for device name (2010-10-20
> 13:37:36 +0300)
> 
> are available in the git repository at:
>   git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
> 
> José Antonio Santos Cadenas (6):
>       Receive an string instead of an integer for ChannelType
>       Modify test-health script to make it more interactive
>       Notify main channel when it is locally opened
>       Emit a valid path when main channel is deleted
>       Delete data channels when their device is removed.
>       Check if the channel mode is correct when opening data channels
> 
> Santiago Carot-Nemesio (6):
>       Remove obsolete comment from MCAP
>       Fix segmentation fault freeing uninitialized pointers
>       Check l2cap configuration when data channels are connected
>       Close the data channel if remote side changes the configuration
>       Enable support to change mode for incoming data channels connections
>       Change data channel mode for incoming connections
> 
>  health/hdp.c      |  106 +++++++++++++++++++++++++--
>  health/hdp_util.c |   35 +++++++---
>  health/mcap.c     |   15 ++++-
>  health/mcap_lib.h |    3 +
>  test/test-health  |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 340 insertions(+), 26 deletions(-)

Pushed upstream. Thanks.

Johan
