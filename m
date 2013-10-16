Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 18:47:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 06/11] android: Implement read_info_complete callback
Message-ID: <20131016154728.GC19385@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381934198-7955-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 16, 2013, Andrei Emeltchenko wrote:
> --- a/android/adapter.h
> +++ b/android/adapter.h
> @@ -34,3 +34,7 @@ struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if);
>  
>  void bt_adapter_start(struct bt_adapter *adapter);
>  void bt_adapter_stop(struct bt_adapter *adapter);
> +
> +void read_info_complete(uint8_t status, uint16_t length, const void *param,
> +							void *user_data);
> +void load_link_keys(struct bt_adapter *adapter, GSList *keys);

Shouldn't you be following the appropriate name space for this header
file? I.e. bt_adapter_*.

That said, it seems to me like you don't need to have any public
functions like this at all if you just do the read_info from the
bt_adapter_new function since you get the mgmt context there anyway.

Johan
