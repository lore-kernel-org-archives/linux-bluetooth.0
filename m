Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <421A15C6.8090400@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: mystic AT-Command
References: <cv4qgt$8h4$1@sea.gmane.org> <4215FC4A.20504@dark-reality.de> <cv50e9$tm3$1@sea.gmane.org> <42161CC7.1090800@dark-reality.de> <cv7vnn$b2i$1@sea.gmane.org> <4217E058.2000805@xmission.com> <cvc5d5$lij$1@sea.gmane.org>
In-Reply-To: <cvc5d5$lij$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 21 Feb 2005 10:09:26 -0700

Sebastian

I fixed btsco2 also.

Brad

> Can you please merge this in btsco2 too.
> 
> diff -u -r1.1 btsco2.c
> --- btsco2.c    1 Dec 2004 12:02:58 -0000       1.1
> +++ btsco2.c    21 Feb 2005 08:15:25 -0000
> @@ -387,10 +387,9 @@
>                 return 0;
>         buf [rlen] = 0;
>         fprintf(stderr, "recieved %s\n", buf);
> -       if (strstr(buf, "AT+BVRA="   )) opdone = headset_button(headset);
> -       else if (strstr(buf, "AT+CKPD=200")) opdone = 
> headset_button(headset);
> -       else if (strstr(buf, "AT+CHUP"    )) opdone = 
> headset_button(headset);
> -       else if (strstr(buf, "AT+CIND=?"  )) opdone = 
> headset_button(headset);
> +       if (strstr(buf, "AT+CKPD=200"   )) opdone = 
> headset_button(headset);
> +       else if (strstr(buf, "AT+CHUP"  )) opdone = 
> headset_button(headset);
> +       else if (strstr(buf, "AT+CIND=?")) opdone = 
> headset_button(headset);
>         else if (sscanf (buf, "AT+VGS=%d", &headset->volumes[0]) == 1) 
> opdone = headset_speaker (headset);
>         else if (sscanf (buf, "AT+VGM=%d", &headset->volumes[1]) == 1) 
> opdone = headset_micro   (headset);
>         if (opdone == 1)
> 
> 
> Best regards,
> Sebastian
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
