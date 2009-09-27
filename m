Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Sep 2009 11:31:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix memory leaks
Message-ID: <20090927083132.GA18495@jh-x301>
References: <200909251623.02240.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200909251623.02240.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

Thanks for the excellent reviews!

There are a few changes however that I'd still do to the patch:

On Fri, Sep 25, 2009, Steve Grubb wrote:
>  	if (!record) {
>  		error("Unable to allocate new service record");
> +		g_free(server);
> +		sdp_record_free(record);
>  		return -1;
>  	}

In this branch record is NULL so I guess the sdp_record_free call is a
mistake (it also doesn't handle NULL nicely like some GLib free functions
do and would cause an imediate segfault).

> --- bluez-4.54.orig/src/glib-helper.c	2009-09-25 11:33:47.000000000 -0400
> +++ bluez-4.54/src/glib-helper.c	2009-09-25 16:07:22.000000000 -0400
> @@ -704,7 +704,7 @@ int bt_acl_encrypt(const bdaddr_t *src, 
>  			bt_hci_result_t cb, gpointer user_data)
>  {
>  	GIOChannel *io;
> -	struct hci_cmd_data *cmd;
> +	struct hci_cmd_data *cmd = NULL;
>  	struct hci_conn_info_req *cr;
>  	auth_requested_cp cp;
>  	struct hci_filter nf;
> @@ -778,6 +778,7 @@ int bt_acl_encrypt(const bdaddr_t *src, 
>  	return 0;
>  
>  failed:
> +	g_free(cmd);
>  	close(dd);

As David already mentioned in the other email, it's good to to avoid
initialization upon declaration to help the compiler detect unused
variables. I think it'd be better to add another label right above failed,
e.g. failed_cmd, which does the g_free and then jump to it from those
places in the function that need it.

Johan
