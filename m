Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Dec 2012 09:32:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] core: Fix trying to store NULL adapter->name
Message-ID: <20121219073257.GA4564@x220>
References: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Dec 18, 2012, Anderson Lizardo wrote:
> When BlueZ starts without a main.conf, adapter->name will be initially
> NULL, until adapter_name_changed() is called and name is set to "BlueZ".
> 
> Before this, store_adapter_info() will try to access a NULL pointer.
> 
> Fixes this GLib error:
> 
> (bluetoothd:1721): GLib-CRITICAL **: g_key_file_set_string: assertion
> `string != NULL' failed
> ---
>  src/adapter.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

All three patches have been applied. Thanks.

Johan
