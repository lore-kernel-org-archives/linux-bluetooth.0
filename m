Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.14.23.44.15.944533@yahoo.com>
References: <pan.2005.01.14.17.46.40.72959@yahoo.com> <41E853A9.5030304@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Re: btsco and Jabra BT 110 experience
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
Date: Sat, 15 Jan 2005 00:44:18 +0100

Hi Brad,

I appended some info bellow.
For some reason, btsco does not work with specified channel, but btsco2
does.

here is the info without specified channel:
 ./btsco 00:07:A4:1D:FB:56
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15


and with specified channel (using btsco2 as btsco does not work here):
 ./btsco2 00:07:A4:1D:FB:56 2
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 2 connected
recieved AT+BRSF=24
recieved AT+CIND=?
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd



On Fri, 14 Jan 2005 16:20:09 -0700, Brad Midgley wrote: 
> it sounds like you're saying the automatic channel detection incorrectly
> chooses channel 1 instead of 2. can you tell me what btsco prints out when
> it's launched without the channel specified?
> 
> Brad




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
