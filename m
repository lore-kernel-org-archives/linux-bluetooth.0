Return-Path: <vogl@soft.uni-linz.ac.at>
Message-ID: <403B4565.1020201@soft.uni-linz.ac.at>
Date: Tue, 24 Feb 2004 13:36:53 +0100
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] browsing non-public services?
References: <403B1072.1020102@soft.uni-linz.ac.at> <1077624474.2880.37.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>



Marcel Holtmann wrote:
> Hi Simon,
> 
> 
>>can I retrieve service information on non-public services? My nokia phones
>>show an SDP-entry for service class 0x5555 that the phones also inquire when
>>connecting, now I'd like to see what is registered there...
> 
> 
> read the manpage or use "sdptool -h" ;)
> 
> 	sdptool search --bdaddr <bdaddr> --tree 0x5555
> 
> Must be something vendor specific. Please show us the output.
> 

tried that already, but with no luck. From hcidump, I see that this is a 128bit
uuid - how can I specify this as an argument??
Cheers
Simon


> Regards
> 
> Marcel
> 


-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/
