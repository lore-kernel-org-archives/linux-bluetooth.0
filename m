Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091028235434.GA13715@jh-x301>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
	<2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
	<e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com>
	<2d5a2c100910231044u6a6c65e0ka8258a6f65d08f41@mail.gmail.com>
	<e8892a6a0910260820g43b4f688g2c33d7d1ae771d07@mail.gmail.com>
	<20091028233425.GA13183@jh-x301> <e8892a6a0910281645r39d3b793wa9b9f2cc948da3da@mail.gmail.com>
	<20091028235434.GA13715@jh-x301>
From: Jaikumar Ganesh <jaikumar@google.com>
Date: Wed, 28 Oct 2009 17:02:35 -0700
Message-ID: <e8892a6a0910281702y952d88evca1bb6a7674b9de7@mail.gmail.com>
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
To: Jaikumar Ganesh <jaikumar@google.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Wed, Oct 28, 2009 at 4:54 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Oct 28, 2009, Jaikumar Ganesh wrote:
>> The SDP cache is  removed when the device is removed. In fact, you
>> fixed this a few days back.
>
> Which commit are you referring to?

Commit number:

4bec43039626e853489e72149014868f8c8afedc

http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=4bec43039626e853489e72149014868f8c8afedc


>
>> This is the scenario I am referring to:
>> a) Device is paired and SDP records fetched.
>> b) Device is unpaired - device cache records of SDP is freed
>
> Ok, so at this point we don't have anything stored about the device,
> neither on disk nor in runtime memory.

I should have been more clear - we only remove the runtime memory cache
The on disk SDP records are not removed.

>
>> c) On Remote Device - some SDP records are deleted.
>> d) When the device is created again and the SDP records fetched,
>> profiles_removed is empty and so
>>
>>         if (req->profiles_removed)
>>                 device_remove_drivers(device, req->profiles_removed);
>>
>> device_remove_drivers will not be called and hence SDP records will
>> never get deleted.
>
> But what is there to delete if in step b) we already deleted everything?

We can also fix this by removing the on disk SDP records when the
device is freed.
(I think which is what you suggested - by cache I was interpreting it
as in memory cache)
Will submit a new patch. Let me know if I read you wrong.

>
> Johan
>
