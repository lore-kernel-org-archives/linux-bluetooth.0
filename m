Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1AFE20D16950C745A2A83986B72E8748011F571E6F06@EMEXM3131.dir.svc.accenture.com>
References: <20101115120632.GB16464@null>
	<1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com>
	<20101115151739.GD16464@null>
	<1AFE20D16950C745A2A83986B72E8748011F571E6F06@EMEXM3131.dir.svc.accenture.com>
Date: Thu, 18 Nov 2010 17:15:25 +0200
Message-ID: <AANLkTi=Q=fUnc3TGWTW_8EypkJc_Q-KXNVxWrYh0Qrj1@mail.gmail.com>
Subject: Re: [RFC] Interface to set LE connection parameters
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: tim.howes@accenture.com
Cc: ville.tervo@nokia.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 16, 2010 at 11:56 AM,  <tim.howes@accenture.com> wrote:
> Ville,
>
>> > As you note the different profiles would likely have different
>> connection parameters.  The different profiles may be running on the
>> same LE link (indeed the same L2CAP [fixed] channel).
>> >
>>
>> I guess the latency should override power requirements. Low power
>> profile can
>> operate on low latency link but low latency profile fails on high
>> latency. Of
>> course this gets much more complicated if there are more requirements.
>
> Agreed.
>
>>
>> Are these (latency and power) the only characteristics we need to deal
>> with.
>> There might be some also. I'm not too familiar with profile drafts.
>
> I think these are the main issues; however I wonder whether link supervision timeout may conflict for different use cases.  Even if it is not the link supervision the lifetime of the physical link may differ between profiles (some may want the link up for a long time but send no data). Slightly off-topic; but still it raises issues around the type of API and the arbitration of different profile requirements on the same link.
>> > Do you have a view on how the different profiles - on the same link -
>> would have different requests arbitrated, and where that arbitration
>> would be done?  I'd imagine that the API towards the profiles should be
>> of the abstract form - such as you mention (eg BT_LE_LOW_LAT).  This
>> would make it easier to arbitrate the different requests, as compared
>> to if the profiles see an API of the "numerical" form (eg interval = N
>> ms).  I guess the arbitration could happen in user or kernel space; as
>> long as there is something with singleton-like semantics to do it.
>> >
>>
>> I think I need to get more details from profile specs and try to find
>> out the
>> requirements from them.
>
> As an aside, it's not just the application profiles.  If you have a link to a device with high latency and need to do more service search using GATT then you might want to lower the latency temporarily.  This may impact the type of API control you give GATT applications versus any in-built GATT service discovery.

Well maybe we could have some sort of QoS API for l2cap sockets, for
instance using link supervision timeout would be very nice to detect
link loss on audio profiles where 20 sec. is way too big, and the
timeout to enter sniff mode could be dynamically adjusted. Normally we
don't export those for userspace but I guess for LE this has to be
done anyway and iirc l2cap sockets require privileges so basically
only root will be able to play with this so e.g. would be able
bluetoothd to adjust the parameter depending on the profile.

-- 
Luiz Augusto von Dentz
Computer Engineer
