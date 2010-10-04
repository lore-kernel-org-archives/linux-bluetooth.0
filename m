Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Oct 2010 22:43:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Pull request:
 git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
Message-ID: <20101004204320.GA11846@jh-x301>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
 <20100929134521.GA19362@jh-x301>
 <AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
 <20100930073938.GA6964@jh-x301>
 <AANLkTikADcqHYfOjmRQVEDdPuU9mrGVvAVGNUdRTsQcd@mail.gmail.com>
 <AANLkTin5RWCfX07xRUfVvkq+C47AOJXCCRpMVa-vqrRA@mail.gmail.com>
 <AANLkTinF1OWKMzuArUS6ptWiDTtvQuXxxW9B5ks3tebW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinF1OWKMzuArUS6ptWiDTtvQuXxxW9B5ks3tebW@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Oct 04, 2010, Claudio Takahasi wrote:
> The following changes since commit 19c8e310329bb6b369f11501afec9ff4223c2971:
> 
>   Allow errors to propagate from connection callback (2010-10-04 17:06:49 +0200)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
> 
> Claudio Takahasi (23):
>       Add LE start and stop scanning
>       Remove RSSI field from the advertising report event
>       Decoding the RSSI parameter from the advertising report event
>       Send Discovering property "FALSE" when the interleave finishes
>       Add length argument on hciops start discovery function
>       Stop inquiry using the length parameter
>       Fix remote name resolution for interleave discovery
>       Add Write LE host supported function
>       Set the LE host supported and disable simultaneous LE and BR/EDR flags
>       Add extended feature mask constants definition
>       Read the local extended features
>       Stop LE scanning when discovery is suspended
>       Rename hciops {start, stop}_discovery to {start, stop}_inquiry
>       Don't enter on interleave mode if there isn't active sessions
>       Code cleanup: improving inquiry logic
>       Clear the remote device found list in the state transition
>       Fix periodic inquiry signals
>       Fixing DeviceDisappeared signal
>       Postpone discovery if still resolving names
>       Add adapter discovery type function
>       Do not send another Discovering TRUE signal if still resolving names
>       Forcing periodic inquiry exit
>       Fix interleave scanning
> 
> Vinicius Costa Gomes (1):
>       Add BR/EDR LE interleaved discovery
> 
>  lib/hci.c        |   29 +++++
>  lib/hci.h        |   17 +++-
>  lib/hci_lib.h    |    1 +
>  plugins/hciops.c |   69 +++++++++++-
>  src/adapter.c    |  301 +++++++++++++++++++++++++++++++++++++-----------------
>  src/adapter.h    |   38 ++++---
>  src/dbus-hci.c   |   45 +++++++--
>  src/dbus-hci.h   |    1 +
>  src/security.c   |  131 ++++++++++++++----------
>  9 files changed, 449 insertions(+), 183 deletions(-)

Thanks. Pushed upstream.

Johan
