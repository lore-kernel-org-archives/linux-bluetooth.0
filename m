Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fe0a97c20606090546w4e53ca48o61f338c44708283@mail.gmail.com>
References: <fe0a97c20606090546w4e53ca48o61f338c44708283@mail.gmail.com>
Date: Sat, 17 Jun 2006 13:09:02 +0200
Message-Id: <1150542542.17539.69.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Limit on the rfcomm socket buffer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Sowmaya,

> I think that the rfcomm sockets can't take as large as 1024 bytes
> unlike TCP/IP (it gets stuck and I get this "Resource temporarily
> unavailbale" error incase I wanna reuse it) .... I know its the
> SOCKET_STREAM thing , but I want to know is there any limit on the
> socket buffer??? 

the kernel socket buffers limits it, but this should be something around
32k or so.

If you can reproduce an error condition, please send in a sample program
and the output of "hcidump -X -V".

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
