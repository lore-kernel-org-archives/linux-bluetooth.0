Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B81ACB.1080807@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] starting btsco-in-libalsa
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
Date: Thu, 09 Dec 2004 02:28:43 -0700

Guys,

I put some junk in the btsco cvs:

alsa-lib.patch
bt/

if you apply alsa-lib.patch and put bt inside alsa-lib/src/pcm then the 
idea is that you can build a userspace alsa driver.

currently it doesn't even compile... it's just based on the jack plugin 
and not yet reworked for bluetooth.

anyway, this is my next project. it depends on a couple of things in 
other parts of the project:

  it would be nice if 'make install' inside sbc/ would install the sbc 
includes and library (static libs would be ok)

  the avdtp library is just a skeleton right now... should I just ignore 
it for now and hardcode what is currently in a2play?

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
