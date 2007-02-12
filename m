Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <b5dccebe0702090245o53dd36cwb62836b7d2b234d2@mail.gmail.com>
References: <b5dccebe0702090245o53dd36cwb62836b7d2b234d2@mail.gmail.com>
Date: Mon, 12 Feb 2007 20:42:38 +0100
Message-Id: <1171309358.11774.20.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] phone model and link manager version
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mikael,

> I wonder if there is you think there is any correlation between the
> Link Manager Protocol
> (LMP) Subversion and the model of a bluetooth phone. I mean, if I find
> out the LMP subversion of a remote device with for example hcitool,
> like this:
> 
> sudo hcitool info <bdaddr>
> 
> Requesting information ...
> ...
> LMP Version: 1.2 (0x2) LMP Subversion: 0x41c
> 
> Can this subversion be used to identify the model of the phone?
> 
> If not, can it be used to suggest that the phone is any of a small set
> of models?
> 
> If firmware updates are being made on the phone, will that affect the
> LMP subversion?
> 
> What process inside a phone manufacturer company decide that a
> Bluetooth chip with a certain LMP subversion ends up in a specific
> model? Is it just related to when the phone happened to be produced or
> is it somehow related to the model?

on some phones yes, on others no. The value is Bluetooth chip
manufacturer specific and nowadays doesn't tell you any details about
the phone.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
