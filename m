Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKriHan=oVqsonGYH_y-N1XOzxZbM0ukugoO_HxeLyrAw@mail.gmail.com>
References: <1309816301-18377-1-git-send-email-bulislaw@linux.com>
	<CABBYNZL3C1hLbgGMvtka8-Pd9bo4zHM0saa2awbdN=vHEddteQ@mail.gmail.com>
	<CAPGrrxWcWr_bQ-_B+jvOWJZJ_2pSt0zEJ4rubgtDnJFPHjSehg@mail.gmail.com>
	<CABBYNZJU3KiK=MFpBQ+nuAJXE1E4pUEt0MecJJXSqqtWwtySfA@mail.gmail.com>
	<CAPGrrxXzkVRLAPxuC86eJCp4hUkPj-TEHZF7h0hzGwb2CwUP1Q@mail.gmail.com>
	<CABBYNZKriHan=oVqsonGYH_y-N1XOzxZbM0ukugoO_HxeLyrAw@mail.gmail.com>
Date: Tue, 5 Jul 2011 12:30:35 +0200
Message-ID: <CAPGrrxVitebn-vjn-uGO9BCLGOWnbzVrB8Cn=+QoqVVhACArkA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/5] Change EDS backend to support multiple ebooks
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 5, 2011 at 12:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Jul 5, 2011 at 1:07 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>> On Tue, Jul 5, 2011 at 11:58 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Bartosz,
>>>
>>> On Tue, Jul 5, 2011 at 12:00 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>>>>
>>>> Don't know anything about it, but is there really any other choice?
>>>>
>>>
>>> I guess the idea is to use D-Bus directly, removing the ebook dependency.
>>>
>>> --
>>> Luiz Augusto von Dentz
>>>
>>
>> And what the "original" problems with libebook was? So i could test it
>> further. BTW I'v tested this backend and it's working fine - no
>> problem with obexd itself either ...
>
> iirc it uses dbus-glib which once initialized replaces the gdbus
> callbacks, in other words D-Bus signals and method calls stop working
> for anything that is not using dbus-glib.
>
>
> --
> Luiz Augusto von Dentz
>

So for example signals would stop being emitted?

-- 
Pozdrowienia,
Bartosz Szatkowski
