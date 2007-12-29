Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4775870C.4030304@yahoo.es>
References: <47754D1D.9020907@yahoo.es> <1198881591.4455.30.camel@aeonflux>
	<4775870C.4030304@yahoo.es>
Date: Sat, 29 Dec 2007 06:00:00 +0100
Message-Id: <1198904400.4455.34.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcitool and argv syntax
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Perki,

> > your patch is way too complicated. You can simply check for
> > command[i].cmd == NULL to print the error.
> You're completely right. I don't know what I was thinking on.
> > 
> > And of course you have to follow the coding style. I am not joking with
> > this one. It is the main reason for me to reject patches.
> I've replaced 3-space-tabs with real tabs.
> 
> --- hcitool.c.orig	2007-12-28 20:06:58.000000000 +0100
> +++ hcitool.c	2007-12-29 00:09:03.000000000 +0100
> @@ -2329,5 +2329,11 @@
>  		command[i].func(dev_id, argc, argv);
>  		break;
>  	}
> -	return 0;
> +
> +	if(!command[i].cmd) {

put a space between "if" and "("
> +		fprintf(stderr, "\"%s\" isn't a valid command. Try --help for a list
> of commands.\n", argv[0]);

A line should not exceed 78 characters. So either shorten it or break it
up.

> +		exit(EXIT_FAILURE);
> +	}
> +
> +	exit(EXIT_SUCCESS);

You have to use "return 0". Otherwise you get a compiler warning.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
