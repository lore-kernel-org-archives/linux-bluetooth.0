Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A6F456.5040005@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Hi all !
References: <41A6046D.30800@xgarreau.org> <1101423126.6465.19.camel@pegasus>
In-Reply-To: <1101423126.6465.19.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 26 Nov 2004 10:16:06 +0100

>>I never used sdp api, did any of you wrote some white paper about 
>>bluetooth programming involving sdp (i found 
>>http://www.holtmann.org/papers/bluetooth/wtc2003_slides.pdf but it's not 
>>dealing with sdp)
> 
> the programs dund and pand show you how to advertise a SDP record.

Thank you very much Marcel, this was a useful answer, as usual !

I just have another (amybe silly) question ...

In bluez/pan/pand/sdp.c
     function bnep_sdp_register

if sdp_record_register is succesful, the sdp_session is not closed 
whereas it is evrywhere else (when something fails).

Does it means that sdp_record_register closes the sdp_session when it is 
successful ? That would mean we need to di sdp_connect foreach record we 
have to add (I know, we usually only have only one to do at a time, but 
that seems "strange" to me)

Regards !
Xavier Garreau


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
