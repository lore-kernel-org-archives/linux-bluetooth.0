Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced05022322584f751610@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net, sebastian.roth@esk.fhg.de
Subject: Re: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <cvhrtb$kn9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <7aa80ced0502222239dd01830@mail.gmail.com>
	 <cvh9lh$2b0$1@sea.gmane.org>
	 <7aa80ced05022223273b5bba4c@mail.gmail.com>
	 <cvhkqf$2b0$2@sea.gmane.org>
	 <7aa80ced0502230228296ac5e7@mail.gmail.com>
	 <cvhrtb$kn9$1@sea.gmane.org>
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
Date: Thu, 24 Feb 2005 12:28:08 +0530

Hi Sebastian,
                  Can you tell me whether the send program is working
after making the device up using "hciconfig hci0 up" on the SiW dongle
side?

Regards
Mohan

On Wed, 23 Feb 2005 13:15:07 +0100, Sebastian Roth
<sebastian.roth@esk.fhg.de> wrote:
> Hi,
> 
> I compiled and tested your applications. Had the (exact) same problem
> when tried to send from a SiW dongle to one with CSR chip. But...
> This was because I forgot to starup the interface. What does
> `hciconfig -a' for the SiW dongle show? Is it up?
> 
> Best regards,
> Sebastian
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
