Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60706281242j2029d6c3mfd09407e9e8cd2b6@mail.gmail.com>
References: <be976db60706281242j2029d6c3mfd09407e9e8cd2b6@mail.gmail.com>
Date: Thu, 28 Jun 2007 22:21:04 +0200
Message-Id: <1183062064.9499.46.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluetooth qualification
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

Hi Mark,

> I believe Bluez is Bluetooth 2.0 compliant.  But I am unable to find
> any official mention of that anywhere.
> Can someone point out where I can find out more about Bluez and which
> Bluetooth spec version is it compliant to? 

using a 2.6.22 kernel and bluez-utils-3.11 gives you a full Bluetooth
2.0 compliant stack from the GAP perspective. It will pass all
qualification tests for L2CAP, RFCOMM, GAP and SPP, but we don't have a
public qualification record for it.

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
