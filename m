Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimO9hqs-_4gyiY3YBOutBd8yhsuXQ@mail.gmail.com>
References: <BANLkTimO9hqs-_4gyiY3YBOutBd8yhsuXQ@mail.gmail.com>
Date: Thu, 9 Jun 2011 11:15:29 -0400
Message-ID: <BANLkTinskHnYfKpPDcu2mvQkF8Wyxm==bw@mail.gmail.com>
Subject: Re: Health Thermomether Profile
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 9, 2011 at 10:09 AM, Santiago Carot <sancane@gmail.com> wrote:
> On the other hand, lastest Anderson's e-mails about GATT make me think
> other designs avoiding attribute D-Bus API by using GATT direclty to
> implement the Thermomether client profile. In this way we can make a
> bluetooth plugin wich exposes the client part through D-Bus API to
> manage Thermomether devices by hiding GATT profile to applications
> that only want to operate over this kind of devices. I think that it's
> a pretty design wich fits better in BlueZ.

Actually this is exactly what we have been doing for profiles not yet
adopted. It seems to fit better next to other non-GATT profiles, each
having it's own D-Bus interface documented in doc/*-api.txt files.

Feel free to suggest a draft API (in the format of doc/*-api.txt
files), it is much easier/cheap than attempting to implement code so
to have to rewrite it later (IMHO).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
