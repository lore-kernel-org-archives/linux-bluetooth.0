Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A75ABD.2050605@suche.org>
From: =?ISO-8859-15?Q?Thomas_Lu=DFnig?= <bluez@suche.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BT-Sco
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	 <20041123033429.132bf84b.henryk@ploetzli.ch>	 <41A2B331.4010001@xmission.com>	 <20041123070621.50569968.henryk@ploetzli.ch>	 <41A3471C.4000602@xmission.com>	 <20041123203836.046fb4f4.henryk@ploetzli.ch>	 <41A3ACE2.4030501@xmission.com>  <41A74FE0.6020006@suche.org> <1101481147.6514.10.camel@pegasus>
In-Reply-To: <1101481147.6514.10.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Fri, 26 Nov 2004 17:33:01 +0100


>the source code size of this version is amazing, but the coding style is
>crap. Sorry to say that.
>  
>
For the current version the size is to large but i thought of extending 
the source to allow multiple Headsets.
Than it does not grow much since it already use an record and no static 
variables.

>Don't use {{{ and include some newlines. Actually follow the kernel
>coding style.
>  
>
The {{{ i use for folding marks they can be replaced with { same as with 
}}} and }.

>Why do you rewrite the function from libbluetooth and libasound. Simply
>use them, because these are shared library and they are loaded anyway.
>  
>
1. What function of libbluetooth ? The only bluetooth function in wich 
would be useable is geting
the local mac and the remove channel and string2adress conversion. wich 
is in no relation to the
size the binary would grow. With the same ground you could ask why i 
rewrite the asound part.
Here the ground is even more interesting.
1. I save many file open / close
2. It run faster
3. If the sound device support async io or even only signaling if there 
are new mixer data it can be done without
poll.

The ground i rewrite the original was so that i can use these code more 
easy to add it so other programms like kphone
and use the button with switch sco on/off for accepting phone calls.

Cu Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
