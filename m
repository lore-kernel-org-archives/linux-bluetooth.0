Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0606131103210.23334@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0606131103210.23334@redbean.intranet.gw-instruments.de>
Date: Tue, 13 Jun 2006 13:10:12 +0200
Message-Id: <1150197013.2534.23.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils-3.0 cross compile broken
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

Hi Peter,

> somewhere on the road from 2.25 (last working for me) and 3.0 (not 
> working) the configure script for bluez utils seems to get broken if the 
> bluez libs are not in the standard place. Neither setting --libdir=.... 
> nor setting environment variable BLUEZ_LIB works. The configure script 
> always stops because it doesn't find the BLUEZ libs (error: Bluetooth 
> library is required). The library is definitly where it should be. 

the bluez-utils-3.0 is now using pkg-config for the library detection.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
