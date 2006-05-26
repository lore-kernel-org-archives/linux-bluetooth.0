Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4476E686.2040402@free.fr>
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] report on new bluez headset
References: <446CDD43.3050604@free.fr> <446F383A.1040605@ens.fr> <4470B491.7040004@free.fr> <4470C77A.2080006@ens.fr> <4475C22B.9080908@free.fr> <4475CE30.7080109@xmission.com> <4475DBB0.2090003@silicom.fr> <44761461.8080503@xmission.com>
In-Reply-To: <44761461.8080503@xmission.com>
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
Date: Fri, 26 May 2006 13:29:10 +0200

Brad Midgley wrote:
> Fabien
> 
> 
>>>We've had quality problems that might be attributed to improperly pacing
>>>the data sent through sco. I am not sure what the kernel provides--if
>>>anything--in terms of timing.
>>> 
>>>
>>
>>Could you provide further information on these other quality problems ?
>>Just out of curiosity ;-)
> 
> 
> the high and lo bytes sometimes get out of sync so we are reading part
> of the previous sample and part of the next one when capturing from the
> mic. the result is noise.

That's *weird*. I'm just wondering how it can ever happen.

> 
> the output sometimes gets stuck in a mode in which it generates only
> static that might be a similar problem.
> 

Very interesting !!
I encountered this problem 2 or 3 times, and thought it was a bug in my 
code. Sadly, the least i can say, is that it is not easily reproductible ...

Thanks for your answers,

Fabien




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
