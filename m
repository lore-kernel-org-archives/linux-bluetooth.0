Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4728B6FD.50205@infitsrl.com>
References: <4728B6FD.50205@infitsrl.com>
Date: Wed, 31 Oct 2007 18:26:33 +0100
Message-Id: <1193851593.32459.83.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About bluetooth 2.1
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

Hi Fabrizio,

> I've read about optimized inquiry in bluetooth 2.1, If I understood 
> correctly the inquiry return remote device name and services list 
> information of the discovered remote devices.
> In current version to obtain the same result I've to make an inquiry a 
> name request and a sdp query for every remote device discovered.
> My question is, given that the new protocol is compatible with the old, 
> if I make an inquiry using a 2.1 dongle with blueZ I don't need to make 
> name and service  discovery or it's required because the optimized 
> inquiry works only between devices with 2.1 version?

you need to have Bluetooth 2.1 dongles and host stacks supporting 2.1 on
both sides to make this work.

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
