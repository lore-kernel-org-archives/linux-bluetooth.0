Return-Path: <cyrus@holtmann.org>
Message-ID: <4A740918.1040504@hartkopp.net>
Date: Sat, 01 Aug 2009 11:21:28 +0200
From: Oliver Hartkopp <oliver@hartkopp.net>
MIME-Version: 1.0
To: Dave Young <hidave.darkstar@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Linux Netdev List <netdev@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: tty_register_device NULL pointer dereference in 2.6.31-rc4
References: <20090727095904.GA5442@darkstar> <4A6D8BA3.3030601@hartkopp.net> <4A6D91D7.6030204@hartkopp.net> <20090727140736.GA1864@darkstar> <4A705604.3040807@hartkopp.net> <a8e1da0907300215q3934da47g3676648e3b247af8@mail.gmail.com> <4A717083.5090101@hartkopp.net> <20090731093949.GA4867@darkstar> <a8e1da0907310310h483cedeeg433947d51345246c@mail.gmail.com> <4A72D373.7080802@hartkopp.net> <20090801031705.GA2817@darkstar>
In-Reply-To: <20090801031705.GA2817@darkstar>
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>


> --- linux-2.6.orig/include/net/bluetooth/rfcomm.h	2009-08-01 10:53:18.000000000 +0800
> +++ linux-2.6/include/net/bluetooth/rfcomm.h	2009-08-01 10:55:29.000000000 +0800
> @@ -355,7 +355,18 @@ struct rfcomm_dev_list_req {
>  };
>  
>  int  rfcomm_dev_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
> +
> +#ifdef CONFIG_BT_RFCOMM_TTY
>  int  rfcomm_init_ttys(void);
>  void rfcomm_cleanup_ttys(void);
> -
> +#else
> +static inline int rfcomm_init_ttys(void)
> +{
> +	return 0;
> +}
> +static inline int rfcomm_cleanup_ttys(void)
> +{
> +	return 0;
> +}
> +#endif

Just a minor thing:

Does rfcomm_cleanup_ttys() return 'int' or is it 'void' ?

Regards,
Oliver
