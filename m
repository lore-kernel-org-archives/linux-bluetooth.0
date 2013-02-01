Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 11:45:46 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] device: Fix not marking svc_resolved when loaded
 from storage
Message-ID: <20130201174546.GA29264@x220>
References: <1359740236-16095-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359740236-16095-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 01, 2013, Vinicius Costa Gomes wrote:
> When the device is loaded from storage, we should mark it as it
> services were resolved.
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
