Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <fc3d922d0707030446l5caf4a11q8b740068e59d4a01@mail.gmail.com>
References: <fc3d922d0707030446l5caf4a11q8b740068e59d4a01@mail.gmail.com>
Date: Thu, 05 Jul 2007 10:09:44 +0200
Message-Id: <1183622984.6351.83.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Authentication in Samsung sgh-z630
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

Hi,

> I've got application, that sends to all phones in range files through
> bluetooth object push.
> I create connection with phones like that
> btgoep://[macaddress]:9;authenticate=false;encrypt=false;master=false 
> 
> With nokia phones or sony ericsson there is no problems, they just ask
> about permission.
> Do you want to accept connection?
> 
> But samsung sgh-z630 ask for PIN number.
> Maybe there is something, I need to change in cell settings. 

I guess it uses security mode 3 and then behavior is normal.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
