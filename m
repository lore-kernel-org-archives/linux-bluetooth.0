Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: h0016530@hkusua.hku.hk
Cc: James Cameron <james.cameron@hp.com>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about Role Changing during PAN setup
Message-ID: <20040708055423.GI18689@hp.com>
References: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk> <20040708052744.GG18689@hp.com> <1089265279.40ecde7f12156@imp.webmail.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089265279.40ecde7f12156@imp.webmail.hku.hk>
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
Date: Thu, 8 Jul 2004 15:54:23 +1000

On Thu, Jul 08, 2004 at 01:41:19PM +0800, h0016530@hkusua.hku.hk wrote:
> server(PC):
> #modprobe l2cap
> #modprobe bnep
> #sdpd
> #hcid
> #hciconfig hci0 up
> #pand --listen --role NAP --service --sdp --master
> #pand --connect 00:02:C7:18:25:A0
> #ifconfig bnep0 10.0.0.1 
>
> client(iPAQ, familiar linux):
> #pand --listen --role PANU
> #ifconfig bnep0 10.0.0.2

Slightly different.  On my server (PC) I run:
# pand --listen --role NAP

And on client (laptop) I run:
# pand --nodetach --role PANU --search 

ifconfig is handled automatically by hotplug on both systems, but
essentially it happens shortly after connection is made.

Since you are making PANU connection from server to iPAQ, it is not
wrong for "pand --show" to show PANU connection.

-- 
James Cameron
Software Security Response Team
HP Services, Asia Pacific


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
