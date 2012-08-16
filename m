Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 12:20:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 04/14] core: Add a list of LE devices to connect
Message-ID: <20120816092032.GA31761@x220>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
 <1345042253-15053-5-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345042253-15053-5-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Wed, Aug 15, 2012, João Paulo Rechi Vita wrote:
> +	device_get_address(device, &bdaddr, NULL);
> +	if (g_slist_find_custom(adapter->connect_list, &bdaddr,
> +					(GCompareFunc) device_bdaddr_cmp)) {
> +		DBG("trying to add device %s which is already in the connect "
> +				"list, ignoring", device_get_path(device));
> +		return;
> +	}

Why don't you just use g_slist_find here? If this is the only place
where you need the new device_bdaddr_cmp then patch 03/14 can be
removed.

Johan
