Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5f30e2610608021526g5083268mad6565d7c13877f9@mail.gmail.com>
References: <5f30e2610608021526g5083268mad6565d7c13877f9@mail.gmail.com>
Date: Thu, 03 Aug 2006 12:29:45 +0200
Message-Id: <1154600985.3905.58.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] nonblocking socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Jeff,

> I am using bluez-libs-2.25 on 2.6.11-mh2 to develop BlueZ support for
> a multithreaded process.  My BlueZ contribution opens a non-blocking
> RFCOMM socket in one thread, and blocking SDP query in another.  So
> far, I have RFCOMM support working, and I have also integrated
> Bluetooth inquiry and SDP queries.
> 
> When I set RFCOMM to nonblocking, the sdp_connect returns an error,
> with errno set to EALREADY.  Why does one thread affect the other?
> 
> This same SDP query worked fine before I change the RFCOMM to nonblocking.

can you provide a simple test program for this? It sounds like a strange
bug with threading. However why do you need a non-blocking socket when
you are using threading?

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
