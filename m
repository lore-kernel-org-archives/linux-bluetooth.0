Return-Path: <mfrey@pepper.com>
In-Reply-To: <1091375871.27018.18.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus> <76F28965-DF34-11D8-B83A-00039390D626@pepper.com> <1090875679.10807.1.camel@pegasus> <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com> <1090916301.4650.9.camel@pegasus> <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com> <1090940516.4845.19.camel@pegasus> <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com> <1090941847.4845.29.camel@pegasus> <86089F56-DFE5-11D8-BE76-00039390D626@pepper.com> <1091375871.27018.18.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <225072EC-EBDC-11D8-B1A2-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Wed, 11 Aug 2004 17:19:30 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

OK -- I am using the new patches and all is well except for one thing.  
My keyboard seems to not be able to re-connect after it goes to sleep 
about 5 times.  It is almost like connections are left open and the 
hidd server does not allow the keyboard to re-connect.

The only way I get it back is to restart hidd.

Any ideas?

Michael

On Aug 1, 2004, at 11:57 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>> That worked..  I can now use both mouse and keyboard.
>>
>> You asked if I tried 2.6.7-mh2.  I assume you mean the back-ported
>> patch?  If so, that is what I am using.
>
> I've now put out another bunch of -mh patches for the 2.4 series. They
> include all updates and also the HIDP support. May you wanna try them
> out. Besides this the hidd from bluez-utils-2.9 got an extra option
> --subclass for overriding the subclass value.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source 
> Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
