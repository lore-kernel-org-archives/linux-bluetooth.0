Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Mar 2010 23:53:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Report local services(UUIDs) through DBus
Message-ID: <20100324215315.GA12632@jh-x301>
References: <1269462368-14079-1-git-send-email-francisco.alecrim@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269462368-14079-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 24, 2010, Francisco Alecrim wrote:
> Include UUIDs field to method GetProperties(org.bluez.Adapter).
> Applications can get local services(UUIDs) available through DBus.
> ---
>  doc/adapter-api.txt |    5 +++++
>  src/adapter.c       |   20 +++++++++++++++++++-
>  src/sdpd-database.c |   21 +++++++++++++++++++++
>  src/sdpd.h          |    1 +
>  test/list-devices   |    3 +++
>  5 files changed, 49 insertions(+), 1 deletions(-)

Thanks for the patch! It looks quite nice and clean :)

However, since it doesn't implement the PropertyChanged signals for the
new property I'll wait until Marcel gets the next release out the door
before pushing this one upstream (so we don't get a new BlueZ release
with a partially implemented API)

Johan
