Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A6EA08.7050904@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp> <20041125112509.75347786.henryk@ploetzli.ch> <20041125105615.GA19821@snoopy.src.ricoh.co.jp> <1101440449.6465.64.camel@pegasus> <20041126041158.GF27879@snoopy.src.ricoh.co.jp>
In-Reply-To: <20041126041158.GF27879@snoopy.src.ricoh.co.jp>
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
Date: Fri, 26 Nov 2004 01:32:08 -0700

Alain

>>You can try to hack the a2play.c to use SEID 3 instead of 1 and see what
>>the audio sink on SEID 3 offers you. Run the hcidump 1.15.

a2play.c from cvs should detect the additional seid values and skip 
those that aren't audio media type and sbc codec type. i'm not sure if i 
should be checking to make sure the seid is an audio sink but it is past 
my bedtime... :)

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
