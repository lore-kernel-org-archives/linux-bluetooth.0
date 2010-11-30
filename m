Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 13:50:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Populate adapter services list
Message-ID: <20101130115036.GA3520@jh-x301>
References: <AANLkTik7su9-KfW-+ZC-yc_SrXq+5K3PvZtu5kKxiJhG@mail.gmail.com>
 <AANLkTimwgPtxRVKuDHT0DZa2MhqOqFFDKiEzAJ3opv_W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimwgPtxRVKuDHT0DZa2MhqOqFFDKiEzAJ3opv_W@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Nov 30, 2010, Daniel Örstadius wrote:
> In case service records have been added to bluetoothd before a new
> adapter is registered, the records which are shared by all adapters
> (indicated by having the address set to BDADDR_ANY) need to be added
> to the services list of the new adapter. This patch adds a function
> for this on adapter initialization.
> 
> The issue could be reproduced by running bluetoothd and obexd on a
> PC and briefly removing the BT dongle. The service records from
> obexd would not be present in the adapter's local list (which is
> used to set the class of device).
> ---
>  src/adapter.c       |    1 +
>  src/sdpd-database.c |   24 ++++++++++++++++++++++++
>  src/sdpd.h          |    2 ++
>  3 files changed, 27 insertions(+), 0 deletions(-)

Thanks. Pushed upstream after a few minor cosmetic changes.

Johan
