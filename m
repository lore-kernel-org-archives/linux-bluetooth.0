Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429B45FB.6090302@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] trying to connect to a M2500 Plantronics headset
References: <200505301752.38707.daniela.taubert@physik.uni-muenchen.de>
In-Reply-To: <200505301752.38707.daniela.taubert@physik.uni-muenchen.de>
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
Date: Mon, 30 May 2005 10:57:31 -0600

Daniela

> I guess there's a problem with the PIN... from what I read there should be a 
> window asking me for PIN but I don't get anything like that.

Yes, that's what I thought too looking at your results (I am not good at 
reading the hcidump output though)

Have you paired with other bluetooth devices ok?

On my embedded machine, the pin is read directly from /etc/bluetooth/pin 
with no user interaction but when I run things as myself from an x 
session, a window comes up.

I have used this same headset with btsco so it should work well.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
