Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170209145549.17542-1-eu@felipetonello.com>
References: <20170209145549.17542-1-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Feb 2017 13:33:22 +0200
Message-ID: <CABBYNZ+vj0YRGQht2ugu2np67rA0W57djJsB8KH4j3fcGZicfQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 0/2] Minor MIDI profile improvements
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Thu, Feb 9, 2017 at 4:55 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> Minor improvements that doesn't have any affect in functionality.
>
> Changes from v1:
>  * Removed SOB from patches.
>
> Felipe F. Tonello (2):
>   profiles/midi: Add safer buffer setter function
>   profiles/midi: Moved MIDI UUIDs to library header
>
>  profiles/midi/libmidi.c | 9 ++++++++-
>  profiles/midi/libmidi.h | 3 +++
>  profiles/midi/midi.c    | 3 ---
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> --
> 2.11.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
