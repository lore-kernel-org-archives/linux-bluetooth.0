Return-Path: <cyrus@holtmann.org>
Message-ID: <49104A5D.1030105@slackdot.org>
Date: Tue, 04 Nov 2008 08:13:01 -0500
From: deker <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <490FCEFE.50302@slackdot.org>
	<36FF1F3A-27F8-4681-B70A-7CB81A295D86@holtmann.org>
In-Reply-To: <36FF1F3A-27F8-4681-B70A-7CB81A295D86@holtmann.org>
Subject: Re: [Bluez-devel] Multiple simultaneous audio streams?
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Speech quality is all we need. If I can get 2 8Khz output streams going 
to 2 devices and 1 8Khz input stream from one device I'll be happy.

If somebody can point me in the right direction I'd really appreciate it.

Thanks,

-d

Marcel Holtmann wrote:
> Hi,
>
>   
>> I am working on a project where it would be desirable to have audio
>> streams going to more than one SCO audio device at a time. My quick  
>> test
>> today of playing a WAV file with mplayer to two different devices  
>> didn't
>> work and bluetoothd was reporting "connection refused" when I tried to
>> get the second stream going. Once the first playback finished, I was
>> able to then play to the second device.
>>
>> So, I suppose m question is if BlueZ supports audio to multiple SCO
>> devices at the same time? If not, what might be involved in making  
>> it work?
>>     
>
> do you wanna do speech quality or CD quality audio streaming?
>
> And yes, BlueZ does support it, but there are limitations from the  
> Bluetooth radio. So you really need to know what you wanna do.
>
> Regards
>
> Marcel
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
