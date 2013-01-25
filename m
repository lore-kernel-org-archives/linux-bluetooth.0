Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:08:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 2/6] device: Fix memory leak while storing GATT
 capable devices
Message-ID: <20130125070858.GB17746@x220>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
 <1359083227-13122-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359083227-13122-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
> bt_uuid2string() returns a newly allocated string, and so it should
> be free'd.
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)

This patch has been applied. Thanks.

Johan
