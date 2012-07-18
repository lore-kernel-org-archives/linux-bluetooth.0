Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 14:59:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v13 14/14] audio: Add fast connectable to telephony
 interface
Message-ID: <20120718115921.GD15775@x220.ger.corp.intel.com>
References: <1342532440-730-1-git-send-email-frederic.danis@linux.intel.com>
 <1342532440-730-15-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342532440-730-15-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Jul 17, 2012, Frédéric Danis wrote:
>  static int register_interface(void *adapter)
>  {
>  	const char *path;
> +	struct tel_adapter *tel_adapter;
>  
>  	if (DBUS_TYPE_UNIX_FD < 0)
>  		return -1;
>  
>  	path = adapter_get_path(adapter);
>  
> +	tel_adapter = g_new0(struct tel_adapter, 1);
> +	tel_adapter->btd_adapter = adapter;

Missing btd_adapter_ref(). Also add the unref to the right place.

Johan
