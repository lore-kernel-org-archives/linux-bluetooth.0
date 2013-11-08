Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 15:16:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] Improve user experience
Message-ID: <20131108131637.GA6383@x220.p-661hnu-f1>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Fri, Nov 08, 2013, Jerzy Kasenberg wrote:
> This patchset works towards improving user interface.
> - Command line parsing (--help, --version, --no-init)
> - All interfaces are now initialized at start by default
> - --no-init allows to disable this initialization
> - pin_request_cb will now present prompt and send reply
> - ssp_request_cb will now present prompt and sent reply
> 
> As part of adding those features terminal.c was restructured.
> Big switch inside terminal_process_char was distributed between
> number of small functions. This work was necessary due to input
> handling of prompted data.
> 
> Version print may need to be changed according to bluez culture. 
> 
> Jerzy Kasenberg (8):
>   android/client: Export get_interface_method
>   android/client: Add NELEM macro for count elements
>   android/client: Initialize all interfaces at start
>   android/client: Add command line arguments
>   android/client: Split terminal_process_char
>   android/client: Add prompting for answer
>   android/client: Add pin handling for bind
>   android/client: Add ssp key confirmation helper
> 
>  android/client/haltest.c       |  102 ++++++-
>  android/client/if-bt.c         |   46 +++
>  android/client/if-main.h       |    4 +
>  android/client/tabcompletion.c |    2 +-
>  android/client/terminal.c      |  605 +++++++++++++++++++++++++++-------------
>  android/client/terminal.h      |    5 +-
>  6 files changed, 567 insertions(+), 197 deletions(-)

All eight patches have been applied. Thanks.

Johan
