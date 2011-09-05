Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110905095532.GA6735@dell.ger.corp.intel.com>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
	<1314999521-11261-3-git-send-email-claudio.takahasi@openbossa.org>
	<20110905095532.GA6735@dell.ger.corp.intel.com>
Date: Mon, 5 Sep 2011 10:47:48 -0300
Message-ID: <CAKT1EBfO0JucWFRPAAajyYMWhneCoG-PDW_nr3jtMmWFEQPWxA@mail.gmail.com>
Subject: Re: [RFC BlueZ 02/11] Add set auto connect in device
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Sep 5, 2011 at 6:55 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Sep 02, 2011, Claudio Takahasi wrote:
>> +void btd_adapter_system_unlocked(struct btd_adapter *adapter)
>> +{
>> +     if (!adapter->up)
>> +             return;
>> +
>> +     DBG("Unlocked");
>> +
>> +     g_slist_foreach(adapter->devices, set_auto_connect, NULL);
>> +}
>
> While the concept seems fine I think you've got the wrong name for the
> function. You shouldn't assume that "system unlocked" is the only reason
> for enabling auto-connect for the devices. It's as if you'd be pushing
> policy into the core daemon ("if unlocked, then auto-connect"). Instead
> the function should be named according to what it does, e.g.
> btd_adapter_enable_auto_connect or btd_adapter_auto_connect_devices.
>
> Johan

Thanks for the feedback. I gonna rename the function. I was more
afraid of the concept, in theory it could be more generic, triggering
connections to other services.
But one step at a time, first we need to improve the handling of
multiple LE connection requests(Including LE passive scanning).

BR,
Claudio
