Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B6CBDC.4010802@suche.org>
From: "suche.org" <admin@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <20041206225609.GA1177@zeus.galaxy.org.uk>	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>	 <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
In-Reply-To: <1102496771.9988.35.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] CVS doubles
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
Date: Wed, 08 Dec 2004 10:39:40 +0100

Hi,

since i wan't to test sdptool with HF (Handsfree) i found some ugly points.
1. On the webside there is no more link to bluez-sdp
2. In CVS bluez/dsp contain sdptool AND bluez/utils contain sdptoll
but bluez/utils depends on bluez/dsp for (libdsp)

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
