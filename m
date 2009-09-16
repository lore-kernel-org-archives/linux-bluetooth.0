Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB101C0.8020906@charter.net>
Date: Wed, 16 Sep 2009 11:18:24 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Install of conf files
References: <4AB0D92A.6000205@charter.net> <1253112855.28416.4.camel@localhost.localdomain>
In-Reply-To: <1253112855.28416.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Peter,
>   
>> The following source config files are not installed during make install:
>>     audio/audio.conf
>>     network/network.conf
>>     serial/serial.conf
>>     input/input.conf
>> Why are main.conf & rfcomm.conf the only conf files that are installed? 
>> (I suspect that it's an oversight and these files should be listed as 
>> conf_DATA in Makefile.am)
>>     
> it is no oversight. It is on purpose. The default values of these files
> should be fine and we do wanna ensure that. It is up to the users to
> modify them.
>   

Ok, thanks for info.  That does mean that someone that does an install 
of 4.52 over 4.36 will be using HSP rather than HFP (since the default 
has changed in audio/audio.conf).

Peter
