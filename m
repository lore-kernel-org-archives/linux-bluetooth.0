Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 10:41:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ v7 7/9] core: Re-connect for ECONNRESET or
 ECONNABORTED
Message-ID: <20120927074101.GA9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
 <1348594686-26221-7-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1348594686-26221-7-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
> +	/*
> +	 * Keep scanning/re-connection active if disconnection reason
> +	 * is page timeout, remote user terminated connection or local
> +	 * initiated disconnection.
> +	 */
> +	if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED)
> +		adapter_connect_list_add(device_get_adapter(device), device);

Page timeouts have always been reported through EHOSTDOWN so either the
comment or the code is wrong here.

Johan
