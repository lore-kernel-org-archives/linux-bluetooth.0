Return-Path: <cyrus@holtmann.org>
Message-Id: <5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48355289.7070906@access-company.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 22 May 2008 13:48:32 +0200
References: <48075B6A.2060308@access-company.com>
	<1209058941.12684.37.camel@violet.holtmann.net>
	<48355289.7070906@access-company.com>
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

>>> I got my hand over a BNEP and PAN test plan and tried to pass it  
>>> with current PAN implementation (pand, not network service). I met  
>>> several issues and tried to find some solutions to them.
>>>
>>> * Handling of 32 and 128 bits uuids,
>>> * Correct response to invalid uuids,
>>> * Respond to control messages before connection setup,
>>> * Handling of bnep extension together with general headers,
>>> * Handling of bnep extensions together with setup connection  
>>> requests.
>>> * Forwarding of unknown BNEP extensions (not available for  
>>> broadcast, advice requested),
>>> * Give up pan connection after 30 seconds,
>>>
>>> The result of that work is two patchs, one for the kernel (based  
>>> on latest git) and one for pand (a bit old that one I fear).  
>>> However, it should be easy to get similar patch for network service.
>>>
>>
>> I need both patches in unified diff format (-u). I am not a machine  
>> and
>> can't read context diffs.
>>
>> Please break up the kernel patch in small chunks that solve each
>> problem. It is easier for me to review them and then apply them.
>>
>
> Sorry for long delay, i was ooto. Will split patch and send with -u.
> For now here is first patch for pand and network service.
>
> Give up pan connection after 30 seconds
> TP/BNEP/CTRL/BV-02-C

patch looks good to me.

Luiz, feel free to apply it.

> A part of the patch si to move handling of incoming setup_conn_req  
> in kernel. In order to keep pan working with older kernel, some  
> differenciation must be done. How to achieve this ?

I don't know yet. Can we first fix the issues that don't need  
modifications within the kernel. I prefer not modifying the kernel at  
all at the moment.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
