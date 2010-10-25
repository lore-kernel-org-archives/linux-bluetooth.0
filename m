Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5AA6D2CA-9EE2-49EC-BBE0-F1185DE42BF5@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
	<AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
	<4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com>
	<AANLkTikLByb4qKBJP_iBUw2H0EqLo1MA9bttLwBO9s-u@mail.gmail.com>
	<5AA6D2CA-9EE2-49EC-BBE0-F1185DE42BF5@signove.com>
Date: Mon, 25 Oct 2010 09:26:41 +0200
Message-ID: <AANLkTikYY85G59-HC4824oYK9u6zJkjFGAP9YqOH8oJW@mail.gmail.com>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Elvis,

2010/10/24 Elvis Pfützenreuter <epx@signove.com>:
>
>> sure?
>> Then you should think what happen with the First reliable data channel
>> in case that you are running multiples IEEE specializations over the
>> same HDP instance (that is pretty common in IEEE level). Remember that
>> the First Relible data channel is used for IEEE association and
>> confirmed event traffic. If you dont allow use that channel by other
>> application it won't associate with the other device at IEEE layer.
>> Please, think that with current HDP implementation you can develop
>> IEEE agent specializations too, not only managers.
>
> Ok, I think I see your point now. Thanks for the patience :)
>

Don't worry. comments are welcome, in any case, If you have more
doubts, please don't hesitate in contact with me, we can talk more
about that and others issues in IRC, the only problem may be the time
difference ;)

Regards
