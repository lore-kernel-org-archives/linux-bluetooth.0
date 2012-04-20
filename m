Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120419075643.GB20738@x220.ger.corp.intel.com>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<20120419075643.GB20738@x220.ger.corp.intel.com>
Date: Fri, 20 Apr 2012 14:01:17 -0300
Message-ID: <CAAngNMb6ZufCt1-LnmbYxWLkRRst=QyB6nkFD7wCueqiqFHn6Q@mail.gmail.com>
Subject: Re: [RFC v2 00/16] HoG plugin
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan

On Thu, Apr 19, 2012 at 4:56 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi João Paulo,
>
> On Wed, Apr 18, 2012, João Paulo Rechi Vita wrote:
>> LE pairing is broken on bluetooth-next atm.
>
> What exactly is broken? Have you already sent patches to fix this? We've
> been planning to enable LE support by default in 3.5 (based on current
> bluetooth-next) so this needs to be fixed asap.
>

Pairing from bluetoothd through CreatePairedDevice() is currently
broken for LE devices. The problem is that userspace creates a LE
connection before pairing, to be able to ATT traffic coming during the
pairing process. When it latter triggers pairing, an error is returned
due to the already existing connection.

Vinicius sent a patch [1] on February fixing this issue, but it have
never been integrated. It doesn't apply anymore, so I'm going to
re-send a version that apply.

[1] http://article.gmane.org/gmane.linux.bluez.kernel/21234/match=bluetooth+add+support+reusing+same+hci_conn+le+links

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
