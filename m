Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fchevalier@silicom.fr>
In-Reply-To: <470A11D3.10707@silicom.fr>
References: <470A11D3.10707@silicom.fr>
Date: Mon, 08 Oct 2007 13:17:07 +0200
Message-Id: <1191842227.7931.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] STLC2500 updated patch
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

Hi Fabien,

> Here is an updated version of the STLC2500 patch. Compared to previous 
> patch versions, it adds support to speeds up to 4000000 bps.
> 
> * Add support for speed up to 4000000 bps.
> * Makes the firmware & parameters download optional : even though those 
> are supposed to be mandatory, practive shows that the chip can run 
> without them.
> * Cleanup the speed setting step : call the Ericsson routines directly 
> instead of duplicating the code.
> * Reset the chip only once after all settings & downloads have been done.

please break this down into four separate patches. I hate big patches
that try to fix everything in one go.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
