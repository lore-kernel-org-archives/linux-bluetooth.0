Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: hci event bug for Nokia 7650
From: Marcel Holtmann <marcel@holtmann.org>
To: radoa <cat@pobox.sk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20041029T203002-259@post.gmane.org>
References: <loom.20041029T194010-621@post.gmane.org>
	 <1099073484.6912.0.camel@pegasus> <loom.20041029T203002-259@post.gmane.org>
Content-Type: text/plain
Message-Id: <1099076638.6912.5.camel@pegasus>
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
Date: Fri, 29 Oct 2004 21:03:58 +0200

Hi Radoa,

> Kernel version is 2.6.9 with Bluetooth kernel patch 2.6.9-mh2.
> Here is code (dst address is changed):
> 
> int test_connect() 
> {
>   struct sockaddr_l2 sa;
>   int fd, ret;
>   bdaddr_t *dst = {{0, 1, 2, 3, 4, 5}};
> 
>   // success
>   fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> 
>   sa.l2_family = AF_BLUETOOTH;
>   sa.l2_psm = htobs(SDP_PSM);               // 0x0001
>   sa.l2_bdaddr = *dst; 
> 
>   // this will fail
>   ret = connect(fd, (struct sockaddr *)&sa, sizeof(sa));
> 
>   return ret;
> }

actually I don't understand how that should ever work. Do you looked at
the example code? We don't do these nasty BD_ADDR tricks. You should
better use this one:

	str2ba("aa:bb:cc:dd:ee:ff", &sa.l2_bdaddr);

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
