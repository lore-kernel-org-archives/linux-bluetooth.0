Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced050224201542f0ec1e@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] using sdptool
In-Reply-To: <E73D9A5BC4A2D711BBC600065BF3595F1C66CFB9@il06exm10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <E73D9A5BC4A2D711BBC600065BF3595F1C66CFB9@il06exm10>
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
Date: Fri, 25 Feb 2005 09:45:15 +0530

Hi Hiren,

> I guess my question should be "how to start a SDP server on a machine?"
         
        #sdpd . This will start the SDP server

Regards
Mohan


On Thu, 24 Feb 2005 17:14:34 -0600, Mandalia Hiren-AHM047
<hirenm@motorola.com> wrote:
> Hello all
> 
> I don't know how to frame my question but I will tell you what problem I'm facing. I have 2 linux machines and a Bluetooth USB dongle on each.
> 
> When I do "sdptool get"(on 1 machine) I get
> % sdptool get record_handle
> Service Name: SDP server
> Service Description: Bluetooth service discovery server
> So on....
> 
> When I do (on another machine) I get
> % sdptool get record_handle
> Failed to connect to SDP server on FF:FF:FF:00:00:00: no such file or directory.
> 
> I guess my question should be "how to start a SDP server on a machine?"
> 
> Thanks,
> Hiren Mandalia
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
