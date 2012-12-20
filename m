Return-Path: <cyrus@holtmann.org>
Subject: Re: Question for setting IO capability parameter for RegisterAgent
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Xian Pan <panxian1212@gmail.com>
In-Reply-To: <20121220075542.GA32641@x220>
Date: Thu, 20 Dec 2012 16:51:16 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <363D4FFF-53E5-40A3-92A4-FDA0BB60EEA6@gmail.com>
References: <679160B2-3B1E-4D5E-978E-E3358F6126E9@gmail.com> <20121220075542.GA32641@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your help. It is more clear now. The 5 io capability is related to low energy smp. And the first 4 IO capability parameters are the same as the values for SSP.
And the DisplayYesNo IO capability can support the numeric comparison mode in SSP.

right?
Thanks a lot.

BEST
Xian


On Dec 20, 2012, at 2:55 AM, Johan Hedberg wrote:

> Hi Xian,
> 
> On Wed, Dec 19, 2012, Xian Pan wrote:
>> I confuse the relationship between the 4 pairing mode in SSP with the
>> IO capability parameter for the agent. From the agent-api.txt file,
>> the capability parameter can have 5 values: DisplayOnly, DisplayYesNo,
>> KeyboardOnly, NoInputNoOutput and KeyboardDisplay. I think there are
>> only 4 pairing mode in SSP: just works, numeric comparison, out of
>> band, and passkey entry. How the 5 IO capabilities can map to those 4
>> pairing modes?
> 
> Low Energy SMP based pairing introduces the additional KeyboardDisplay
> IO capability. If you want to support LE it's recommended you provide
> that as your agent capability and BlueZ will then automatically
> downgrade it to DisplayYesNo for BR/EDR (SSP) pairing and use it as is
> for LE SMP pairing.
> 
> Johan

