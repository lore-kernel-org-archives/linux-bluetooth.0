Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] can bluez dynamically allocate l2cap psm?
From: Stephen Crane <steve.crane@rococosoft.com>
To: albert@csail.mit.edu
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <ef9938ec04051118174f3302f3@mail.gmail.com>
References: <ef9938ec04051118174f3302f3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1084353460.2834.6.camel@baroque.rococosoft.com>
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
Date: Wed, 12 May 2004 10:17:40 +0100

Hi Albert,
At the moment you have to cycle through the available PSMs trying to
bind to each one. BlueZ sockets don't yet support binding to PSM_ANY.

Steve

On Wed, 2004-05-12 at 02:17, Albert Huang wrote:
> I want a simple client/server that operates as follows.
> 
> server listens for l2cap connections.  accepts a connection, does
> something with it.
> 
> client discovers server by entering inquiry mode and then checking SDP
> records for service id of the server.
> 
> I don't want to hard-code the l2cap psm, as that seems like it defeats
> half the point of SDP, but I can't figure out how to request a dynamic
> psm.  I want to be able to do somethiing like this:
> 
> int s;
> struct sockaddr_l2 s_addr;
> s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> 
> s_addr.l2_family = AF_BLUETOOTH;
> bacopy( &s_addr.l2_bdaddr, BDADDR_ANY );
> s_addr.l2_psm = L2CAP_PSM_ANY;
> 
> bind(s, (struct sockaddr *)&s_addr, sizeof(s_addr) );
> 
> struct sockaddr_l2 local_addr;
> struct socklen_t addr_len = sizeof(local_addr);
> getsockname( s, (struct sockaddr *)&local_addr, &addr_len);
> int psm = btohs( local_addr.l2_psm );
> 
> // register service with SDP using dynamic psm
> 
> 
> Is this possible with bluez?  Or do I have to do the ugly thing and
> pick an arbitrary psm?
> 
> thanks!
> -albert
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
