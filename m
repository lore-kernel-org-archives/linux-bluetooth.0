Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 May 2011 14:20:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix disconnect devices after enabling offline mode
Message-ID: <20110527111147.GA15238@dell.amr.corp.intel.com>
References: <1305792740-32536-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305792740-32536-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, May 19, 2011, Rafal Michalski wrote:
> Previously paired and connected devices were disconnected automatically
> after turning bluetooth off directly via bluetooth UI. This patch makes
> that also other ways of turning bluetooth off (which should lead to
> disconnecting paired and connected devices), such as enabling offline
> mode (which turns bluetooth off as well), can be handled properly.
> ---
>  plugins/maemo6.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
>  src/adapter.c    |    5 +++++
>  src/adapter.h    |    1 +
>  3 files changed, 50 insertions(+), 5 deletions(-)
<snip>
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -106,6 +106,7 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
>  void adapter_set_state(struct btd_adapter *adapter, int state);
>  int adapter_get_state(struct btd_adapter *adapter);
>  int adapter_get_discover_type(struct btd_adapter *adapter);
> +GSList *adapter_get_connected_device_list(struct btd_adapter *adapter);

If this is the intended solution, the function should be called
adapter_get_connections to match the internal naming. However, I'm
wondering if we could do a bit better here. Do you think it'd make sense
to have something like:

int btd_adapter_switch_offline(struct btd_adapter *adapter, gboolean clean);

If the boolean parameter is TRUE adapter.c would internally take care of
first trying to disconnect existing connections and only after that
power off the adapter. This way we wouldn't need to expose the
connection list outside of adapter.c.

Johan
