Return-Path: <mfrey@pepper.com>
In-Reply-To: <1090865790.29589.5.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76F28965-DF34-11D8-B83A-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Mon, 26 Jul 2004 14:49:03 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Thanks for the help.  However I do not have sockfd_lookup()  in 
net/bluetooth/bnep/core.c
Am I that out of date?  Is there a more recent patch I should apply?

Michael


On Jul 26, 2004, at 2:16 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> ok -- got past those -- now here are some more.
>
> your kernel is a little bit outdated ;)
>
>> sock.c: In function `hidp_sock_ioctl':
>> sock.c:84: warning: implicit declaration of function `sockfd_lookup'
>> sock.c:84: warning: assignment makes pointer from integer without a 
>> cast
>> sock.c:88: warning: assignment makes pointer from integer without a 
>> cast
>
> Copy sockfd_lookup() from net/bluetooth/bnep/core.c
>
>> sock.c: In function `hidp_init_sockets':
>> sock.c:200: error: `BTPROTO_HIDP' undeclared (first use in this
>> function)
>> sock.c:200: error: (Each undeclared identifier is reported only once
>> sock.c:200: error: for each function it appears in.)
>> sock.c: In function `hidp_cleanup_sockets':
>> sock.c:210: error: `BTPROTO_HIDP' undeclared (first use in this
>> function)
>> make[3]: *** [sock.o] Error 1
>
> Here is a patch for that problem. It is already in the mainline tree.
>
> diff -Nru a/include/net/bluetooth/bluetooth.h
> b/include/net/bluetooth/bluetooth.h
> --- a/include/net/bluetooth/bluetooth.h 2004-07-26 20:15:15 +02:00
> +++ b/include/net/bluetooth/bluetooth.h 2004-07-26 20:15:15 +02:00
> @@ -52,6 +52,7 @@
>  #define BTPROTO_RFCOMM 3
>  #define BTPROTO_BNEP   4
>  #define BTPROTO_CMTP   5
> +#define BTPROTO_HIDP   6
>
>  #define SOL_HCI     0
>  #define SOL_L2CAP   6
> diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> --- a/net/bluetooth/af_bluetooth.c      2004-07-26 20:15:15 +02:00
> +++ b/net/bluetooth/af_bluetooth.c      2004-07-26 20:15:15 +02:00
> @@ -57,7 +57,7 @@
>  #endif
>
>  /* Bluetooth sockets */
> -#define BLUEZ_MAX_PROTO        6
> +#define BLUEZ_MAX_PROTO        7
>  static struct net_proto_family *bluez_proto[BLUEZ_MAX_PROTO];
>
>  int bluez_sock_register(int proto, struct net_proto_family *ops)
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
