Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <37A4BD1B-EB5A-49F7-93E5-E2C1AEC8C7DA@holtmann.org>
References: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
	<37A4BD1B-EB5A-49F7-93E5-E2C1AEC8C7DA@holtmann.org>
Date: Wed, 10 Dec 2014 22:28:33 -0800
Message-ID: <CAPt0RYw6qC8N4muqbqbLcMN3yqF+w6210jww_sL7NoJsbpo6KQ@mail.gmail.com>
Subject: Re: Question about mgmt header files and shared-mainloop library
From: Mona Attariyan <monattar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
Does that mean that one shouldn't be using these APIs? (src/shared/*.h
?) How can I use
the mgmt sockets then?

Thanks,

On Mon, Dec 8, 2014 at 10:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mona,
>
>> I'm using bluez mgmt API in a simple scan application. I've been
>> including headers files like src/shared/mgmt.h and src/shared/util.h.
>> Also the main bluez bluetooth library (libbluetooth.so) does not
>> include the mgmt and mainloop stuff, so I've been linking against
>> shared-mainloop.a. My question is why aren't these header files part
>> of the public API? as in in lib directory or something that doesn't
>> sound internal. Same question about the library. Why aren't mgmt stuff
>> compiled into the main library?
>> I appreciate it if anyone could shed some light into the reasoning
>> behind this. Am I not supposed to be using these?
>
> there are not meant to be a public API. Even libbluetooth is no longer installed by default actually.
>
> Regards
>
> Marcel
>
