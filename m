Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Dec 2010 17:08:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Remove ancient NAME_SENT name resolution status
Message-ID: <20101227150822.GB17203@jh-x301>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 27, 2010, Anderson Lizardo wrote:
> The NAME_SENT status was introduced on commit
> d6a16516a9f6deae8342f00e8186b02d0019a1e1, when there was a
> "RemoteNameUpdate" D-Bus signal. Nowadays, there is no such signal, and
> the device name (if any) is always sent on "DeviceFound" signal.
> ---
>  src/adapter.h |    1 -
>  src/event.c   |   19 -------------------
>  2 files changed, 0 insertions(+), 20 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
