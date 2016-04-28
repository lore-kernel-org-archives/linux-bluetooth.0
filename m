Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=X57vOejt9ZcvjFYu7iTvwWX0a2WQri_5UaQ_f5fJW91x_+Q@mail.gmail.com>
References: <CAG=X57uJqf2kuedzNjJCVvy5RKyWwcM7nSJjgOn24jBOn40Z7g@mail.gmail.com>
	<CAG=X57u1_b_aajsMd3p5ZSN6=0q7PnRgWa7izWxCpOr1QvSYcQ@mail.gmail.com>
	<CAG=X57vOejt9ZcvjFYu7iTvwWX0a2WQri_5UaQ_f5fJW91x_+Q@mail.gmail.com>
Date: Thu, 28 Apr 2016 13:41:02 +0300
Message-ID: <CABBYNZ+MqbTbs=taSyaU=2Twd9Gpi93RpECaaeCFtr_Y7RhoFQ@mail.gmail.com>
Subject: Re: GATT Client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: NagaChaitanya Vellanki <nagachaitanya.vellanki@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 28, 2016 at 3:23 AM, NagaChaitanya Vellanki
<nagachaitanya.vellanki@gmail.com> wrote:
> sudo ./main -d B4:99:4C:64:B2:2B -t public -s low -v
> btgatt-client: Opening L2CAP LE connection on ATT channel:
>          src: 00:00:00:00:00:00
>         dest: B4:99:4C:64:B2:2B
> Connecting to device... Done
> started discovery request and returning out of gatt_client_init
> GATT Client created returning reference client->in_init: 1  client->ready: 0
>
> when will client->ready be true in btgatt-client.c

Please no top posting in the mailing list. As for the actual problem I
guess it is better to use bluetootctl nowadays, you should be able to
act as GATT client and it is a much more complete client including
pairing agent, etc.

>
> Thank you,
> Naga
>
> On Wed, Apr 27, 2016 at 3:08 PM, NagaChaitanya Vellanki
> <nagachaitanya.vellanki@gmail.com> wrote:
>> More context info here
>>
>> sudo ./main -d B0:34:95:58:E5:08
>> Connecting to device... Done
>> [GATT client]# help
>> Commands:
>>         help                    Display help message
>>         services                Show discovered services
>>         read-value              Read a characteristic or descriptor value
>>         read-long-value         Read a long characteristic or desctriptor value
>>         read-multiple           Read Multiple
>>         write-value             Write a characteristic or descriptor value
>>         write-long-value        Write long characteristic or descriptor value
>>         write-prepare           Write prepare characteristic or descriptor value
>>         write-execute           Execute already prepared write
>>         register-notify         Subscribe to not/ind from a characteristic
>>         unregister-notify       Unregister a not/ind session
>>         set-security            Set security level on le connection
>>         get-security            Get security level on le connection
>>         set-sign-key            Set signing key for signed write command
>> [GATT client]# services
>> GATT client not initialized
>> [GATT client]#
>>
>> Would like to understand what needs to be done to initialize the GATT Client.
>>
>> Thank you,
>> NagaChaitanya Vellanki
>>
>> On Wed, Apr 27, 2016 at 12:15 PM, NagaChaitanya Vellanki
>> <nagachaitanya.vellanki@gmail.com> wrote:
>>> Hi all,
>>> I am trying to run the btgatt-client.c example in the source
>>> code(http://git.kernel.org/cgit/bluetooth/bluez.git/tree/tools/btgatt-client.c)
>>> to connect to the TI sensor tag. But I am getting 'GATT Client not
>>> initialized'. Please let me know how can i initialize the GATT
>>> Client?.
>>>
>>> Thank you,
>>> NagaChaitanya Vellanki
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
