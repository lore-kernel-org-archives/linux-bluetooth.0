Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Baseband Packets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <d1f423d30504181634cdd0a46@mail.gmail.com>
References: <12a241ad050415175936c651a1@mail.gmail.com>
	 <1113623792.16433.49.camel@pegasus>
	 <d1f423d305041815331d2e6698@mail.gmail.com>
	 <1113864236.16233.148.camel@pegasus>
	 <d1f423d30504181634cdd0a46@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1113868546.16233.153.camel@pegasus>
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
Date: Tue, 19 Apr 2005 01:55:46 +0200

Hi Anderson,

> I understand your arguments. But is It possible to interact with the
> LM by software? I mean, send PDUs ... Probably you have faced many
> many problems in order to build Bluez, and probably you have gained a
> huge experience and even you dont intend to implement it you have an
> idea of how i could start of doing it for academic porposes. Any help
> would be very welcome.

it is not possible to interact directly with the link manager. The only
way is over HCI.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
