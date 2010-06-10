Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jun 2010 21:20:23 +0100
From: Tim Renouf <tpr.vger@botech.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bug and possible patch for dbus DiscoverServices
Message-ID: <20100610202023.GC16611@botech.co.uk>
References: <20100610125848.GA28631@botech.co.uk> <AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 10, 2010 at 04:48:58PM +0300, Luiz Augusto von Dentz wrote:
> I would just rework it a bit to make the tmp_records to always store
> the last search, something like the following:
> 
> -       if (device->tmp_records && req->records) {
> +       if (device->tmp_records)
>                 sdp_list_free(device->tmp_records,
>                                         (sdp_free_func_t) sdp_record_free);
> -               device->tmp_records = req->records;
> -               req->records = NULL;
> -       }
> +
> +       device->tmp_records = req->records;
> +       req->records = NULL;
> 
>         if (!req->profiles_added && !req->profiles_removed) {
>                 DBG("%s: No service update", device->path);
> @@ -1522,7 +1522,7 @@ send_reply:
> 
>         if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
>                                         "DiscoverServices"))
> -               discover_services_reply(req, err, req->records);
> +               discover_services_reply(req, err, device->tmp_records);
>         else if (dbus_message_is_method_call(req->msg, ADAPTER_INTERFACE,
>                                                 "CreatePairedDevice"))
>                 create_device_reply(device, req);
> 
> What do you think?

Thanks, that looks good, I'll use that.

What is the procedure to get it included in future versions of BlueZ ?
Does someone sweep this list for patches to review and possibly
include ?

Thanks.

-tpr
