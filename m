Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
	 <1240966565.997.65.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
Date: Tue, 28 Apr 2009 22:47:50 -0300
Message-ID: <6b53b1990904281847i5c72770dif47b67366b7b9183@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
	mm/slub.c:1595 --- "hcitool cc" or "l2ping"
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Bing Zhao <bzhao@marvell.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing

On Tue, Apr 28, 2009 at 10:14 PM, Bing Zhao <bzhao@marvell.com> wrote:
>> Hi Bing,
>>
>> > I'm getting this error whenever I use "hcitool cc" or "l2ping xx:xx:xx=
:xx:xx:xx"
>> command.
>> >
>> > Kernel: version 2.6.30-rc3 from bluetooth-testing tree
>> > HCI Tool: version 3.20
>> > Laptop: Lenovo X61s
>>
>> can you rebase the bluetooth-testing.git tree from a few hours ago and
>> test again.
>>
>> Regards
>>
>> Marcel
>>
>
> Hi Marcel,
>
> "git log" shows the last commit was ad4751fcada51292bb2967748667b58228164=
7d0.
> Bluetooth: Fix errors and warnings in L2CAP reported by checkpatch.pl
>
> Is it the latest one?

yes, but make sure that you already have this patch:
d79c7b52d647153831c59c223a44015c2050ad67

>
> Thanks,
>
> Bing
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gustavo F. Padovan
http://padovan.org
