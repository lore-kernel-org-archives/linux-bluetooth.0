Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120302235731.GA32181@x220.ice.intel.com>
References: <1330070908-2361-1-git-send-email-sancane@gmail.com>
	<20120302235731.GA32181@x220.ice.intel.com>
Date: Fri, 2 Mar 2012 20:05:58 -0400
Message-ID: <CAJdJm_NzQ50r02tk5=fCOFtTxFGZ+9RpwB5GAWAzp8SQoLXmbw@mail.gmail.com>
Subject: Re: [PATCH] Heart Rate Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 2, 2012 at 7:57 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Santiago,
>
> On Fri, Feb 24, 2012, Santiago Carot-Nemesio wrote:
>> +             Reset()
>> +
>> +                     Restart the accumulation of energy expended from zero.
>> +
>> +                     Possible Errors: org.bluez.Error.NotSupported
>> +
>> +Properties   boolean Reset [readonly]
>> +
>> +                     True if energy expended is supportted.
>
> The API looks good to me, but I think ResetSupported would make more
> sense for this property name. Also, I'd have expected someone from INdT
> to either give an ack or nack for this.

I previously said "Just minor typos below. After they are fixed, I
think it is okay to go upstream."

The typos were fixed on this last version.

Regarding "Reset" -> "ResetSupported", I agree with your suggestion.

Santiago, also take the opportunity to fix another typo (on the
snippet above): supportted -> supported

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
