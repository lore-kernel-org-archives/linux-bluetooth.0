Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403A02FA.60008@superbug.demon.co.uk>
References: <40397111.7000903@superbug.demon.co.uk>
	 <1077522140.2832.70.camel@pegasus>  <403A02FA.60008@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077545085.13454.1.camel@pegasus>
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
Date: Mon, 23 Feb 2004 15:04:45 +0100

Hi James,

> Each call to parse_de_hdr and print_uuid changes the value of frm->len.
> So, each time round the while loop (len - frm->len) becomes larger.
> 
> The n1 value is set by the previous line
> "if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {"
> 
> This means we have n1 bytes of data we wish to parse inside the while loop.
> So, we want to start the while loop with (len - frm->len) == 0
> Each time round the loop (len - frm->len) will increase( due to calls to 
> parse_de_hdr and print_uuid) , and the loop will exit when (len - 
> frm->len) >= n1, which is what we want.
> 
> If we fail to set "len = frm->len;" just before the while loop, the 
> previous line
> "if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {"
> changes frm->len, so the "int len = frm->len;" at the beginning of the 
> function is no longer correct.
> I.E. len != frm->len after the "if (parse_de_hdr(frm, &n1) == 
> SDP_DE_SEQ) {" statement.
> 
> I hope this explanation is clear.
> 
> Do you want me to resubmit the patch as a "cvs -u diff" ?

yes. And please remove the initial assignment of len.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
