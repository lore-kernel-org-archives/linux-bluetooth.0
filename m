Return-Path: <mfrey@pepper.com>
In-Reply-To: <1090875679.10807.1.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus> <76F28965-DF34-11D8-B83A-00039390D626@pepper.com> <1090875679.10807.1.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Mon, 26 Jul 2004 20:31:26 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

ok, got it working.  However -- when typing fast on my keyboard I get 
incorrect characters.  This does not happen when using bthid.  Also,  
my mouse does not work,  where using bthid it does.

How should I go about debugging this?

Michael

On Jul 26, 2004, at 5:01 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> Thanks for the help.  However I do not have sockfd_lookup()  in
>> net/bluetooth/bnep/core.c
>
> it should be present in any 2.4.20 kernel.
>
>> Am I that out of date?  Is there a more recent patch I should apply?
>
> Your kernel is out of date, because I made the patch against the latest
> 2.4.27-rc3. Take another kernel source and simply copy that function.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
