Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429CD880.6090205@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] trying to connect to a M2500 Plantronics headset
References: <200505301752.38707.daniela.taubert@physik.uni-muenchen.de> <200505301929.23992.daniela.taubert@physik.uni-muenchen.de> <429CA856.6020602@xmission.com> <200505312328.47057.daniela.taubert@physik.uni-muenchen.de>
In-Reply-To: <200505312328.47057.daniela.taubert@physik.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 31 May 2005 15:34:56 -0600

Daniela

>>strace btsco <btaddr> 2

if you can, get btsco from cvs and run it as:

btsco -v <bdaddr>

then make your audio app send audio to the device and the audio 
connection should be fired up.

see http://bluetooth-alsa.sf.net for examples on how to run a client 
like aplay etc

brad


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
