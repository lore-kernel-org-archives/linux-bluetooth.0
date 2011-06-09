Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307615061.2589.36.camel@aeonflux>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1307615061.2589.36.camel@aeonflux>
Date: Thu, 9 Jun 2011 21:38:22 +0900
Message-ID: <BANLkTimz5QrqtXpEnEF8gwiVesGt8-HjLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add RequestSecurePinCode to agent API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 9, 2011 at 7:24 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Waldemar,
>
>> The method is called if min. 16 bytes pincode is mendatory
>> to authenticate connection.
>>
>> In practice this will be called only with mgmtops switched on. Hciops
>> don't support secure pin code so far.
>> ---
>> =A0doc/agent-api.txt | =A0 11 +++++++++++
>> =A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
>> index 9ab2063..b1cb354 100644
>> --- a/doc/agent-api.txt
>> +++ b/doc/agent-api.txt
>> @@ -31,6 +31,17 @@ Methods =A0 =A0 =A0 =A0 =A0 =A0void Release()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Possible errors: org.bluez.E=
rror.Rejected
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0org.bluez.Error.Canceled
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 string RequestSecurePinCode(object device)
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 This method gets called when t=
he service daemon
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 needs to get the secure passke=
y for an authentication.
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The return value should be a s=
tring of 16 characters
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length. The string can be alph=
anumeric.
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Possible errors: org.bluez.Err=
or.Rejected
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0org.bluez.Error.Canceled
>> +
>
> I do not like this since it is really legacy stuff and makes since
> really complicated. And now we are making big efforts to support this
> and that is bad. Since Simple Pairing solved this nicely for us.
>
> However I need to talk with Johan about this and figure something out.

We are getting closer to 4.100, maybe it is time to start doing the
transition to 5.x, which means we could start thinking on fixing the
current API without worrying if it breaks or not. How about that?



--=20
Luiz Augusto von Dentz
Computer Engineer
