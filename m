Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5dccebe0611190350p4801a631m3cca5cc0b5c9abb3@mail.gmail.com>
References: <b5dccebe0611190350p4801a631m3cca5cc0b5c9abb3@mail.gmail.com>
Date: Sun, 19 Nov 2006 13:47:51 +0100
Message-Id: <1163940471.11790.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] permissions to set local name
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

Hi Mikael,

> I've noticed that only the superuser may perform some hci commands,
> such as OCF_WRITE_LOCAL_NAME and OCF_WRITE_INQUIRY_MODE. How can I
> grant privileges for other users to perform those commands?
> 
> The problem is that I have an application that needs to set those
> paramaters, but I don't want to run the application as root. 

the inquiry mode should never be set by an application. It is up to hcid
to pick the best inquiry mode.

The local name can be set via the D-Bus interface and no root privileges
are needed.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
