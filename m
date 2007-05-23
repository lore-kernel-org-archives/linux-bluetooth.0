Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46548395.1070208@access-company.com>
Date: Wed, 23 May 2007 20:10:29 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <464B36D4.80702@access-company.com>	<1179666685.10069.250.camel@violet>	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>	<4653218D.3090504@access-company.com>	<1179854658.9152.37.camel@aeonflux.holtmann.net>	<46533F31.9090406@access-company.com>	<1179868135.9152.39.camel@aeonflux.holtmann.net>	<46536A7D.7010500@access-company.com>
	<1179872473.9152.49.camel@aeonflux.holtmann.net>
In-Reply-To: <1179872473.9152.49.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Fix for disconnection in new serial service
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

Hello,

Using the latest cvs revision, I saw that this problem has been fixed (using RFCOMM_HANGUP_NOW when rfcomm device is released).

Sorry

Fred

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
