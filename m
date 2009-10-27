Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256647374.2367.82.camel@localhost.localdomain>
References: <f9d4bd30910261504l577041d7y72f7a68b9a9753e9@mail.gmail.com>
	 <1256647374.2367.82.camel@localhost.localdomain>
Date: Tue, 27 Oct 2009 11:45:03 -0200
Message-ID: <f9d4bd30910270645y23040483na346dc93a29bff01@mail.gmail.com>
Subject: Re: [PATCH] Local out of band properties
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 27, 2009 at 10:42 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2009-10-26 at 20:04 -0200, Claudio Takahasi wrote:
>> Hi,
>>
>> this is the first step to support secure simple pairing using out of
>> band mechanism(NFC, USB, ..).
>>
>> First it is necessary export to applications a method to retrieve the data
>> that will be exchanged using out of band mechanism. "Hash" and "Randomizer"
>> properties were added in GetProperties method and PropertyChanged signal.
>>
>> git://git.infradead.org/users/cktakahasi/bluez.git oob-local
>>
>> Comments? Useless for now?
>>
>>
>>
>> The second part of oob is set the exchanged oob data in the device struct
>> and reply the oob data when the host controller sends "Remote OOB Data
>> Request Event".
>>
>> Initial proposal is here:
>> git://git.infradead.org/users/cktakahasi/bluez.git  oob-remote
>> It works, but we need to discuss the API.
>
> http://git.infradead.org/users/cktakahasi/bluez.git/blobdiff/ece9ea1c2e50697ed9b57fb53ff681d20b317610..d8a359f5e90879468ec1291961f9f60c62a52ac2:/doc/adapter-api.txt
> Same typo in both descriptions.
>
> Is there any way to request that the adapter refresh the
> hash/randomizer, or would that happen automatically when the data is
> actually used?
>
> Also, can the values be used independently of each other? In that case,
> it might make sense to have them both concatenated inside a one and only
> property.
>
> Finally, as you say you've tested this, which hardware did you use for
> testing? I know about the Nokia 6212 with NFC, but couldn't find a
> suitable NFC reader to go with it.
>
> Cheers
>
>
>

Hi Bastien,

I agree, both contains the same description we can concatenate in one
property only.
Both values are used in the "Remote OOB Data Request Reply Command" only.

>From BT spec:
" Note: Each OOB transfer will have unique C and R values so after each OOB
transfer this command shall be used to obtain a new set of values for the next
OOB transfer."

Currently, I am not updating hash and randomizer automatically, it is
necessary run  "hciconfig -a hci0 oobdata".
An approach to update it automatically can be  call "Read Local OOB
Data Command" after "Remote OOB Data Request Event". If the remote oob
data is present "Remote OOB Data Request Reply Command" will be used
to notify the Host controller, it also means that the LOCAL oob data
will be used and a new value must be set for the next OOB transfer. At
the moment, I am not sure if it is correct update the local OOB data
immediately or  if it is necessary wait for link key event to avoid
some race condition.

I have only one NXP PN533 board, I wish I had two to test real peer to
peer transfer instead of peer<->tag.
For initial tests I developed a python script, but it is necessary to
type the oob data on both sides :-P

Cheers,
krau
