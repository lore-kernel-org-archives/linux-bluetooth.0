Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42398407.7000204@amplex.dk>
From: Stephan Henningsen <sth@amplex.dk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Error compiling bluez-utils for buildroot/ARM
References: <4239536C.5030202@amplex.dk> <1111058060.11792.63.camel@pegasus>	 <4239711A.8070604@amplex.dk> <1111063118.11792.70.camel@pegasus>
In-Reply-To: <1111063118.11792.70.camel@pegasus>
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
Date: Thu, 17 Mar 2005 14:20:07 +0100

> then you must find the library that provides _IO_getc() or replace yacc
> or bison to generate correct code for your platform.

Please se my other message.  I don't think the library is the 
problem, as I can build without it, if I issue make manually.

-- 
Stephan.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
