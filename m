Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F91420.8080300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] partly OT: pipe sound from Headset to soundcard
References: <41F7CEF6.1050508@webstuhl.net> <41F7D274.4030208@xmission.com> <41F82DA9.8090806@webstuhl.net>
In-Reply-To: <41F82DA9.8090806@webstuhl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 27 Jan 2005 09:17:36 -0700

Your program would be an alsa client, copying from one alsa device to 
another. No btsco changes at all.

I don't know enough about how alsa works to know if you could just do it 
in asound.conf

Ben Pezzei wrote:
> Hi Brad,
> 
> Brad Midgley schrieb:
> 
>> I had the same thought.
>>
>> We have a way to send line in to a stereo headset but there is a 
>> delay. (see bluetooth-alsa.sf.net)
> 
> 
> Yeah, but this covers A2DP only, right?
> 
> Right now, I was trying to accomplish this via asound.conf:
> something like:
> pcm.foo {
>   type multi
>   <map soundcard>
>   <map headset>
> }
> pcm.bar {
>   type route
>   slave.pcm "bar"
>   <map channels card out -> hs in>
>   <map channels card in -> hs out>
> }
> 
> hope the idea is understandable
> 
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_route 
> 
> 
> but I guess this won't work
> 
>> You could write something similar that runs in userspace and copies 
>> audio streams around using sco.
> 
> 
> C hacking? ;) well, if there is really no other way, i could
> try it. Are there some docs around to dig in or just the btsco
> sources?
> 
> greetings
> ben
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
