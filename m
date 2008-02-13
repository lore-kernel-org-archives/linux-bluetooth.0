Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 13 Feb 2008 15:16:42 +0200
Message-ID: <5976F853A3B35845B6375F0C1FE13EB30315351E@hasmsx415.ger.corp.intel.com>
In-Reply-To: <1202487825.15090.308.camel@violet>
References: <5976F853A3B35845B6375F0C1FE13EB303115489@hasmsx415.ger.corp.intel.com>
	<1202487825.15090.308.camel@violet>
From: "Glickman, Claudio" <claudio.glickman@intel.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDIO support
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Thanks Marcel. We'll try it.
Does anybody know about an SDIO specific device tested with BlueZ stack?
Any modifications required to the generic driver?
Thanks,
Claudio
 

>-----Original Message-----
>From: bluez-users-bounces@lists.sourceforge.net 
>[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf 
>Of Marcel Holtmann
>Sent: Friday, February 08, 2008 6:24 PM
>To: BlueZ users
>Subject: Re: [Bluez-users] SDIO support
>
>Hi Claudio,
>
>> Are there any developments in progress concerning BlueZ support for
>> Bluetooth devices over SD/SDIO protocol?
>
>BlueZ and SDIO works perfectly together. You only need a 
>kernel with the
>SDIO support and the generic Bluetooth SDIO driver (btsdio). Both have
>been merged upstream and can be found in 2.6.24. The Bluetooth SDIO
>device has to comply with the Type-A or Type-B standard.
>
>Regards
>
>Marcel
>
>
>
>---------------------------------------------------------------
>----------
>This SF.net email is sponsored by: Microsoft
>Defy all challenges. Microsoft(R) Visual Studio 2008.
>http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
