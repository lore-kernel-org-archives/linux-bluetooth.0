Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <448DEA20.5000806@stfw.eu>
References: <1150148335.7372.7.camel@johannes_01.kapune.local>
	<448DEA20.5000806@stfw.eu>
Date: Tue, 13 Jun 2006 19:23:03 +0200
Message-Id: <1150219383.7401.5.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: bluez-users@lists.sourceforge.net
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi!


Am Montag, den 12.06.2006, 23:26 +0100 schrieb Zhares:
> Johannes Kapune wrote:
> 
> > Found A2DP Sink at the destination
> > Can't connect to 3B:59:A0:94:0A:00. Connection refused(111)
> > cannot open psm_cmd = 25
> 
> Hi!
> 
> It sound like a pin problem. Try first to connect to you headset with:
> # hcitool con 3B:59:A0:94:0A:00
> 
> If it is also refused, try to change the security settings in 
> /etc/bluetooth/hcid.conf to user or to none and try to reconnect with 
> the above command.
> 
No, it's not refused, but I see no connections.

johannes@johannes_01:~/btsco> hcitool con 3B:59:A0:94:0A:00
Connections:
johannes@johannes_01:~/btsco>            

When I have changed the hcid.conf, what to do to use the changes?



my original hcid.conf:

device {
	# auth disable;
	# encrypt disable;
	iscan enable;
	pscan enable;
	name "BlueZ %h (%d)";
	class 0x700100;
	lm accept;
	lp rswitch,hold,sniff,park;
}
options {
	security auto;
	autoinit yes;
	pairing multi;
}



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
