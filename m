Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
In-Reply-To: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405310213.25767.tim@birdsnest.maths.tcd.ie>
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
Date: Mon, 31 May 2004 02:13:25 +0100

On Sunday 30 May 2004 22:25, Toby Fisher wrote:

> I'm using kernel 2.6.6RC1, and I almost have the connecting working with
> Gnokii to the phone.  However, there are some weird things going on which
> lead me to belioeve that something is wrong.
>
> I can, using rfcomm, get a connection to the phone, however tearing it
> down has strange results:
> 1.  Once the connection is down, I can no longer ping the phone using
> l2ping, though hcitool scan and info still work.

Do you have 
# CONFIG_BT_HCIUSB_SCO is not set
in .config (or /proc/config.gz) ?
On my machine (a Sony C1VFK Picturebook)
I had more or less your problems when this was set.

> 2.  The command rfcomm release rfcomm0 yields a device not found error,
> whereas the binding works without error.

I give the command "rfcomm release 0".
But if "rfcomm -a" says nothing,
I would have doubts if binding did work.

> Oh yes, and one final thing, rfcomm -a gives no output, despite the fact
> that I created rfcomm0 and it seems to work,

Did you say "rfcomm bind 0 <phoneBTaddress> 1" first?



-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
