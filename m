Return-Path: <cyrus@holtmann.org>
Message-Id: <8D4D4D94-FD26-47A8-A9F9-CFD7D093BBDE@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1223936924.2243.0.camel@snoogens.fab.redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix PS3 BD remote input event generation
Date: Tue, 14 Oct 2008 09:38:04 +0300
References: <1223936924.2243.0.camel@snoogens.fab.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Oct 14, 2008, at 1:28, Bastien Nocera wrote:
> - Fix byte-reading in the decode function by using a guint8, instead
> of an int, we were overreading and were getting keycodes of
> 0xffffff44 when we wanted a single byte of 0x44.
> - Remove use of KEY_REMOTE_X, those keys never got upstream, and the
> values they were defined at are now used for completely different
> keys
> - Update uinput.h with the latest keycodes from 2.6.27

The patch has been pushed upstream. Thanks!

Johan
