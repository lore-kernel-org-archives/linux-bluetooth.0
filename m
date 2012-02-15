Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukz+nFbUn141XYsN91asx=BT=O1sK3s=__tEr7W+JVK6dyg@mail.gmail.com>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
	<1329241945-32414-2-git-send-email-anderson.lizardo@openbossa.org>
	<CACLukz+nFbUn141XYsN91asx=BT=O1sK3s=__tEr7W+JVK6dyg@mail.gmail.com>
Date: Wed, 15 Feb 2012 06:41:19 -0400
Message-ID: <CAJdJm_PP+WJ=er2vwDLwJSF4bsS0EjF7S=Wtx20+MQt+xJHa5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] thermometer: Fix handling of missing
 Temperature Type
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Feb 15, 2012 at 4:50 AM, Santiago Carot <sancane@gmail.com> wrote:
> Hi Anderson,
>
> 2012/2/14 Anderson Lizardo <anderson.lizardo@openbossa.org>:
>> According to HTS 1.0, it is not mandatory to have Temperature Type
>> information (the Characteristic and the indication field are both
>> unconditionally optional).
>>
>
> I'm afraid there is an slight conceptual error in this patch.
> According to HTS 1.0, there are two *exclusive* methods to provide the
> temperature type to a Colector: either by using a characteristic type
> or providing it as a field within the measurement. This doesn't mean
> that the temperature characteristic or field type are both
> unconditionally optional because one of them *MUST* be used, but not
> both of them at the same time. So there will always be a method to get
> the temperature type either if it's a static value (characteristic
> type) or a non-static value (temperature field). Health Thermometer
> Service[3.2] ,[3.1] &  Health Thermometer Profile [4.7]

I've seen these sections. And they are exclusive, but none of them are
mandatory. The reason for this patch is that we have seen an LE
thermometer without any method to get its type (and the current
upstream code simply ignores its measurements). Looking at both
HTS/HTP and developer.bluetooth.org does not mention them as
"conditionally optional" (usually shown by a C<n>  note on the service
table on service specification).

Please feel free to refer to where this "must" (usually a sentence
using "shall" word) condition is described.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
