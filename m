Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 13:23:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add adaptername plugin
Message-ID: <20110628102306.GA4652@dell.ger.corp.intel.com>
References: <20110628085132.GH18047@dell.ger.corp.intel.com>
 <1309252884-5385-1-git-send-email-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309252884-5385-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Jun 28, 2011, Bastien Nocera wrote:
> Replacing the name setting code in src/adapter.c.
> 
> Moving the adapter naming allows us to use the /etc/machine-info [1]
> pretty hostname, as implemented by hostnamed [2] in systemd.
> 
> If /etc/machine-info is not present, the adapter name stored
> on disk in /var/lib/bluetooth will be used. If no adapter name
> has been set yet, the default from the main.conf will be used.
> 
> We don't currently number the name of hci0 if a pretty name is
> available, but we should instead number it if it happens not
> to be the default adapter. As we cannot be told when the default
> adapter changes, we'll behave this way for now.
> 
> Note that when an adapter name is set automatically from
> the pretty hostname, changing it through the D-Bus interface
> will fail.
> 
> [1]: http://0pointer.de/public/systemd-man/machine-info.html
> [2]: http://www.freedesktop.org/wiki/Software/systemd/hostnamed
> ---
>  Makefile.am           |    3 +
>  configure.ac          |    4 +
>  plugins/adaptername.c |  321 +++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.c         |   66 ----------
>  4 files changed, 328 insertions(+), 66 deletions(-)
>  create mode 100644 plugins/adaptername.c

Thanks for the quick response. After a couple of more (minor) coding
style fixes the patch is now upstream.

Johan
