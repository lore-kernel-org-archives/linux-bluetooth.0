Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050120003408.GA8619@salvia.homeip.net>
References: <20050119224400.GA7881@salvia.homeip.net> <1106180379.8190.146.camel@pegasus>
Mime-Version: 1.0
In-Reply-To: <1106180379.8190.146.camel@pegasus>
Subject: Re: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in hidp/core.c
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 20 Jan 2005 02:34:08 +0200

Hi Marcel,

On Thu, Jan 20, 2005 at 01:19:38AM +0100, Marcel Holtmann wrote:

> can you point me to the part of the HID specification that defines this
> behaviour? And show me an extract from hcidump when this happens.

I don't know if this is in the spec, or if it is just a quirk of some
Logitech keyboards.  However, it shouldn't cause any trouble to check
for it as a special case, since that kind of data packet is clearly
invalid, no?

Here's the dump of me pressing 'qwert', and then releasing 't':

1106180982.868085 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 14 00 00 00 00 00 
1106180982.927077 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 14 1A 00 00 00 00 
1106180982.967071 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 14 1A 08 00 00 00 
1106180983.027061 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 14 1A 08 15 00 00 
1106180983.047059 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 01 01 01 01 01 01 
1106180983.267020 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      A1 01 00 00 14 1A 08 15 00 00 

Cheers,
Juha


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
