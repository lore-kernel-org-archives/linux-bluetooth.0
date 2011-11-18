Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 17:37:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] serial: Fix error handling in connect_port()
Message-ID: <20111118153749.GB3647@fusion.localdomain>
References: <1321618307-11456-1-git-send-email-anderson.lizardo@openbossa.org>
 <1321628930-13493-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321628930-13493-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Nov 18, 2011, Anderson Lizardo wrote:
> bt_io_connect() does not set errno on error, instead it uses GError. For
> now, simply return -EIO if bt_io_connect() fails. The serial plug-in
> code can be changed later to use and set GError appropriately.
> ---
>  serial/port.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
