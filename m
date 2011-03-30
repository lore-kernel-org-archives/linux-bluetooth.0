Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 19:19:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Attrib client move
Message-ID: <20110330161920.GA30984@jh-x301>
References: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Mar 28, 2011, Vinicius Costa Gomes wrote:
> Hi,
> 
> This patch series moves the Attrib client to the core, this move is
> more related to the build system than with code being moved.
> 
> Things left to be done (that will be done in later patches):
>  - Remove the attrib plugin;
>  - Use SDP information to register primary services;
> 
> --
> Cheers,
> 
> 
> Vinicius Costa Gomes (6):
>   Move Attrib client to the core
>   Register Attrib interface when loading device from storage
>   Register Attrib interface after Primary Service discovery
>   Remove _init and _exit methods from Attrib client
>   Add support for re-using the attrib channel
>   Fix disconnecting when primary service discovery is done
> 
>  Makefile.am      |    4 +-
>  attrib/client.c  |   49 +++++++++++++++---------------------------
>  attrib/client.h  |    6 ++--
>  attrib/main.c    |   14 +-----------
>  attrib/manager.c |   62 ++---------------------------------------------------
>  attrib/manager.h |    2 +-
>  src/adapter.c    |    5 ++++
>  src/device.c     |   20 +++++++++++------
>  8 files changed, 46 insertions(+), 116 deletions(-)

All patches in this set have been pushed upstream. Thanks.

Johan
