Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 13:40:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Remove EnableLE option from the user-space
Message-ID: <20110822104028.GD9949@dell>
References: <1313785841-24047-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313785841-24047-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Aug 19, 2011, Claudio Takahasi wrote:
> Deprecated configure option after adding "enable_le" parameter in the
> bluetooth module. Write LE Host Supported Command is now sent by the
> kernel if "enable_le" is enabled and the controller supports LE.
> ---
>  plugins/hciops.c    |   24 +-----------------------
>  plugins/mgmtops.c   |    7 -------
>  src/adapter.c       |    3 ---
>  src/adapter.h       |    1 -
>  src/attrib-server.c |    3 ---
>  src/hcid.h          |    1 -
>  src/main.c          |    7 -------
>  src/main.conf       |    7 +------
>  8 files changed, 2 insertions(+), 51 deletions(-)

Both patches have been applied. Thanks.

Johan
