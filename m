Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: aji.kumar@accenture.com
Subject: Re: fail to configure and compile the source of bluez-5.7 
References: <op.w1fi20rze4gg2u@localhost>
 <558B77349A98DB438591B5FD93003409263E702B@048-CH1MPN1-141.048d.mgd.msft.net>
Date: Thu, 08 Aug 2013 08:29:01 -0000
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
From: atar <atar.yosef@gmail.com>
Message-ID: <op.w1hoinkoe4gg2u@localhost>
In-Reply-To: <558B77349A98DB438591B5FD93003409263E702B@048-CH1MPN1-141.048d.mgd.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Atar,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of atar
>> Sent: Wednesday, August 07, 2013 10:06 AM
>> To: linux-bluetooth@vger.kernel.org
>> Subject: fail to configure and compile the source of bluez-5.7
>>
>> Hi there!!
>>
>> My machine is running Debian Wheezy from the live-boot Debian project  
>> which
>> is installed on my USB stick.
>>
>> I've downloaded from bluez.org the source of the 5.7 package but when I  
>> ran
>> ./configure on it, it emitted an error message at the bottom of all the  
>> messages
>> saying:
>>
>> > "checking for GLIB... no
>> > configure: error: GLib >= 2.28 is required"
>>
>> This, although I've the glib libraries installed.
>>
>> How can this problem be solved?
>>
>
> Check the version of the glib library installed, you could use  
> "apt-cache show <glib>"
>
> If you need to know the actual package name for glib, do "apt-cache  
> search glib" and find out the right package, you could replace that in  
> the above line.
>
> If version installed is less than required, you will have to install the  
> later versions, the corresponding glib images can be downloaded from  
> Ubuntu repositories...
>
>> Thanks in advance!!
>>
>> atar.
>> --
>> To unsubscribe from this list: send the line "unsubscribe  
>> linux-bluetooth" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>
>
> This message is for the designated recipient only and may contain  
> privileged, proprietary, or otherwise confidential information. If you  
> have received it in error, please notify the sender immediately and  
> delete the original. Any other use of the e-mail by you is prohibited.
>
> Where allowed by local law, electronic communications with Accenture and  
> its affiliates, including e-mail and instant messaging (including  
> content), may be scanned by our systems for the purposes of information  
> security and assessment of internal compliance with Accenture policy.
>
> ______________________________________________________________________________________
>
> www.accenture.com

Hi Kumar!

the command 'apt-cache search glib' produces a lot of output. I can't  
figure out which line is really related to the glib library in question.  
please help.

Thanks in advance!!

atar.
