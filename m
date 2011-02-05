Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=qXPsLwAd96i5Okw_sh-PFKPy6chnEJ6zb9nu7@mail.gmail.com>
References: <AANLkTimT8sHND7PtKszFntj-b-BjmJORtijqOh_Bu3vP@mail.gmail.com>
 <AANLkTin60Z53M=vYA37tU7=7mQzv_Y+aeZp7ZeODSvaU@mail.gmail.com>
 <AANLkTimesBP5-KineuPYB6-uPEa+-=yBpbZmVo+SEW5=@mail.gmail.com> <AANLkTi=qXPsLwAd96i5Okw_sh-PFKPy6chnEJ6zb9nu7@mail.gmail.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Sat, 5 Feb 2011 12:39:50 +0100
Message-ID: <AANLkTin35v-OpSW34PMiG2qqBLPckcjhLv5GVKnsqQ49@mail.gmail.com>
Subject: Re: Health interfaces
To: Zahirul Islam <zahir1976@gmail.com>
Cc: sancane@gmail.com, epx@signove.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zahirul,

First, please do not do top posting in this mailing list.

2011/2/4 Zahirul Islam <zahir1976@gmail.com>:
> Hi Jose,
> Thank you for your mail. I really appreciate it.
> Let me explain little more. I am trying to read data from Health device
> (blood pressure monitor) and for this trying to create a sink in D-bus using
> python.
> I downloaded python script from there and ran deb packages.

What python script do you mean? and what deb packages?

> Now python script can create channel in MCAP as follows:
>
> Discovering device 00:15:83:43:36:EC CSR - bc4
>
> Discovering device 00:09:1F:80:07:E4 AND BP5091101130
>
> Handle 00010001:
>
> [{'mcap_procedures': ('reconnect_init', 'reconnect_accept'), 'handle':
> 65537, 'features': [{'mdep_id': 17, 'role': 'source', 'description': u'Blood
> Pressure Monitor ', 'data_type': 4103}], 'description': '', 'mcap_data_psm':
> 4099, 'mcap_control_psm': 4097, 'data_spec': 1, 'provider': '', 'name': ''}]
>
> Discovering device 00:09:1F:80:0F:0B AND SC5091150921
>
> Handle 00010001:
>
> [{'mcap_procedures': ('reconnect_init', 'reconnect_accept'), 'handle':
> 65537, 'features': [{'mdep_id': 17, 'role': 'source', 'description':
> u'Weighing Scale ', 'data_type': 4111}], 'description': '', 'mcap_data_psm':
> 4099, 'mcap_control_psm': 4097, 'data_spec': 1, 'provider': '', 'name': ''}]


I've got no idea about what this dictionaries are. I recognize some of
the data there, but I've never seen this dictionaries. Where did you
get them? Can you give more details.


>
> but I guess I need HealthManager interface (CreateApplication method) to
> establish connection. I dont see that interface in my qt dbus viewer.
> I am doing right things? I will appreciate any advice.

I thing that you are mixing things. As I told you in my previous email
you don't need to use anything from hdpy (wich is a different
implementation for HDP that was performed just for testing purposes).
You just have to use D-Bus interfaces.

Regards.

>
> Thanks again.
>
> On Fri, Feb 4, 2011 at 10:49 AM, Jose Antonio Santos Cadenas
> <santoscadenas@gmail.com> wrote:
>>
>> Hi Zahirul,
>>
>> 2011/2/4 Zahirul Islam <zahir1976@gmail.com>
>> >
>> > I am using ubuntu kernel 2.6.36 (enhanced transmission enabled) and
>> > qdbusviewer to browse bluez services ..
>> >
>> > Thanks in advance.
>> >
>> > Regards
>> > Zahir
>> >
>> > On Fri, Feb 4, 2011 at 10:31 AM, Zahirul Islam <zahir1976@gmail.com>
>> > wrote:
>> >>
>> >> Hello,
>> >>
>> >>
>> >> I have installed bluez 4.85 on my Ubuntu and was expecting following Health Interfaces
>> >> (according to http://gitorious.org/hdpy) in service org.bluez:
>> >>
>> >> Org.bluez.HealthManager
>> >> Org.bluez.HealthApplication
>> >> Org.bluez.HealthService
>> >> Org.bluez.HealthAgent
>> >>
>> >>
>> >> I can see only org.bluez.Manager interface available. How could I get those interfaces.
>> >>
>> >> I will appreciate any advice.
>> >>
>> >>
>> >> Regards
>> >>
>> >> Zahir
>>
>> Adding the bluez mail list in CC because this kind of questions should
>> be reported there.
>>
>> I think that your are mixing thing a little bit. If you are using
>> BlueZ you don't need hdpy. BlueZ implements MCAP and HDP since version
>> 4.76. The interface is exposed in D-Bus and this should be the unique
>> way to access HDP.
>>
>> You can find the API documentation of the HDP profile in the "docs"
>> folder of the BlueZ project.
>>
>> Regards.
>>
>> Jose.
>
>
