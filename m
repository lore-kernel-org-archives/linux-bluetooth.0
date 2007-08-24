Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 24 Aug 2007 14:14:53 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
Message-ID: <Pine.LNX.4.63.0708241410030.12067@redbean.intranet.gw-instruments.de>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
	<1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] multithreaded name resolution
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


Hi Matthias,

On Fri, 24 Aug 2007, Matthias Becker wrote:

> Hi,
> 
> I tried to read the name of different devices parallel using multi
> threading, but without success. If there is one bluetooth device I works
> (as there is no real multi threading). If there are who devices, the
> same name is reported for both devices. In another test with 6 devices
> hci_read_remote_name returned something <0 so I did not get any name at
> all.

this won't work. Asking for the name of a device is some sort of 
connection setup, and most (all ?) Bt chips do not allow / can not handle 
parallel connection setups (even though parallel connections are 
possible). 

So don't try further, the problem is outside your code (and even BlueZ). 

Ciao, 

Peter 




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
