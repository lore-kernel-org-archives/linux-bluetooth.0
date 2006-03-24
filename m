Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44244610.40703@evilgenius.de>
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
References: <44229D0A.5080508@rumms.uni-mannheim.de>	 <1143122060.9923.12.camel@localhost>	 <4422C49C.2060004@rumms.uni-mannheim.de>	 <1143218750.12582.33.camel@localhost>	 <44242DFC.4080501@rumms.uni-mannheim.de> <1143223791.12582.47.camel@localhost>
In-Reply-To: <1143223791.12582.47.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 24 Mar 2006 20:18:40 +0100

Marcel Holtmann wrote:
> Hi Andreas,
> 
>>>> The only weird thing I'm still tracking 
>>>> down is that I only get inquiry results every five minutes while it did 
>>>> work as expected with the previous dongles...
>>>>     
>>> ask Broadcom, I have no idea. You might wanna try to compare it against
>>> a CSR based dongle.
>>>   
>> The problem has not reappeared today; my period length is set to 30
>> (*1.28s) now and today the visible repetition of the inquiry results was
>> more around 3 seconds or less... ;-) That's not too bad, we're happy it
>> works at all as a proof of concept.
>>
>> I did ask you for a recommendation of reference hardware available in
>> Germany some weeks ago on the list but I got no reply. We had a very
>> difficult time finding a supplier of any hardware with HCI >1.1 as
>> webshops or shops like Saturn don't really know about the chipsets and
>> the manufacturers' sites don't always list such details. If you let us
>> know what USB hardware (as opposed to chipset) we should/could use we
>> might consider that.
> 
> I have been really busy lately and thus I am not able to answer all
> emails on the BlueZ mailing lists. Hopefully some other people will step
> in at some point. However you should check my EDR page:
> 
> 	http://www.holtmann.org/linux/bluetooth/edr.html
> 

in germany karstadt is selling the csr-based cellink bta-6030.

regards
martin




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
