Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yC=vh0PUS7ZgZ_zUff_gPzLwjYx8EABxbT71uU5zQAChTQ@mail.gmail.com>
References: <CAHZ1yC=vh0PUS7ZgZ_zUff_gPzLwjYx8EABxbT71uU5zQAChTQ@mail.gmail.com>
Date: Mon, 21 Oct 2013 21:31:40 -0400
Message-ID: <CAJdJm_P4kq2WFRhhSbr9KROqTaqwmV2p3u9NzHW1Lt1v8hX0tA@mail.gmail.com>
Subject: Re: GATT - How to mark an attribute as requiring encryption
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Mon, Oct 21, 2013 at 9:01 PM, Scott James Remnant <keybuk@google.com> wrote:
> While there is a way to mark an attribute as needing authentication
> and/or authorization, there does not seem to be a way to mark an
> attribute as requiring encryption (or a particular key size), and I
> couldn't find any code that would return the ATT_ECODE_INSUFF_ENC or
> ATT_ECODE_INSUFF_ENCR_KEY_SIZE responses.

There is a FIXME for this on function att_check_reqs()
(src/attrib-server.c). Feel free to fix it :)

Note that, as part of the ongoing implementation of a D-Bus API for
implementing external GATT services, we have patches (currently being
cleaned up for upstream submission) that will refactor the internal C
API for creating GATT services. If you are interested, take a look at
(note that it is work-in-progress code):

git://git.infradead.org/users/cktakahasi/bluez.git (branch gatt-api-devel)

Also take a look at the API document sent by Claudio a few days ago:
"[RFC BlueZ v0] doc: Add GATT API"

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
