Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [Patch] Samsung D600 (sdp, service discovery
	deadlocks)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1132691970.9887.14.camel@localhost.localdomain>
References: <1132691970.9887.14.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1132806128.5982.18.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Nov 2005 05:22:08 +0100

Hi Victor,

> We experienced some deadlock in the bluez library for Samsund-D600 phone
> during service discovery. This is due to incorrect SDP record set
> returned on service inquiry request. The response from the SDP server
> contains service records + some rubbish at the end. So when it tries to
> parse it, sdp_extract_pdu() returns 0 recsize and locks the while()
> loop.

the patch is in the CVS now. Thanks.

> Samsung is informed, but I do not know if they will come up with
> something (have no idea who provides the stack for them, they have a
> Broadcom chip in there)

Don't expect anything.

> P.S. I do not have the phone with me now, otherwise I would send in
> hcidump output. It reports errors when trying to parse at the end of
> response.

I like to have these phones at home for further testing, but getting all
the bad phones is quite an expensive hobby. The donations are not enough
to buy them.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
