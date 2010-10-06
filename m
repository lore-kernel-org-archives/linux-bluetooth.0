Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101006133206.GA8696@jh-x301>
References: <1286369566-1453-1-git-send-email-lucas.pawlik@gmail.com>
	<20101006133206.GA8696@jh-x301>
Date: Wed, 6 Oct 2010 17:33:07 +0200
Message-ID: <AANLkTim4WEh7ZLTiWbhiWcv1VXV+jpb_V8NqJjeq=OzH@mail.gmail.com>
Subject: Re: [PATCH] Fix problem with invalid read from array
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sorry. My bad. It was never my intention to change src/adapter.c. I've
prepared two patches with the same name and of course send the wrong
one. Problem with invalid read fix change made in src/sdpd-service.c
file.

Lukasz

2010/10/6 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Lukasz,
>
> On Wed, Oct 06, 2010, Lukasz Pawlik wrote:
>> This patch fix problem with reading data from out of the array range in
>> function used to create EIR response.
>
> You'll need to explain in more detail exactly what was wrong with the
> old code and how your patch fixes it (and why it is the correct fix).
>
>> -     uint8_t data[240];
>> +     uint8_t data[242];
>
> Why 242? The core spec defines the EIR data as a 240 byte field.
>
>> -                                     uuid128_data[SIZEOF_UUID128 - k])
>> +                                     uuid128_data[SIZEOF_UUID128 - 1 - k])
>
> This change looks fine (the index of the last byte is sizeof(uuid128) - 1).
>
> Johan
>
