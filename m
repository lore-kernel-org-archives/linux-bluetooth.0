Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] LM_AUTH and LM_ENCRYPT support for
	outgoing sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4316C4A0.1070100@palmsource.com>
References: <4316C4A0.1070100@palmsource.com>
Content-Type: text/plain
Message-Id: <1125922059.11955.15.camel@pegasus>
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
Date: Mon, 05 Sep 2005 14:07:39 +0200

Hi Fred,

> The following patch adds supports of LM_AUTH and LM_ENCRYPT flags for outgoing L2CAP and RFCOMM sockets.

I am still not sure if LM_AUTH and LM_ENCRYPT support is needed for
outgoing connection, but I would add it if the implementation is sane
and it is tested enough.

> diff -ruN linux-2.6.12.5/include/net/bluetooth/bluetooth.h linux-2.6.12.5-fda/include/net/bluetooth/bluetooth.h
> --- linux-2.6.12.5/include/net/bluetooth/bluetooth.h	2005-08-15 02:20:18.000000000 +0200
> +++ linux-2.6.12.5-fda/include/net/bluetooth/bluetooth.h	2005-08-25 10:43:47.000000000 +0200
> @@ -73,6 +73,7 @@
>  	BT_LISTEN,
>  	BT_CONNECT,
>  	BT_CONNECT2,
> +	BT_CONNECT3,
>  	BT_CONFIG,
>  	BT_DISCONN,
>  	BT_CLOSED

Without fully looking at the rest of your patch, I can tell you that we
can't do it this way. This will break the userspace, because we use the
same enum in userspace. Please find another way.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
