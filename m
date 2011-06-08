Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110608022610.GA2772@dell.ccr.corp.intel.com>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
	<1307483205-1518-8-git-send-email-vinicius.gomes@openbossa.org>
	<20110608022610.GA2772@dell.ccr.corp.intel.com>
Date: Wed, 8 Jun 2011 13:16:42 +0900
Message-ID: <BANLkTikHJE-165=JOD+4UhxY7XQ6Lrx3KA@mail.gmail.com>
Subject: Re: [bluetooth-next v3 07/16] Bluetooth: Add SMP confirmation checks methods
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Jun 8, 2011 at 11:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vinicius/Anderson,
>
> On Tue, Jun 07, 2011, Vinicius Costa Gomes wrote:
>> +     ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
>> +                     conn->src, 0, conn->dst, res);
>
> The third last parameter is the remote address type and you're
> hard-coding it to 0 (public) here. This means that we cannot pair with a
> device with a random address. I suppose you should be passing
> conn->hcon->dst_type instead.

I notice that you guys have this fixed here:

http://git.infradead.org/users/vcgomes/linux-2.6.git/commitdiff/f345aa37d6d49104ef4b2b7e4466fb3186807199

So I wonder why this was not fix in place?

>> +             ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
>> +                                     0, conn->dst, 0, conn->src, res);
>
> Same here.
>
>> +     if (conn->hcon->out)
>> +             ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
>> +                             conn->src, 0, conn->dst, res);
>> +     else
>> +             ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
>> +                             conn->dst, 0, conn->src, res);
>
> And here.
>
> You're also hard-coding the local address type to public, but that's a
> less severe issue (for now).
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer
