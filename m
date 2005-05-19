Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID Keyboard Emulator enquiry
From: Anthony Jewell <tjewell@cregganna.com>
To: Bluez Users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1116515326.24921.23.camel@pegasus>
References: <1116512877.6838.52.camel@tonyvaio.cregganna.com>
	 <1116515326.24921.23.camel@pegasus>
Content-Type: text/plain
Message-Id: <1116519017.6838.63.camel@tonyvaio.cregganna.com>
Mime-Version: 1.0
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
Date: Thu, 19 May 2005 17:10:18 +0100

On Thu, 2005-05-19 at 16:08, Marcel Holtmann wrote:
> > I'm looking for a HID Bluetooth keyboard emulator for linux so that I
> > can type to my Nokia phone from my PC. I tried google but no luck.
> 
> does your phone support HID-host?
> 
I believe it does - it supports the Su-8W Bluetooth keyboard.

http://www.nokia.com/nokia/0,,67021,00.html

I  have downloaded the phone's Symbian app and its looking for keyboards
- I don't understand hcidump output so can't give a definitive answer as
to what its looking for - I assume is HID.

(Can post hcidump output if you would like.)

> > Does anyone know if such a thing already exists. If not I'm willing to
> > write one.
> 
> At the moment nothing like this exists.

Great! Time to write some code! I assume I have to allocate a channel,
advertise it with sdp, listen for a connection and the rest is just
application code.....

Any pointers to a similar bluez app I can copy the bluetooth stuff
from..... Any manuals pages for coding to the bluez sdp and socket
interfaces?

Anthony
-- 
Tony Jewell                             Tony.Jewell@cregganna.com
Cregganna Computer Consultants Ltd.     http://www.cregganna.com/



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
