Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with connect()
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hennrich <tettokalle@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FFD826F.5080808@hotmail.com>
References: <3FFD826F.5080808@hotmail.com>
Content-Type: text/plain
Message-Id: <1073583332.2563.24.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 08 Jan 2004 18:35:32 +0100

Hi Christian,

> I'm working on a programm which uses sdp to connect only to PANU, 
> creating l2cap and bnep connections. First i start the master, that 
> inquires and then connects to the discovered devices (using sdp), that 
> are started as slaves. 2 slaves are connected(with one L2cap and one 
> Bnep for each slave). this works very fine. then i want to connect the 
> third and so on... but there is the problem: the third one can't connect 
>    with sdp on or off. the connect(socket) command fails with the error:
> 
> Connect failed. Function not implemented(38).
> 
> on the slave machine is only one program started. i tried around with 
> different dongles, but they are not the problem. what is wrong? has 
> anybody some idea? i don't use fork. the sockets that are created(have 
> all different numbers(increasing)). is there any limitation of creating 
> sockets or something like this.
> 
> i think the problem is the master, because on the clients there are only 
> 2 sockets created. i only have one dongle per pc.

I don't even understand what your setup is, but have you checked that
role switch is allowed? Check the connection establishment with hcidump.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
