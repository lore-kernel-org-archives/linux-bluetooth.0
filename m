Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4475DBB0.2090003@silicom.fr>
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] report on new bluez headset
References: <446CDD43.3050604@free.fr> <446F383A.1040605@ens.fr> <4470B491.7040004@free.fr> <4470C77A.2080006@ens.fr> <4475C22B.9080908@free.fr> <4475CE30.7080109@xmission.com>
In-Reply-To: <4475CE30.7080109@xmission.com>
Content-Type: multipart/mixed;
 boundary="------------000308050406070408060404"
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
Date: Thu, 25 May 2006 18:30:40 +0200

This is a multi-part message in MIME format.
--------------000308050406070408060404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brad Midgley wrote:

>this is only going to work if egika will listen for dbus events to that
>effect. alsa provides nothing for signaling.
>
>  
>
Agreed :-)
However Ekiga already has optionnal support for DBUS. It should be 
possible to patch Ekiga so that it is responsive to headset 
connect/disconnect/button pushed events.

>>>But the sound is not perfect. I hear some frying sound (un petit
>>>gresillement), not very disturbing though but it is absent when I use
>>>it with Ekiga.
>>>      
>>>
>>I noticed that. It's not perfect yet.
>>I'm currently working on improving voice quality in general, but i looks
>>it will end up with a kernel patch.
>>    
>>
>
>We've had quality problems that might be attributed to improperly pacing
>the data sent through sco. I am not sure what the kernel provides--if
>anything--in terms of timing.
>  
>
Could you provide further information on these other quality problems ? 
Just out of curiosity ;-)

>What kind of kernel patch you are looking into?
>  
>
Well, i'm currently implementing a prototype for SCO flow control, so 
that user apps don't have to throttle themselves when sending data over 
a SCO socket. It should *theorically* help to have a continuous stream
of PCM samples flow troughout the stack without interruption. Everything 
is in the *theorically*. I'm just checking
that at the moment.

>alsa has two ways to look for devices. plugins do not show up using the
>api everyone is used to unfortunately.
>  
>
That's too bad, but that's true. It's just a shame alsa IO plugins can't 
appear like sound cards too.

>Brad
>
>
>-------------------------------------------------------
>All the advantages of Linux Managed Hosting--Without the Cost and Risk!
>Fully trained technicians. The highest number of Red Hat certifications in
>the hosting industry. Fanatical Support. Click to learn more
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>


--------------000308050406070408060404
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet;RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------000308050406070408060404--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
