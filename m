Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 17:03:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git
 for_upstream
Message-ID: <20101118150351.GA14348@jh-x301>
References: <1290092014-32574-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1290092014-32574-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 18, 2010, Santiago Carot-Nemesio wrote:
>   Fix typos in adapter documentation (2010-11-16 13:39:43 +0000)
> 
> are available in the git repository at:
>   git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
> 
> José Antonio Santos Cadenas (9):
>       Add reference counter to hdp_application
>       Add reference counter to hdp_channel
>       Notify a channel deleted when remote side has already deleted it
>       Fix typos in mcap
>       Set reference counter for mcls to gint
>       Fix message error
>       Remove magic number to check ECHO MDEPs in HDP
>       Fixes to echo
>       Check if the mcl insiede the device is correctly set before use it
> 
> Santiago Carot-Nemesio (10):
>       Add reference counter to hdp_device
>       Remove MCL's before removing the application
>       Add missed unrefs for hdp_tmp_dc_data
>       Add reference counter to mcap_instances
>       Add reference counter to mcap_mdl
>       Remove old reference to mcap session in the name of variables
>       Code refactorization in MCAP
>       Fix dereference to NULL pointers during data channels creation
>       Return proper response code if there is an error creating echo channel
>       Check if MCAP Instance is already released when a callbacks comes back.
> 
>  health/hdp.c           |  266 ++++++++++++++++++++++++++++++++----------------
>  health/hdp_types.h     |    4 +
>  health/hdp_util.c      |   55 ++++++++++-
>  health/hdp_util.h      |    8 ++
>  health/mcap.c          |  242 +++++++++++++++++++++++++------------------
>  health/mcap_internal.h |    9 +-
>  health/mcap_lib.h      |   13 ++-
>  health/mcap_sync.c     |   22 ++--
>  8 files changed, 407 insertions(+), 212 deletions(-)

In general, please try to avoid such big sets of patches and send them
in smaller bits (as they get created) to linux-bluetooth. That makes
things easier for me and I am able to do a more thorough review.
However, I did a quick skim through of the patches and only found one
coding style issue (C++ style comment) which I fixed my self. So the
patches have now all been pushed upstream.

Johan
