Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ohad Ben-Cohen <ohad@bencohen.org>
In-Reply-To: <200704301139.44842.ohad@bencohen.org>
References: <200704301139.44842.ohad@bencohen.org>
Date: Fri, 04 May 2007 08:49:56 +0200
Message-Id: <1178261396.25425.35.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH bluez-utils] add support for Texas
	Instruments' BRF63xx	chips
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

Hi Ohad,

> Introduces initializing procedures for Texas Instruments' BRF63xx chips.
> These procedures take care of:
> 1. Loading TI's init script
> 2. Setting up HCILL, TI's runtime power-management UART protocol

patch looks good, but needs some major cleanups. Especially the header
file stuff needs fixing. However without hardware to test this with, I
am not going to touch it.

> An additional, tiny feature, which proved useful for
> stress checkings, is added to l2test: random delays.

Please never combine totally unrelated things into one big patch. This
needs to be a separate patch.

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
