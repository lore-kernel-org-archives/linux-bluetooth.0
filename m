Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFD28CA.5010707@gmail.com>
Date: Fri, 13 Nov 2009 10:37:14 +0100
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	=?ISO-8859-1?Q?Pedro_de_las_He?= =?ISO-8859-1?Q?ras_Quir=F3s?=
	<pheras@gsyc.es>, scarot@libresoft.es,
	=?ISO-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Subject: Re: HDP & MCAP developed for Bluez
References: <4AFBF5AE.9090107@gmail.com> <2d5a2c100911121051u5824197an19d5607eb9a2e40c@mail.gmail.com>
In-Reply-To: <2d5a2c100911121051u5824197an19d5607eb9a2e40c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz escribió:
> Hi,
> 
> 2009/11/12 sancane <sancane@gmail.com>:
>> Hi all,
>>
>> I would like to announce to you that we have finished our open
>> source MCAP-HDP implementation for Bluez. We've successfully tested it
>> against a Nonin Onyx II 9560 using the el2cap Gustavo's kernel
>> implementation.
> 
> Look pretty good, I just check the video.
> 
>> We're planning to release it under GNU/GPL v3. If you are interested, we
>> can add it to Bluez official library. We are open to any suggestion or
>> recommendation.
>>
>> At current moment we are working on it to set the code in a more stable
>> state. We will plan to upload our libraries in next few days, we will
>> announce here when the code is available.
> 
> Normally we implement the profile as device drivers (bluetoothd device
> driver not kernel :D), it would be nice to have and appropriate driver
> to handle MCAP-HDP records and put together a nice DBus API so any
> application can easily access its informations without having to
> really use any library.

Yes, we are planning to integrate our libraries with DBus to make our
code Bluez happy.
The main problem is that we have not any experience in DBus, but we
think that the wrappers for DBus should not be a problem. Can you give
to us a good starting point to DBus?

> 
>> We have noticed that it is necessary to add some functionalities to the
>> SDP implementation (which affect to HDP records), at the current moment,
>> we have included it in HDP, but we think that it is better to include it
>> in SDP. If you want, we can submit a patch to add it.
> 
> Patches are always welcome :D
> 

Ok, i talked with Jose Antonio that worked with my in HDP
imeplementation. He will submit the patch shortly

Thanks in advance.

