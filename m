Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Flush timeout at Baseband
From: Marcel Holtmann <marcel@holtmann.org>
To: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LMEOKMJFKNFFHEAEDGDEGEEHCHAA.wanghg@i2r.a-star.edu.sg>
References: <LMEOKMJFKNFFHEAEDGDEGEEHCHAA.wanghg@i2r.a-star.edu.sg>
Content-Type: text/plain
Message-Id: <1085494294.9779.130.camel@pegasus>
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
Date: Tue, 25 May 2004 16:11:34 +0200

Hi Haiguang,

> Please refer to the following section in Bluetooth specification 1.2:
> 
> -- Volume 2: Core System Package
>     -- Part E: Host Controller Interface Functional Specification
>        -- Chapter 6: HCI Configuration Parameters
>            -- Section 6.20: Flush Timeout.
> 
> It explains the use of flush timeout value for ACL data and default is
> infinite.
> 
> In PART B: the baseband specification, section 7.6.3, it explains this
> parameter
> is designed for the delay sensitive traffic such as voice/video.
> 
> As in our project, we definitely need this parameter in configuration. So
> asked for
> the plan of including it in impelmentaion.

I checked the spec. by myself, because I don't asked for the explanation
of flush timeout. I asked for the HCI command to read or write it. The
commands are in 7.3.31 and 7.3.32 (read/write_automatic_flush_timeout).

These commands take a connection handle as parameter and so they are
connection specific and belong to hcitool. If they are not implemented
and you need them, send me a patch for hcitool.c and its manpage.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
