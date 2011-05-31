Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 16:55:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Fix disconnect devices after enabling offline mode
Message-ID: <20110531135546.GA24318@dell.ger.corp.intel.com>
References: <1306849030-12332-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306849030-12332-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Tue, May 31, 2011, Rafal Michalski wrote:
> +	guint timer_id;

Please call this off_timer.

> +		adapter->timer_id = g_timeout_add_seconds(3,
> +					switch_off_timeout, adapter);

No magic constants whenever possible so please add a OFF_TIMER define to
the beginning of the file.

Also, it seems like you're missing the timer removal in the adapter_free
function. It would be pretty bad if the timer goes off after the adapter
object has already been freed.

Johan
