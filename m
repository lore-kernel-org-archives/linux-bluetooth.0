Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099065198.28599.57.camel@baroque.rococosoft.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C01@il93exb05.corp.mot.com>
	 <1099065198.28599.57.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1099069525.10164.78.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Oct 2004 19:05:25 +0200

Hi Steve,

> > Sorry for the confusion but I wasn't referring to user space at all. I was thinking of having the rfcomm service level security implemented in almost the same way as the l2cap service level security(incoming connection). The service level security options could be set using setsockopt(..) in rfcomm. This in turn could be used to set the service level settings for the l2cap socket it uses. I can draw a sequence diagram(function calls) to show how i
> > picture the design. I'll do that.
> 
> I think that from the user-space's point of view, the interface should
> be identical. (In fact I think this is already supported, just not
> acted-upon: you do setsockopt(sock, SOL_RFCOMM, ...).)

it is the same. I already committed the needed stuff to the CVS and
changed rctest to set them. However without a correct kernel the call of
setsockopt() will fail.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
