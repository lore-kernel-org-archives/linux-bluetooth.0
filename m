Return-Path: <lintner@c-lab.de>
Message-ID: <41345B84.6040306@c-lab.de>
Date: Tue, 31 Aug 2004 13:05:40 +0200
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
References: <1324.1093866265@www49.gmx.net>	 <1093867195.5620.16.camel@pegasus>  <41331EBB.9000606@gmx.de>	 <1093869614.5620.24.camel@pegasus>  <41342BF8.2040703@c-lab.de> <1093947830.5620.114.camel@pegasus>
In-Reply-To: <1093947830.5620.114.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:

>Hi Johannes,
>
>  
>
>>the BTMidServ runs on the Linux side as the server.
>>    
>>
>
>I thought you use some C code for the server. I am not a Java expert and
>actually I don't have fun reading Java source code.
>
>  
>
>>    gotland:~# hcitool info 00:02:72:80:B1:6F
>>    Device is not available or not connected.
>>    
>>
>
>You must fill in the BD_ADDR of your phone.
>
>Regards
>
>Marcel
>

Hi,

for 1500ms, the string arrives correct the phone, but the sign for a 
received emptystring (an 'y' with 2 dots on it, I will write it 'y:') is 
added to the end.
The String I receive is: 'Handy!y:'
 Do you have any ideas?

Greets John
