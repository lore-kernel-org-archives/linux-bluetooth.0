Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <988EE2C769AC284ABAE9328BFC10703F0B9733@ZMY16EXM66.ds.mot.com>
References: <988EE2C769AC284ABAE9328BFC10703F0B9733@ZMY16EXM66.ds.mot.com>
Date: Fri, 24 Aug 2007 14:08:13 +0200
Message-Id: <1187957293.15402.139.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluez with MISPEL
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

Hi Sinah,

> I am trying to install Bluez driver in BusyBox which is MISPEL
> chipset.
> BlueZ util has a dependency on 'hal.pc'. I downloaded the hal-0.5.9.1.
> The hal configuration has dependency on expat. I installed expat but
> while running the configuration of hal I am getting error msg: 
> checking for XML_ParserCreate in -lexpat.... no
> configuration: error: Can't find expat library. Please install expat.

it has no HAL and Expat dependency. These components are optional. You
can use --disable-hal and --disable-expat.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
