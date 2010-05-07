Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2541510E-4912-4AEB-AEFB-83F4339EC3FA@signove.com>
References: <201005051255.09394.jcaden@libresoft.es> <3CCD92AC-1578-4E78-AEE8-80AEE73511EB@signove.com>
	<201005071203.23882.jcaden@libresoft.es> <2541510E-4912-4AEB-AEFB-83F4339EC3FA@signove.com>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Fri, 7 May 2010 17:51:38 -0300
Message-ID: <n2haa32413d1005071351qb6db6039u7caab57a5e893884@mail.gmail.com>
Subject: Re: HDP proposed api (ver 0.2)
To: =?UTF-8?Q?Elvis_Pf=C3=BCtzenreuter?= <epx@signove.com>
Cc: jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 7, 2010 at 10:46, Elvis Pfützenreuter <epx@signove.com> wrote:
>>> "Forcing" a source to specify the MDEP IDs here, even if not publishing the
>>> record, makes checks easier further.
>>
>> Not sure about that. Note that when you don't publish a SDP record, nobody
>> could connect to you, so you won't receive data channel connections request,
>> so you don't need to check if the mdeps are in use or not.
>
> Indeed, you are right; from spec point of view I am not forced to define MDEP IDs beforehand (my old habits of TCP/IP, having ports both sides, sometimes overwhelm me :)
>
> The actual argument is higher level: whether should we *force* the application to specify the MDEP IDs / data types beforehand (as I "voted", with "my" API) or not (as you "voted").
>
> This is the point we need more opinions, from people in the list :)
>
>
>>> Perhaps you tried to accomodate the notion that a data channel ID
>>> "survives" even if the device disappearrs for a short moment?
>>
>> Also this, remember that MCAP allow temporal disconnections to reestablish
>> them in future connections to save state.
>
> Ok, I need to see whether BlueZ keeps the device objects in D-BUS tree after disconnection of if it removees it immediately. If it keeps the object, the sessions should be there as sub-paths (to be consistent with HdpSession being a part of adapter path.). If it doesn't, indeed they need to go somewhere else.

Device objects exists for each paired device. If the pairing is
removed the object is also removed and a new pairing is needed before
connecting to it (as imposed by the whole bluetooth stack logic
anyway).

Re-using the device path and adding sessions as sub-paths seems
reasonable, but I would wait on comments from Johan / Luiz / Marcel if
this is desirable or might have any side-implication before defining
this topic as closed.

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
