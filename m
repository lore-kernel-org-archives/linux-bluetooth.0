Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W2777B5DBF6DAA26AA0CA9EF0010@phx.gbl>
References: <BAY102-W2777B5DBF6DAA26AA0CA9EF0010@phx.gbl>
Date: Sat, 07 Jul 2007 00:00:24 +0200
Message-Id: <1183759224.4815.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] configure: error: Bluetooth library is required
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

fre 2007-07-06 klockan 16:57 +0000 skrev Robert Rawlins:

> And then when trying to configure my bluez utils i use
>  
> ./configure BLUEZ_LIBS=/usr/local/lib
>  
> And i still get the same issue that it cannot find the bluetooth
> libraries.

The universal cure to this is to use

  $ env BLUES_LIBS=/usr/local/lib ./configure

That way the variable BLUES_LIBS is guaranteed to enter the environment
for the new process.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
