Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] OBEX Push without pairing
References: <42242BAB.7080406@futurlink.com> <1109667687.17256.140.camel@pegasus> <42244089.7010906@futurlink.com>
In-Reply-To: <42244089.7010906@futurlink.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503011150.57455.bluez-user@schaettgen.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 1 Mar 2005 11:50:57 +0100

On Tuesday 01 March 2005 11:14, Pedro Monjo Florit wrote:
> but still no success. With the same computer and configuration and as a
> normal user, if I send a file from KDE using kbtobexclient, it works as
> expected (no PIN requested, just the confirmation for receiving the
> message), so I believe that there is some other things to do. I guess
> that it should be a library call or somthing similar. Any suggestions?

Are you sure that you are connecting to the rfcomm channel of the obex push 
service? All others require authentication usually. Maybe you should have a 
look at hcidump's output to see the difference and at which point the phone 
is requesting authentication.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
