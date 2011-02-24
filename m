Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C0C1E181-6699-4545-9AEC-EB813F387EBD@signove.com>
References: <1298468980-2215-1-git-send-email-epx@signove.com>
	<AANLkTik9wa_Pzezs3_udVD9MzwjxOaAAdEugjrD_U-KG@mail.gmail.com>
	<C0C1E181-6699-4545-9AEC-EB813F387EBD@signove.com>
Date: Thu, 24 Feb 2011 17:46:16 -0300
Message-ID: <AANLkTi=zuZk0cYTqp-REn2oFybfHP4+VBc4rOEaNBPfD@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] Add generic descriptor support to Attribute API document
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Feb 24, 2011 at 4:34 PM, Elvis Pfützenreuter <epx@signove.com> wrote:
>> With all those restrictions for writing, do you think it makes sense
>> to allow writing to the "Descriptors" property? Can you mention
>> situations where you might want applications to modify descriptors?
>
> Apart from CCC (which we plan to deal with in another series), no :(
>
> But GATT has this feature, so a general API should IMHO have it, since some
> future GATT-based profile may well use it.
>
> Actually, there is just one restriction for writing: one descriptor at a time,
> and I propose this just because of difficulties in error reporting (if e.g.
> 2 out of 5 descriptors could not be updated due to lack of permissions, yet
> just 1 error can be reported back).

As we discussed on IRC, let's wait for stabilization and clarification
or our D-Bus API for GATT services and characteristics, then we can
introduce a descriptor access API upstream.

Anyway, your patch is useful for whoever wants direct access to descriptors :)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
