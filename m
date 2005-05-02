Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4275D372.8050503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Is there anyone working with cordless telephony
 profile?
References: <20050502122149.713295404.durai@isofttech.com>
In-Reply-To: <20050502122149.713295404.durai@isofttech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 02 May 2005 01:14:58 -0600

Hi

I think there would be a lot of interest once some handsets could use 
CTP. It doesn't even really help for someone to come along and make a 
CTP-only handset because the interesting application is a phone that can 
wander between CTP and traditional cells.

One big complication is the radio. Phones can get away with 
single-connection class 2 radios now but the radio will have to support 
multiple simultaneous connections (headset, CTP base) *and* class 1 in 
order to work well.

Maybe a third party will come along and add CTP to one of the PDA 
phones. Call forwarding etc wouldn't be seamless though. Is there even a 
way to get class 1 for a treo/ppc?

Brad

durai wrote:
> Hi,
> Is there anyone working on implementing Bluetooth cordless telephony 
> profile? If someone knows
> more information about the implementation, please share your 
> experiences/guidelines about it.
> regards
> durai


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
