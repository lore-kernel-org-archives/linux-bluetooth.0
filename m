Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Feb 2010 14:12:32 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Denis Kenzior <denis.kenzior@intel.com>
Subject: Re: [PATCH] Punch a hole for HandsfreeAgent in dbus policy
Message-ID: <20100218171108.GA15944@jh-x301>
References: <1266026813-29676-1-git-send-email-denis.kenzior@intel.com>
 <1266026813-29676-2-git-send-email-denis.kenzior@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266026813-29676-2-git-send-email-denis.kenzior@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

On Fri, Feb 12, 2010, Denis Kenzior wrote:
> ---
>  src/bluetooth.conf |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index 315009c..56e7a83 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -11,6 +11,7 @@
>      <allow own="org.bluez"/>
>      <allow send_destination="org.bluez"/>
>      <allow send_interface="org.bluez.Agent"/>
> +    <allow send_interface="org.bluez.HandsfreeAgent"/>
>    </policy>

The patch is now upstream. Thanks.

Johan
