Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with connect()
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hennrich <tettokalle@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FFEB4E0.3070603@hotmail.com>
References: <3FFD826F.5080808@hotmail.com>
	 <1073583332.2563.24.camel@pegasus>  <3FFEB4E0.3070603@hotmail.com>
Content-Type: text/plain
Message-Id: <1073657444.2563.77.camel@pegasus>
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
Date: Fri, 09 Jan 2004 15:10:45 +0100

Hi Christian,

> today i tried to connect more than 2 slaves with pand -c "Addresse of 
> master" to one master that is started with pand -s -r GN. the same 
> problem occurs, i can't connect more than 2 slaves to one master, the 
> third one makes no connection.

you are connecting two master ;) Think again about the master/slave
roles of a Bluetooth device. You must use the role switch. What do
"hciconfig -a" say?

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
