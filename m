Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket CF Rev G or H working?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jay W. Summet" <summetj@cc.gatech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0410261602020.4862@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410261602020.4862@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1098826982.14036.123.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 26 Oct 2004 23:43:02 +0200

Hi Jay,

> I have an offer from Socket to replace my Rev F card with their latest
> card (rev H).  (It is my understanding that cards after rev G use the new
> CSR chipset.) But, they don't know if it's supported under Linux.

ask them for a test device and tell them to also send me one.

> Does anybody have a Socket CF bluetooth adaptor, REV G or H that works for
> you?

We have problems with some serial based cards. They got detected correct
with a 2.6 kernel, but they don't work as expected. Some of them do and
others don't. Using the latest 2.6.10-rc1 this may have changed, because
there was some ongoing work in the serial subsystem. However I don't
know, because I am not an expert in this area.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
