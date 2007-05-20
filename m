Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0705200633k711b8744y8d81e7e9c31195bc@mail.gmail.com>
References: <e96e9eeb0705200633k711b8744y8d81e7e9c31195bc@mail.gmail.com>
Date: Sun, 20 May 2007 15:57:07 +0200
Message-Id: <1179669427.23757.1.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] sdpd problem
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

Hi Voni,

> I am working on embedded without d-bus so I have used utils and libs ver 2.25.

whatever reason works for you not installing D-Bus. However I said this
multiple times. The 2.x series is deprecated and no longer supported.

> When I start hcid and then hciattach, the device is automatically getting up
> by hcid, and everything is working.
> 
> but, when I start hcid AND sdpd, and then hciattach, the device stays DOWN...
> 
> Do you have any idea why this is happening ?

No idea.

> And, what does sdpd give me ? do I need it ?

It implements the SDP server for service discovery.

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
