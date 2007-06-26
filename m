Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46812123.4030908@free.fr>
Date: Tue, 26 Jun 2007 16:22:27 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <467FD4DF.9090108@free.fr>
	<1182808431.6385.30.camel@aeonflux.holtmann.net>
In-Reply-To: <1182808431.6385.30.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Kernel vs Userland AVDTP
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

Hi Marcel,

> at some point, yes. Currently it makes no sense to start with a kernel
> version of AVDTP. Also Bluetooth 2.1 and 3.0 are gonna have high impact
> on L2CAP and I wanna have that settled first before considering a kernel
> based AVDTP, because it is not that simple. It would be as complex as
> RFCOMM and so keeping it in userspace is better for now.
> 
I would tend to agree with you, specially on the fact that it would be 
quite complex to implement.
But what about a user space library? Do you thing that would make sense ?

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
