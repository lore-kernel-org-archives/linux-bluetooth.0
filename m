Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: tim@birdsnest.maths.tcd.ie
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
Message-Id: <20040531061149.3d168e0d.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <200405310213.25767.tim@birdsnest.maths.tcd.ie>
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
	<200405310213.25767.tim@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Mon, 31 May 2004 06:11:49 +0200

On Mon, 31 May 2004 02:13:25 +0100
Timothy Murphy <tim@birdsnest.maths.tcd.ie> wrote:

> On Sunday 30 May 2004 22:25, Toby Fisher wrote:
> 
> > Oh yes, and one final thing, rfcomm -a gives no output, despite the fact
> > that I created rfcomm0 and it seems to work,
> 
> Did you say "rfcomm bind 0 <phoneBTaddress> 1" first?
> 
To my understanding you dont have to bind a /dev/rfcommX to connect. Using bind
means that you "prepare" that /dev/rfcommX to connect to the peer when someone uses
the /dev/rfcommX. If you use the rfcomm connect /dev/rfcommX <bd-adress> <channel> 
this connection will be made instantly and will be closed after ctrl-c or 
dissconect of the peer.
The channel number must be the number of the channel on the phone you want to connect.
To find the channelnumber of a profile use sdptool and its browse or serach command.

Greetings

Andy


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
