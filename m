Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP chnnel
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <E1EFR9z-0001K1-00.bizon_art-mail-ru@f48.mail.ru>
References: <E1EFR9z-0001K1-00.bizon_art-mail-ru@f48.mail.ru>
Content-Type: text/plain
Message-Id: <1126703758.16166.34.camel@station6.example.com>
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
Date: Wed, 14 Sep 2005 15:15:58 +0200

Hi,

>     I`m try to write application that send and recive data over L2CAP channel, between PC and my custom arm board. I have a next problem. I dont understand haw create a socket, if PC must inquirying and connect to my board. Device must remain slave in piconnect.
>     I`m try run next simpl daemon on my custom arm board:
> 
> 	struct sockaddr_l2 L2capAddr;
> 	int iSockFd;
> 	iSockFd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
> 	if (iSockFd == -1) {
> 		TRACE1("opening L2CAP socket: %s", strerror(errno));
> 		return -1;
> 	};
> 	L2capAddr.l2_bdaddr = *BDADDR_ANY;
> 	/*L2capAddr.l2_bdaddr = *strtoba( strdup("78:A1:1F:96:A0:00"));*/
> 	L2capAddr.l2_family = AF_BLUETOOTH;
> 	L2capAddr.l2_psm    = htobs(SDP_PSM); // I sigth this valuer in Tsimbal code
> 	if(0 > bind(iSockFd, (struct sockaddr *)&L2capAddr, sizeof(L2capAddr)))
> 	{
> 		TRACE1("binding L2CAP socket: %s", strerror(errno));
> 		return -1;
> 	}
> 	incoming = listen(iSockFd, ACTIVE_CONN_MAX);
> 
> But ACL connection don`t establishing. The hcidump on board give next chat

what about using "hcidump -X -V", because I am no longer decoding hex
numbers.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
