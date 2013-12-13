Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131213144922.GE30037@x220.p-661hnu-f1>
References: <1386938480-12049-1-git-send-email-luiz.dentz@gmail.com>
	<20131213144922.GE30037@x220.p-661hnu-f1>
Date: Fri, 13 Dec 2013 17:28:54 +0200
Message-ID: <CABBYNZ+bsmEv+xNK+PTVQToxuNDK7e8Y2ESu2R-ANc9c7SF7Cg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android: Add initial Android Bluetooth Audio
 protocol API doc
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Dec 13, 2013 at 4:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Dec 13, 2013, Luiz Augusto von Dentz wrote:
>> This IPC is used to communicate Android BlueZ daemon and AudioFlinger
>> plugin.
>> ---
>>  android/audio-ipc-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 android/audio-ipc-api.txt
>
> This seems to be missing an addition to EXTRA_DIST. Once you've fixed
> that feel free to push this yourself.

Will fix it.

> Also, I assume you've got missing bits, like those for suspending and
> resuming streams planned for later patches?

It seems this is handled by upper layer, we just have to make sure the
events are propagated by using the audia state notification, anyway if
we latter find out it is still necessary to synchronize via Audio IPC
we can extend the IPC with some extra bits like you said.


-- 
Luiz Augusto von Dentz
