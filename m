Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085937625.4462.5.camel@localhost.localdomain>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
	 <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
	 <1085937625.4462.5.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1086042128.4690.16.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 01 Jun 2004 00:22:08 +0200

Hi David,

> This patch adds support to pand for writing a pidfile and cleaning up
> the client connection on exit. I'll go play with initscripts next...

I applied this patch with some small modifications. And btw you forgot
the diff for the man page ;)

>  static struct option main_lopts[] = {
>  	{ "help",     0, 0, 'h' },
>  	{ "listen",   0, 0, 's' },
> @@ -405,6 +481,8 @@
>  	{ "encrypt",  0, 0, 'E' },
>  	{ "master",   0, 0, 'M' },
>  	{ "cache",    0, 0, 'C' },
> +	{ "pidfile",  1, 0, 'P' },
> +	{ "autokill", 0, 0, 'a' },
>  	{ 0, 0, 0, 0 }
>  };

I don't like --autokill and -a option. I named it --autozap and used -z
as option.

> +		case 'P':
> +			pidfile = strdup(optarg);
> +			break;
> +
> +		case 'a':
> +			cleanup = 1;
> +			break;
> +

If you don't modify main_sopts, this won't work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
