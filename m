Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jul 2012 16:57:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: bruna.moreira@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] adapter: Remove unused Broadcaster property
Message-ID: <20120729145727.GA19214@x220>
References: <50117f05.0a4bec0a.04ec.ffffcfe2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50117f05.0a4bec0a.04ec.ffffcfe2@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Jul 26, 2012, bruna.moreira@openbossa.org wrote:
> Applications that want to be Observers of certain Advertising data type
> (e.g. Manufacturer Specific Data or Service Data) will use new Observer
> D-Bus API to monitor these AD types. Therefore, the old Broadcaster
> device property is unnecessary.
> ---
>  doc/adapter-api.txt |    3 +--
>  src/adapter.c       |    7 -------
>  2 files changed, 1 insertion(+), 9 deletions(-)

All three patches have been applied. Thanks.

Johan
