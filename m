Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] phone+heaset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F55rqLvw2FZ8ZX00039a1b@hotmail.com>
References: <Sea2-F55rqLvw2FZ8ZX00039a1b@hotmail.com>
Content-Type: text/plain
Message-Id: <1073657615.2563.81.camel@pegasus>
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
Date: Fri, 09 Jan 2004 15:13:35 +0100

Hi Joao,

> >read it again, because if I am not wrong only the headset can send
> >+ckpd=200. And you also have to answer any command from the headset with
> >ok or error.
> 
> i think i'm doing it right, because is the pc, that i want to work like a 
> headset of the phone, who send the +ckpd=200, and receve a ok from the 
> phone.

in that case you have to wait for the incoming SCO connection from your
phone. I have not so much time to read the headset profile again, but
from what I remember is that the phone have to establish the SCO link if
the headset sends +ckpd=200. Check the specification by yourself.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
