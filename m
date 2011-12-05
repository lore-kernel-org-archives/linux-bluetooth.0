Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDC9019.6080405@globaledgesoft.com>
Date: Mon, 05 Dec 2011 15:04:17 +0530
From: Deepthi <deepthi.pv@globaledgesoft.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: mpris-player
References: <4EDC77AA.3020801@globaledgesoft.com> <CABBYNZLrJsqwbN6hs_DU0aeL5T9DFuLMO3=ZEND+iE=DdhUA6A@mail.gmail.com>
In-Reply-To: <CABBYNZLrJsqwbN6hs_DU0aeL5T9DFuLMO3=ZEND+iE=DdhUA6A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 12/05/2011 02:13 PM, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Mon, Dec 5, 2011 at 9:50 AM, Deepthi<deepthi.pv@globaledgesoft.com>  wrote:
>    
>>
>> Hello,
>>
>>
>>     While executing the mpris-player , I 'm getting error saying :No
>> such Object path  /org/mpris/MediaPlayer2. Please help.
>>      
> This means your player is probably no following the mpris spec as it
> should, http://www.mpris.org/2.1/spec/:
>
> The media player must expose the /org/mpris/MediaPlayer2 object path,
> which must implement the following interfaces:
> org.mpris.MediaPlayer2
> org.mpris.MediaPlayer2.Player
>
> Version 1.0 of mpris is currently not supported by mpris-player.
>    

Hello,


I am using slackware 13.1,  with kernel version 2.6.33 , and amarok 
player with version 2.3.0 .

Which version of mpris will support for mpris-player?



Thanks & Regards,

Deepthi Elizabeth P V



