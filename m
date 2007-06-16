Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200706082336.00557.dgollub@suse.de>
References: <200706082336.00557.dgollub@suse.de>
Date: Sat, 16 Jun 2007 09:50:17 +0200
Message-Id: <1181980217.6846.78.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Cc: Stefan Seyfried <seife@suse.de>
Subject: Re: [Bluez-devel] [PATCH] Input Service - Support for
	hidd	configuration
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

Hi Daniel,

> attachted an input service patch which implements support for the hidd 
> configuration. This is needed to have a smooth transition from hidd daemon to 
> the new shiny input service ...
> 
> ( ... and especially this is needed to be able to return from vacation back to 
> the office - without getting blamed by Seife for not working bluetooth input 
> devices ;P )
> 
> The patch reads the entries of hidd and stores it with store_device_info() 
> function. The hidd doesn't get modified - this means the transition happens 
> on every start of the input service. store_device_info() avoids duplicate 
> entries. So there is still the possibility to have a working bluetooth input 
> device when falling back to hidd.

if I read this correctly, then a hidd entry would overwrite a input
entry. We can't let that happen.

Also the format of hidd and input is different, but you are using the
same function to parse it.

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
