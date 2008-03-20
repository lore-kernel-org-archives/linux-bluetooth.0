Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <039f01c88a15$a848aaa0$6701a8c0@freqonedev>
References: <1205440348.12951.9.camel@californication>
	<039f01c88a15$a848aaa0$6701a8c0@freqonedev>
Date: Thu, 20 Mar 2008 14:50:14 +0100
Message-Id: <1206021014.7678.7.camel@californication>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
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

Hi David,

> Thanks for all of the great effort, especially in moving toward the DBus model.
> 
> I am currently going through the work done to date in audio/control.c (the implementation of AVRCP), and am trying to apply that to 
> an application connecting with an AVRCP on CSR's BlueLab 4.0 framework (implements BT2.1+).  I have some ideas, although I am still 
> making sure I understand what has been done to this point, and would like to participate in further development (although I am not 
> the best C developer).
> 
> As things stand, it appears we could use more functions and callbacks to support UnitInfo, SubUnitInfo, Passthrough, and 
> VendorDependent (wherein Metadata resides), etc., and at the same time, I think we should not constrain the use cases to the simple 
> 10-button remote that has been implemented to date.
> 
> At any rate, I would like to get involved, as I have immediate interest in moving this forward.  I do have the official Bluetooth 
> specs and the CSR IDE, so I think I could contribute from that front.
> 
> Any interest?  Who should I communicate with?

go ahead and do so. Patches are always welcome. However, please start a
new thread for it.

Regards



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
