Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Philippe Berini <philippe@berini.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051112124505.GI7787@loulou-becane>
References: <20051020135234.GC28731@loulou-becane> <20051023123808.GA14322@elmicha.333200002251-0001.dialin.t-online.de> <20051023151215.GB31746@loulou-becane> <1130191981.9463.13.camel@localhost.localdomain> <20051025163115.GA29385@loulou-becane> <1130342970.8178.5.camel@localhost.localdomain> <20051026195956.GH7782@loulou-becane> <1131007931.2415.2.camel@yoda.digitalfredy.org> <20051109161839.GG21921@loulou-becane> <1131668163.6367.15.camel@yoda.digitalfredy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1131668163.6367.15.camel@yoda.digitalfredy.org>
Subject: [Bluez-users] Re: Re: Re: Re: Re: Buetooth and SAMSUNG SGH-E340
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
Date: Sat, 12 Nov 2005 13:45:05 +0100

* Fredy Pulido López <digitalfredy@debiancolombia.org> [Thu, Nov 10, 2005 at 07:16:03PM -0500]:

> Try it:
> 1)see your movile services (use your phone MAC) - are chanel 7 OBEX File
> Transfer?

Yes:

# obexftp -b -l
Scanning ...
Using   00:12:47:AB:AF:46       SAMSUNG SGH-E340
Browsing 00:12:47:AB:AF:46 ...
Channel: 7
No custom transport
Connecting...failed: connect


> $ sdptool  browse AA:0A:D9:78:ED:AA 

Nothing happens:

# sdptool browse 00:12:47:AB:AF:46
Browsing 00:12:47:AB:AF:46 ...


> 2) remove the pc in your movil btdevices
> 3) restart bluez -if get error send my your init.d/bluez-utils file for
> test it in my system

There is no error:

# /etc/init.d/bluez-utils restart 
Restarting bluez-utils: hidd hcid sdpd hidd rfcomm

I believe we'd better forget it for now.

-- 
Philippe Berini                


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
