Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 13:22:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/5] DeviceInfo: Read PNP ID
Message-ID: <20120329102232.GD23176@x220>
References: <1332948405-1104-1-git-send-email-chen.ganir@ti.com>
 <1332948405-1104-6-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332948405-1104-6-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
> +	if (status != 0) {
> +		DBG("value read failed: %s",
> +							att_ecode2str(status));

Why is this split into two lines. The call can easily fit within 80
chars with all of its parameters. Also, this should be error() and not
DBG().

> +	if (!dec_read_resp(pdu, len, value, &vlen)) {
> +		DBG("Protocol error\n");

This should be error() and the \n at the end should be removed.

> +	device_set_pnpid(ch->d->dev,value[0],att_get_u16(&value[1]), att_get_u16(&value[3]),
> +				att_get_u16(&value[5]));

Over 80 character line and the continuation looks like it's incorrectly
indented (it should be indented with tabs as much as possible as long as
you don't hit the 80 character boundary.

> +static void process_deviceinfo_char(struct characteristic *ch)
> +{
> +	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0) {
> +		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
> +							read_pnpid_cb, ch);
> +		return;
> +	}
> +}

The explicit return statement seems redundant since that's what the
function does anyway even without the if-branch. You can then also
remove the {}.

Johan
