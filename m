Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Aug 2012 10:42:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 04/14] core: Add a list of LE devices to connect
Message-ID: <20120817074208.GB30060@x220>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
 <1345152524-13404-5-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345152524-13404-5-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 16, 2012, João Paulo Rechi Vita wrote:
> +void adapter_connect_list_add(struct btd_adapter *adapter,
> +					struct btd_device *device)
> +{
> +	if (g_slist_find(adapter->connect_list, device)) {
> +		DBG("trying to add device %s which is already in the connect "
> +				"list, ignoring", device_get_path(device));
> +		return;
> +	}

If possible could you try to avoid split message strings. Since the
context (function name, line number) is anyway logged with DBG you could
just have e.g. "ignoring already added device %s"

> +	adapter->connect_list = g_slist_append(adapter->connect_list, device);

Looks like there's a missing btd_device_ref here.

> +void adapter_connect_list_remove(struct btd_adapter *adapter,
> +					struct btd_device *device)
> +{
> +	adapter->connect_list = g_slist_remove(adapter->connect_list, device);

And a missing btd_device_unref here.

Johan
