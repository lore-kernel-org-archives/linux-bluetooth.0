Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B6D9BA.3050302@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <20041206225609.GA1177@zeus.galaxy.org.uk> <cp3mkk$m7t$1@sea.gmane.org> <20041208103449.GC2258@zeus.galaxy.org.uk>
In-Reply-To: <20041208103449.GC2258@zeus.galaxy.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re[2]: snd-bt-sco problem
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
Date: Wed, 08 Dec 2004 11:38:50 +0100


>As mentioned in reply to Brad Midgley, this established a successful
>connection (pressing the volume buttons affected alsamixer), but I
>still couldn't actually get any audio to flow in either direction,
>despite continuous SCO data packets seen with hcidump, although only in
>one direction.
>  
>
Hi,
i had the same problem in the first.
Possible options:
a) Other soundcards
b) Insufficent rights on /dev/dsp*  /dev/audio* /dev/sound* or /dev/snd/*

Cu Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
