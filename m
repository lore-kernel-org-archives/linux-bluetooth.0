Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Dec 2012 16:41:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] audio: Fix not releasing all references to
 btd_adapter
Message-ID: <20121219144118.GA1253@x220.ger.corp.intel.com>
References: <1355927348-19430-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355927348-19430-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 19, 2012, Luiz Augusto von Dentz wrote:
> A2DP server now take a reference to btd_adapter which needs to be
> released properly once the adapter is unplugged.
> ---
>  profiles/audio/a2dp.c    | 44 +++++++++++++++++++++++++++++++++++---------
>  profiles/audio/a2dp.h    |  3 ++-
>  profiles/audio/manager.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 81 insertions(+), 14 deletions(-)

Both patches have been applied. Thanks.

Johan
