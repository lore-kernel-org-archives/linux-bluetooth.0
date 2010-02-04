Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Feb 2010 11:02:04 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, ofono@ofono.org
Subject: Re: [PATCH] Implement HandsfreeGateway Interface
Message-ID: <20100204190204.GA16538@jh-x301>
References: <1265307534-1250-1-git-send-email-padovan@profusion.mobi>
 <1265309291-5940-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265309291-5940-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Feb 04, 2010, Gustavo F. Padovan wrote:
> Create a interface where a Handsfree agent can register and use BlueZ to
> handle the rfcomm and sco links.
> 
> Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for his
> prototype on this code.
> ---
>  audio/device.c  |    3 +
>  audio/gateway.c |  447 +++++++++++++++++++++++++++++++++++++++++--------------
>  audio/gateway.h |   14 +-
>  audio/manager.c |   19 +--
>  audio/unix.c    |   13 +-
>  doc/hfp-api.txt |   82 ++++++++++
>  6 files changed, 445 insertions(+), 133 deletions(-)
>  create mode 100644 doc/hfp-api.txt

I didn't find any more obvious issues with this last version so the two
patches are now finally pushed upstream. Thanks.

Johan
