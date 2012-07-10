Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NjTgwanMe-eSZ6RYQLV1-4V5tetpidr1Qd4aS2P7=XFA@mail.gmail.com>
References: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
	<CAJdJm_NjTgwanMe-eSZ6RYQLV1-4V5tetpidr1Qd4aS2P7=XFA@mail.gmail.com>
Date: Tue, 10 Jul 2012 11:03:45 -0300
Message-ID: <CAAngNMY8vwedEQdxvg2nUn0jqLy0vryPR6iz4Wd0Kwo5d1fHpw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] time: fix byte position
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 5, 2012 at 6:39 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Joao,
>
> On Thu, Jul 5, 2012 at 2:37 PM, João Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> The position of the "Time Zone" and "Daylight Saving Time" fields on
>> the Local Time Information characteristic was inverted. This commit
>> fix their position.
>> ---
>>  time/server.c |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Patch looks good.
>

Is there something preventing this patches to being merged? I see
Gustavo is already sending the directory move patches, and this will
probably not apply after his patches.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
