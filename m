Return-Path: <cyrus@holtmann.org>
Message-ID: <4C860CBE.8060808@Atheros.com>
Date: Tue, 7 Sep 2010 15:28:22 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>,
	<joakim.xj.ceder@stericsson.com>, <claudio.takahasi@gmail.com>,
	<Waldemar.Rymarkiewicz@tieto.com>, <Arkadiusz.Lichwa@tieto.com>
Subject: Re: [RFC] Sim Access Profile API doc
References: <1283839375-20033-1-git-send-email-suraj@atheros.com> <20100907092927.GA28640@jh-x301>
In-Reply-To: <20100907092927.GA28640@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 9/7/2010 2:59 PM, Johan Hedberg wrote:
> Hi Suraj,
>
> On Tue, Sep 07, 2010, Suraj Sumangala wrote:
>> +Methods		void RegisterAgent(object agent)
>> +
>> +			This registers the Sim Access adapter agent.
>> +			This also registers the profile with the service
>> +			Databse and start waiting for an RFCOMM connection
>> +			on the SAP server channel.
>> +
>> +			The object path defines the path the of the agent.
>> +
>> +			If an application disconnects from the bus all
>> +			of its registered agents will be removed.
>> +
>> +			Possible errors: org.bluez.Error.InvalidArguments
>> +					 org.bluez.Error.AlreadyExists
>> +					 org.bluez.Error.Failed
>> +
>> +		void UnregisterAgent(object agent)
>> +
>> +			This unregisters the agent that has been previously
>> +			registered. The object path parameter must match the
>> +			same value that has been used on registration.
>> +
>> +			Possible errors: org.bluez.Error.DoesNotExist
>> +					 org.bluez.Error.InvalidArguments
>> +					 org.bluez.Error.Failed
>
> So you have these nice agent registration methods, however where's the
> definition of the agent interface? And if you're going to use an agent
> for this (which seems like a good idea) the SAP commands should map to
> D-Bus method calls to the agent and the D-Bus method replies from the
> agent should map to the SAP replies. I.e. please get rid of the D-Bus
> signals and methods you currently have for this.

The idea was to let the agent implementation be written depending on the 
actual SIM card reader implementation used in the back end. The agent 
can then map its signal/methods to the corresponding SAP server calls.

>
> Btw, I'm not 100% convinced that this is the most sensible architecture
> for implementing SAP, but assuming that it is the above comments apply
> :)

Yep, I understand. There were doubts raised on this methods. That is the 
reason why I thought about getting comments from the community.

Your comments are most welcome.

>
> Johan

Regards
Suraj

