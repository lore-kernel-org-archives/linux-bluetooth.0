Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179674287.32091.109.camel@dipsy>
References: <1179674287.32091.109.camel@dipsy>
Date: Sun, 20 May 2007 17:26:18 +0200
Message-Id: <1179674779.23757.10.camel@violet>
Mime-Version: 1.0
Cc: Edward OCallaghan <victoredwardocallaghan@yahoo.com.au>
Subject: Re: [Bluez-devel] Sony BD Remote Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frank,

> I gathered some information about the Sony BD Remote Control, available
> at [1].
> 
> Basically, it's possible to connect it, and with hidd it also gets
> automatically reconnected - not on a PS3 at the moment, but this should
> be known. The problem is that this thing only sends a vendor defined
> 11-byte input data package. Currently it's only a useless brick.
> 
> So I'm looking for ways to get it to send some input events. One vague
> idea is to put some special treatment into hidd, like it was done with
> some other devices in fakehid.c.

the hidd will be obsoleted by the input service.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
