Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cuvml7$rkm$1@sea.gmane.org>
References: <42134A5D.4050309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <42134A5D.4050309@gmx.net>
Subject: [Bluez-devel] Re: Bluetooth-alsa question: possible to use phone itself as headset?
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
Date: Wed, 16 Feb 2005 15:53:46 +0100

Hi Marcel,

Marcel Partap wrote:
> Hey folks,
> I got a 3650 (also named the 'play bone') and would like to spare money 
> for a headset. The phone has bluetooth and so I thought, why not use the 
> phone itself as headset? It seems this is not supported yet, but would 
> it be possible?

As far as I know, we would only need to implement headset profile in the 
phone side. I think this shouldn't be impossible, after all Symbian OS 
has public API for RFCOMM, L2CAP and SDP socket connection, and I think 
it is also possible to create SCO connections in a socket basis... So, 
what is the problem then? Even in the assumption that we managed to 
develop the headset profile I think NONE actual mobile phone would let 
us hook the audio streaming from/to the microphone/speaker to/into a SCO 
channel. It is physically posible, of course because the AudioGateway 
profile embedded in the phone just do it, but I'm afraid we have no 
public interface to get this functionality (I'm not Symbian developer, 
let's hope somebody tell this is not true!).

Maybe phone manufacturers are too dependent on the Telephony Companies 
requirements to allow this nice functionality which would lead us 
without doubt to make VoIP calls from the phone if it detects the 
presence of the appropiate service running in our home's box.


> Connected (wire) to the phone I also have a headset.. Could _that_ be 
> used via bluetooth? That'd be soo great, I wouldn't have to get another 
> headset. 


As I said, the problem is in the interface phone|bluetooth, and with an 
external headset the same interface is still present

Regards,

Luis



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
