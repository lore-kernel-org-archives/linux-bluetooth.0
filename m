Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cleaning up after sdp_get_access_protos()
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Stephen Crane <steve.crane@rococosoft.com>
In-Reply-To: <001401c51b9d$4c81af30$1a01010a@baked>
References: <001401c51b9d$4c81af30$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1109579551.17256.27.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Feb 2005 09:32:31 +0100

Hi Daryl,

> This stuff hurts my brain, so I was hoping someone (Marcel? ;) could verify
> my logic.
> 
> I'm mentioning this mostly because the utils code gets used as example code.
> 
> In this snippet from sdptool.c, proto is cleaned up with
> sdp_list_free(proto, (sdp_free_func_t)sdp_data_free);
> 
>         if (sdp_get_access_protos(rec, &proto) == 0) {
>                 printf("Protocol Descriptor List:\n");
>                 sdp_list_foreach(proto, print_access_protos, 0);
>                 sdp_list_free(proto, (sdp_free_func_t)sdp_data_free);
>         }
> 
> I think the cleanup should be:
> 
>     sdp_list_foreach(proto,(sdp_list_func_t)sdp_list_free,0);
>     sdp_list_free(proto,0);
> 
> Looking at sdp.c source (in libs), sdp_get_access_protos() returns a list of
> lists of data sequences. The data sequences themselves shouldn't be freed at
> this point because they weren't allocated by sdp_get_access_protos() (thus
> the ,0 in the sdp_list_foreach call). But the list of lists is allocated
> inside sdp_get_access_protos().

actually I have no idea, because I didn't wrote this code.

Steve, any thoughts?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
