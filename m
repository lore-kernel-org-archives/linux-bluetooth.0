Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <009601c47642$9c950ef0$79000f0a@matrix>
From: "Virat Gohil" <virat4lug@hotpop.com>
To: <johan@vandenbrande.com>, <bluez-users@lists.sourceforge.net>
References: <64925.213.118.22.110.1091145636.squirrel@webmail.fusebox.be>
Subject: Re: [Bluez-users] Palm connection problems.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Fri, 30 Jul 2004 20:06:24 +0530

> Hi,
>
> I'm facing a problem connecting my Palm|T to my linux box.

> I can connect to the Palm manually (at least, the Palm says 'connection in
> progress') using:
> rfcomm connect /dev/rfcomm0 00:07:E0:0E:00:3A 1

# rfcomm bind 0 00:07:E0:0E:00:3A 1

the 1 at the end refers to the channel no. for DUN on your mobile, usually
its 1, check out your palm's channel.

> Anybody who knows what the problem can be?
>
> Johan

Regards,

Virat




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
