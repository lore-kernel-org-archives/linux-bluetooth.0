Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05040323102b9160a1@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluepin ERROR with RFCOMM
In-Reply-To: <1112554304.8263.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f16b04cf05033022021405d585@mail.gmail.com>
	 <1112554304.8263.0.camel@pegasus>
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
Date: Mon, 4 Apr 2005 11:40:30 +0530

Dear marcel,
                 Thanks for your support. i have brought uo n\my
bluetooth interface with
the RFCOMM. 
                    Now i going into the Obex file transfer. is there
any bluez utility to test
the Obex and the Installation of Obex document.

Please advise

Thanks and regards
Hariharan.v.

On Apr 4, 2005 12:21 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hariharan,
> 
> >       we have bind the RFCOMM with bluetooth device using
> >
> > rfcomm bind 0 <BD_ADDR> 1
> >      binding was successful.
> >
> > while connecting the device with RFCOMM we get error,
> >       Cannot connect RFCOMM socket:
> >
> > As per your mailing list, we checked the HCID dameon running state
> > and bluepin working status.
> >
> > we found that bluepin is not working properly it returns ERR.
> 
> use either the bind or the connect method of the rfcomm utility. If you
> bind then open /dev/rfcomm0 to connect. Check with "hcidump -X -V" for
> further problems.
> 
> Regards
> 
> Marcel
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
