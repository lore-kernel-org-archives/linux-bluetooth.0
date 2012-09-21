Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:35:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Rafal Garbat <rafal.garbat@tieto.com>
Subject: Re: [PATCH v6 06/13] heartrate: Read Body Sensor Location
 characteristics
Message-ID: <20120921133522.GA16944@x220>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348139690-26985-7-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348139690-26985-7-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 20, 2012, Andrzej Kaczmarek wrote:
> +static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
> +						guint16 len, gpointer user_data)
> +{
> +	struct heartrate *hr = user_data;
> +	uint8_t value;
> +	ssize_t vlen;
> +
> +	if (status != 0) {
> +		error("Body Sensor Location read failed: %s",
> +							att_ecode2str(status));
> +		return;
> +	}
> +
> +	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
> +	if (vlen < 0) {
> +		error("Protocol error");
> +		return;
> +	}
> +
> +	if (vlen != 1) {
> +		error("Invalid length for Body Sensor Location");
> +		return;
> +	}

Minor nitpick: vlen != sizeof(value) would make it more clear exactly
what you want to compare with.

Johan
