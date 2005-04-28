Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4270E4E0.1070504@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: DBT 120 dongle defaulting to HID mode
References: <pan.2005.04.14.18.57.06.661056@wingnet.net> <pan.2005.04.15.13.26.00.874309@wingnet.net> <1113572820.16433.26.camel@pegasus> <20050428131624.554B38CB@arbetsmyra.dyndns.org>
In-Reply-To: <20050428131624.554B38CB@arbetsmyra.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 28 Apr 2005 15:28:00 +0200

Marcel wrote the pskey tool. With that you can set the boot mode of a csr 
dongle. It's currently only in the cvs.

regards
Marco


Ronny L Nilsson wrote:
>>>OK. Has anyone written a program capable of changing arbitrary
>>>PS key settings yet? Or do I have to write my own?
>>
>>there is the pskey program, but this will only work over UART with
>>H:4 or BCSP transports. The BlueZ hciconfig code contains code to
>>read PS key values, but it can't store them. However I really think
>>that we need a graphical pstool for Linux like the CSR one for
>>Windows.
> 
> 
> 
> Hi
> I've been looking for this pskey program, but have yet only found it in 
> "iPaq" package format. Anyone with a link to the sources? And has 
> anyone used it with other arches than iPaq? If not, does anyone have an 
> idea of how much work needs to be done to get it up and running?
> 
> Regards
> /Ronny Nilsson
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
