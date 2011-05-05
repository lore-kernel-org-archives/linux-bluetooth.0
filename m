Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110505083417.GB24639@jh-x301>
References: <BANLkTin_qd=-3-3undR-Rcx0BG9t=Z3nVQ@mail.gmail.com>
	<1304458330-21499-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110505083417.GB24639@jh-x301>
Date: Thu, 5 May 2011 14:34:53 -0300
Message-ID: <BANLkTikx8qkTnpb46Q=zh8=7NnwDyvXDXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Discovery Cleanup - Step 1
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>, linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, May 5, 2011 at 5:34 AM, Johan Hedberg <johan.hedberg@gmail.com> wro=
te:
> Hi Claudio,
>
> On Tue, May 03, 2011, Claudio Takahasi wrote:
>> This patch series is the first step to cleanup the device discovery
>> procedure. The main changes are:
>> =C2=A0 - Unify advertising reports and inquiry results: mgmt sends
>> =C2=A0 =C2=A0 one device found event
>> =C2=A0 - Logic improvement/cleanup: device found
>> =C2=A0 - Move EIR functions to a new file
>> =C2=A0 - Add BDADDR type constants: necessary L2CAP connections and bond=
ing
>>
>>
>>
>> Bruna Moreira (3):
>> =C2=A0 Remove btd_event_advertising_report
>> =C2=A0 Replace EIR_DATA_LENGTH with HCI_MAX_EIR_LENGTH
>> =C2=A0 Drop variable EIR length
>>
>> Claudio Takahasi (10):
>> =C2=A0 Move EIR related functions to a new file
>> =C2=A0 Add Bluetooth address type definition
>> =C2=A0 Initial device found cleanup
>> =C2=A0 Move legacy verification to a new function
>> =C2=A0 Cleanup read name and alias from storage
>> =C2=A0 Don't resolve name if the name is in the storage
>> =C2=A0 Unify inquiry results and advertises
>> =C2=A0 Fix memory leak of EIR data
>> =C2=A0 Change the order to write/read the remote's name
>> =C2=A0 Cleanup inserting new device found entry
>>
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0lib/bluetooth.h =C2=A0 | =C2=A0 =C2=A04 +
>> =C2=A0plugins/hciops.c =C2=A0| =C2=A0202 +++++--------------------------=
--
>> =C2=A0plugins/mgmtops.c | =C2=A0 =C2=A03 +-
>> =C2=A0src/adapter.c =C2=A0 =C2=A0 | =C2=A0182 +++++++++++++++++++-------=
----
>> =C2=A0src/adapter.h =C2=A0 =C2=A0 | =C2=A0 =C2=A09 +-
>> =C2=A0src/eir.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0328 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++
>> =C2=A0src/eir.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 41 +++++++
>> =C2=A0src/event.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0224 +--------------------=
---------------
>> =C2=A0src/event.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A05 +-
>> =C2=A0src/sdpd.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 ---
>> =C2=A011 files changed, 530 insertions(+), 484 deletions(-)
>> =C2=A0create mode 100644 src/eir.c
>> =C2=A0create mode 100644 src/eir.h
>
> These patches don't seem to apply any more after I applied Andr=C3=A9s
> patches. (also, I can't really try applying anything else except 1/13
> since 2/13 is already the address type patch which is still being
> discussed).
>
> Johan
>

I am aware of this conflict. Patches are already rebased, but I will
wait Marcel's blessing(for the address type) before to send again the
patch series.

BR,
Claudio.
