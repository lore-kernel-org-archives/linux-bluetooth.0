Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] phone+heaset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <SEA2-F33wlVZmSox9fS00030187@hotmail.com>
References: <SEA2-F33wlVZmSox9fS00030187@hotmail.com>
Content-Type: text/plain
Message-Id: <1073588371.2563.69.camel@pegasus>
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
Date: Thu, 08 Jan 2004 19:59:31 +0100

Hi Joao,

> I already had read the hset profile specification and i had change the 
> program hstest.c to send at+ckpd=200 instead of ring (used if i want to make 
> a sco link between the pc and a bluetooth headset), and nothing, i dont 
> receve any sco data.

read it again, because if I am not wrong only the headset can send
+ckpd=200. And you also have to answer any command from the headset with
ok or error.

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
