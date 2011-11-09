Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320835923-10989-1-git-send-email-sancane@gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
Date: Wed, 9 Nov 2011 08:19:40 -0400
Message-ID: <CAJdJm_PNH-1EZqVZp8ZXkU94p6cHJ-3yDcQ4srCX-JwTOSctXg@mail.gmail.com>
Subject: Re: Health Thermometer Profile (HTP)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> This is a new set of patches to enhance thermometer plugin fuctionality.
> These patches enable watchers to receiave final/intermediate measurements
> from thermometers devices.

Out of curiosity, with this latest series, will we be able to use LE
Health Thermometers? Or do you still have pending items?

It would be nice if you share your TODO list regarding this profile,
or current limitations (if any), on each series you send.

> [PATCH 1/6] Manage GATT attribute indications in handle callback.
> [PATCH 2/6] Parse final measurement indication
> [PATCH 3/6] Add org.bluez.ThermometerWatcher interface to default
> [PATCH 4/6] Implement EnableIntermediateMeasurement D-Bus method
> [PATCH 5/6] Implement DisableIntermediateMeasurement D-Bus method
> [PATCH 6/6] Notify intermediate measurements

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
