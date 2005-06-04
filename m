Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frank Pieczynski <pieczy@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Protocol error in btsco
References: <200506041519.15949.pieczy@web.de>
In-Reply-To: <200506041519.15949.pieczy@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506041549.11210.pieczy@web.de>
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
Date: Sat, 4 Jun 2005 15:49:11 +0200

On Saturday 04 June 2005 15:19, Frank Pieczynski wrote:
> I try to play a short wav file, it works. But after on of the next tries
> the connection dies somehow with "Protocol error"
some addtitional info (I discovered the -V of hcidump):

< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 47 ptype 0x00e0
    Packet type: HV1 HV2 HV3
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 47 slots 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x24 handle 47 bdaddr 00:0E:DA:XX:XX:XX type SCO encrypt 0x00
    Error: LMP PDU Not Allowed
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 47 slots 5

What is wrong here?
Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
