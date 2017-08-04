Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH Bluez] profiles: Fix memory leak of avrcp player
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <57331670-a1aa-3fa5-1280-86aa997dd2a1@jp.fujitsu.com>
 <CABBYNZKSADLQgVy19VBptrw8jxicVpTSgOp56CDP=q0YeE+kdg@mail.gmail.com>
 <725bac69-52a7-e8d4-7227-352cb39df2b8@jp.fujitsu.com>
Message-ID: <a7d2a5df-2866-dbf1-0160-6a7b16180447@jp.fujitsu.com>
Date: Fri, 4 Aug 2017 13:51:34 +0900
MIME-Version: 1.0
In-Reply-To: <725bac69-52a7-e8d4-7227-352cb39df2b8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I apology for the mistake of commit message. I had misread the source code.
I sent out v2 (http://marc.info/?l=linux-bluetooth&m=150182142229855&w=2).

Regards,
Eramoto

On 08/04/2017 10:20 AM, ERAMOTO Masaya wrote:
> Hi Luiz,
> 
> On 08/03/2017 06:30 PM, Luiz Augusto von Dentz wrote:
>> Hi Aram,
>>
>> On Thu, Aug 3, 2017 at 7:10 AM, ERAMOTO Masaya
>> <eramoto.masaya@jp.fujitsu.com> wrote:
>>> Fix the following problem that occurs in the case of D-Bus fails to
>>> register media player path with org.bluez.MediaPlayer1.
>>
>> Has this actually happened? Im asking because if that does happen it
>> probably because the already exists and we might want to return it
>> instead, though the fix seems good and I might apply it anyway.
> 
> I do not know what actually happened. I got this message of valgrind and
> forgot to get log messages of bluetoothd when the memory leak happened. 
> This commit message describe one of cause that I guess from implement of
> create_ct_player().
> 
> Is it better to remove this guessed cause from this patch to prevent
> misunderstanding?

