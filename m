Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Toby Fisher <toby@tjfisher.co.uk>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Problems connecting to Nokia 6310I phone.
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
Date: Sun, 30 May 2004 22:25:33 +0100 (BST)

Hi.

The subject gives the outline, and a brief scan of the archives didn't 
yield anything useful.

I'm using kernel 2.6.6RC1, and I almost have the connecting working with 
Gnokii to the phone.  However, there are some weird things going on which 
lead me to belioeve that something is wrong.

I can, using rfcomm, get a connection to the phone, however tearing it 
down has strange results:
1.  Once the connection is down, I can no longer ping the phone using 
l2ping, though hcitool scan and info still work.
2.  The command rfcomm release rfcomm0 yields a device not found error, 
whereas the binding works without error.

In addition to this, if I use the gnokii --monitor command I can get a 
response from the phone, however it sends one lot of data and then seems 
to hang - the only way to end the Gnokii process is to move to another 
console and use the kill command, as ctrl-c doesn't work.


I'm puzzled, as I seem almost to be there but somehow seem to be missing 
one step.
Oh yes, and one final thing, rfcomm -a gives no output, despite the fact 
that I created rfcomm0 and it seems to work,
rfcomm connect rfcomm0 00:60:57:69:CB:18
will get me an rfcomm connection to the phone.

Thanks in advance for any pointers you can offer.


-- 
Toby Fisher	Email: toby@tjfisher.co.uk
Tel.: +44(0)1480 417272	Mobile: +44(0)7974 363239
ICQ: #61744808


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
