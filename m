Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] phone+heaset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F62gC2DWpmy20h00009644@hotmail.com>
References: <Sea2-F62gC2DWpmy20h00009644@hotmail.com>
Content-Type: text/plain
Message-Id: <1073583113.2563.17.camel@pegasus>
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
Date: Thu, 08 Jan 2004 18:31:54 +0100

Hi Joao,

> I think you are talking about this:
> 
> [root@olivia scoinfo-0.1]# ./scoinfo -i hci0
> PSKEY_HOSTIO_MAP_SCO_PCM: 0x00
> 
> and this means that the SCO traffic goes over HCI, as you already told me.
> 
> So what is the problem.

do you read the headset profile specification? You have to answer the AT
commands on the RFCOMM channel. Look at hstest.c for an example.

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
