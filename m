Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121017113515.GA16879@x220.ger.corp.intel.com>
References: <507D6F26.8040306@schulz.dk>
	<CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
	<507D7480.6040205@schulz.dk>
	<005601cdac45$e1ee8ac0$a5cba040$@dk>
	<CAJdJm_P+udqJta3K-FhzYEO4bOm+W=u9koV953etN8TmO=eo4w@mail.gmail.com>
	<20121017113515.GA16879@x220.ger.corp.intel.com>
Date: Wed, 17 Oct 2012 10:02:44 -0300
Message-ID: <CAJdJm_Mv7rEaeYYoipWgmF0VQ-69GA=MqipEtxDgKQ1mT5ukfA@mail.gmail.com>
Subject: Re: gatttool and multiple devices connected
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Kim Schulz <kim@schulz.dk>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Oct 17, 2012 at 8:35 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> This kernel is actually not that old (as long as it is based on the
>> official 3.4.0 one). Did you have hcidump logs for the attempt to
>> discover primary services on device B while connected to device A?
>
> Actually I'd say that it is too old for LE usage. E.g. the address type
> field to the L2CAP socket address was introduced in 3.5 which is quite
> important from an LE standpoint.

Ok, my mistake. I thought it was introduced still on 3.4.0. In this
case, Better use the latest mainline (3.6.*).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
