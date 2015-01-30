Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1422452517-4240-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
Date: Fri, 30 Jan 2015 19:37:02 +0530
Message-id: <001201d03c96$10ca2ab0$325e8010$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, January 28, 2015 7:12 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH] test/pbap-client: Add support to fetch spd,fav PB
> 
> Adds support to fetch spd,fav phonebook.
> Tested using PTS test case TC_PCE_PBB_BV_01_C.
> ---
>  test/pbap-client | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/pbap-client b/test/pbap-client index 51e26eb..16a786b
> 100755
> --- a/test/pbap-client
> +++ b/test/pbap-client
> @@ -170,6 +170,6 @@ if  __name__ == '__main__':
> 
>  		pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
> 
> -	test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
> +	test_paths(["PB", "ICH", "OCH", "MCH", "CCH", "SPD", "FAV"])
> 
>  	mainloop.run()
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

