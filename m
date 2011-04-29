Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 29 Apr 2011 18:07:48 -0300
Message-ID: <BANLkTin_qd=-3-3undR-Rcx0BG9t=Z3nVQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Discovery Cleanup - Step 1
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Please ignore this patch series. I will fix the unnecessary
file-system lookup for the remote features.

On Thu, Apr 28, 2011 at 7:36 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch series is the first step to cleanup the device discovery
> procedure. The main changes are:
> =C2=A0- Unify advertising reports and inquiry results: mgmt sends
> =C2=A0 =C2=A0one device found event
> =C2=A0- Logic improvement/cleanup: device found
> =C2=A0- Move EIR functions to a new file
>
> Andre Guedes will send soon a patch series changing the discovery state
> control to be make hciops and mgmtops functional.
>
> There is excessive dynamic memory allocations/deallocations for EIR data.
> This is not a problem introduced by this patch serie. eir_data_free
> will be removed soon.
>
> ***** Open Issues *****
>
> * Use BDADDR_TYPE_NON_LE instead of BR?
> #define BDADDR_TYPE_LE_PUBLIC =C2=A00x00
> #define BRADDR_TYPE_LE_RANDOM =C2=A00x01
> #define BDADDR_TYPE_BR =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff

Comments here?

BR,
Claudio

>
> Bruna Moreira (3):
> =C2=A0Remove btd_event_advertising_report
> =C2=A0Replace EIR_DATA_LENGTH with HCI_MAX_EIR_LENGTH
> =C2=A0Drop variable EIR length
>
> Claudio Takahasi (10):
> =C2=A0Move EIR related functions to a new file
> =C2=A0Add Bluetooth address type definition
> =C2=A0Initial device found cleanup
> =C2=A0Move legacy verification to a new function
> =C2=A0Cleanup read name and alias from storage
> =C2=A0Don't resolve name if the name is in the storage
> =C2=A0Unify inquiry results and advertises
> =C2=A0Fix memory leak of EIR data
> =C2=A0Change the order to write/read the remote's name
> =C2=A0Cleanup inserting new device found entry
>
> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0lib/bluetooth.h =C2=A0 | =C2=A0 =C2=A04 +
> =C2=A0plugins/hciops.c =C2=A0| =C2=A0202 +++++---------------------------=
-
> =C2=A0plugins/mgmtops.c | =C2=A0 =C2=A03 +-
> =C2=A0src/adapter.c =C2=A0 =C2=A0 | =C2=A0178 ++++++++++++++++++---------=
--
> =C2=A0src/adapter.h =C2=A0 =C2=A0 | =C2=A0 =C2=A09 +-
> =C2=A0src/eir.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0328 +++++++++++++++++=
++++++++++++++++++++++++++++++++++++
> =C2=A0src/eir.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 41 +++++++
> =C2=A0src/event.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0222 +---------------------=
--------------
> =C2=A0src/event.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A05 +-
> =C2=A0src/sdpd.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 ---
> =C2=A011 files changed, 526 insertions(+), 482 deletions(-)
> =C2=A0create mode 100644 src/eir.c
> =C2=A0create mode 100644 src/eir.h
>
> --
> 1.7.5.rc3
>
