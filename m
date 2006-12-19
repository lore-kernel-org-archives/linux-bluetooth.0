Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4587E9E6.40302@idlum.be>
Date: Tue, 19 Dec 2006 14:32:22 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <c49421c50612190525h197663fcu79da33f496526f45@mail.gmail.com>
In-Reply-To: <c49421c50612190525h197663fcu79da33f496526f45@mail.gmail.com>
Subject: Re: [Bluez-users] notification of baseband conection establishment
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

Hello Loreno,

> does anybody know some facility for a called device to detect the 
> establishment of a baseband connection?

The DBus API already offers that:

Signals from the Adapter hierarchy (from dbus-api.txt):

void RemoteDeviceConnected(string address)
	This signal will be send if a low level connection
	between two devices has been created.

void RemoteDeviceDisconnected(string address)
	This signal will be send if a low level connection
	between two devices has been terminated.

Regards,
Pierre-Yves

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
