Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Apr 2012 12:13:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmtops: Handle Start Discovery Complete in case of
 failure
Message-ID: <20120410091320.GA6124@x220>
References: <1333955251-8377-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333955251-8377-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Apr 09, 2012, Hemant Gupta wrote:
> +	if (len != sizeof(*type)) {
> +		error("start_discovery_complete event size mismatch "
> +		      "(%zu != %zu)", len, sizeof(*type));

The above line should be indented only with tabs. You're using tabs +
spaces.

> +	if (index > max_index) {
> +		error("Unexpected index %u in start_discovery_complete",
> +		      index);
> +		return;
> +	}
> +
> +	if (!status)
> +		return;
> +
> +	DBG("hci%u type%d status%d", index, *type, status);

Could you move this DBG statement above the index < max_index and add
spaces after "type" and "status" (hci%u is the only exception since
that's how adapters are named). Also, the format specifiers should be %u
since both type and status are unsigned.

> +	adapter = manager_find_adapter_by_id(index);
> +
> +	if (adapter)

Remove the empty line between the adapter assignment and the
if-statement (this applies to any function call and a test for its
result; there should be no empty line between them).

Johan
