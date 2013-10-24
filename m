Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_P4kq2WFRhhSbr9KROqTaqwmV2p3u9NzHW1Lt1v8hX0tA@mail.gmail.com>
References: <CAHZ1yC=vh0PUS7ZgZ_zUff_gPzLwjYx8EABxbT71uU5zQAChTQ@mail.gmail.com>
	<CAJdJm_P4kq2WFRhhSbr9KROqTaqwmV2p3u9NzHW1Lt1v8hX0tA@mail.gmail.com>
Date: Thu, 24 Oct 2013 13:46:13 -0700
Message-ID: <CAHZ1yCkAcqZqr8DwtRdPvdhQP8NheitbMM8qf6HLPenc6pf_2Q@mail.gmail.com>
Subject: Re: GATT - How to mark an attribute as requiring encryption
From: Scott James Remnant <keybuk@google.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 21, 2013 at 6:31 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:

> On Mon, Oct 21, 2013 at 9:01 PM, Scott James Remnant <keybuk@google.com> wrote:
>> While there is a way to mark an attribute as needing authentication
>> and/or authorization, there does not seem to be a way to mark an
>> attribute as requiring encryption (or a particular key size), and I
>> couldn't find any code that would return the ATT_ECODE_INSUFF_ENC or
>> ATT_ECODE_INSUFF_ENCR_KEY_SIZE responses.
>
> There is a FIXME for this on function att_check_reqs()
> (src/attrib-server.c). Feel free to fix it :)
>
Actually the FIXME seems unrelated, that seems to be about looking at
the reported security level of the connection and only considering the
"have authentication" check to be passed if the level is
BT_IO_SEC_HIGH -- right now it would accept BT_IO_SEC_MEDIUM as
evidence of authentication.

At least that's how I read it.


That said, having stared at the standard and the Test Purposes a
little longer, the test isn't even checking for "insufficient
encryption" but "insufficient encryption key size". In these tests the
PTS actually does negotiate encryption, it's expecting the attribute
server to record the key size and allow attributes to declare that
they need a bigger key.

> Note that, as part of the ongoing implementation of a D-Bus API for
> implementing external GATT services, we have patches (currently being
> cleaned up for upstream submission) that will refactor the internal C
> API for creating GATT services. If you are interested, take a look at
> (note that it is work-in-progress code):
>
> git://git.infradead.org/users/cktakahasi/bluez.git (branch gatt-api-devel)
>
> Also take a look at the API document sent by Claudio a few days ago:
> "[RFC BlueZ v0] doc: Add GATT API"
>
I have this on my TODO to read once we're clear through qualification.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
