Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 15 May 2007 02:16:32 +0200
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
	<200705150200.43977.bluez-devel@huitl.de>
In-Reply-To: <200705150200.43977.bluez-devel@huitl.de>
MIME-Version: 1.0
Message-Id: <200705150216.33013.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] skype and bluetooth
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

On Dienstag, 15. Mai 2007, Robert Huitl wrote:
> So either
> 1) Skype tries to use a sample format that is not supported at all or
> 2) the sample format is okay but it fails because of the missing kernel
> patch 3) there's some other problem ;-)
>
> You could try the patch to see if it helps.

Okay I just tried the patch myself. arecord works fine with the s16_le sample 
format, but Skype does not.

Robert

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
