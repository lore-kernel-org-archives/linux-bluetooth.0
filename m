Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C03@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C03@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099078907.6912.23.camel@pegasus>
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
Date: Fri, 29 Oct 2004 21:41:46 +0200

Hi Abhi,

don't forget to use the "Reply to All" button ;)

> > it is the same. I already committed the needed stuff to the CVS and
> > changed rctest to set them. However without a correct kernel the call of
> > setsockopt() will fail.
> I am not clear on what this means. Could you please explain what it is that
> you've added and committed in to CVS ?

I like to say look at my latest changes in the CVS and look at rctest,
but it seems that the anonymous CVS is not in sync with the developer
CVS. Again, this is a Sourceforge problem and I heard of other projects
that had the same problems at the moment.

However, I added RFCOMM_LM and RFCOMM_LM_AUTH resp. RFCOMM_LM_ENCRYPT
with the same values as we used for their L2CAP_* counterparts. So you
can use the setsockopt() with these values to achieve the same effect as
you expect on L2CAP. But without a kernel that knows about RFCOMM_LM the
setsockopt() and getsockopt() calls will fail.

And btw I got the service level security for incoming RFCOMM channels
working on my development system and I did it without modifying the
current state machine and it is hopefully SMP safe. I think we need
another timer on the server side that kills the connection if nobody
wants to authenticate, but thats another thing to look at. So someone
owes me a crate full of beer :)

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
