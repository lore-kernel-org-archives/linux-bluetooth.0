Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8E0BA3.1010308@Atheros.com>
Date: Mon, 13 Sep 2010 17:01:47 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <20100913105932.GA3566@jh-x301>
In-Reply-To: <20100913105932.GA3566@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 9/13/2010 4:29 PM, Johan Hedberg wrote:
> Hi Suraj,
>
> On Mon, Sep 13, 2010, Suraj Sumangala wrote:
>> +		void Response(string command, string result, object response)
>
> This method should be removed. Instead, you should use the methor return
> messages for the commands to relay the response information.

Ok,

Should we have the method like,
	struct RequestATR(string command, variant param)
	
	where, struct = { string, array{uint8} )
>
>> +Sim Access Server Agent hierarchy
>> +=================================
>> +
>> +Service         unique name
>> +Interface       org.bluez.SAPServerAgent
>> +Object path     freely definable
>> +
>> +Methods		Request(string command, object param)
>
> Since the set of SAP commands is fixed and rather short it'd be much
> simpler if you have a separate D-Bus method for each command
> (particularly from the method and method return signature perspective).
> You also seem to have some confusion about what an "object" type
> parameter is. It seems you're using it for some sort of variant type
> when it will only ever represent a simple object path.

Thanks, My mistake. I was referring to a variant type there.
>
> Johan

Regards
Suraj

