Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <448DEA20.5000806@stfw.eu>
Date: Mon, 12 Jun 2006 23:26:40 +0100
From: Zhares <ml-sourceforge@stfw.eu>
MIME-Version: 1.0
To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
References: <1150148335.7372.7.camel@johannes_01.kapune.local>
In-Reply-To: <1150148335.7372.7.camel@johannes_01.kapune.local>
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Johannes Kapune wrote:

> Found A2DP Sink at the destination
> Can't connect to 3B:59:A0:94:0A:00. Connection refused(111)
> cannot open psm_cmd = 25

Hi!

It sound like a pin problem. Try first to connect to you headset with:
# hcitool con 3B:59:A0:94:0A:00

If it is also refused, try to change the security settings in 
/etc/bluetooth/hcid.conf to user or to none and try to reconnect with 
the above command.

-- 

     Zhares


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
