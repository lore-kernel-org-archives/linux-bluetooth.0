Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438CD881.8060405@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] avrcp start
References: <438C8EDE.1010309@xmission.com> <1133296630.23817.5.camel@blade>
In-Reply-To: <1133296630.23817.5.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Tue, 29 Nov 2005 15:38:57 -0700

Marcel

> you actually copied to much from on of the A2DP record handlers. The
> specification definces the AVRCP CT service record like this:
> You need the supported features attribute. The correct PSM and protocol
> and profile descriptors.

> Functions for both records are in the CVS now.

thanks for straightening it out on sdp.

so I am making progress like I did with hammering out a2dp but i'm a
little stuck. I am not finding constants for anything they talk about in
AVRCP. Things like play/track back/track forward operands, opcodes for
using passthrough, what the significance of "sub unit type 9" is... am I
missing something? None of it appears in assigned numbers either.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
