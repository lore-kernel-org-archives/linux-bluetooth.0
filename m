Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mikko Rapeli <mikko.rapeli@iki.fi>
In-reply-to: <20040708205303.GD2581@nalle>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <20040708211107.GE2581@nalle>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20040708205303.GD2581@nalle>
Subject: [Bluez-users] Re: rfcomm and a freezing SE t610
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Jul 2004 00:11:07 +0300

On Thu, Jul 08, 2004 at 11:53:03PM +0300, Mikko wrote:
> Is the phone only one to blame? Is there a way to send some more hangup
> messages to the phone and hope that it catches them and stops the GPRS
> and rfcomm connections? 

*doink*, as usual I found a way immediately after sending the question
out: add more PPP hangup characters.

Now, my hangup chat script seems to have enough (more than just one pair
of) \K's and +++ATH's:
exec /usr/sbin/chat -V -s -S    \
ABORT           "BUSY"          \
ABORT           "ERROR"         \
ABORT           "NO DIALTONE"   \
""              "\K"            \
""              "\K"            \
""              "\K"            \
""              "+++ATH"        \
""              "+++ATH"        \
""              "+++ATH"        

Now the t610 seems to work as it should.

-Mikko


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
